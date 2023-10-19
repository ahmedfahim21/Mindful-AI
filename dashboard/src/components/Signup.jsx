'use client'
import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { getAuth, createUserWithEmailAndPassword } from "firebase/auth";
import { app, db } from '@/firebase/config';
import { doc, setDoc } from 'firebase/firestore';


const SignUp = () => {
  const auth = getAuth(app);
  const [email, setEmail] = useState("tes1t@test.com");
  const [name, setName] = useState("test");
  const [passwordOne, setPasswordOne] = useState("test123");
  const [passwordTwo, setPasswordTwo] = useState("test123");
  const router = useRouter();
  const [error, setError] = useState(null);

  const onSubmit = event => {
    event.preventDefault();
    console.log(email, passwordOne, passwordTwo)
    setError(null)
    //check if passwords match. If they do, create user in Firebase
    // and redirect to your logged in page.
    if (passwordOne === passwordTwo)
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

        })

        .catch(error => {
          // An error occurred. Set error message to be displayed to user
          setError(error.message)
        });
    else
      setError("Password do not match")
  };

  return (



    <form>

      <div className="form-group">
        <label htmlFor="email">Email address</label>
        <input type="email" className="form-control" id="email"
          onChange={event => setEmail(event.target.value)}
          value={email} />
      </div>

      <div className="form-group">
        <label htmlFor="passwordOne">Password</label>
        <input type="password" className="form-control" id="passwordOne"
          onChange={event => setPasswordOne(event.target.value)}
          value={passwordOne} />
      </div>

      <div className="form-group">
        <label htmlFor="passwordTwo">Confirm Password</label>
        <input type="password" className="form-control" id="passwordTwo"
          onChange={event => setPasswordTwo(event.target.value)}
          value={passwordTwo} />
      </div>

      <button type="submit" className="btn btn-primary" onClick={onSubmit}>Sign Up</button>

      <div className="error">
        {error ? <p>{error}</p> : null}
      </div>
    </form>


  )
}

export default SignUp;