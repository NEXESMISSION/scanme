import type { Metadata } from 'next'
import './globals.css'

export const metadata: Metadata = {
  title: 'Scaniha',
  description: 'Create beautiful QR code menus for your restaurant',
  icons: {
    icon: [
      { url: '/logo-icon.png', type: 'image/png' },
    ],
    apple: [
      { url: '/logo-icon.png', type: 'image/png' },
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

