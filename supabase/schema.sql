-- LaundryLoop database schema (Supabase / PostgreSQL)
create extension if not exists pgcrypto;

create table if not exists public.machines (
  id text primary key,
  name text not null,
  location text not null,
  status text not null default 'Available' check (status in ('Available','Running','Maintenance')),
  minutes_remaining integer not null default 0 check (minutes_remaining >= 0),
  cycle text not null default '—',
  updated_at timestamptz not null default now()
);

create table if not exists public.bookings (
  id uuid primary key default gen_random_uuid(),
  machine_id text not null references public.machines(id),
  student_name text not null,
  room_number text not null,
  booking_date date not null,
  time_slot text not null,
  status text not null default 'Booked' check (status in ('Booked','In progress','Completed','Cancelled')),
  created_at timestamptz not null default now(),
  constraint no_duplicate_machine_slot unique (machine_id, booking_date, time_slot)
);

create index if not exists bookings_date_idx on public.bookings (booking_date);
create index if not exists bookings_machine_idx on public.bookings (machine_id, status);

insert into public.machines (id,name,location,status,minutes_remaining,cycle) values
('WM-01','Washer 01','Hostel A · Ground floor','Available',0,'—'),
('WM-02','Washer 02','Hostel A · Ground floor','Running',24,'Quick wash'),
('WM-03','Washer 03','Hostel A · First floor','Available',0,'—'),
('WM-04','Washer 04','Hostel B · Ground floor','Maintenance',0,'Service required'),
('WM-05','Washer 05','Hostel B · First floor','Running',41,'Cotton'),
('WM-06','Washer 06','Hostel B · First floor','Available',0,'—')
on conflict (id) do nothing;

-- IMPORTANT: This schema intentionally does not enable public write access.
-- Connect a trusted backend / Supabase Auth and add row-level security policies
-- before using a shared production database. The included app runs in local demo
-- mode and stores bookings in the visitor's browser until that integration is added.
