import { getBusinessBySlug } from '@/lib/db/business'
import type { Metadata } from 'next'

export async function generateMetadata({ params }: { params: { slug: string } }): Promise<Metadata> {
  try {
    const business = await getBusinessBySlug(params.slug)
    
    if (!business) {
      return {
        title: 'Menu',
      }
    }

    return {
      title: business.name || 'Menu',
      description: `قائمة ${business.name}`,
      icons: business.logo_url ? {
        icon: business.logo_url,
        apple: business.logo_url,
      } : undefined,
    }
  } catch {
    return {
      title: 'Menu',
    }
  }
}

export default function MenuLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return <>{children}</>
}

