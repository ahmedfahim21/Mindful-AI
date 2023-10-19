'use client'
import { where, query,collection } from '@firebase/firestore'
import { doc, getDoc, getDocs } from 'firebase/firestore'
import { db } from '@/firebase/config'
import { useParams } from 'next/navigation'
import { useEffect, useState } from 'react'
import React from 'react'
import StudentTable from '@/components/studentTable'

const Dashboard = () => {

  const id = useParams()

  const [admin, setAdmin] = useState("")
  const [students, setStudents] = useState([])
  const [fetching, setFetching] = useState(false)

  if(fetching)
    console.log(students)

  //read
  useEffect(() => {
    const read = async () => {
      
      const docRef = doc(db, "admin", id.admin);
      const docSnap = await getDoc(docRef);

      if (docSnap.exists()) {
        await setAdmin(docSnap.data().name)
        console.log(admin)
        const q = query(collection(db, "students"), where("institute", "==", admin));
        const querySnapshot = await getDocs(q);
        console.log(querySnapshot)
        querySnapshot.forEach((doc) => {
          setStudents((students) => [...students, doc.data()])
          console.log(doc.id, " => ", doc.data());
        });
        setFetching(true)

      } else {
        console.log("No such document!");
      }
  }
    read()
  }, [admin])

  // useEffect(() => {
  //   const read = async () => {
  //     const q = query(collection(db, "students"), where("institute", "==", admin));
  //     const querySnapshot = await getDocs(q);
  //     querySnapshot.forEach((doc) => {
  //       // setStudents(doc.data().name)
  //       console.log(doc.id, " => ", doc.data());
  //     });
  // }
  //   read()
  // }
  // , [admin])


  return (
    <main className="flex flex-col items-center justify-between p-5 overflow-y-hidden">
        <div className="flex flex-col items-center justify-center w-full h-full">
          <div className="absolute z-10 right-10 top-32 w-3/4 h-5/6 bg-white rounded-3xl p-5">
            {fetching &&
                <StudentTable data={students} />
            }
            </div>
            <img src='/Rectangle.png' className="w-[85%] absolute right-0 top-[10%]" />
        </div>
    </main>
  )
}

export default Dashboard