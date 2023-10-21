'use client'
import React from 'react'
import { where, query,collection } from '@firebase/firestore'
import { doc, getDoc, getDocs } from '@firebase/firestore'
import { db } from '@/firebase/config'
import { useEffect, useState } from 'react'
import StudentTable from '@/components/studentTable'
import { Skeleton } from "@/components/ui/skeleton"

const Dashboard = () => {

  const [students, setStudents] = useState([])
  const [fetch, setFetch] = useState(false)

  //read
  const readAll = async () => {

    const q = query(collection(db, "students"));

    const querySnapshot = await getDocs(q);
    querySnapshot.forEach((doc) => {
      setStudents(students => [...students, doc.data()])
      setFetch(true)
      console.log(doc.id, " => ", doc.data());
    });
}

 if(!fetch)
    readAll()



  return (
    <main className="flex flex-col items-center justify-between p-5 overflow-y-hidden">
        <div className="flex flex-col items-center justify-center w-full  overflow-y-scroll">
          <div className="absolute z-10 right-10 top-32 w-3/4 h-5/6 overflow-y-scroll bg-white rounded-3xl p-5 shadow-xl ">
            {fetch &&
                <StudentTable data={students} />
            }
            {!fetch &&
                <div className="flex items-center space-x-4">
                  <Skeleton className="h-12 w-12 rounded-full" />
                  <div className="space-y-2">
                    <Skeleton className="h-4 w-[250px]" />
                    <Skeleton className="h-4 w-[200px]" />
                  </div>
                </div> 

            }
            </div>
            <img src='/Rectangle.png' className="w-[85%] absolute right-0 top-[10%] blur-md"/>
        </div>
    </main>
  )
}

export default Dashboard