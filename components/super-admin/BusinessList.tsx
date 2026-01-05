'use client'

import { useState } from 'react'
import type { Database } from '@/lib/supabase/database.types'

type Business = Database['public']['Tables']['businesses']['Row'] & {
  profiles: {
    email: string
    phone_number: string
  }
}

interface BusinessListProps {
  businesses: Business[]
}

const quickTimeOptions = [
  { label: 'إيقاف فوري', minutes: -1, color: 'bg-red-500' },
  { label: '30 دقيقة', minutes: 30, color: 'bg-orange-500' },
  { label: '1 ساعة', minutes: 60, color: 'bg-amber-500' },
  { label: '24 ساعة', minutes: 1440, color: 'bg-yellow-500' },
  { label: '7 أيام', minutes: 10080, color: 'bg-blue-500' },
  { label: '30 يوم', minutes: 43200, color: 'bg-green-500' },
  { label: 'غير محدود', minutes: null, color: 'bg-zinc-500' },
]

export default function BusinessList({ businesses: initialBusinesses }: BusinessListProps) {
  const [businesses, setBusinesses] = useState(initialBusinesses)
  const [searchTerm, setSearchTerm] = useState('')
  const [loading, setLoading] = useState<string | null>(null)
  const [error, setError] = useState<string | null>(null)
  const [showTimeModal, setShowTimeModal] = useState<string | null>(null)
  const [customDays, setCustomDays] = useState('')
  const [customHours, setCustomHours] = useState('')
  const [customMinutes, setCustomMinutes] = useState('')

  const filteredBusinesses = businesses.filter(
    (b) =>
      b.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
      b.slug.toLowerCase().includes(searchTerm.toLowerCase())
  )

  const handleSetTime = async (businessId: string, minutes: number | null) => {
    setLoading(businessId)
    setError(null)

    try {
      const response = await fetch(`/api/super-admin/businesses/${businessId}/time`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ minutes }),
      })

      if (!response.ok) {
        const data = await response.json()
        throw new Error(data.error || 'فشل في تحديث الوقت')
      }

      const { data } = await response.json()
      
      setBusinesses(
        businesses.map((b) =>
          b.id === businessId ? { ...b, ...data } : b
        )
      )
      setShowTimeModal(null)
      setCustomDays('')
      setCustomHours('')
      setCustomMinutes('')
    } catch (err: any) {
      setError(err.message)
    } finally {
      setLoading(null)
    }
  }

  const handleCustomTime = (businessId: string) => {
    const days = parseInt(customDays) || 0
    const hours = parseInt(customHours) || 0
    const minutes = parseInt(customMinutes) || 0
    
    if (days === 0 && hours === 0 && minutes === 0) {
      setError('يرجى إدخال قيمة على الأقل')
      return
    }
    
    const totalMinutes = (days * 24 * 60) + (hours * 60) + minutes
    handleSetTime(businessId, totalMinutes)
  }

  const getTimeRemaining = (expiresAt: string | null, status: string) => {
    if (!expiresAt) return null
    
    const now = new Date()
    const expiry = new Date(expiresAt)
    const diff = expiry.getTime() - now.getTime()
    
    // If expired, show expired message
    if (diff <= 0) {
      return { 
        text: 'منتهي', 
        color: 'text-red-600', 
        urgent: true,
        expired: true 
      }
    }
    
    const days = Math.floor(diff / (1000 * 60 * 60 * 24))
    const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60))
    const mins = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60))
    
    if (days > 30) return { text: `${days} يوم متبقي`, color: 'text-green-600', urgent: false }
    if (days > 7) return { text: `${days} يوم متبقي`, color: 'text-blue-600', urgent: false }
    if (days > 0) return { text: `${days} يوم ${hours} س متبقي`, color: 'text-amber-600', urgent: true }
    if (hours > 0) return { text: `${hours} ساعة ${mins} د متبقي`, color: 'text-orange-600', urgent: true }
    return { text: `${mins} دقيقة متبقي`, color: 'text-red-600', urgent: true }
  }

  return (
    <div>
      {error && (
        <div className="mb-4 p-4 bg-red-50 border border-red-200 text-red-700 rounded-xl flex justify-between items-center">
          <span>{error}</span>
          <button onClick={() => setError(null)} className="text-red-400 hover:text-red-600">✕</button>
        </div>
      )}

      {/* Search */}
      <div className="mb-6">
        <input
          type="text"
          placeholder="بحث بالاسم أو الرابط..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          className="w-full px-4 py-3 border border-zinc-200 rounded-xl focus:ring-2 focus:ring-red-500 focus:border-transparent bg-white text-base"
        />
      </div>

      {/* Stats */}
      <div className="grid grid-cols-3 gap-4 mb-6">
        <div className="bg-white rounded-xl p-4 border border-zinc-200">
          <p className="text-2xl font-bold text-zinc-900">{businesses.length}</p>
          <p className="text-sm text-zinc-500">إجمالي الحسابات</p>
        </div>
        <div className="bg-white rounded-xl p-4 border border-zinc-200">
          <p className="text-2xl font-bold text-green-600">
            {businesses.filter(b => b.status === 'active').length}
          </p>
          <p className="text-sm text-zinc-500">نشط</p>
        </div>
        <div className="bg-white rounded-xl p-4 border border-zinc-200">
          <p className="text-2xl font-bold text-amber-600">
            {businesses.filter(b => b.status === 'paused').length}
          </p>
          <p className="text-sm text-zinc-500">متوقف</p>
        </div>
      </div>

      {/* Business Cards */}
      <div className="space-y-4">
        {filteredBusinesses.map((business) => {
          const timeInfo = getTimeRemaining(business.expires_at, business.status)
          
          return (
            <div key={business.id} className="bg-white rounded-xl border border-zinc-200 p-5">
              <div className="flex flex-wrap items-start justify-between gap-4">
                {/* Business Info */}
                <div className="flex-1 min-w-0">
                  <div className="flex items-center gap-3 mb-2">
                    <h3 className="font-bold text-lg text-zinc-900">{business.name}</h3>
                    <span
                      className={`px-2 py-0.5 text-xs font-medium rounded-full ${
                        business.status === 'active'
                          ? 'bg-green-100 text-green-700'
                          : 'bg-amber-100 text-amber-700'
                      }`}
                    >
                      {business.status === 'active' ? 'نشط' : 'متوقف'}
                    </span>
                  </div>
                  
                  <div className="space-y-1 text-sm">
                    <p className="text-zinc-600">
                      <span className="text-zinc-400">البريد:</span> {business.profiles.email}
                    </p>
                    <p className="text-zinc-600">
                      <span className="text-zinc-400">الهاتف:</span> {business.profiles.phone_number}
                    </p>
                    <a
                      href={`/${business.slug}`}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="text-blue-600 hover:underline"
                      dir="ltr"
                    >
                      /{business.slug}
                    </a>
                  </div>
                </div>

                {/* Time & Actions */}
                <div className="flex flex-col items-end gap-3">
                  {/* Time Badge */}
                  <div className="text-left">
                    {business.expires_at ? (
                      <div className={`text-sm font-medium ${timeInfo?.color}`}>
                        {timeInfo?.urgent && '⚠️ '}
                        {timeInfo?.text || 'منتهي'}
                      </div>
                    ) : (
                      <div className="text-sm text-zinc-400">
                        {business.status === 'active' ? 'غير محدود' : 'لا يوجد وقت'}
                      </div>
                    )}
                    {business.expires_at && (
                      <div className="text-xs text-zinc-400 mt-0.5" dir="ltr">
                        {new Date(business.expires_at).toLocaleDateString('ar-TN')}
                      </div>
                    )}
                  </div>

                  {/* Time Button */}
                  <button
                    onClick={() => setShowTimeModal(business.id)}
                    disabled={loading === business.id}
                    className="px-4 py-2 bg-zinc-900 text-white rounded-xl text-sm font-medium hover:bg-zinc-800 disabled:opacity-50"
                  >
                    {loading === business.id ? 'جاري...' : 'تحديد الوقت'}
                  </button>
                </div>
              </div>

              {/* Time Modal */}
              {showTimeModal === business.id && (
                <div className="mt-4 pt-4 border-t border-zinc-100">
                  <p className="text-sm font-medium text-zinc-700 mb-3">اختر مدة الاشتراك:</p>
                  
                  {/* Quick Options */}
                  <div className="flex flex-wrap gap-2 mb-4">
                    {quickTimeOptions.map((option) => (
                      <button
                        key={option.label}
                        onClick={() => handleSetTime(business.id, option.minutes)}
                        disabled={loading === business.id}
                        className={`px-3 py-2 rounded-lg text-sm font-medium text-white transition-colors ${option.color} hover:opacity-90 disabled:opacity-50`}
                      >
                        {option.label}
                      </button>
                    ))}
                  </div>

                  {/* Custom Time Inputs */}
                  <div className="border-t border-zinc-100 pt-4 mt-4">
                    <p className="text-sm font-medium text-zinc-700 mb-3">وقت مخصص:</p>
                    <div className="grid grid-cols-3 gap-3">
                      <div>
                        <label className="block text-xs text-zinc-500 mb-1">الأيام</label>
                        <input
                          type="number"
                          min="0"
                          value={customDays}
                          onChange={(e) => setCustomDays(e.target.value)}
                          placeholder="0"
                          className="w-full px-3 py-2 border border-zinc-200 rounded-lg text-sm focus:ring-2 focus:ring-zinc-900 focus:border-transparent"
                        />
                      </div>
                      <div>
                        <label className="block text-xs text-zinc-500 mb-1">الساعات</label>
                        <input
                          type="number"
                          min="0"
                          max="23"
                          value={customHours}
                          onChange={(e) => setCustomHours(e.target.value)}
                          placeholder="0"
                          className="w-full px-3 py-2 border border-zinc-200 rounded-lg text-sm focus:ring-2 focus:ring-zinc-900 focus:border-transparent"
                        />
                      </div>
                      <div>
                        <label className="block text-xs text-zinc-500 mb-1">الدقائق</label>
                        <input
                          type="number"
                          min="0"
                          max="59"
                          value={customMinutes}
                          onChange={(e) => setCustomMinutes(e.target.value)}
                          placeholder="0"
                          className="w-full px-3 py-2 border border-zinc-200 rounded-lg text-sm focus:ring-2 focus:ring-zinc-900 focus:border-transparent"
                        />
                      </div>
                    </div>
                    
                    <div className="flex gap-2 mt-3">
                      <button
                        onClick={() => handleCustomTime(business.id)}
                        disabled={!customDays && !customHours && !customMinutes || loading === business.id}
                        className="px-4 py-2 bg-zinc-900 text-white rounded-lg text-sm font-medium hover:bg-zinc-800 disabled:opacity-50"
                      >
                        تطبيق
                      </button>
                      <button
                        onClick={() => {
                          setShowTimeModal(null)
                          setCustomDays('')
                          setCustomHours('')
                          setCustomMinutes('')
                        }}
                        className="px-4 py-2 text-zinc-500 text-sm font-medium hover:text-zinc-700"
                      >
                        إلغاء
                      </button>
                    </div>
                  </div>
                </div>
              )}
            </div>
          )
        })}
      </div>

      {filteredBusinesses.length === 0 && (
        <div className="text-center py-12 bg-white rounded-xl border border-zinc-200">
          <p className="text-zinc-500">لا توجد حسابات</p>
        </div>
      )}
    </div>
  )
}
