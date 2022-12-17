<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>



    
<h2>인사이트</h2>



<div>
  <canvas id="myChart"></canvas>
</div>
<div>
  <canvas id="myChart2"></canvas>
</div>

<script>
  const labels = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
  ];

  const data = {
    labels: labels,
    datasets: [{
      label: 'My First dataset',
      backgroundColor: 'rgb(255, 99, 132)',
      borderColor: 'rgb(255, 99, 132)',
      data: [0, 10, 5, 2, 20, 30, 45],
    }]
  };

  const config = {
    type: 'line',
    data: data,
    options: {}
  };
  
  const myChart = new Chart(
		    document.getElementById('myChart'),
		    config
		  );
  
  
  const data1 = {
		  labels: [
		    'Red',
		    'Blue',
		    'Yellow'
		  ],
		  datasets: [{
		    label: 'My First Dataset',
		    data: [300, 50, 100],
		    backgroundColor: [
		      'rgb(255, 99, 132)',
		      'rgb(54, 162, 235)',
		      'rgb(255, 205, 86)'
		    ],
		    hoverOffset: 4
		  }]
		};
  
  const config1 = {
		  type: 'doughnut',
		  data: data,
		};
  
  const myChart2 = new Chart(
		    document.getElementById('myChart2'),
		    config1
		  );
  
  
</script>