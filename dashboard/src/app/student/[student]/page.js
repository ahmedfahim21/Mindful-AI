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
import RadarChart from "@/components/RadarChart"
import LineChart from "@/components/LineChart"
import { Line } from "react-chartjs-2"
import BarChart from "@/components/BarChart"


export default function Student() {

  const { student } = useParams()
  // console.log(student)

  const [studentData, setStudentData] = useState(null)
  const [loading, setLoading] = useState(true)

  const studentRef = doc(db, "students", student)
  // console.log(studentRef)

  const getStudent = async () => {
    const studentDoc = await getDoc(studentRef)
    console.log(studentDoc.data())
    setStudentData(studentDoc.data())
    setLoading(false)
  }

  const radar_data = (studentData) => {
    // console.log(studentData)

    const data = {
      labels: ['Video', 'Quiz', 'Transcript', 'Audio'],
      datasets: [
        {
          label: 'Student Data',
          data: [studentData.video_score, studentData.quiz_score, studentData.transcript_score, studentData.audio_score],
          backgroundColor: 'rgba(102, 202, 152, 0.2)',
          borderColor: 'rgba(102, 202, 152, 1)',
          borderWidth: 2,
        },
      ],
    };

    return data
  }

  const heart_data = (studentData) => {

    const data = {

      labels: studentData.body_vitals.map((item) => {
        return item.created_at
      }
      ),
      datasets: [
        {
          label: 'Heart Rate',
          data: studentData.body_vitals.map((item) => {
            // console.log(item)
            return item.heartrate
          }
          ),
          fill: false,
          backgroundColor: 'rgba(255, 99, 132, 1)',
          borderColor: 'rgba(255, 99, 132, 1)',
          tension: 0.1,
        },
      ],
    };

    return data
  }


  const emotion_data = (studentData) => {

    const data = {

      labels: ["Happy", "Sad", "Angry", "Neutral", "Surprise", "Fear", "Disgust"],

      datasets: [

        {
          label: 'Emotions',

          data: [studentData.emotions[0], studentData.emotions[1], studentData.emotions[2], studentData.emotions[3], studentData.emotions[4], studentData.emotions[5], studentData.emotions[6]],

          backgroundColor: [
              
              'rgba(255, 99, 132, 0.2)',
  
              'rgba(54, 162, 235, 0.2)',
  
              'rgba(255, 206, 86, 0.2)',
  
              'rgba(75, 192, 192, 0.2)',
  
              'rgba(153, 102, 255, 0.2)',
  
              'rgba(255, 159, 64, 0.2)',
  
              'rgba(255, 99, 132, 0.2)'
  
            ],

          borderColor: [

              'rgba(255, 99, 132, 1)',

              'rgba(54, 162, 235, 1)',

              'rgba(255, 206, 86, 1)',

              'rgba(75, 192, 192, 1)',

              'rgba(153, 102, 255, 1)',

              'rgba(255, 159, 64, 1)',

              'rgba(255, 99, 132, 1)'

            ],
          borderWidth: 1,
        },
      ],
    };
    return data
  }








  const getAge = (_dob) => {
    const currentDate = new Date();
    const currentYear = currentDate.getFullYear();
    const currentMonth = currentDate.getMonth() + 1; 

    const dob = _dob.split("-");
    const dobMonth = parseInt(dob[1], 10);
    const dobDay = parseInt(dob[2], 10);
    const dobYear = parseInt(dob[0], 10);

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
        <div className="flex flex-col items-center justify-center w-full h-auto">
        <div className="absolute z-10 right-10 top-32 w-3/4 h-auto bg-white rounded-3xl p-5">
      {
        studentData ? (
          <Table className="text-lg">
          <TableBody>
              <TableRow key={studentData.uid} className={` px-2 py-1 ${studentData.status === "Good" ? "bg-green-100 text-green-800" : "bg-red-100 text-red-800"}`}>
                <TableCell>
                <Avatar className="h-[50px] w-[50px] mx-4">
                  <AvatarImage src="" alt="@shadcn" />
                  <AvatarFallback>{studentData.name.substring(0,1)}</AvatarFallback>
                </Avatar>
                </TableCell>
                <TableCell className="font-bold">{studentData.name}</TableCell>
                <TableCell>{studentData.dept}</TableCell>
                <TableCell>{studentData.institute}</TableCell>
                <TableCell className='font-bold'>{studentData.status}</TableCell>
                <TableCell className='font-medium'>{studentData.gender}</TableCell>
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
      <hr className="w-full" />
      <div className="flex flex-col items-center justify-center w-full h-full">
        {
          loading ? ( 
            <>Loading..</>
          ):
          (
          <>
          <RadarChart data={radar_data(studentData)}/>
          <LineChart  data={heart_data(studentData)}/>
          <BarChart  data={emotion_data(studentData)}/>
          </>
          )
        }


      </div>
      </div>
    <img src='/Rectangle.png' className="w-[85%] absolute right-0 top-[10%]" />
    </div>
    </main>

  )


}