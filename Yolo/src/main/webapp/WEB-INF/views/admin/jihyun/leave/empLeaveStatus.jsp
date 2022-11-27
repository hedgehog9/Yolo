<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath=request.getContextPath(); %>

<jsp:include page="leaveCategory.jsp" />
    
<style type="text/css">
	
	div#tableDiv {
		width: 90%;
		margin: 10px auto;
	}
	
	table {
		margin-top : 10px;
		width: 100%;
		text-align: center;
	}
	
	tr {
		height: 40px;
	}
	
	th {
		vertical-align: middle;
	}
	
	td.promotionLeave:hover {
		cursor: pointer; 
		background-color: #9d9d9d;
	}
	
	div.tableProf {
		display : inline-block;
		width: 40px; 
		height: 40px; 
		border-radius: 40%; 
		background-color: #239afe;
		color: white;
		text-align: center;
		padding-top: 8px;
		border: 1px solid #ccced0;
		font-weight: bold;
		font-size: 13px;
		margin: auto 10px auto 5px;;
	}
	
	td.patop {
		padding-top: 20px;
	} 
	
	td {
		font-size: 11pt;
	}
	
	.head {
		width: 150px;
	}
	
	span.tableTitle {
		display: block;
		font-size: 12pt;
	}
	
	span.tableTitle2 {
		font-size: 11pt;
		font-weight: normal;
		color: gray;
	}
	

</style>

<script type="text/javascript">

	$(document).ready(function () {
		
		$("span#empLeave").css("color", "#494949");
		$("span.headerTitle2").show();
		$("span#empLeaveStatus").css("color", "#494949");
	  
	});

	
</script>	    

<%-- 구성원 휴가 보유 현황 시작 --%>

<div id="tableDiv">
	<table class="table table-bordered table-hover ">
		<thead>
		    <tr>
		      <th class="head"><span class="tableTitle">이름</span></th>
		      <th><span class="tableTitle">사번</span></th>
		      <th><span class="tableTitle">잔여연차</span><span class="tableTitle2">매년 지급(25일)</span></th>
		      <th><span class="tableTitle">잔여반차</span><span class="tableTitle2">매년 지급(50번)</span></th>
		      <th><span class="tableTitle">잔여병가</span><span class="tableTitle2">기본 90일까지</span></th>
		      <th><span class="tableTitle">잔여여름휴가</span><span class="tableTitle2">매년 지급(4일)</span></th>
		      <th><span class="tableTitle">조의사용</span><span class="tableTitle2">신청시 지급(5일/3일)</span></th>
		      <th><span class="tableTitle">결혼사용</span><span class="tableTitle2">신청시 지급(2일/1일)</span></th>
		      <th><span class="tableTitle">긴급사용</span><span class="tableTitle2">신청시 지급(1일)</span></th>
		      <th><span class="tableTitle">기타사용</span><span class="tableTitle2">신청시 지급(1일)</span></th>
		    </tr>
		</thead>
		<tbody>
		    <tr>
		      <td><div class="tableProf">지현</div>김지현</td>
		      <td class="patop">103</td>
		      <td class="promotionLeave patop">12</td>
		      <td class="patop">25</td>
		      <td class="patop">90</td>
		      <td class="patop">4</td>
		      <td class="patop">0</td>
		      <td class="patop">0</td>
		      <td class="patop">0</td>
		      <td class="patop">0</td>
		    </tr>
		    <tr>
		      <td><div class="tableProf">지현</div>김지현</td>
		      <td class="patop">103</td>
		      <td class="promotionLeave patop">12</td>
		      <td class="patop">25</td>
		      <td class="patop">90</td>
		      <td class="patop">4</td>
		      <td class="patop">0</td>
		      <td class="patop">0</td>
		      <td class="patop">0</td>
		      <td class="patop">0</td>
		    </tr>
		    <tr>
		      <td><div class="tableProf">지현</div>김지현</td>
		      <td class="patop">103</td>
		      <td class="promotionLeave patop">12</td>
		      <td class="patop">25</td>
		      <td class="patop">90</td>
		      <td class="patop">4</td>
		      <td class="patop">0</td>
		      <td class="patop">0</td>
		      <td class="patop">0</td>
		      <td class="patop">0</td>
		    </tr>
		    <tr>
		      <td><div class="tableProf">지현</div>김지현</td>
		      <td class="patop">103</td>
		      <td class="promotionLeave patop">12</td>
		      <td class="patop">25</td>
		      <td class="patop">90</td>
		      <td class="patop">4</td>
		      <td class="patop">0</td>
		      <td class="patop">0</td>
		      <td class="patop">0</td>
		      <td class="patop">0</td>
		    </tr>
		    <tr>
		      <td><div class="tableProf">지현</div>김지현</td>
		      <td class="patop">103</td>
		      <td class="promotionLeave patop">12</td>
		      <td class="patop">25</td>
		      <td class="patop">90</td>
		      <td class="patop">4</td>
		      <td class="patop">0</td>
		      <td class="patop">0</td>
		      <td class="patop">0</td>
		      <td class="patop">0</td>
		    </tr>
	    </tbody>
	</table>
</div>

<%-- 구성원 휴가 보유 현황  끝 --%>		
	