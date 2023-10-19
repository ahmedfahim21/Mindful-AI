

function Navbar() {
    return (
      <div className="z-10 w-full font-mada text-xl mx-auto p-5 top-0 flow-root">
          <img src="logo.png" className="h-[50px] w-[50px] mx-5 float-left" />
          <p className="text-2xl my-2 float-left">MINDFUL AI DASHBOARD</p>
  
          <div className="float-right flex">
          <div className=" left-10 w-[500px] h-[50px] my-1 rounded-md bg-white"></div>
          <div className="w-[50px] h-[50px] my-1 rounded-md bg-primary mx-2 "></div>
          <div className="w-[55px] h-[55px]  rounded-md bg-black mx-2 text-white text-center text-4xl pt-1">N</div>
          </div>
      </div>
    )
  }
  
  export default Navbar