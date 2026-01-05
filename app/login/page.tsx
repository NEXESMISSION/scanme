'use client'

import LoginForm from '@/components/auth/LoginForm'

export default function LoginPage() {
  return (
    <div className="min-h-screen bg-zinc-100 flex items-center justify-center p-4" dir="rtl">
      <div className="w-full max-w-md">
        <div className="bg-white rounded-2xl shadow-lg border border-zinc-200 p-8">
          {/* Logo/Header */}
          <div className="text-center mb-8">
            <div className="w-16 h-16 rounded-xl bg-gradient-to-br from-orange-500 to-amber-500 flex items-center justify-center font-bold text-2xl text-white mx-auto mb-4">
              Q
            </div>
            <h1 className="text-2xl lg:text-3xl font-bold text-zinc-900 mb-2">
              تسجيل الدخول
            </h1>
            <p className="text-zinc-500 text-sm">
              سجل الدخول إلى حسابك لإدارة قائمتك
            </p>
          </div>

          <LoginForm />
        </div>

        <div className="text-center mt-6">
          <a 
            href="/signup" 
            className="text-sm text-zinc-600 hover:text-zinc-900 font-medium"
          >
            ليس لديك حساب؟ <span className="text-zinc-900 font-semibold">سجل الآن</span>
          </a>
        </div>
      </div>
    </div>
  )
}
