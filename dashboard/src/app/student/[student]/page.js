'use client'
import { useParams } from "next/navigation"
import { useEffect, useState } from "react"
import { collection, doc, getDoc } from "firebase/firestore"
import { db } from "@/firebase/config"
import { Skeleton } from "@/components/ui/skeleton"
import {
  Avatar,
  AvatarFallback,
  AvatarImage,
} from "@/components/ui/avatar"
import { TableCell } from "@/components/ui/table"
import { Table, TableBody, TableRow } from "@/components/ui/table"


export default function Student() {

  const { student } = useParams()
  // console.log(student)

  const [studentData, setStudentData] = useState(null)
  const [age, setAge] = useState(0)

  const studentRef = doc(db, "students", student)
  // console.log(studentRef)

  const getStudent = async () => {
    const studentDoc = await getDoc(studentRef)
    console.log(studentDoc.data())
    setStudentData(studentDoc.data())
  }

  const getAge = (_dob) => {
    const currentDate = new Date();
    const currentYear = currentDate.getFullYear();
    const currentMonth = currentDate.getMonth() + 1; 

    const dob = _dob.split("/");
    const dobMonth = parseInt(dob[0], 10);
    const dobDay = parseInt(dob[1], 10);
    const dobYear = parseInt(dob[2], 10);

    let age = currentYear - dobYear;

    if (currentMonth < dobMonth || (currentMonth === dobMonth && currentDate.getDate() < dobDay)) {
        age--;
    }

    return age;
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
          <Table className="text-lg">
          <TableBody>
              <TableRow key={studentData.uid}>
                <TableCell>
                <Avatar className="h-[50px] w-[50px] mx-4">
                  <AvatarImage src="" alt="@shadcn" />
                  <AvatarFallback>{studentData.name.substring(0,1)}</AvatarFallback>
                </Avatar>
                </TableCell>
                <TableCell className="font-bold">{studentData.name}</TableCell>
                <TableCell>{studentData.dept}</TableCell>
                <TableCell>{studentData.institute}</TableCell>
                <TableCell><span className={`text-sm font-medium rounded-full px-2 py-1 ${studentData.status === "Good" ? "bg-green-100 text-green-800" : "bg-red-100 text-red-800"}`}>{studentData.status}</span></TableCell>
                <TableCell>{getAge(studentData.dob)} years</TableCell>
              </TableRow>
          </TableBody>
        </Table>
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