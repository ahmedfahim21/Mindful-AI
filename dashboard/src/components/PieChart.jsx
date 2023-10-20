'use client'
import { Pie } from 'react-chartjs-2';
import { Chart, registerables } from 'chart.js';
Chart.register(...registerables);


function PieChart({data}) {


  console.log(data)

  const options = {
    responsive: true,
    plugins: {
      legend: {
        position: 'top',
      },
    },
  };


  return (
    <div className='flex mx-auto p-4 w-[500px]'>
      <Pie data={data} options={options} />
    </div>
  )
}

export default PieChart;