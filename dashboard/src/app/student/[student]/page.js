'use client'
import { useParams } from "next/navigation"
import { useEffect, useState } from "react"
import { collection, doc, getDoc } from "firebase/firestore"
import { db } from "@/firebase/config"
import { Skeleton } from "@/components/ui/skeleton"


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
        <div className="absolute z-10 right-10 top-32 w-3/4 h-5/6 bg-white rounded-3xl p-5">
      {
        studentData ? (
          <div>
            <h1>{studentData.name}</h1>
            <p>{studentData.dob}</p>
          </div>
          
        ) : (
          <div className="flex items-center space-x-4">
            <Skeleton className="w-20 h-20 rounded-full" />
            <div className="flex flex-col items-start justify-center space-y-2">
              <Skeleton className="w-40 h-5" />
              <Skeleton className="w-20 h-5" />
            </div>
            
          </div>
        )
      }
      </div>
    <img src='/Rectangle.png' className="w-[85%] absolute right-0 top-[10%]" />
    </div>
    </main>

  )


}