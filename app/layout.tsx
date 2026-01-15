import type { Metadata } from 'next'
import './globals.css'

export const metadata: Metadata = {
  metadataBase: new URL(process.env.NEXT_PUBLIC_SITE_URL || 'https://scaniha.com'),
  title: {
    default: 'Scaniha - QR Menu Builder',
    template: '%s | Scaniha',
  },
  description: 'Create beautiful QR code menus for your restaurant',
  keywords: ['QR menu', 'digital menu', 'restaurant menu', 'QR code menu', 'menu builder'],
  authors: [{ name: 'Scaniha' }],
  creator: 'Scaniha',
  icons: {
    icon: [
      { url: '/logo-icon.png', type: 'image/png' },
    ],
    apple: [
      { url: '/logo-icon.png', type: 'image/png' },
    ],
  },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      'max-video-preview': -1,
      'max-image-preview': 'large',
      'max-snippet': -1,
    },
  },
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="ar" dir="rtl" suppressHydrationWarning>
      <body suppressHydrationWarning>{children}</body>
    </html>
  )
}

