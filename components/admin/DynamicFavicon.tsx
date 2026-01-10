'use client'

import { useEffect } from 'react'

interface DynamicFaviconProps {
  logoUrl: string | null
  businessName: string
}

export default function DynamicFavicon({ logoUrl, businessName }: DynamicFaviconProps) {
  useEffect(() => {
    if (!logoUrl) return

    // Remove existing favicon
    const existingFavicon = document.querySelector("link[rel='icon']")
    if (existingFavicon) {
      existingFavicon.remove()
    }

    // Create new favicon link
    const link = document.createElement('link')
    link.rel = 'icon'
    link.type = 'image/png'
    link.href = logoUrl
    document.head.appendChild(link)

    // Also set apple-touch-icon
    const appleLink = document.querySelector("link[rel='apple-touch-icon']")
    if (appleLink) {
      appleLink.remove()
    }
    const apple = document.createElement('link')
    apple.rel = 'apple-touch-icon'
    apple.href = logoUrl
    document.head.appendChild(apple)

    // Update page title
    document.title = businessName

    return () => {
      // Cleanup on unmount - use .remove() which is safer than removeChild
      try {
        if (link && link.isConnected) {
          link.remove()
        }
      } catch (e) {
        // Element may have already been removed
      }
      try {
        if (apple && apple.isConnected) {
          apple.remove()
        }
      } catch (e) {
        // Element may have already been removed
      }
    }
  }, [logoUrl, businessName])

  return null
}

