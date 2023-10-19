'use client'
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { useState } from "react"

function Login() {
    const [isLoading, setIsLoading] = useState(false)

  return (
    <div className="flex">
        <img src="ScreenBg.png" className=" h-screen object-cover" />
        <div className="flex flex-col justify-center items-center w-full">
            <h1 className="text-4xl font-bold my-[80px]">SIGN IN</h1>
        <form className="flex flex-col items-center justify-center">
            <div className="grid gap-8">
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