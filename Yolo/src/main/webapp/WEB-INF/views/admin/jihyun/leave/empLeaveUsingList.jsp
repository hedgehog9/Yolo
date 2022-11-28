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
		cursor: pointer;
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
	
	span.badge {
		font-size: 10pt;
	}
	
	button.approve {
		height: 30px;
		font-size: 10pt;
		font-weight: bold;
		border-radius: 1rem;
		margin-top: 5px;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		$("span#empLeave").css("color", "#494949");
		$("span.headerTitle2").show();
		$("span#empLeaveSubmit").css("color", "#494949");
		$("div#underBar1").css("display", "block");
		
	});

	
</script>	


<div id="tableDiv">
	<table class="table table-bordered table-hover ">
		<thead>
		    <tr>
		      <th class="head"><span class="tableTitle">이름</span></th>
		      <th><span class="tableTitle">사번</span></th>
		      <th><span class="tableTitle">기간</span></th>
		      <th><span class="tableTitle">항목</span></th>
		      <th><span class="tableTitle">사용시간</span></th>
		      <th><span class="tableTitle">증명자료</span></th>
		      <th><span class="tableTitle">승인</span></th>
		    </tr>
		</thead>
		<tbody>
		    <tr>
		      <td><div class="tableProf">지현</div>김지현</td>
		      <td class="patop">103</td>
		      <td class="patop">2022.11.11(금) ~ 2022.11.11(금)</td>
		      <td class="patop">연차</td>
		      <td class="patop">오후</td>
		      <td class="patop"></td>
		      <td><button type="button" class="btn btn-outline-secondary btn-sm approve">승인 / 취소</button></td>
		    </tr>
		    <tr>
		      <td><div class="tableProf">지현</div>김지현</td>
		      <td class="patop">103</td>
		      <td class="patop">2022.11.11(금) ~ 2022.11.11(금)</td>
		      <td class="patop">병가</td>
		      <td class="patop">3일</td>
		      <td class="patop"><span class="badge badge-success rounded-pill">제출완료</span></td>
		      <td class="patop">승인 완료</td>
		    </tr>
		    <tr>
		      <td><div class="tableProf">지현</div>김지현</td>
		      <td class="patop">103</td>
		      <td class="patop">2022.11.11(금) ~ 2022.11.11(금)</td>
		      <td class="patop">결혼-자녀</td>
		      <td class="patop">1일</td>
		      <td class="patop"></td>
		      <td class="patop">승인 취소</td>
		    </tr>
		    
	    </tbody>
	</table>
</div>
