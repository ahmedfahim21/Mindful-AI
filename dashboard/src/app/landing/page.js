import About from "@/components/landing/about"
import Hero from "@/components/landing/hero"
import Navbar from "@/components/landing/navbar"



const Home = () => {
  
  return (
    <div>
      <Navbar />
      <Hero />
      <About />


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