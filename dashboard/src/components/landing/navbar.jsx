import Link from 'next/link';



function Navbar() {


  return (
    <div id="home" className='flex  flex-1 justify-between items-center sm:h-24 h-16 w-full mx-auto px-4 text-white bg-primary '>
      {/* <h1 className='text-4xl font-bold'>TEAM JUST NOT IDEAS</h1> */}
      <ul className='hidden md:flex font-medium text-md'>
        <Link href="/login"><li className='p-4'>LOGIN</li></Link>
        <Link href="/register"><li className='p-4'>SIGNUP</li></Link>
      </ul>
    </div>
  )
}

export default Navbar