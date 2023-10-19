

function Sidepane() {
    return (
      <div>
          <div className="absolute z-10 left-10 top-32 w-1/4 h-5/6 rounded-3xl p-5">
          <button className="w-[60%] my-2 h-10 bg-primary rounded-md text-white">Dashboard</button>
          <button className="w-[60%] my-2 h-10 bg-secondary rounded-md text-white">Analytics</button>
          <button className="w-[60%] my-2 h-10 bg-secondary rounded-md text-white">Settings</button>
        </div>
      </div>
    )
  }
  
  export default Sidepane