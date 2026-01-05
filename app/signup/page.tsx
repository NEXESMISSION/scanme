'use client'

import SignupForm from '@/components/auth/SignupForm'

export default function SignupPage() {
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
              إنشاء حساب جديد
            </h1>
            <p className="text-zinc-500 text-sm">
              ابدأ رحلتك مع منشئ القوائم
            </p>
          </div>

          <SignupForm />
        </div>

        <div className="text-center mt-6">
          <a 
            href="/login" 
            className="text-sm text-zinc-600 hover:text-zinc-900 font-medium"
          >
            لديك حساب بالفعل؟ <span className="text-zinc-900 font-semibold">سجل الدخول</span>
          </a>
        </div>
      </div>
    </div>
  )
}
