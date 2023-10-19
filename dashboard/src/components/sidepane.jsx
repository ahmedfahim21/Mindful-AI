'use client';
import Link  from 'next/link'


function Sidepane() {

    const admin = localStorage.getItem('admin')?localStorage.getItem('admin'):''

    return (
      <div>
          <div className="absolute z-10 left-10 top-32 w-1/4 h-5/6 rounded-3xl p-5">
          <Link href={`/${admin}`}><button className="w-[60%] my-2 h-10 bg-primary rounded-md text-white">Dashboard</button></Link>
          <Link href='/analytics'><button className="w-[60%] my-2 h-10 bg-secondary rounded-md text-white">Analytics</button></Link>
          <button className="w-[60%] my-2 h-10 bg-secondary rounded-md text-white">Settings</button>
        </div>
      </div>
    )
  }
  
  export default Sidepane