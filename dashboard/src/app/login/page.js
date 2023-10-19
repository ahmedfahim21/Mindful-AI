'use client'
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Checkbox } from "@/components/ui/checkbox"

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { getAuth, signInWithEmailAndPassword } from "firebase/auth";
import { app, db } from '@/firebase/config';
import { doc, setDoc } from 'firebase/firestore';


function Login() {
    const [isLoading, setIsLoading] = useState(false)

    const auth = getAuth(app);
    const [email, setEmail] = useState("");
    const [passwordOne, setPasswordOne] = useState("");
    const router = useRouter();
    const [error, setError] = useState(null);

    const onSubmit = event => {
        event.preventDefault();
        console.log(email, passwordOne)
        setError(null)
        //check if passwords match. If they do, create user in Firebase
        // and redirect to your logged in page.

        signInWithEmailAndPassword(auth, email, passwordOne)
            .then((authUser) => {
                localStorage.setItem('admin', authUser.user.uid)
                router.push(`/${authUser.user.uid}`)
            })

            .catch(error => {
                // An error occurred. Set error message to be displayed to user
                setError(error.message)
            });

    };

    return (
        <div className="flex">
            <img src="ScreenBg.png" className=" h-screen object-cover" />
            <div className="flex flex-col justify-center items-center w-full">
                <h1 className="text-4xl font-bold my-[80px]">Login Institution</h1>
                <form className="flex flex-col items-center justify-center">
                    <div className="grid gap-8">
                        <div className="grid gap-2">
                            <Label className="font-thin" htmlFor="email">
                                Email Address*
                            </Label>
                            <Input
                                onChange={event => setEmail(event.target.value)}
                                value={email}
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
                                onChange={event => setPasswordOne(event.target.value)}
                                value={passwordOne}
                                id="password"
                                placeholder="Enter password"
                                type="password"
                                autoCapitalize="none"
                                autoComplete="email"
                                autoCorrect="off"
                                disabled={isLoading}
                            />
                        </div>
                        <Button
                            onClick={onSubmit}
                            className="font-bold">
                            {isLoading && (
                                <p>Loading...</p>
                            )}
                            SIGN IN
                        </Button>
                    </div>
                    
                    <div className="error">
                        {error && <p>{error}</p>}
                    </div>

                </form>


            </div>
        </div>
    )
}

export default Login