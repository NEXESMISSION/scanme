'use client'

import AdminSidebar from '@/components/admin/AdminSidebar'
import DynamicFavicon from '@/components/admin/DynamicFavicon'
import type { Database } from '@/lib/supabase/database.types'

type Business = Database['public']['Tables']['businesses']['Row']

interface AdminLayoutClientProps {
  business: Business | null
  children: React.ReactNode
}

export default function AdminLayoutClient({ business, children }: AdminLayoutClientProps) {
  if (!business) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-zinc-100" dir="rtl">
        <div className="bg-white rounded-xl shadow-sm p-8 text-center max-w-md mx-auto border border-zinc-200">
          <h1 className="text-2xl font-bold text-zinc-900 mb-4">لم يتم العثور على عمل</h1>
          <p className="text-zinc-600">يرجى إنشاء عمل للمتابعة.</p>
        </div>
      </div>
    )
  }

  return (
    <div className="flex min-h-screen bg-zinc-100" dir="rtl">
      <DynamicFavicon logoUrl={business.logo_url} businessName={business.name} />
      <AdminSidebar />
      <main className="flex-1 overflow-auto">
        {children}
      </main>
    </div>
  )
}
