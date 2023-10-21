'use client'
import { Button } from "@/components/ui/button"
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card"
import {
  Tabs,
  TabsContent,
  TabsList,
  TabsTrigger,
} from "@/components/ui/tabs"
import { Overview } from "@/components/ui/overview"
import { RecentSales } from "@/components/ui/recent-sales"
import { useEffect, useState } from "react"
import { doc, getDoc, getDocs, query, where, collection } from "firebase/firestore";
import { db } from "@/firebase/config";
import OverviewAnalytics from "./OverviewAnalysis"
import BranchAnalysis from "./BranchAnalysis"
import GenderAnalysis from "./GenderAnalysis"
import AgeAnalysis from "./AgeAnalysis"



export default function AnalyticsTable() {


  const [students, setStudents] = useState([])
  const [fetching, setFetching] = useState(false)
  const [risky, setRisky] = useState(0)

  //read
  const read = async () => {

    const q = query(collection(db, "students"));

    const querySnapshot = await getDocs(q);
    querySnapshot.forEach((doc) => {
      if(doc.data().status == "Risky")
        setRisky(risky => risky + 1)
      setStudents(students => [...students, doc.data()])
      setFetching(true)
      console.log(doc.id, " => ", doc.data());
    });
}

 if(!fetching)
    read()

  return (
    <>
      <div className="hidden flex-col md:flex">
        <div className="flex-1 spa  ce-y-4 p-8 pt-6">
          <Tabs defaultValue="overview" className="space-y-4">
            <TabsList>
              <TabsTrigger value="overview">Overview</TabsTrigger>
              <TabsTrigger value="branch" >
                Branch
              </TabsTrigger>
              <TabsTrigger value="age" >
                Age
              </TabsTrigger>
              <TabsTrigger value="gender" >
                Gender
              </TabsTrigger>
            </TabsList>
            <TabsContent value="overview" className="space-y-4">
              <OverviewAnalytics  data={students} />
            </TabsContent>
            <TabsContent value="branch" className="space-y-4">
            <BranchAnalysis data={students} />
            </TabsContent>
            <TabsContent value="age" className="space-y-4">
            <AgeAnalysis data={students} />
            </TabsContent>
            <TabsContent value="gender" className="space-y-4">
            <GenderAnalysis data={students} />
            </TabsContent>
          </Tabs>
        </div>
      </div>
    </>
  )
}
