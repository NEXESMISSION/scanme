'use client'

import Link from 'next/link'
import { usePathname } from 'next/navigation'
import { createClient } from '@/lib/supabase/client'
import { useRouter } from 'next/navigation'
import { useState } from 'react'

const navItems = [
  { href: '/admin', label: 'لوحة التحكم', icon: (
    <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z" />
    </svg>
  )},
  { href: '/admin/menu', label: 'القائمة', icon: (
    <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16" />
    </svg>
  )},
]

export default function AdminSidebar() {
  const pathname = usePathname()
  const router = useRouter()
  const supabase = createClient()
  const [loading, setLoading] = useState(false)
  
  const isActive = (path: string) => {
    if (path === '/admin') return pathname === '/admin'
    return pathname.startsWith(path)
  }

  const handleSignOut = async () => {
    setLoading(true)
    await supabase.auth.signOut()
    router.push('/login')
    router.refresh()
  }

  return (
    <>
      <style jsx>{`
        .nav-item {
          transition: all 0.15s ease;
        }
        
        .nav-item:hover {
          transform: translateX(-2px);
        }
      `}</style>
      
      <aside className="admin-sidebar w-16 lg:w-56 bg-zinc-950 text-white flex flex-col border-l border-zinc-800/50" dir="rtl">
        {/* Logo */}
        <div className="h-16 flex items-center justify-center lg:justify-start lg:px-5 border-b border-zinc-800/50">
          <div className="w-9 h-9 rounded-lg bg-gradient-to-br from-orange-500 to-amber-500 flex items-center justify-center font-bold text-base">
            Q
          </div>
          <span className="hidden lg:block mr-3 font-semibold text-base tracking-tight">
            منشئ القوائم
          </span>
        </div>

        {/* Navigation */}
        <nav className="flex-1 py-5 px-2 lg:px-4 space-y-2">
          {navItems.map((item) => (
            <Link
              key={item.href}
              href={item.href}
              className={`nav-item flex items-center justify-center lg:justify-start gap-3 px-3 py-3 rounded-xl text-base font-medium ${
                isActive(item.href)
                  ? 'bg-zinc-800 text-white'
                  : 'text-zinc-400 hover:text-white hover:bg-zinc-800/50'
              }`}
            >
              <span className="text-zinc-300">{item.icon}</span>
              <span className="hidden lg:block">{item.label}</span>
            </Link>
          ))}
        </nav>

        {/* Sign Out */}
        <div className="p-3 lg:p-4 border-t border-zinc-800/50">
          <button
            onClick={handleSignOut}
            disabled={loading}
            className="nav-item w-full flex items-center justify-center lg:justify-start gap-3 px-3 py-3 rounded-xl text-base font-medium text-zinc-400 hover:text-white hover:bg-zinc-800/50 disabled:opacity-50"
          >
            <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
            </svg>
            <span className="hidden lg:block">{loading ? 'جاري الخروج...' : 'تسجيل الخروج'}</span>
          </button>
        </div>
      </aside>
    </>
  )
}
