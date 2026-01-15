'use client'

import { useEffect, useRef } from 'react'

interface DynamicFaviconProps {
  logoUrl: string | null
  businessName: string
}

export default function DynamicFavicon({ logoUrl, businessName }: DynamicFaviconProps) {
  const linkRef = useRef<HTMLLinkElement | null>(null)
  const appleRef = useRef<HTMLLinkElement | null>(null)
  const mountedRef = useRef(true)
  const cleanupRef = useRef(false)

  useEffect(() => {
    // Only run in browser
    if (typeof window === 'undefined' || typeof document === 'undefined') return
    if (!logoUrl) return

    // Skip if we're in the middle of a cleanup (Fast Refresh scenario)
    if (cleanupRef.current) {
      cleanupRef.current = false
      return
    }

    mountedRef.current = true

    // Use setTimeout to ensure DOM is ready and avoid Fast Refresh issues
    const timeoutId = setTimeout(() => {
      if (!mountedRef.current) return

      try {
        // Remove existing favicon safely using .remove() method
        const existingFavicon = document.querySelector("link[rel='icon']")
        if (existingFavicon && existingFavicon.isConnected) {
          existingFavicon.remove()
        }

        // Create new favicon link
        const link = document.createElement('link')
        link.rel = 'icon'
        link.type = 'image/png'
        link.href = logoUrl
        linkRef.current = link
        
        if (document.head) {
          document.head.appendChild(link)
        }

        // Also set apple-touch-icon
        const appleLink = document.querySelector("link[rel='apple-touch-icon']")
        if (appleLink && appleLink.isConnected) {
          appleLink.remove()
        }
        
        const apple = document.createElement('link')
        apple.rel = 'apple-touch-icon'
        apple.href = logoUrl
        appleRef.current = apple
        
        if (document.head) {
          document.head.appendChild(apple)
        }

        // Update page title
        document.title = businessName
      } catch (e) {
        // Silently ignore errors during Fast Refresh
        // This is a known issue with React Fast Refresh and DOM manipulation
      }
    }, 0)

    return () => {
      mountedRef.current = false
      cleanupRef.current = true
      clearTimeout(timeoutId)
      
      // Skip cleanup during Fast Refresh to avoid React errors
      // React will handle cleanup of hoisted elements
      if (process.env.NODE_ENV === 'development') {
        // In development, let React handle cleanup to avoid Fast Refresh issues
        linkRef.current = null
        appleRef.current = null
        return
      }
      
      // Production cleanup - use .remove() which is safer
      try {
        const link = linkRef.current
        if (link && link.isConnected && link.parentNode) {
          // Check if parentNode still exists before removing
          const parent = link.parentNode
          if (parent && parent.contains(link)) {
            link.remove()
          }
        }
      } catch (e) {
        // Element may have already been removed - safe to ignore
      } finally {
        linkRef.current = null
      }
      
      try {
        const apple = appleRef.current
        if (apple && apple.isConnected && apple.parentNode) {
          // Check if parentNode still exists before removing
          const parent = apple.parentNode
          if (parent && parent.contains(apple)) {
            apple.remove()
          }
        }
      } catch (e) {
        // Element may have already been removed - safe to ignore
      } finally {
        appleRef.current = null
      }
    }
  }, [logoUrl, businessName])

  return null
}

