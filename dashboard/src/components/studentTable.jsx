'use client'
import {
    Table,
    TableBody,
    TableCaption,
    TableCell,
    TableHead,
    TableHeader,
    TableRow,
  } from "@/components/ui/table"
import { Button } from "./ui/button"
import { useRouter } from "next/navigation"


function StudentTable({data}) {

    const router = useRouter()
    const viewHandler = (sid) => {
        router.push(`/student/${sid}`)
    }


    return (
        <div>
        <Table>
          <TableCaption>List of students and status.</TableCaption>
          <TableHeader>
            <TableRow>
              <TableHead>NAME</TableHead>
              <TableHead>DEPARTMENT</TableHead>
              <TableHead>INSTITUTE</TableHead>
              <TableHead>STATUS</TableHead>
              <TableHead className="text-right">ACTIONS</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {data.map((data, index) => (
              <TableRow key={index}>
                <TableCell className="font-medium">{data.name}</TableCell>
                <TableCell>{data.dept}</TableCell>
                <TableCell>{data.institute}</TableCell>
                <TableCell><span className={`text-sm font-medium rounded-full px-2 py-1 ${data.status === "Good" ? "bg-green-100 text-green-800" : "bg-red-100 text-red-800"}`}>{data.status}</span></TableCell>
                <TableCell className="text-right"><Button onClick={() => viewHandler(data.uid)}>View</Button></TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
        </div>
  
  
    )
  }
  
  export default StudentTable