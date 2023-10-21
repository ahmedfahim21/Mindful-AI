
'use client';
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover"
import Link from "next/link";
import { useRouter } from "next/navigation"

function Navbar() {

    const router = useRouter()

    const logoutHandler = () => {
      localStorage.removeItem('admin')
      router.push('/login')
    }


    return (
      <div className="z-10 w-full font-mada text-xl mx-auto p-5 top-0 flow-root">
        <Link href="/" className="pointer-cursor">
          <img src="/logo.png" className="h-[50px] w-[50px] mx-5 float-left" />
          <p className="text-2xl my-2 float-left">MINDFUL AI DASHBOARD by </p><p className="text-3xl my-2 float-left text-primary font-bold">( TEAM "JUST NOT IDEAS" )</p>
        </Link>
          <div className="float-right flex">
          {/* <div className=" left-10 w-[500px] h-[50px] my-1 rounded-md bg-white border-gray border-2"></div> */}
          {/* <div className="w-[50px] p-2 h-[50px] my-1 rounded-md bg-primary mx-2 "><img src='/search.png'/></div> */}
          
          

          <Popover>
            <PopoverTrigger asChild>
            <Avatar className="w-[50px] h-[50px] m-1 bg-black">
              <AvatarImage src="/" />
              <AvatarFallback>M</AvatarFallback>
            </Avatar>
            </PopoverTrigger>
            <PopoverContent className="w-60">
              <div className="grid gap-4">
                <div className="space-y-2">
                  <h4 className="font-medium leading-none">Do you want to Logout?</h4>
                </div>
                <Button className="w-full" onClick={logoutHandler}>Logout</Button>
              </div>
            </PopoverContent>
          </Popover>


          </div>
      </div>
    )
  }
  
  export default Navbar