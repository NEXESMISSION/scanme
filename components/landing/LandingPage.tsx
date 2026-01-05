'use client'

import Link from 'next/link'
import Image from 'next/image'

export default function LandingPage() {
  return (
    <div className="min-h-screen bg-white" dir="rtl">
      {/* Modern Hero Section */}
      <section className="relative min-h-[90vh] flex items-center justify-center overflow-hidden bg-gradient-to-br from-orange-500 via-amber-500 to-yellow-500">
        {/* Animated Background Pattern */}
        <div className="absolute inset-0 opacity-10">
          <div className="absolute inset-0" style={{
            backgroundImage: `radial-gradient(circle at 2px 2px, white 1px, transparent 0)`,
            backgroundSize: '50px 50px',
          }}></div>
        </div>
        
        {/* Background Image with better overlay */}
        <div className="absolute inset-0">
          <Image
            src="/img1.png"
            alt="Background"
            fill
            className="object-cover opacity-15"
            priority
            quality={90}
          />
        </div>
        
        {/* Gradient Overlay */}
        <div className="absolute inset-0 bg-gradient-to-b from-black/30 via-black/20 to-black/40"></div>
        
        {/* Floating Elements */}
        <div className="absolute top-20 right-20 w-72 h-72 bg-white/10 rounded-full blur-3xl animate-pulse"></div>
        <div className="absolute bottom-20 left-20 w-96 h-96 bg-amber-400/20 rounded-full blur-3xl animate-pulse" style={{ animationDelay: '1s' }}></div>
        
        {/* Content */}
        <div className="relative z-10 max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          {/* Badge */}
          <div className="inline-flex items-center gap-2 bg-white/20 backdrop-blur-md px-4 py-2 rounded-full mb-8 border border-white/30">
            <span className="w-2 h-2 bg-green-400 rounded-full animate-pulse"></span>
            <span className="text-white/90 text-sm font-medium">تجربة مجانية 7 أيام</span>
          </div>
          
          {/* Main Headline */}
          <h1 className="text-5xl sm:text-6xl lg:text-7xl font-extrabold mb-6 leading-tight text-white drop-shadow-2xl">
            قائمة رقمية<br />
            <span className="bg-gradient-to-r from-yellow-200 to-white bg-clip-text text-transparent">
              احترافية
            </span>
            <br />
            في 5 دقائق
          </h1>
          
          {/* Subheadline */}
          <p className="text-xl sm:text-2xl lg:text-3xl mb-10 text-white/95 font-light drop-shadow-lg max-w-3xl mx-auto">
            أنشئ قائمة QR لمطعمك أو مقهىك بسرعة وسهولة
            <br className="hidden sm:block" />
            <span className="text-white/80">بدون معرفة تقنية</span>
          </p>
          
          {/* CTA Buttons */}
          <div className="flex flex-col sm:flex-row gap-4 justify-center items-center mb-8">
            <Link
              href="/signup"
              className="group relative px-10 py-5 bg-white text-orange-600 rounded-2xl font-bold text-lg sm:text-xl hover:scale-105 transition-all duration-300 shadow-2xl hover:shadow-white/50"
            >
              <span className="relative z-10">ابدأ الآن مجاناً</span>
              <span className="absolute inset-0 bg-gradient-to-r from-orange-50 to-amber-50 rounded-2xl opacity-0 group-hover:opacity-100 transition-opacity"></span>
            </Link>
            <Link
              href="/login"
              className="px-10 py-5 bg-white/10 backdrop-blur-md text-white rounded-2xl font-semibold text-lg sm:text-xl border-2 border-white/30 hover:bg-white/20 transition-all duration-300"
            >
              تسجيل الدخول
            </Link>
          </div>
          
          {/* Trust Indicators */}
          <div className="flex flex-wrap items-center justify-center gap-6 text-white/80 text-sm">
            <div className="flex items-center gap-2">
              <svg className="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clipRule="evenodd" />
              </svg>
              <span>لا حاجة لبطاقة ائتمانية</span>
            </div>
            <div className="flex items-center gap-2">
              <svg className="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clipRule="evenodd" />
              </svg>
              <span>إلغاء في أي وقت</span>
            </div>
            <div className="flex items-center gap-2">
              <svg className="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clipRule="evenodd" />
              </svg>
              <span>قابل للتخصيص بالكامل</span>
            </div>
          </div>
        </div>
        
        {/* Scroll Indicator */}
        <div className="absolute bottom-8 left-1/2 transform -translate-x-1/2 animate-bounce">
          <svg className="w-6 h-6 text-white/60" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 14l-7 7m0 0l-7-7m7 7V3" />
          </svg>
        </div>
      </section>

      {/* Value Props - Quick Benefits */}
      <section className="py-16 bg-zinc-50">
        <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid md:grid-cols-3 gap-8 text-center">
            <div className="bg-white p-8 rounded-2xl shadow-sm hover:shadow-md transition-shadow">
              <div className="text-5xl mb-4">⚡</div>
              <h3 className="text-xl font-bold text-zinc-900 mb-2">سريع جداً</h3>
              <p className="text-zinc-600">أنشئ قائمتك في أقل من 5 دقائق. لا حاجة للمعرفة التقنية.</p>
            </div>
            <div className="bg-white p-8 rounded-2xl shadow-sm hover:shadow-md transition-shadow">
              <div className="text-5xl mb-4">💰</div>
              <h3 className="text-xl font-bold text-zinc-900 mb-2">أسعار منخفضة</h3>
              <p className="text-zinc-600">25 د.ت لـ 6 أشهر أو 35 د.ت للسنة الكاملة. بدون رسوم خفية.</p>
            </div>
            <div className="bg-white p-8 rounded-2xl shadow-sm hover:shadow-md transition-shadow">
              <div className="text-5xl mb-4">✨</div>
              <h3 className="text-xl font-bold text-zinc-900 mb-2">سهل التحديث</h3>
              <p className="text-zinc-600">عدّل الأسعار والأطباق في أي وقت. التحديثات فورية.</p>
            </div>
          </div>
        </div>
      </section>

      {/* Pricing - Prominent & Clear */}
      <section className="py-20 bg-white">
        <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-12">
            <h2 className="text-3xl sm:text-4xl font-bold text-zinc-900 mb-4">
              خطط بأسعار لا تقبل المنافسة
            </h2>
            <p className="text-lg text-zinc-600">
              اختر ما يناسبك. كل الخطط تشمل كل المميزات
            </p>
          </div>

          <div className="grid md:grid-cols-2 gap-8 max-w-3xl mx-auto mb-12">
            {/* Plan 1 */}
            <div className="bg-white border-2 border-zinc-200 rounded-2xl p-8 hover:border-orange-500 transition-all">
              <div className="text-center mb-6">
                <h3 className="text-2xl font-bold text-zinc-900 mb-2">6 أشهر</h3>
                <div className="flex items-baseline justify-center gap-2 mb-2">
                  <span className="text-5xl font-bold text-zinc-900">25</span>
                  <span className="text-xl text-zinc-600">د.ت</span>
                </div>
                <p className="text-sm text-zinc-500">≈ 4.17 د.ت / شهر</p>
              </div>
              <ul className="space-y-3 mb-8">
                <li className="flex items-center gap-2">
                  <span className="text-green-500 text-xl">✓</span>
                  <span className="text-zinc-700">قائمة QR احترافية</span>
                </li>
                <li className="flex items-center gap-2">
                  <span className="text-green-500 text-xl">✓</span>
                  <span className="text-zinc-700">عدد غير محدود من الأطباق</span>
                </li>
                <li className="flex items-center gap-2">
                  <span className="text-green-500 text-xl">✓</span>
                  <span className="text-zinc-700">تصاميم جاهزة</span>
                </li>
                <li className="flex items-center gap-2">
                  <span className="text-green-500 text-xl">✓</span>
                  <span className="text-zinc-700">دعم فني</span>
                </li>
              </ul>
              <Link
                href="/signup"
                className="block w-full text-center px-6 py-4 bg-zinc-900 text-white rounded-xl font-semibold hover:bg-zinc-800 transition-colors"
              >
                ابدأ الآن →
              </Link>
            </div>

            {/* Plan 2 - Popular */}
            <div className="bg-gradient-to-br from-orange-500 to-amber-500 text-white rounded-2xl p-8 shadow-2xl transform scale-105 border-4 border-orange-400">
              <div className="text-center mb-2">
                <span className="inline-block bg-white text-orange-600 px-4 py-1 rounded-full text-sm font-bold mb-4">
                  الأكثر شعبية
                </span>
              </div>
              <div className="text-center mb-6">
                <h3 className="text-2xl font-bold mb-2">سنة كاملة</h3>
                <div className="flex items-baseline justify-center gap-2 mb-2">
                  <span className="text-5xl font-bold">35</span>
                  <span className="text-xl text-white/90">د.ت</span>
                </div>
                <p className="text-sm text-white/90">≈ 2.92 د.ت / شهر</p>
                <p className="text-sm mt-2 text-yellow-200 font-semibold">توفر 15 د.ت!</p>
              </div>
              <ul className="space-y-3 mb-8">
                <li className="flex items-center gap-2">
                  <span className="text-white text-xl">✓</span>
                  <span>كل ما في خطة 6 أشهر</span>
                </li>
                <li className="flex items-center gap-2">
                  <span className="text-white text-xl">✓</span>
                  <span>دعم أولوية</span>
                </li>
                <li className="flex items-center gap-2">
                  <span className="text-white text-xl">✓</span>
                  <span>تحديثات مجانية</span>
                </li>
              </ul>
              <Link
                href="/signup"
                className="block w-full text-center px-6 py-4 bg-white text-orange-600 rounded-xl font-semibold hover:bg-zinc-50 transition-colors"
              >
                ابدأ الآن →
              </Link>
            </div>
          </div>

          {/* Payment Methods */}
          <div className="text-center mb-8">
            <p className="text-sm text-zinc-600 mb-4">طرق الدفع المتاحة:</p>
            <div className="flex flex-wrap items-center justify-center gap-6">
              {/* Flouci */}
              <div className="flex items-center gap-2 bg-white px-4 py-2 rounded-lg border border-zinc-200 shadow-sm">
                <Image
                  src="https://805342.fs1.hubspotusercontent-na1.net/hubfs/805342/flouci_logo_new.png"
                  alt="Flouci"
                  width={80}
                  height={30}
                  className="object-contain h-8"
                />
              </div>
              
              {/* D17 */}
              <div className="flex items-center gap-2 bg-white px-4 py-2 rounded-lg border border-zinc-200 shadow-sm">
                <Image
                  src="https://805342.fs1.hubspotusercontent-na1.net/hubfs/805342/flouci_logo_new.png"
                  alt="D17"
                  width={80}
                  height={30}
                  className="object-contain h-8"
                />
                <span className="text-zinc-700 font-medium">D17</span>
              </div>
              
              {/* Bank Transfer */}
              <div className="flex items-center gap-2 bg-white px-4 py-2 rounded-lg border border-zinc-200 shadow-sm">
                <svg className="w-8 h-8 text-zinc-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z" />
                </svg>
                <span className="text-zinc-700 font-medium">تحويل بنكي</span>
              </div>
            </div>
          </div>

          <div className="text-center">
            <p className="text-zinc-600 mb-4">
              جميع الخطط تشمل تجربة مجانية 7 أيام
            </p>
            <Link
              href="/signup"
              className="text-orange-600 font-semibold hover:text-orange-700 underline"
            >
              ابدأ تجربتك المجانية →
            </Link>
          </div>
        </div>
      </section>

      {/* Final CTA - Simple & Direct */}
      <section className="py-20 bg-gradient-to-br from-orange-50 to-amber-50">
        <div className="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <h2 className="text-3xl sm:text-4xl font-bold text-zinc-900 mb-6">
            جاهز للبدء؟
          </h2>
          <p className="text-lg text-zinc-600 mb-8">
            أنشئ قائمتك الرقمية الآن. لا حاجة لبطاقة ائتمانية.<br />
            <strong className="text-zinc-900">ابدأ مجاناً واستكشف كل المميزات.</strong>
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <Link
              href="/signup"
              className="px-10 py-5 bg-orange-600 text-white rounded-xl font-bold text-xl hover:bg-orange-700 transition-colors shadow-xl"
            >
              ابدأ مجاناً الآن →
            </Link>
            <Link
              href="/login"
              className="px-10 py-5 bg-white text-zinc-900 rounded-xl font-bold text-xl hover:bg-zinc-50 transition-colors border-2 border-zinc-200"
            >
              تسجيل الدخول
            </Link>
          </div>
          <p className="text-sm text-zinc-500 mt-6">
            تجربة مجانية 7 أيام • بدون التزام • إلغاء في أي وقت
          </p>
        </div>
      </section>

      {/* Simple Footer */}
      <footer className="bg-zinc-900 text-zinc-400 py-8">
        <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center">
            <p className="mb-2">© 2024 QR Menu Builder. جميع الحقوق محفوظة.</p>
            <div className="flex justify-center gap-6 text-sm">
              <Link href="/login" className="hover:text-white transition-colors">تسجيل الدخول</Link>
              <Link href="/signup" className="hover:text-white transition-colors">إنشاء حساب</Link>
            </div>
          </div>
        </div>
      </footer>
    </div>
  )
}
