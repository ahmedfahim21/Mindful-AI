'use client'
import { Radar } from 'react-chartjs-2';
import { Chart, registerables } from 'chart.js';
Chart.register(...registerables);


function RadarChart(data) {


  const options = {
    responsive: true,
    plugins: {
      legend: {
        position: 'top',
      },
      colors: {
        enabled: true
      }
    },
  };


  return (
    <div className='w-[400px]'>
      <Radar data={data.data} options={options} />
    </div>
  )
}

export default RadarChart;