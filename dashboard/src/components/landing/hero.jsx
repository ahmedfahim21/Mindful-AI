import Link from "next/link"


function Hero() {
  return (
    <div className='text-primary' id="home">
        <div className='max-w-[800px] mt-[-96px] w-full h-screen mx-auto text-center flex flex-col justify-center'>
            <img src="/logo.png" alt='mim-logo' className='w-[15rem] mx-auto' />
            <div className='flex justify-center items-center'>
                
            </div>
            <h1 className='text-3xl font-bold text-slate-700 p-5'>Mindful AI</h1>
            <h1 className='text-4xl font-bold text-black p-5'>TEAM JUST NOT IDEAS</h1>
            <p className='md:text-2xl text-xl text-bold text-gray-500 pt-5'>Nurturing Mental Wellness with Technology
            </p>
            <Link href="/login"><button className='bg-secondary w-[200px] rounded-md font-medium my-6 mx-auto py-4 text-white'>Get Started</button></Link>

        </div>
      
    </div>
  )
}

export default Hero