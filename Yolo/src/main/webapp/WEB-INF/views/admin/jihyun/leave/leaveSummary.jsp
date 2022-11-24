<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<% String ctxPath=request.getContextPath(); %>

<jsp:include page="leaveCategory.jsp" />

<style type="text/css">
	
	
	div.dashBoard {
		width: 90%;
		margin: 20px 5% 5px 5%;	
	 	
	}
	
	h4 {
		font-size: 20px; 
		font-weight: bold;
		margin-bottom: 15px;
	}
	
	.card {
		border-radius: 1rem;
		cursor: pointer;
	}
	
	.card:hover {
    	background: #ededed;
 	}
 	
 	span.miniTitle{
 		font-size: 15pt; 
 		font-weight: bold;
 	}
 	
 	span.miniTitleNumber{
 		font-size: 15pt; 
 		font-weight: bold;
 		color: red;
 		margin-left: 10px;
 	}
 	
 	/* datepicker 시작 */
 		
 	.ui-datepicker-trigger {
		padding: 0;
		border-style: none;
		margin-left: 10px;
		width: 20px;
		height: 20px;
	}
	
	#datepicker {
		width: 100px; 
		border-radius: 10px; 
		padding: 0;
		border-color: silver;
	}
	
	#searchYear {
	 	margin-right: 150px; 
	/* 	width: 100px;   */
		float: right;
	}
	
	
	/* datepicker 끝 */
	
	button {
		border-style: none;
		box-shadow: none !important;
		background-color: inherit;
		padding: 0;
		margin: 0;
		text-align: left;
		cursor: pointer;
	}
	
	button:link, button:visited,
	button:active, button:hover { 
		border-style: none;
		display: inherit; 
	}
	
	table {
		margin-top : 10px;
		width: 100%;
	}
	
	tr:hover {
		cursor: pointer;
	}
	
	div.leaveProf{
		width: 40px; 
		height: 40px; 
		border-radius: 40%; 
		text-align: center;
		border: 1px solid #ccced0;
		font-size: 16pt;
		display: flex;
  		align-items: center;
  		padding-left: 4px;
	}
	
	button.submitCancle {
		height: 30px;
		font-size: 10pt;
		font-weight: bold;
		border-radius: 1rem;
		margin-top: 5px;
	} 
	
	td.patop {
		padding-top: 20px;
	} 
	
	td.head {
		width: 70px;
	}
	
	td.tail{
		text-align: right;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function () {
		
		
		
		$("span#myLeave").css("color", "#494949");
		
		
		$("#datepicker" ).datepicker({
			 dateFormat: 'yy' //Input Display Format 변경
            ,showOtherMonths: false //빈 공간에 현재월의 앞뒤월의 날짜를 표시
            ,changeYear: true //콤보박스에서 년 선택 가능
            ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
            ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
            ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
            ,minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
            ,maxDate: "+5Y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)       
			
      /* 	 dateFormat:"yyyy",   // 연도 출력폼 설정
		     onSelect:function(year){    // 연도 선택되었을때 실행하는 함수
		     alert(year);
		     }
		*/	     
			 
		});
		 
		 
		//초기값을 오늘 날짜로 설정
        $('#datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후) 
		
		
	});


	
</script>

	<%-- 대쉬보드 시작 --%>
	<div id="container">
		<div class="dashBoard">
			<h4 class="my-4">휴가등록</h4>
			<div class="card-columns">
			  <div class="card mb-4">
			    <div class="card-body text-left ml-3">
				 	<span style="font-size:30px;">&#9978;</span>
			     	<h6 class="card-title mt-4">연차</h6>	
			      	<p class="card-text">-4</p>
			    </div>
			  </div>
			  <div class="card mb-4">
			    <div class="card-body text-left ml-3">
			    	<span style="font-size:30px;">&#9993;</span>
			     	<h6 class="card-title mt-4">조의</h6>	
			      	<p class="card-text">#</p>
			    </div>
			  </div>
			  <div class="card mb-4">
			    <div class="card-body text-left ml-3">
			    	<span style="font-size:30px;">&#128138;</span>
			     	<h6 class="card-title mt-4">병가</h6>	
			      	<p class="card-text">#</p>
			    </div>
			  </div>
			  <div class="card mb-4">
			    <div class="card-body text-left ml-3">
			    	<span style="font-size:30px;">&#128141;</span>
			     	<h6 class="card-title mt-4">결혼</h6>	
			      	<p class="card-text">#</p>
			    </div>
			  </div>
			  <div class="card mb-4">
			    <div class="card-body text-left ml-3">
			    	<span style="font-size:30px;">&#127808;</span>
			     	<h6 class="card-title mt-4">리프레쉬</h6>	
			      	<p class="card-text">3년 극속시 30일 지급</p>
			    </div>
			  </div>
			  <div class="card mb-4t">
			    <div class="card-body text-left ml-3">
			    	<span style="font-size:30px;">&#128420;</span>
			     	<h6 class="card-title mt-4">기타</h6>	
			      	<p class="card-text">#</p>
			    </div>
			   </div>
			   
			</div>
		</div>
	</div>
	<%-- 대쉬보드 끝 --%>
	
	
	<%-- 예정휴가 테이블 --%>
	<%-- 휴가 신청으로 예정된 휴가 있는 경우 --%>
	<div class="dashBoard">
		<span class="miniTitle">예정 휴가</span><span class="miniTitleNumber">6</span>
		<table class="table table-borderless table table-hover ">
		    <tr>
		      <td class="head"><div class="leaveProf">&#9978;</div></td>
		      <td class="patop">연차</td>
		      <td class="patop">2022.11.11 ~ 2022.11.11<span class="badge badge-light rounded-pill ml-4">4일</span></td>
		      <td class="patop"><span class="badge badge-warning rounded-pill">자료 미첨부</span></td>
		      <td class="tail"><button type="button" class="btn btn-outline-secondary btn-sm submitCancle">신청 취소</button></td>
		    </tr>
		    <tr>
		      <td class="head"><div class="leaveProf">&#128420;</div></td>
		      <td class="patop">기타</td>
		      <td class="patop">2022.11.11 ~ 2022.11.11<span class="badge badge-light rounded-pill ml-4">1일</span></td>
		      <td class="patop"><span class="badge badge-success rounded-pill">자료 첨부완료</span></td>
		      <td class="tail"><button type="button" class="btn btn-outline-secondary btn-sm submitCancle">신청 취소</button></td>
		    </tr>
		</table>
	  </div>
	<%-- 예정된 휴가 없는 경우 --%>
	<%-- 예정 휴가 태이블 끝 --%>
	   
	    
    <%-- 휴가 사용 기록 시작 --%>
    <div class="dashBoard mt-5">
    	<div>
		<span class="miniTitle">사용 기록</span><span class="miniTitleNumber">6</span>
		<form id="searchYear"	name="searchYearFrm">
			<input type="text" id="datepicker" class="date-picker-year" />
		</form>
		</div>
		<table class="table table-borderless table table-hover ">
		    <tr>
		      <td class="head"><div class="leaveProf">&#9978;</div></td>
		      <td class="patop">연차</td>
		      <td class="patop">2022.11.11 ~ 2022.11.11<span class="badge badge-light rounded-pill ml-4">4일</span></td>
		      <td class="patop"><span class="badge badge-warning rounded-pill">자료 미첨부</span></td>
		      <td style="width: 170px;"></td>
		    </tr>
		    <tr>
		      <td class="head"><div class="leaveProf">&#127808;</div></td>
		      <td class="patop">리프레쉬</td>
		      <td class="patop">2022.11.11 ~ 2022.11.11<span class="badge badge-light rounded-pill ml-4">1일</span></td>
		      <td class="patop"><span class="badge badge-success rounded-pill">자료 첨부완료</span></td>
		      <td></td>
		    </tr>
		</table>
	  </div>
    
    <%-- 휴가 사용 기록 끝 --%>     
 
