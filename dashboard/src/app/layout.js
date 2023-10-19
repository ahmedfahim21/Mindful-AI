import { Roboto } from 'next/font/google'
import './globals.css'

const roboto = Roboto({weight: '400', subsets: ['cyrillic']})

export const metadata = {
  title: 'Mindful AI',
  description: 'Nurturing Mental Wellness with Technology',
}

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body className={roboto.className}>{children}</body>
    </html>
  )
}
