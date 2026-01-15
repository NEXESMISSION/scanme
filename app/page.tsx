import { redirect } from 'next/navigation'
import { createServerClient } from '@/lib/supabase/server'
import LandingPage from '@/components/landing/LandingPage'
import type { Database } from '@/lib/supabase/database.types'
import type { Metadata } from 'next'

type Profile = Database['public']['Tables']['profiles']['Row']

export const metadata: Metadata = {
  title: 'QR Menu Builder - Create Digital Menus for Your Restaurant',
  description: 'Create beautiful, customizable digital menus for your restaurant or cafe. Generate QR codes, manage your menu items, and share your menu with customers instantly.',
  keywords: ['QR menu', 'digital menu', 'restaurant menu', 'QR code menu', 'menu builder', 'online menu'],
  openGraph: {
    title: 'QR Menu Builder - Create Digital Menus for Your Restaurant',
    description: 'Create beautiful, customizable digital menus for your restaurant or cafe. Generate QR codes, manage your menu items, and share your menu with customers instantly.',
    type: 'website',
  },
  twitter: {
    card: 'summary_large_image',
    title: 'QR Menu Builder - Create Digital Menus for Your Restaurant',
    description: 'Create beautiful, customizable digital menus for your restaurant or cafe.',
  },
  robots: {
    index: true,
    follow: true,
  },
}

export default async function Home() {
  const supabase = await createServerClient()
  const { data: { session } } = await supabase.auth.getSession()

  if (session) {
    // Check user role to redirect appropriately
    const { data: profile } = await supabase
      .from('profiles')
      .select('role')
      .eq('user_id', session.user.id)
      .single() as { data: Profile | null }

    if (profile?.role === 'super_admin') {
      redirect('/super-admin')
    } else {
      redirect('/admin')
    }
  }

  return <LandingPage />
}
