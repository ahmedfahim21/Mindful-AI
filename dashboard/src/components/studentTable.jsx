import {
    Table,
    TableBody,
    TableCaption,
    TableCell,
    TableHead,
    TableHeader,
    TableRow,
  } from "@/components/ui/table"


function StudentTable({data}) {
    return (
        <div>
        <Table>
          <TableCaption>List of students and status.</TableCaption>
          <TableHeader>
            <TableRow>
              <TableHead>NAME</TableHead>
              <TableHead>DEPARTMENT</TableHead>
              <TableHead>INSTITUTE</TableHead>
              <TableHead className="text-right">DOB</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {data.map((data) => (
              <TableRow key={data.uid}>
                <TableCell className="font-medium">{data.name}</TableCell>
                <TableCell>{data.dept}</TableCell>
                <TableCell>{data.institute}</TableCell>
                <TableCell className="text-right">{data.dob}</TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
        </div>
  
  
    )
  }
  
  export default StudentTable