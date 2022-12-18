<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
div#div_content{
	width: 100%;
	display: flex;
	margin: 0 20px;
}

div.div_chart{
	margin: 7px;
	display:flex;
	justify-content: space-between;
	
	width : 49%;
	height: 400px;
	border: solid 1px gray;
	
}

div#chart7{
	width: 98.7%;
	height: 400px;
}
div#insightTitle{
	color:  #3C4651;
	font-size: 28px;
	font-weight: 700;
	margin: 25px;
}

canvas#myChart{

}

</style>

<script>

</script>
    
<div style="width: 100%;">    
	<div id="insightTitle">인사이트</div>
	
	<div id="div_content">
		
		<div style="width:100%; display: flex;">
			<div id="chart1" class="div_chart">
				<div>
					<div>부서별 인원</div>
					<div>기준 . 재직 구성원</div>
				</div>
				<canvas id="myChart1" width="200px" height="200px"></canvas>			
			</div>
			
			
			<div id="chart2" class="div_chart">
				<div>
					<div>구성원 성비</div>
					<div>기준 . 재직 구성원</div>
				</div>
				<canvas id="myChart2" width="200px" height="200px"></canvas>		
			
			</div>
		</div>
	</div>
	
	<div style="width:100%;">
		<div id="chart7" class="div_chart">
			<div>
				<div>부서별 인원</div>
				<div>기준 . 재직 구성원</div>
			</div>
			<canvas id="myChart3" width="600px" height="300px"></canvas>	
		
		</div>
	</div>		
</div>


<script>
<%-- 부서별 구성원 인원수  --%>
var context = document
.getElementById('myChart1')
.getContext('2d');
var myChart = new Chart(context, {
type: 'bar', // 차트의 형태
data: { // 차트에 들어갈 데이터
    labels: [
        //x 축
        '1','2','3','4','5','6','7'
    ],
    datasets: [
        { //데이터
            label: 'test1', //차트 제목
            fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
            data: [
                21,19,25,20,23,26,25 //x축 label에 대응되는 데이터 값
            ],
            backgroundColor: [
                //색상
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
                //경계선 색상
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 1 //경계선 굵기
        }/* ,
        {
            label: 'test2',
            fill: false,
            data: [
                8, 34, 12, 24
            ],
            backgroundColor: 'rgb(157, 109, 12)',
            borderColor: 'rgb(157, 109, 12)'
        } */
    ]
},
options: {
    scales: {
        yAxes: [
            {
                ticks: {
                    beginAtZero: true
                }
            }
        ]
    }
}
});

<%-- 부서별 구성원 인원수  --%>

<%--  구성원 성비  --%>
const ctx = document.getElementById('myChart2').getContext('2d');
const myChart2 = new Chart(ctx, {
    type: 'pie',
    data: {
        datasets: [{
            label: '# of Votes',
            data: [12, 19, 3, 5, 2, 3],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});

<%-- 부서별 급여 평균 --%>
var context = document
.getElementById('myChart3')
.getContext('2d');
var myChart = new Chart(context, {
type: 'line', // 차트의 형태
data: { // 차트에 들어갈 데이터
    labels: [
        //x 축
        '1','2','3','4','5','6','7'
    ],
    datasets: [
        { //데이터
            label: 'test1', //차트 제목
            fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
            data: [
                21,19,25,20,23,26,25 //x축 label에 대응되는 데이터 값
            ],
            backgroundColor: [
                //색상
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
                //경계선 색상
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 1 //경계선 굵기
        }/* ,
        {
            label: 'test2',
            fill: false,
            data: [
                8, 34, 12, 24
            ],
            backgroundColor: 'rgb(157, 109, 12)',
            borderColor: 'rgb(157, 109, 12)'
        } */
    ]
},
options: {
    scales: {
        yAxes: [
            {
                ticks: {
                    beginAtZero: true
                }
            }
        ]
    }
}
});



</script>
