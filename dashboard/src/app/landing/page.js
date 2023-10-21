import About from "@/components/landing/about"
import Hero from "@/components/landing/hero"
import Navbar from "@/components/landing/navbar"



const Home = () => {
  
  return (
    <div>
      <Navbar />
      <Hero />
      <About />
      <div className="flex flex-col justify-center m-auto w-[85%] h-[1000px]">
        <h1 className="text-4xl font-bold text-center mt-20">ADMIN DASHBOARD</h1>
        <h1 className="text-3xl text-center mb-10">How it works</h1>
        <iframe src="https://app.supademo.com/embed/2XthgTOFVJYIYPVHqjCtK" frameborder="0" webkitallowfullscreen="true" mozallowfullscreen="true" allowfullscreen className="w-[85%] h-full items-center justify-center m-auto">
        </iframe>
      </div>
        <div className="flex flex-col justify-center m-auto w-[85%] h-[1200px]">
        <h1 className="text-4xl font-bold text-center mt-20">USER APP</h1>
        <h1 className="text-3xl text-center mb-10">How it works</h1>
          <iframe src="https://app.supademo.com/embed/clnzu8nq85137pedvf7cg5g7p" frameborder="0" webkitallowfullscreen="true" mozallowfullscreen="true" allowfullscreen className="w-[25%] h-full items-center justify-center m-auto">
          </iframe>
        </div>
        
      <footer className="flex flex-col items-center justify-center text-lg w-full h-20 border-t">
        <a
          className="flex items-center justify-center"
          target="_blank"
          rel="noopener noreferrer"
          >
          Powered by{" "} 
          <img src="/logo.png" alt="Our Logo" className="h-4 ml-2 pr-3" />
          and made with ❤️ by the Just Not Ideas
        </a>
      </footer>
    </div>
    
  )
}

export default Home