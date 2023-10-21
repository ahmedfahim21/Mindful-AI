'use client'

import {
  Card,
} from "@/components/ui/card"

import BarChart from "./BarChart"
import { count } from "firebase/firestore";


export default function AgeAnalysis(students) {

    // console.log(students.data)

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

    const countAge = (students) => {
        const ageCounts = {"16-18" : 0, "19-21" : 0, "22-24" : 0, "25-27" : 0, "28-30" : 0}
        students.data.forEach((student) => {
            if(student.dob != null && student.status == "Risky"){
                
                student.age = getAge(student.dob)
                if(student.age <= 18)
                    ageCounts["16-18"] += 1
                else if(student.age <= 21)
                    ageCounts["19-21"] += 1
                else if(student.age <= 24)
                    ageCounts["22-24"] += 1
                else if(student.age <= 27)
                    ageCounts["25-27"] += 1
                else if(student.age <= 30)
                    ageCounts["28-30"] += 1
            }
        })

        return ageCounts
    }

    console.log(countAge(students))

    const gdata = {
        labels: Object.keys(countAge(students)),
        datasets: [
          {
            label: 'No of risky students',
            data: countAge(students),
            backgroundColor: [
                'rgba(255, 159, 64, 0.2)',
            ],
            borderColor: [
              'rgba(255, 159, 64, 1)',
            ],
            borderWidth: 1,
          },
        ],
      };


    
    console.log(gdata)


  return (
    <>

                <Card className="w-full">
                    <BarChart data={gdata} width={700} />
                </Card>
    </>
  )
}
