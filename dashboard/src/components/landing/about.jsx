



function About() {
  return (
    <div className="w-full bg-secondary py-16 px-4 " id="about">
      <div className="max-w-[1240px] mx-auto grid md:grid-cols-2 ">
        <img className="w-[400px] mx-auto my-4" src="emotional-health.png" alt="/" />
        <div className="flex flex-col justify-center">
          <h1 className="md:text-4xl sm:text-3xl text-2xl font-bold py-2 text-white">Introducing the comprehensive mental illness onset detection system</h1>
          <p>We help organisations to detect the onset of mental illness in their students, and provide them with the necessary tools for the same.</p>
          {/* <a target='blank' ><button className='bg-white w-[200px] rounded-md font-medium my-6 mx-auto md:mx-0 py-4 text-center text-[#2abfff]'>Get Started</button></a> */}
        </div>
      </div>


      <div className='max-w-[1240px] mx-auto grid md:grid-cols-2'>
        <div className='md:text-5xl sm:text-3xl text-2xl font-bold py-2 my-auto text-white mx-auto'>
          <p>You do the steps,</p>
          <p>we handle the <span className='text-black'>rest.</span></p>

          {/* <p className='md:text-[20px] sm:text-[12px] text-[10px] py-2 my-auto text-slate-600 mx-auto'>Our system is powered by Machine Learning models to extract text from pdfs and summarise them..</p> */}
        </div>

        <div>

          <div className='border-2 bg-slate-50 rounded-[33px] m-2 p-4 flex'>
            {/* <div className='border-2 border-white rounded-[88px]  m-1 mt-2 text-center my-auto'>1</div> */}
            <div className='text-[33px] my-auto text-white mx-2'>
              {/* <HiChevronDoubleRight></HiChevronDoubleRight> */}
            </div>
            <div>
              <h1 className='text-[32px] font-semibold'>Register your organisation</h1>
              <p className='text-[20px] text-slate-600'>
                Login with your email and password and register your organisation
              </p>
            </div>
          </div>

          <div className='border-2 bg-white rounded-[33px] m-2 p-4 flex'>

            <div className='text-[33px] my-auto text-white mx-2'>
              {/* <HiChevronDoubleRight></HiChevronDoubleRight> */}
            </div>
            <div>
              <h1 className='text-[32px] font-semibold'>User App</h1>
              <p className='text-[20px] text-slate-900'>
                Download the user app and share it with your students
              </p>
            </div>
          </div>

          <div className='border-2 bg-white rounded-[33px] m-2 p-4 flex'>

            <div className='text-[33px] my-auto text-white mx-2'>
              {/* <HiChevronDoubleRight></HiChevronDoubleRight> */}
            </div>
            <div>
              <h1 className='text-[32px] font-semibold text-black'>Mindful Analysis</h1>
              <p className='text-[20px] text-slate-600'>
               Get access to the dashboard and analyse the granular data
              </p>
            </div>
          </div>
        </div>
      </div>

    </div>
  )
}

export default About