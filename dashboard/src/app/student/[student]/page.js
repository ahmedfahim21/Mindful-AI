'use client'
import { useParams } from "next/navigation"
import { useEffect, useState } from "react"
import { collection, doc, getDoc } from "firebase/firestore"
import { db } from "@/firebase/config"


export default function Student() {

  const { student } = useParams()
  // console.log(student)

  const [studentData, setStudentData] = useState(null)

  const studentRef = doc(db, "students", student)
  // console.log(studentRef)

  const getStudent = async () => {
    const studentDoc = await getDoc(studentRef)
    console.log(studentDoc.data())
    setStudentData(studentDoc.data())
  }

  useEffect(() => {
    getStudent()
  }, [])


  return(

    <main className="flex flex-col items-center justify-between p-5 overflow-y-hidden">
        <div className="flex flex-col items-center justify-center w-full h-full">
      {
        studentData ? (
          <div className="absolute z-10 right-10 top-32 w-3/4 h-5/6 bg-white rounded-3xl p-5">
            <h1>{studentData.name}</h1>
            <p>{studentData.dob}</p>
          
          </div>
        ) : (
          <h1>Loading...</h1>
        )
      }
    <img src='/Rectangle.png' className="w-[85%] absolute right-0 top-[10%]" />
    </div>
    </main>

  )


}