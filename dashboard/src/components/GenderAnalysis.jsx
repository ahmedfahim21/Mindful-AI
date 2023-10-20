'use client'

import {
  Card,

} from "@/components/ui/card"
import PieChart from "./PieChart"


export default function GenderAnalysis(students) {

    console.log(students.data)



    const countGen = (students) => {
        const genders = [0,0]
        students.data.forEach((student) => {
            if(student.gender == "Male")
                genders[0] += 1
            else if(student.gender == "Female")
                genders[1] += 1
        })

        return genders
    }

    console.log(countGen(students))

    const gdata = {
        labels: ["male", "female"],
        datasets: [
          {
            label: 'No of risky students',
            data: countGen(students),
            backgroundColor: [
              'rgba(255, 99, 132, 0.2)',
              'rgba(54, 162, 235, 0.2)',
            ],
            borderColor: [
              'rgba(255, 99, 132, 1)',
              'rgba(54, 162, 235, 1)',
            ],
            borderWidth: 1,
          },
        ],
      };

    console.log(gdata)

  return (
    <>

                <Card className="w-full">
                    <PieChart data={gdata} />
                </Card>
    </>
  )
}
