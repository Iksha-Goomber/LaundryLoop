import type { Metadata } from 'next';
import './globals.css';
export const metadata: Metadata = { title: 'LaundryLoop — Hostel laundry, simplified', description: 'Check machine availability, reserve laundry slots and track your wash cycle.' };
export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) { return <html lang="en"><body>{children}</body></html>; }
