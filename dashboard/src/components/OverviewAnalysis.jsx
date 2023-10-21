'use client'

import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card"

import { Overview } from "@/components/ui/overview"
import { RecentSales } from "@/components/ui/recent-sales"





export default function OverviewAnalytics(students) {

    // console.log(students.data)

    const avgQuizScore = (students) => {
        let sum = 0
        let count = 0
        students.data.forEach((student) => {
            if(student.scores != null)
            {
            sum += student.scores.Anxiety.Score
            count += 1
            }
        })
        return sum/count
    }

    const avgHeartRate = (students) => {
        let sum = 0
        let count = 0
        students.data.forEach((student) => {
            if(student.body_vitals != null)
            {
                for(let i = 0; i < student.body_vitals.length; i++)
                {
                    sum += student.body_vitals[i].heartrate
                    count += 1
                }
            }
        })
        return sum/count
    }

    const avgMood = (students) => {
        let sum = 0
        let count = 0
        students.data.forEach((student) => {
            if(student.depression != null)
            {
                  sum += student.depression
                  count += 1

            }
        }
        )
        return sum/count
    }

    const countRisky = (students) => {
        let count = 0
        students.data.forEach((student) => {
            if(student.status == "Risky")
                count += 1
        })
        return count
    }


  return (
    <>
      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
                <Card>
                  <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                    <CardTitle className="text-sm font-medium">
                      Average DASS-21 Score
                    </CardTitle>
                    <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth="2"
                    className="h-4 w-4 text-muted-foreground"
                  >
                    <polygon points="12 2 15.09 8.26 22 9.27 17 14.02 18.18 21.02 12 17.77 5.82 21.02 7 14.02 2 9.27 8.91 8.26 12 2" />
                  </svg>

                  </CardHeader>
                  <CardContent>
                    <div className="text-2xl font-bold">{avgQuizScore(students)!==NaN ? avgQuizScore(students).toFixed(2) : 0}</div>
                  </CardContent>
                </Card>
                <Card>
                  <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                    <CardTitle className="text-sm font-medium">
                      Average Heartrate
                    </CardTitle>
                    <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth="2"
                    className="h-4 w-4 text-muted-foreground"
                  >
                    <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z" />
                  </svg>
                  </CardHeader>
                  <CardContent>
                    <div className="text-2xl font-bold">{avgHeartRate(students)!==NaN ? avgHeartRate(students).toFixed(2) : 0}</div>
                  </CardContent>
                </Card>
                <Card>
                  <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                    <CardTitle className="text-sm font-medium">
                      No of Risky Students
                    </CardTitle>
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      viewBox="0 0 24 24"
                      fill="none"
                      stroke="currentColor"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth="2"
                      className="h-4 w-4 text-muted-foreground"
                    >
                      <path d="M22 12h-4l-3 9L9 3l-3 9H2" />
                    </svg>
                  </CardHeader>
                  <CardContent>
                    <div className="text-2xl font-bold">{countRisky(students) !== NaN ? countRisky(students) : 0}</div>
                  </CardContent>
                </Card>
                <Card className="border-2 border-secondary">
                  <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                    <CardTitle className="text-sm font-medium">Average Mood</CardTitle>
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      viewBox="0 0 24 24"
                      fill="none"
                      stroke="currentColor"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth="2"
                      className="h-4 w-4 text-muted-foreground"
                    >
                      <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2" />
                      <circle cx="9" cy="7" r="4" />
                      <path d="M22 21v-2a4 4 0 0 0-3-3.87M16 3.13a4 4 0 0 1 0 7.75" />
                    </svg>
                  </CardHeader>
                  <CardContent>
                    <div className="text-2xl font-bold">{avgMood(students)!==NaN ? avgMood(students).toFixed(2) : 0}</div>
                  </CardContent>
                </Card>
              </div>
              <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-7">
                <Card className="col-span-4">
                  <CardHeader>
                    <CardTitle>Overview</CardTitle>
                  </CardHeader>
                  <CardContent className="pl-2">
                    <Overview />
                  </CardContent>
                </Card>
                <Card className="col-span-3">
                  <CardHeader>
                    <CardTitle>Recent Students</CardTitle>
                    <CardDescription>
                      Total {students.data.length} students.
                    </CardDescription>
                  </CardHeader>
                  <CardContent>
                    <RecentSales data = {students.data} />
                  </CardContent>
                </Card>
              </div>
    </>
  )
}
