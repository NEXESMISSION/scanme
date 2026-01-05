import { notFound } from 'next/navigation'
import { getBusinessBySlug, getBusinessWithCategoriesAndItems } from '@/lib/db/business'
import { getTheme } from '@/lib/themes'
import PublicMenu from '@/components/menu/PublicMenu'

export default async function PublicMenuPage({
  params,
}: {
  params: { slug: string }
}) {
  let business
  try {
    business = await getBusinessBySlug(params.slug)
  } catch (error) {
    console.error('Error fetching business:', error)
    notFound()
  }
  
  if (!business) {
    notFound()
  }

  // Check if business is expired or paused
  // If expired, treat it as paused for display purposes
  let isPaused = business.status === 'paused'
  
  if (business.expires_at && business.status === 'active') {
    const now = new Date()
    const expiry = new Date(business.expires_at)
    
    if (expiry < now) {
      // Business has expired - treat as paused for public display
      // But don't update status here (let super admin or cron handle it)
      isPaused = true
    }
  }

  // If paused or expired, still load categories but pass isPaused flag
  let categories = []
  if (!isPaused) {
    try {
      categories = (await getBusinessWithCategoriesAndItems(business.id)) || []
    } catch (error) {
      console.error('Error loading categories:', error)
      categories = []
    }
  }

  const theme = getTheme(business.theme_id)

  // Create a business object with modified status for display
  const businessForDisplay = {
    ...business,
    status: isPaused ? 'paused' as const : business.status
  }

  return (
    <PublicMenu
      business={businessForDisplay}
      categories={categories}
      theme={theme}
    />
  )
}

export async function generateMetadata({ params }: { params: { slug: string } }) {
  try {
    const business = await getBusinessBySlug(params.slug)
    return {
      title: business?.name || 'Menu',
    }
  } catch {
    return {
      title: 'Menu',
    }
  }
}
