

export function RecentSales(data) {


  return (
    <div className="space-y-8">
      {
          data.data.slice(0,6).map((item, index) => (
            <div key={index} className="flex items-center justify-between">
              <div className="flex items-center">
                <div className="ml-4">
                  <div className="text-sm font-medium text-gray-900">{item.name}</div>
                </div>
              </div>
              <div className="flex items-center">
                <div className="ml-4 flex-shrink-0">
                  <button
                    type="button"
                    className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${item.status === "Good" ? "bg-green-100 text-green-800" : "bg-red-100 text-red-800"}`}
                  >
                    {item.status}
                  </button>
                </div>
              </div>
            </div>
          ))


      }


    </div>
  )
}
