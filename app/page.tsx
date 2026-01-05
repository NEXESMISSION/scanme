import { redirect } from 'next/navigation'
import { createServerClient } from '@/lib/supabase/server'
import LandingPage from '@/components/landing/LandingPage'
import type { Database } from '@/lib/supabase/database.types'

type Profile = Database['public']['Tables']['profiles']['Row']

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
