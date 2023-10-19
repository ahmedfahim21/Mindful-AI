'use client'
import { Radar } from 'react-chartjs-2';
import { Chart, registerables } from 'chart.js';
Chart.register(...registerables);


function RadarChart() {

  const data = { 
    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
    datasets: [
      {
        label: 'Amount',
        data: [12, 19, 3, 5, 2, 3],
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