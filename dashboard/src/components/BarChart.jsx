'use client'
import { Bar } from 'react-chartjs-2';
import { Chart, registerables } from 'chart.js';
Chart.register(...registerables);


function BarChart({data,width}) {



  const options = {
    scales: {
      y: {
        beginAtZero: true,
      },
    },
    responsive: true,
    plugins: {
      legend: {
        position: 'top',
      },
    },
  };

  console.log(width)
  return (
    <div width={`${width}px`} className=" flex mx-auto p-4">
      <Bar data={data} options={options} />
    </div>
  )
}

export default BarChart;