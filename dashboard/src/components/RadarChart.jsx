'use client'
import { Radar } from 'react-chartjs-2';
import { Chart, registerables } from 'chart.js';
Chart.register(...registerables);


function RadarChart() {

  const data = { 
    labels: ['Video', 'Transcript', 'Audio', 'Quiz'],
    datasets: [
      {
        label: 'Depression Detection',
        data: [12, 19, 3, 5],
      },
    ],
  };

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
    <>
      <Radar data={data} options={options} />
    </>
  )
}

export default RadarChart;