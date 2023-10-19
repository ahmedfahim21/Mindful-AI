'use client'
import { useParams } from "next/navigation"
import { useEffect, useState } from "react"
import { doc, getDoc } from "firebase/firestore"
import { db } from "@/firebase/config"

function Student() {

    const studentId = useParams()
    console.log(studentId)
    const [student, setStudent] = useState([])
    

    useEffect(() => {
        const read = async () => {
          if(done){
          const docRef = doc(db, "students", studentId.student);
          console.log(studentId.student)
          const docSnap = await getDoc(docRef);
    
          if (docSnap.exists()) {
            await setStudent(docSnap.data())
            console.log(student)
    
          } else {
            console.log("No such document!");
          }
        }
      }
      read()
      }, [])


  return (
    <main className="flex flex-col items-center justify-between p-5 overflow-y-hidden">
    <div className="flex flex-col items-center justify-center w-full h-full">
      <div className="absolute z-10 right-10 top-32 w-3/4 h-5/6 bg-white rounded-3xl p-5">
        page
    </div>
    </div>
    </main>
  )
}

export default Student