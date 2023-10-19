'use client'
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Checkbox } from "@/components/ui/checkbox"
import { useState } from "react"

function Login() {
    const [isLoading, setIsLoading] = useState(false)

  return (
    <div className="flex">
        <img src="ScreenBg.png" className=" h-screen object-cover" />
        <div className="flex flex-col justify-center items-center w-full">
            <h1 className="text-4xl font-bold my-[80px]">Register Institution</h1>
        <form className="flex flex-col items-center justify-center">
            <div className="grid gap-8">
            <div className="grid gap-2">
                <Label className="font-thin" htmlFor="insti">
                Institution Name*
                </Label>
                <Input
                id="insti"
                className="w-[500px]"
                placeholder="Enter Institution Name"
                type="text"
                autoCapitalize="none"
                autoCorrect="off"
                disabled={isLoading}
                />
            </div>
            <div className="grid gap-2">
                <Label className="font-thin" htmlFor="email">
                Email Address*
                </Label>
                <Input
                id="email"
                className="w-[500px]"
                placeholder="Enter email address"
                type="email"
                autoCapitalize="none"
                autoComplete="email"
                autoCorrect="off"
                disabled={isLoading}
                />
            </div>
            <div className="grid gap-2">
                <Label className="font-thin" htmlFor="password">
                Enter Password*
                </Label>
                <Input
                id="password"
                placeholder="Enter password"
                type="password"
                autoCapitalize="none"
                autoComplete="email"
                autoCorrect="off"
                disabled={isLoading}
                />
            </div>
            <div className="items-top flex space-x-2">
                <Checkbox id="terms1" />
                <div className="grid gap-1.5 leading-none">
                    <label
                    htmlFor="terms1"
                    className="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70"
                    >
                    Accept terms and conditions
                    </label>
                    <p className="text-sm text-muted-foreground">
                    You agree to our Terms of Service and Privacy Policy.
                    </p>
                </div>
                </div>


            <Button className="font-bold" disabled={isLoading}>
                {isLoading && (
                <p>Loading...</p>
                )}
                SIGN IN
            </Button>
            </div>
        </form>
        

        </div>
    </div>
  )
}

export default Login