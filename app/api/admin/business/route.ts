import { NextResponse } from 'next/server'
import { requireOwner } from '@/lib/auth'
import { getBusinessByOwner } from '@/lib/db/business'

export async function GET() {
  try {
    const { user } = await requireOwner()
    const business = await getBusinessByOwner(user.id)

    if (!business) {
      return NextResponse.json({ error: 'Business not found' }, { status: 404 })
    }

    // Don't auto-pause here - owners should always access their dashboard
    // Return business as-is, even if expired - dashboard will show warning
    return NextResponse.json(business)
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Internal server error' },
      { status: 500 }
    )
  }
}
