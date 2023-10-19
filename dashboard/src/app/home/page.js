import React from 'react'

function page() {
  return (
    <main className="flex flex-col items-center justify-between p-5 overflow-y-hidden">
        <div className="flex flex-col items-center justify-center w-full h-full">
            <h1 className="text-5xl font-bold text-center text-primary">Welcome to the Mindful AI Dashboard</h1>
            <p className="text-2xl text-center text-secondary">This is a dashboard for the Mindful AI project</p>
        </div>
    </main>
  )
}

export default page