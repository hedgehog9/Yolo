<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
div#div_content{
	width: 100%;
	margin: 0 20px;
}

div.div_chart{
	margin: 7px;
	display:flex;
	justify-content: space-between;
	
	width : 48%;
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

    
<div style="width: 100%;">    
	<div id="insightTitle">인사이트</div>
	
	<div id="div_content">
		
		<div style="width:100%; display: flex;">
			<div id="chart1" class="div_chart">
				<div>
					<div>구성원 성비</div>
					<div>기준 . 재직 구성원</div>
				</div>
				<canvas id="myChart1" width="300px" height="300px"></canvas>			
			</div>
			
			
			<div id="chart2" class="div_chart">
				<div>
					<div>부서별 인원</div>
					<div>기준 . 재직 구성원</div>
				</div>
				<canvas id="myChart2" width="300px" height="300px"></canvas>		
			
			</div>
		</div>
		
		
		<div style="width:100%; display: flex;">
			<div id="chart3" class="div_chart">
				<canvas id="myChart3" width="600px" height="300px"></canvas>			
			</div>
			
			
			<div id="chart4" class="div_chart">
				<div>
					<div>구성원 성비</div>
					<div>기준 . 재직 구성원</div>
				</div>
				<canvas id="myChart4" width="600px" height="300px"></canvas>			
			
			</div>
		</div>
	</div>
	
</div>


<script>

$(document).ready(function() {
	
	let arr_rate=[];
	let arr_gender=[];
	$.ajax({
		url:"<%= ctxPath%>/insight/genderRate.yolo",
		dataType:"JSON",
		success:function(json) {
			arr.push(...json);
					
			$.each(arr, function(index, item){
				arr_gender.push(item.gender);
				arr_rate.push(item.rate);
			});
			
			console.log(arr_gender);
			<%--  구성원 성비  --%>
			const ctx = document.getElementById('myChart1').getContext('2d');
			const myChart1 = new Chart(ctx, {
			    type: 'pie',
			    data: {
		        	labels: arr_gender,
			        datasets: [{
			            data: arr_rate,
			            backgroundColor: [
			                'rgba(54, 162, 235, 0.2)',
			                'rgba(255, 99, 132, 0.2)',
			                'rgba(255, 206, 86, 0.2)',
			                'rgba(75, 192, 192, 0.2)',
			                'rgba(153, 102, 255, 0.2)',
			                'rgba(255, 159, 64, 0.2)'
			            ],
			            borderColor: [
			                'rgba(54, 162, 235, 1)',
			                'rgba(255, 99, 132, 1)',
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
			},
			error: function(request, status, error){
		        alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
	
	})



	<%-- 부서별 급여 평균 --%>
	let arr_deptNameEmp=[];
	let arr_empCnt=[];
	$.ajax({
		url:"<%= ctxPath%>/insight/empCntDept.yolo",
		dataType:"JSON",
		success:function(json) {
			arr.push(...json);
					
			$.each(arr, function(index, item){
				arr_deptNameEmp.push(item.deptname);
				arr_empCnt.push(item.empCnt);
			});
			
			console.log(arr_gender);
			<%--  구성원 성비  --%>
			const ctx = document.getElementById('myChart2').getContext('2d');
			const myChart2 = new Chart(ctx, {
			    type: 'pie',
			    data: {
		        	labels: arr_deptNameEmp,
			        datasets: [{
			            data: arr_empCnt,
			            backgroundColor: [
			                'rgba(54, 162, 235, 0.2)',
			                'rgba(255, 99, 132, 0.2)',
			                'rgba(255, 206, 86, 0.2)',
			                'rgba(75, 192, 192, 0.2)',
			                'rgba(153, 102, 255, 0.2)',
			                'rgba(255, 159, 64, 0.2)'
			            ],
			            borderColor: [
			                'rgba(54, 162, 235, 1)',
			                'rgba(255, 99, 132, 1)',
			                'rgba(255, 206, 86, 1)',
			                'rgba(75, 192, 192, 1)',
			                'rgba(153, 102, 255, 1)',
			                'rgba(255, 159, 64, 1)'
			            ],
			            borderWidth: 1
			        }]
			    },
			    options: {
			    	plugins:{
		                legend: {
		                    display: false
		                }
		            },
			        scales: {
			            y: {
			                beginAtZero: true
			            }
			        }
			    }
			});
			},
			error: function(request, status, error){
		        alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
	
	});







	<%-- 부서별 최근한달간 평균근무시간  --%>
	let arr=[];
	let arr_deptname=[];
	let arr_sum_worktime=[];
	$.ajax({
		url:"<%= ctxPath%>/insight/sumWorktimeByDept.yolo",
		dataType:"JSON",
		success:function(json) {
			arr.push(...json);
			console.log(arr.length)
			
			$.each(arr, function(index, item){
				arr_deptname.push(item.deptname)
				arr_sum_worktime.push(item.avg_worktime)
			})
			
			var context3 = document.getElementById('myChart3').getContext('2d');
			var myChart3 = new Chart(context3, {
			type: 'bar', // 차트의 형태
			data: { // 차트에 들어갈 데이터
			    labels: arr_deptname,
			    datasets: [
			        { //데이터
			            label: '부서별 최근한달간 평균근무시간', //차트 제목
			            fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
			            data: arr_sum_worktime,
			            backgroundColor: [
			                //색상
			                'rgba(255, 99, 132, 0.2)',
			                'rgba(54, 162, 235, 0.2)',
			                'rgba(255, 206, 86, 0.2)',
			                'rgba(75, 192, 192, 0.2)',
			                'rgba(153, 102, 255, 0.2)',
			                'rgba(255, 159, 64, 0.2)',
			                'rgba(255, 99, 132, 0.2)',
			                'rgba(54, 162, 235, 0.2)',
			                'rgba(255, 206, 86, 0.2)',
			                'rgba(75, 192, 192, 0.2)',
			                'rgba(153, 102, 255, 0.2)'
			            ],
			            borderColor: [
			                //경계선 색상
			                'rgba(255, 99, 132, 1)',
			                'rgba(54, 162, 235, 1)',
			                'rgba(255, 206, 86, 1)',
			                'rgba(75, 192, 192, 1)',
			                'rgba(153, 102, 255, 1)',
			                'rgba(255, 159, 64, 1)',
			                'rgba(255, 99, 132, 0.2)',
			                'rgba(54, 162, 235, 0.2)',
			                'rgba(255, 206, 86, 0.2)',
			                'rgba(75, 192, 192, 0.2)',
			                'rgba(153, 102, 255, 0.2)',
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
		},
		error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	    }
	})
	
	



	var context4 = document.getElementById('myChart4').getContext('2d');
	var myChart4 = new Chart(context4, {
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
	
})// end of ready -----------------------------------------------------




</script>
