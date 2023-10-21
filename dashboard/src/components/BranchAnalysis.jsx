'use client'

import {
  Card,
} from "@/components/ui/card"

import BarChart from "./BarChart"


export default function BranchAnalysis(students) {

    // console.log(students.data)



    const countDept = (students) => {
        const deptCounts = {}
        students.data.forEach((student) => {
            if(student.dept in deptCounts)
                deptCounts[student.dept] += 1
            else
                deptCounts[student.dept] = 1
        })

        return deptCounts
    }

    console.log(countDept(students))

    const gdata = {
        labels: Object.keys(countDept(students)),
        datasets: [
          {
            label: 'No of risky students',
            data: countDept(students),
            backgroundColor: [
              'rgba(255, 99, 132, 0.2)',
            ],
            borderColor: [
              'rgba(255, 99, 132, 1)',
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
