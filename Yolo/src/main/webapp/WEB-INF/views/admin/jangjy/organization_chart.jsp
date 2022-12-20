<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath();%>    


<style>
	 div#peopleContent{
    	margin-right:10px;
    }
    
    div#header{
    	display:flex;
    	justify-content: space-between;
    	border-bottom: solid 1px #d9d9d9;
    	margin-bottom: 50px;
    }
    
    span.title{
        font-size: 28px;
        margin-right:20px;
        font-weight: 700;
        letter-spacing:-1.12px;
    }

    div#header_title, div#button_title{
        margin: 35px 20px 20px 20px;
    }
    
    button#change_dept{
    	background-color: #66cc66;
    	color: white;
    }
    
    
    <%-- hirechart css --%>
    .highcharts-figure,
	.highcharts-data-table table {
	    min-width: 320px;
	    max-width: 800px;
	    margin: 1em auto;
	}
	
	.highcharts-data-table table {
	    font-family: Verdana, sans-serif;
	    border-collapse: collapse;
	    border: 1px solid #ebebeb;
	    margin: 10px auto;
	    text-align: center;
	    width: 100%;
	    max-width: 500px;
	}
	
	.highcharts-data-table caption {
	    padding: 1em 0;
	    font-size: 1.2em;
	    color: #555;
	}
	
	.highcharts-data-table th {
	    font-weight: 600;
	    padding: 0.5em;
	}
	
	.highcharts-data-table td,
	.highcharts-data-table th,
	.highcharts-data-table caption {
	    padding: 0.5em;
	}
	
	.highcharts-data-table thead tr,
	.highcharts-data-table tr:nth-child(even) {
	    background: #f8f8f8;
	}
	
	.highcharts-data-table tr:hover {
	    background: #f1f7ff;
	}
    <%-- hirechart css --%>
    
<%-- header a태그 css  --%>
a.a_title{
	font-size: 28px;
	font-weight: 700;
	letter-spacing: -1.12px;
	text-decoration: none solid rgb(60, 70, 81);
	word-spacing: 0px;
	color: #cdd2d6;
}
<%-- color : #3C4651; --%>
a.a_title:hover{
	text-decoration: none;
	color: #9e9e9e;
}
a.a_title:link, a.a_title:visited, a.a_title:active {
	text-decoration: none;
	color: #9e9e9e;
}
a.current,a.current:hover {
	text-decoration: none;
	color : #3C4651;
}
    
    
</style>

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/networkgraph.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>



<div id="peopleContent">
		<div id="header">
	        <div id="header_title">
	            <a class="a_title" href="<%= ctxPath%>/people.yolo"><span class="title">구성원</span></a>
	            <a class="current" href="<%= ctxPath%>/organization_chart.yolo"><span class="title">조직도</span></a>
	            <c:if test="${sessionScope.loginuser.empno == 9999}">
	            	<a class="a_title" href="<%= ctxPath%>/change_history.yolo"><span class="title">인사 정보 관리</span></a>
	            </c:if>
	        </div>
	    </div>
</div>

<figure class="highcharts-figure">
    <div id="container" style="overflow:hidden;"></div>
</figure>


<script type="text/javascript">

$(document).ready(function(){
	
	func_networkgraph(); 
	
})// end of document.ready()---------------------------------------

// 부서이름 조회 -> 팀 이름 조회 -> 사원 조회 후 highchart 에 출력하는 메소드
function func_networkgraph(){

	let dataArr = []; // 차트 출력하는 모든 데이터를 담는 배열 
	
	$.ajax({
		  url:"<%= ctxPath %>/getDeptName.yolo",
		  // type:"POST",
		  // data:{},
		  dataType:"JSON",
		  async : false,
		  success:function(json){
			  // 부서 이름 구해오기  [ [사장,부서1],[사장,부서2],[사장,부서3],[사장,부서4],[사장,부서5] ]
			  $.each(json, function(index,dept){
				  let deptArr = [];
				  deptArr.push("CEO");
				  deptArr.push(dept.deptname);     //  [사장,부서1]
				  dataArr.push(deptArr);           //[ [사장,부서1],[사장,부서2],[사장,부서3],[사장,부서4],[사장,부서5] ]
				  
				  $.ajax({
					  url:"<%= ctxPath %>/getTeamName.yolo",
					  // type:"POST",
					  data:{"deptno":dept.deptno},
					  dataType:"JSON",
					  async : false,
					  success:function(json2){
						  
						  $.each(json2, function(index,team){
							  let teamArr = [];
							  teamArr.push(dept.deptname);	   //  [개발부]
							  teamArr.push(team.teamname);     //  [개발1팀]
							  dataArr.push(teamArr);           //[ [개발부, 개발1팀],[개발부, 개발2팀] ]
							  
							  $.ajax({
								  url:"<%= ctxPath %>/getEmployees.yolo",
								  // type:"POST",
								  data:{"teamno":team.teamno},
								  async : false,
								  dataType:"JSON",
								  success:function(json3){
									  
									  $.each(json3, function(index,employee){
										  let employeeArr = [];
										  employeeArr.push(employee.deptname);  //  [개발1팀]
										  employeeArr.push(employee.name);      //  [조승남]
										  dataArr.push(employeeArr);            //[ [개발1팀, 조승남],[개발1팀, 서세훈] ]
									  });
									  // console.log("### 확인용 두번째 부서명 호출 ### "+ dataArr);
									  
								  },error: function(request, status, error){
									  console.log("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
								  }
				  			  }); // end of $.ajax({})-----------------------------------------
				  			  
						  });// end of $.each(json2, function(index,team){}-------------
						  
					  },error: function(request, status, error){
						  console.log("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					  }
				  }); // end of $.ajax({})-----------------------------------
				 
			  }); // end of $.each(json, function(index,dept){}---------------------------------------
					  
			  Highcharts.addEvent(
					    Highcharts.Series,
					    'afterSetOptions',
					    function (e) {
					        var colors = Highcharts.getOptions().colors,
					            i = 0,
					            nodes = {};

					        if (
					            this instanceof Highcharts.Series.types.networkgraph &&
					            e.options.id === 'lang-tree'
					        ) {
					            e.options.data.forEach(function (link) {

					                if (link[0] === 'CEO') {
					                    nodes['CEO'] = {
					                        id: 'CEO',
					                        marker: {
					                            radius: 20
					                        }
					                    };
					                    nodes[link[1]] = {
					                        id: link[1],
					                        marker: {
					                            radius: 10
					                        },
					                        color: colors[i++]
					                    };
					                } else if (nodes[link[0]] && nodes[link[0]].color) {
					                    nodes[link[1]] = {
					                        id: link[1],
					                        color: nodes[link[0]].color
					                    };
					                }
					            });

					            e.options.nodes = Object.keys(nodes).map(function (id) {
					                return nodes[id];
					            });
					        }
					    }
					);// end of Highcharts.addEvent()---------------------------------

					Highcharts.chart('container', {
					    chart: {
					        type: 'networkgraph',
					        height: '100%'
					    },
					    title: {
					        text: '조직도'
					    },
					    subtitle: {
					    },
					    plotOptions: {
					        networkgraph: {
					            keys: ['from', 'to'],
					            layoutAlgorithm: {
					                enableSimulation: true,
					                friction: -0.9
					            }
					        }
					    },
					    series: [{
					        accessibility: {
					            enabled: false
					        },
					        dataLabels: {
					            enabled: true,
					            linkFormat: ''
					        },
					        id: 'lang-tree',
					        data: dataArr
					    }]
					}); // end of Highcharts.chart('container', {}-----------------------
			  
		  },error: function(request, status, error){
			  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		  }
		  
	  }); // end of $.ajax({})-----------------------------------
	
}// end of function func_networkgraph(){}-------------


</script>