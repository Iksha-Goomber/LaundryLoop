# LaundryLoop 🧺

**Smart Hostel Laundry Management** — a responsive campus laundry dashboard where students can discover machine availability, reserve time slots, track active cycles, and view availability estimates.

## What's included

- Machine dashboard with Available / Running / Maintenance states
- Search and status filters across laundry rooms
- Slot booking flow with date, time, student and room details
- Duplicate machine-slot prevention in the demo experience
- Booking history and cancellation
- Cycle countdown/progress display and demo cycle completion control
- Availability forecast based on current cycle minutes
- Responsive desktop and mobile UI
- Browser persistence via `localStorage`
- Supabase/PostgreSQL starter schema in `supabase/schema.sql`

## Run locally

Requirements: Node.js 20.9+ and npm.

```bash
npm install
npm run dev
```

Open http://localhost:3000.

The app works immediately in **demo mode**. Bookings and machine status changes are stored in the current browser only. Use the demo controls on running machines to simulate a completed wash.

## Deploy to Vercel

1. Push this folder to a GitHub repository.
2. In Vercel, choose **Add New → Project** and import the repository.
3. Keep the detected framework as **Next.js** and use the default build settings.
4. Deploy. No environment variables are required for demo mode.

## Database setup (next step for a shared live deployment)

1. Create a Supabase project.
2. Open the Supabase SQL Editor and run `supabase/schema.sql`.
3. Add `NEXT_PUBLIC_SUPABASE_URL` and `NEXT_PUBLIC_SUPABASE_ANON_KEY` to your Vercel project environment variables (and local `.env.local` if needed).

The current UI deliberately remains in local demo mode; the Supabase schema is supplied as the database foundation, not represented as a fully wired live sync. Before enabling shared writes, implement Supabase Auth and row-level security policies, then connect the UI to the authenticated database. Never expose a service-role key in a browser environment.

## IoT integration path

The included machine status is simulated for a working prototype. To connect real hardware:

- Install an ESP32/current sensor or smart plug per washer.
- Publish machine telemetry (`machine_id`, `state`, `cycle`, `minutes_remaining`, `updated_at`) to a trusted API or MQTT broker.
- Have a backend validate the device and update `machines`.
- Subscribe to trusted status updates in the dashboard and trigger push/email notifications when a cycle completes.

Do not let unauthenticated clients directly write machine state in a production deployment.

## Suggested next milestones

- Supabase Auth (student sign-in)
- Server-side booking API with transactional slot locking
- Realtime machine telemetry (MQTT → backend → Supabase Realtime)
- Web Push notifications for cycle completion
- Admin dashboard for machine maintenance and hostel-wise analytics

## Tech stack

Next.js 15 · React 19 · TypeScript · Lucide · Supabase/PostgreSQL schema · Vercel
