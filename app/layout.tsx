import type { Metadata } from 'next'
import './globals.css'

export const metadata: Metadata = {
  title: 'QR Menu Builder',
  description: 'Create beautiful QR code menus for your restaurant',
  icons: {
    icon: [
      { url: '/icon.svg', type: 'image/svg+xml' },
    ],
  },
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en" suppressHydrationWarning>
      <body suppressHydrationWarning>{children}</body>
    </html>
  )
}

