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
import Link from "next/link"


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
              <TableHead>DOB</TableHead>
              <TableHead className="text-right">ACTIONS</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {data.map((data) => (
              <TableRow key={data.uid}>
                <TableCell className="font-medium">{data.name}</TableCell>
                <TableCell>{data.dept}</TableCell>
                <TableCell>{data.institute}</TableCell>
                <TableCell>{data.dob}</TableCell>
                <TableCell className="text-right"><Button onClick={() => viewHandler(data.uid)}>View</Button></TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
        </div>
  
  
    )
  }
  
  export default StudentTable