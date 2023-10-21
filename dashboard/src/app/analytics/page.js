import AnalyticsTable from "@/components/Analytics"
export default function Analytics() {


  return (

    <main className="flex flex-col items-center justify-between p-5 overflow-y-hidden">
      <div className="flex flex-col items-center justify-center w-full h-auto">
        <div className="absolute z-10 right-10 top-32 w-3/4 h-auto bg-white rounded-3xl p-5 shadow-xl ">
          <AnalyticsTable />
        </div>
        <img src='/Rectangle.png' className="w-[85%] absolute right-0 top-[10%] blur-md opacity-50" />
      </div>
    </main>

  )


}