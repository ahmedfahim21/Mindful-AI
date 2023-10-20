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


  return (

    <div className="data">
      {
        studentData ? (
          <div>
            <h1>{studentData.name}</h1>

          </div>
        ) : (
          <h1>Loading...</h1>
        )
      }
    </div>

  )


}