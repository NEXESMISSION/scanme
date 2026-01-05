'use client'

import { useState } from 'react'
import { createClient } from '@/lib/supabase/client'
import { uploadItemImage, uploadCategoryImage, deleteImage } from '@/lib/storage'
import type { Database } from '@/lib/supabase/database.types'

type Category = Database['public']['Tables']['categories']['Row'] & {
  items: Database['public']['Tables']['items']['Row'][]
}

interface ModernMenuBuilderProps {
  businessId: string
  initialCategories: Category[]
}

export default function ModernMenuBuilder({ businessId, initialCategories }: ModernMenuBuilderProps) {
  const [categories, setCategories] = useState<Category[]>(initialCategories)
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const [editingItem, setEditingItem] = useState<string | null>(null)
  const [addingCategory, setAddingCategory] = useState(false)
  const [expandedCategory, setExpandedCategory] = useState<string | null>(
    initialCategories.length > 0 ? initialCategories[0].id : null
  )
  const supabase = createClient()

  const refreshCategories = async () => {
    setLoading(true)
    try {
      const { data: cats } = await supabase
        .from('categories')
        .select(`*, items (*)`)
        .eq('business_id', businessId)
        .order('position', { ascending: true })

      if (cats) setCategories(cats as Category[])
    } catch (err: any) {
      setError(err.message)
    } finally {
      setLoading(false)
    }
  }

  const handleAddCategory = async (name: string, imageFile?: File) => {
    if (!name?.trim()) return
    setLoading(true)
    try {
      const position = categories.length
      const { data: newCat, error: catError } = await (supabase.from('categories') as any)
        .insert({ business_id: businessId, name: name.trim(), position })
        .select()
        .single()
      
      if (catError) throw catError

      if (imageFile && newCat?.id) {
        try {
          const imageUrl = await uploadCategoryImage(newCat.id, imageFile)
          await (supabase.from('categories') as any)
            .update({ image_url: imageUrl })
            .eq('id', newCat.id)
        } catch (imgErr) {
          console.error('Category image upload failed:', imgErr)
        }
      }
      
      setAddingCategory(false)
      await refreshCategories()
      setExpandedCategory(newCat.id)
    } catch (err: any) {
      setError(err.message)
    } finally {
      setLoading(false)
    }
  }

  const handleSaveItem = async (categoryId: string, itemData: {
    name: string
    description?: string
    price?: number
    image?: File
  }) => {
    setLoading(true)
    try {
      const { data: newItem, error: insertError } = await (supabase.from('items') as any)
        .insert({
          category_id: categoryId,
          name: itemData.name,
          description: itemData.description || null,
          price: itemData.price || null,
          available: true
        })
        .select()
        .single()

      if (insertError) throw insertError

      if (itemData.image && newItem?.id) {
        try {
          const imageUrl = await uploadItemImage(newItem.id, itemData.image)
          await (supabase.from('items') as any)
            .update({ image_url: imageUrl })
            .eq('id', newItem.id)
        } catch (imageError) {
          console.error('Image upload failed:', imageError)
        }
      }
      
      setEditingItem(null)
      await refreshCategories()
    } catch (err: any) {
      setError(err.message)
    } finally {
      setLoading(false)
    }
  }

  const handleDeleteItem = async (itemId: string, imageUrl: string | null) => {
    if (!confirm('هل تريد حذف هذا العنصر؟')) return
    setLoading(true)
    try {
      if (imageUrl) {
        try { await deleteImage(imageUrl) } catch {}
      }
      await (supabase.from('items') as any).delete().eq('id', itemId)
      await refreshCategories()
    } catch (err: any) {
      setError(err.message)
    } finally {
      setLoading(false)
    }
  }

  const handleDeleteCategory = async (categoryId: string, imageUrl: string | null) => {
    if (!confirm('هل تريد حذف هذه الفئة وجميع العناصر؟')) return
    setLoading(true)
    try {
      if (imageUrl) {
        try { await deleteImage(imageUrl) } catch {}
      }
      await (supabase.from('categories') as any).delete().eq('id', categoryId)
      await refreshCategories()
    } catch (err: any) {
      setError(err.message)
    } finally {
      setLoading(false)
    }
  }

  const handleUpdateCategoryImage = async (categoryId: string, imageFile: File, oldImageUrl: string | null) => {
    setLoading(true)
    try {
      if (oldImageUrl) {
        try { await deleteImage(oldImageUrl) } catch {}
      }
      const imageUrl = await uploadCategoryImage(categoryId, imageFile)
      await (supabase.from('categories') as any)
        .update({ image_url: imageUrl })
        .eq('id', categoryId)
      await refreshCategories()
    } catch (err: any) {
      setError(err.message)
    } finally {
      setLoading(false)
    }
  }

  const toggleAvailability = async (itemId: string, currentAvailable: boolean) => {
    try {
      await (supabase.from('items') as any)
        .update({ available: !currentAvailable })
        .eq('id', itemId)
      await refreshCategories()
    } catch (err) {
      console.error('Error toggling availability:', err)
    }
  }

  return (
    <div className="space-y-5">
      {error && (
        <div className="px-4 py-3 bg-red-50 border border-red-200 rounded-xl text-red-700 text-sm lg:text-base flex justify-between items-center">
          <span>{error}</span>
          <button onClick={() => setError(null)} className="text-red-400 hover:text-red-600 text-lg">✕</button>
        </div>
      )}

      {/* Add Category */}
      {!addingCategory ? (
        <button
          onClick={() => setAddingCategory(true)}
          disabled={loading}
          className="w-full py-4 border-2 border-dashed border-zinc-300 rounded-2xl text-base lg:text-lg font-medium text-zinc-500 hover:text-zinc-700 hover:border-zinc-400 transition-colors disabled:opacity-50"
        >
          + إضافة فئة
        </button>
      ) : (
        <CategoryForm
          onSave={handleAddCategory}
          onCancel={() => setAddingCategory(false)}
          loading={loading}
        />
      )}

      {/* Categories */}
      {categories.length === 0 && !addingCategory ? (
        <div className="text-center py-16 text-zinc-400 text-base lg:text-lg">
          لا توجد فئات بعد. أضف واحدة للبدء.
        </div>
      ) : (
        <div className="space-y-4">
          {categories.map((category) => {
            const isExpanded = expandedCategory === category.id
            const itemCount = category.items?.filter(i => i.available).length || 0
            
            return (
              <div 
                key={category.id} 
                className="bg-white rounded-2xl border border-zinc-200 overflow-hidden"
              >
                {/* Category Header */}
                <button
                  onClick={() => setExpandedCategory(isExpanded ? null : category.id)}
                  className="w-full p-5 lg:p-6 flex items-center justify-between hover:bg-zinc-50 transition-colors"
                >
                  <div className="flex items-center gap-4">
                    {category.image_url ? (
                      <img 
                        src={category.image_url} 
                        alt="" 
                        className="w-12 h-12 lg:w-14 lg:h-14 rounded-xl object-cover"
                      />
                    ) : (
                      <div className="w-12 h-12 lg:w-14 lg:h-14 rounded-xl bg-zinc-100 flex items-center justify-center text-zinc-400">
                        <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16" />
                        </svg>
                      </div>
                    )}
                    <div className="text-right">
                      <h3 className="font-bold text-zinc-900 text-base lg:text-lg">{category.name}</h3>
                      <p className="text-sm lg:text-base text-zinc-500">{itemCount} عناصر</p>
                    </div>
                  </div>
                  <span 
                    className={`text-zinc-400 transition-transform text-lg ${isExpanded ? 'rotate-180' : ''}`}
                  >
                    ▼
                  </span>
                </button>

                {/* Expanded Content */}
                {isExpanded && (
                  <div className="border-t border-zinc-100">
                    {/* Category Actions */}
                    <div className="px-5 lg:px-6 py-4 bg-zinc-50 flex gap-3 flex-wrap">
                      <button
                        onClick={() => setEditingItem('new-' + category.id)}
                        disabled={loading}
                        className="px-4 py-2 bg-zinc-900 text-white rounded-xl text-sm lg:text-base font-medium hover:bg-zinc-800 disabled:opacity-50"
                      >
                        + إضافة عنصر
                      </button>
                      <label className="px-4 py-2 bg-white border border-zinc-200 text-zinc-700 rounded-xl text-sm lg:text-base font-medium hover:bg-zinc-50 cursor-pointer flex items-center gap-2">
                        <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
                        </svg>
                        صورة
                        <input
                          type="file"
                          accept="image/*"
                          className="hidden"
                          onChange={(e) => {
                            const file = e.target.files?.[0]
                            if (file) handleUpdateCategoryImage(category.id, file, category.image_url)
                          }}
                        />
                      </label>
                      <button
                        onClick={() => handleDeleteCategory(category.id, category.image_url)}
                        disabled={loading}
                        className="px-4 py-2 bg-red-50 text-red-600 rounded-xl text-sm lg:text-base font-medium hover:bg-red-100 disabled:opacity-50 mr-auto"
                      >
                        حذف
                      </button>
                    </div>

                    {/* Add Item Form */}
                    {editingItem === 'new-' + category.id && (
                      <div className="p-5 lg:p-6 border-t border-zinc-100">
                        <ItemForm
                          onSave={(data) => handleSaveItem(category.id, data)}
                          onCancel={() => setEditingItem(null)}
                          loading={loading}
                        />
                      </div>
                    )}

                    {/* Items */}
                    <div className="divide-y divide-zinc-100">
                      {category.items?.map((item) => (
                        <div 
                          key={item.id} 
                          className={`p-5 lg:p-6 flex items-center gap-4 ${!item.available ? 'opacity-50' : ''}`}
                        >
                          {item.image_url ? (
                            <img 
                              src={item.image_url} 
                              alt="" 
                              className="w-14 h-14 lg:w-16 lg:h-16 rounded-xl object-cover flex-shrink-0"
                            />
                          ) : (
                            <div className="w-14 h-14 lg:w-16 lg:h-16 rounded-xl bg-zinc-100 flex items-center justify-center text-zinc-300 text-xs flex-shrink-0">
                              صورة
                            </div>
                          )}
                          
                          <div className="flex-1 min-w-0">
                            <div className="flex items-center gap-3">
                              <h4 className="font-semibold text-zinc-900 text-base lg:text-lg truncate">{item.name}</h4>
                              {item.price && (
                                <span className="text-sm lg:text-base font-bold text-zinc-600 whitespace-nowrap" dir="ltr">
                                  {Number(item.price).toFixed(2)} TD
                                </span>
                              )}
                            </div>
                            {item.description && (
                              <p className="text-sm lg:text-base text-zinc-500 truncate mt-1">{item.description}</p>
                            )}
                          </div>
                          
                          <div className="flex items-center gap-3 flex-shrink-0">
                            <button
                              onClick={() => toggleAvailability(item.id, item.available)}
                              className={`w-10 h-6 rounded-full transition-colors relative ${
                                item.available ? 'bg-green-500' : 'bg-zinc-300'
                              }`}
                            >
                              <span 
                                className={`absolute top-1 w-4 h-4 rounded-full bg-white shadow transition-all ${
                                  item.available ? 'left-5' : 'left-1'
                                }`}
                              />
                            </button>
                            <button
                              onClick={() => handleDeleteItem(item.id, item.image_url)}
                              className="text-zinc-400 hover:text-red-500 text-lg"
                            >
                              ✕
                            </button>
                          </div>
                        </div>
                      ))}
                      
                      {(!category.items || category.items.length === 0) && editingItem !== 'new-' + category.id && (
                        <div className="p-10 text-center text-zinc-400 text-base lg:text-lg">
                          لا توجد عناصر بعد
                        </div>
                      )}
                    </div>
                  </div>
                )}
              </div>
            )
          })}
        </div>
      )}
    </div>
  )
}


function CategoryForm({
  onSave,
  onCancel,
  loading
}: {
  onSave: (name: string, image?: File) => void
  onCancel: () => void
  loading: boolean
}) {
  const [name, setName] = useState('')
  const [image, setImage] = useState<File | null>(null)

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    if (!name.trim()) return
    onSave(name.trim(), image || undefined)
  }

  return (
    <form onSubmit={handleSubmit} className="bg-white rounded-2xl border border-zinc-200 p-5 lg:p-6">
      <div className="flex gap-4">
        <input
          type="text"
          value={name}
          onChange={(e) => setName(e.target.value)}
          placeholder="اسم الفئة"
          autoFocus
          className="flex-1 px-4 py-3 border border-zinc-200 rounded-xl text-base lg:text-lg focus:outline-none focus:ring-2 focus:ring-zinc-900 focus:border-transparent"
        />
        <label className="px-4 py-3 bg-zinc-100 text-zinc-600 rounded-xl cursor-pointer hover:bg-zinc-200 transition-colors flex items-center gap-2">
          <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
          </svg>
          <input
            type="file"
            accept="image/*"
            className="hidden"
            onChange={(e) => setImage(e.target.files?.[0] || null)}
          />
        </label>
      </div>
      
      {image && (
        <p className="text-sm lg:text-base text-zinc-500 mt-3">صورة: {image.name}</p>
      )}
      
      <div className="flex gap-3 mt-4">
        <button
          type="submit"
          disabled={loading || !name.trim()}
          className="px-5 py-3 bg-zinc-900 text-white rounded-xl text-base lg:text-lg font-medium hover:bg-zinc-800 disabled:opacity-50"
        >
          {loading ? 'جاري الإنشاء...' : 'إنشاء'}
        </button>
        <button
          type="button"
          onClick={onCancel}
          className="px-5 py-3 bg-zinc-100 text-zinc-700 rounded-xl text-base lg:text-lg font-medium hover:bg-zinc-200"
        >
          إلغاء
        </button>
      </div>
    </form>
  )
}


function ItemForm({ 
  onSave, 
  onCancel, 
  loading 
}: { 
  onSave: (data: { name: string; description?: string; price?: number; image?: File }) => void
  onCancel: () => void
  loading: boolean
}) {
  const [name, setName] = useState('')
  const [description, setDescription] = useState('')
  const [price, setPrice] = useState('')
  const [image, setImage] = useState<File | null>(null)

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    if (!name.trim()) return
    onSave({
      name: name.trim(),
      description: description.trim() || undefined,
      price: price ? parseFloat(price) : undefined,
      image: image || undefined
    })
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-4">
      <div className="grid grid-cols-2 gap-4">
        <input
          type="text"
          value={name}
          onChange={(e) => setName(e.target.value)}
          placeholder="اسم العنصر"
          autoFocus
          className="col-span-2 sm:col-span-1 px-4 py-3 border border-zinc-200 rounded-xl text-base lg:text-lg focus:outline-none focus:ring-2 focus:ring-zinc-900 focus:border-transparent"
        />
        <input
          type="number"
          step="0.01"
          min="0"
          value={price}
          onChange={(e) => setPrice(e.target.value)}
          placeholder="السعر (TD)"
          dir="ltr"
          className="col-span-2 sm:col-span-1 px-4 py-3 border border-zinc-200 rounded-xl text-base lg:text-lg focus:outline-none focus:ring-2 focus:ring-zinc-900 focus:border-transparent"
        />
        <input
          type="text"
          value={description}
          onChange={(e) => setDescription(e.target.value)}
          placeholder="الوصف (اختياري)"
          className="col-span-2 px-4 py-3 border border-zinc-200 rounded-xl text-base lg:text-lg focus:outline-none focus:ring-2 focus:ring-zinc-900 focus:border-transparent"
        />
      </div>
      
      <div className="flex items-center gap-4">
        <label className="px-4 py-2 bg-zinc-100 text-zinc-600 rounded-xl text-sm lg:text-base cursor-pointer hover:bg-zinc-200 transition-colors flex items-center gap-2">
          <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
          </svg>
          {image ? image.name.slice(0, 15) + '...' : 'إضافة صورة'}
          <input
            type="file"
            accept="image/*"
            className="hidden"
            onChange={(e) => setImage(e.target.files?.[0] || null)}
          />
        </label>
        
        <div className="flex-1" />
        
        <button
          type="button"
          onClick={onCancel}
          className="px-4 py-2 text-zinc-500 text-base lg:text-lg font-medium hover:text-zinc-700"
        >
          إلغاء
        </button>
        <button
          type="submit"
          disabled={loading || !name.trim()}
          className="px-5 py-2 bg-zinc-900 text-white rounded-xl text-base lg:text-lg font-medium hover:bg-zinc-800 disabled:opacity-50"
        >
          {loading ? 'جاري الإضافة...' : 'إضافة عنصر'}
        </button>
      </div>
    </form>
  )
}
