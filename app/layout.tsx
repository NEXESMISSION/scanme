import type { Metadata } from 'next'
import './globals.css'

export const metadata: Metadata = {
  title: 'QR Menu Builder',
  description: 'Create beautiful QR code menus for your restaurant',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  )
}

