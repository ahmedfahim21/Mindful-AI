'use client'
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Checkbox } from "@/components/ui/checkbox"

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { getAuth, createUserWithEmailAndPassword } from "firebase/auth";
import { app, db } from '@/firebase/config';
import { doc, setDoc } from 'firebase/firestore';


function Register() {
    const [isLoading, setIsLoading] = useState(false)

    const auth = getAuth(app);
    const [email, setEmail] = useState("tes1t@test.com");
    const [name, setName] = useState("test");
    const [passwordOne, setPasswordOne] = useState("test123");
    const router = useRouter();
    const [error, setError] = useState(null);

    const onSubmit = event => {
        event.preventDefault();
        console.log(email, passwordOne)
        setError(null)
        //check if passwords match. If they do, create user in Firebase
        // and redirect to your logged in page.

        createUserWithEmailAndPassword(auth, email, passwordOne)
            .then(async (authUser) => {

                const admin = {
                    email: authUser.user.email,
                    uid: authUser.user.uid,
                    name: name,
                }

                //add the user to your own firebase database at 'admin'
                const adminInsert = await setDoc(doc(db, 'admin', authUser.user.uid), admin)
                console.log(adminInsert)
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
                <h1 className="text-4xl font-bold my-[80px]">Register Institution</h1>
                <form className="flex flex-col items-center justify-center">
                    <div className="grid gap-8">
                        <div className="grid gap-2">
                            <Label className="font-thin" htmlFor="insti">
                                Institution Name*
                            </Label>
                            <Input
                                onChange={event => setName(event.target.value)}
                                value={name}
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


                        <Button
                            onClick={onSubmit}
                            className="font-bold">
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

export default Register