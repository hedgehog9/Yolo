<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<% String ctxPath=request.getContextPath(); %>

<jsp:include page="/WEB-INF/tiles/admin/jinji/leaveCategory.jsp" ></jsp:include>

<style type="text/css">
	
	/* leaveCategory.jsp 시작 */
	
	#cate2, #cate4 {
		color: silver;
	}

	/* leaveCategory.jsp 끝 */
	
	#container {
		margin-left: 15px;	
	 /* width: 95%; */
	}
	
	h4 {
		font-size: 20px; 
		font-weight: bold;
	}
	
	.card {
		border-radius: 10px;
		cursor: pointer;
		
	}
	
	.card:hover {
    	background: #ededed;
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
 
	#leavecancel {
		border-style: none;
		box-shadow: none !important;
		background-color: inherit;
		padding: 0;
		margin: 0;
		text-align: left;
		cursor: pointer;
	}
	
	table {
		max-width: 100%;
		table-layout: fixed;
	}
	
	td, th {
		flex: 1;
	}
</style>

<script type="text/javascript">

	$(document).ready(function () {
	
		 $( "#datepicker" ).datepicker({
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


	///////// Function Declaration ////////////
	function goleaveSummary() { // 휴가개요로 이동 
		// alert('goPage!');
	   location.href="<%= ctxPath%>/jinji/leaveSummary.yolo"
	};
	
	function goleaveDetail() { // 연차 상세 페이지로 이동 
	 // alert('goPage!');
		location.href="<%= ctxPath%>/jinji/leaveDetail.yolo"
	};
	

	function goEmpleaveManage() { // 연차 상세 페이지로 이동 
		 // alert('goPage!');
			location.href="<%= ctxPath%>/jinji/empLeaveStatus.yolo"
	};
	
</script>


	<%-- 대쉬보드 시작 --%>
	<div id="container" style="cursor: pointer;">
		<h4 style="margin-bottom: 10px;">휴가등록</h4><br>
		<div class="card-columns mb-5 mr-1" style="max-width:95%;">
		  <div class="card md-light">
		    <div class="card-body text-left">
			 	<span style="font-size:30px;">&#9978;</span>
		     	<h6 class="card-title mt-4">연차</h6>	
		      	<p class="card-text">-4</p>
		    </div>
		  </div>
		  <div class="card md-light">
		    <div class="card-body text-left">
		    	<span style="font-size:30px;">&#9993;</span>
		     	<h6 class="card-title mt-4">조의</h6>	
		      	<p class="card-text">#</p>
		    </div>
		  </div>
		  <div class="card md-light">
		    <div class="card-body text-left">
		    	<span style="font-size:30px;">&#128138;</span>
		     	<h6 class="card-title mt-4">병가</h6>	
		      	<p class="card-text">#</p>
		    </div>
		  </div>
		  <div class="card md-light">
		    <div class="card-body text-left">
		    	<span style="font-size:30px;">&#128141;</span>
		     	<h6 class="card-title mt-4">결혼</h6>	
		      	<p class="card-text">#</p>
		    </div>
		  </div>
		  <div class="card md-light">
		    <div class="card-body text-left">
		    	<span style="font-size:30px;">&#127808;</span>
		     	<h6 class="card-title mt-4">리프레쉬</h6>	
		      	<p class="card-text">3년 극속시 30일 지급</p>
		    </div>
		  </div>
		  <div class="card md-light">
		    <div class="card-body text-left">
		    	<span style="font-size:30px;">&#128420;</span>
		     	<h6 class="card-title mt-4">기타</h6>	
		      	<p class="card-text">#</p>
		    </div>
		   </div>
		   
		</div>
	</div>
	<%-- 대쉬보드 끝 --%>
	
	
	<%-- 예정휴가 테이블 --%>
	<div id="container" style="width: 99%;">
		<h4>예정 휴가</h4>
		<table class="table table-borderless table table-hover ">
		  <thead>
		    <tr>
		      <th></th>
		      <th></th>
		      <th></th>
		      <th></th>
		      <th></th>
		      <th></th>
		    </tr>
		  </thead>
		  <tbody>
		  	<%-- 휴가 신청으로 예정된 휴가 있는 경우 --%>
		    <tr>
		      <td>1</td>
		      <td>연차</td>
		      <td>2022.11.11 ~ 2022.11.11 </td>
		      <td></td>
		      <td><span class="badge badge-warning rounded-pill d-inline">4일</span></td>
		      <td>
			    <form id="leavecancel" style="width: 70px">
	           	 <button type="button" class="badge badge-dark rounded-pill d-inline">신청 취소</button>
        		</form>
		      </td ><%-- 휴가 신청 취소 버튼 --%>
		    </tr>
			<tr>
		      <td>1</td>
		      <td>연차</td>
		      <td>2022.11.11 ~ 2022.11.11 </td>
		      <td></td>
		      <td><span class="badge badge-warning rounded-pill d-inline">4일</span></td>
		      <td>
			    <form id="leavecancel"  style="width: 70px">
	           	 <button type="button" class="badge badge-dark rounded-pill d-inline">신청 취소</button>
        		</form>
		      </td><%-- 휴가 신청 취소 버튼 --%>
		    </tr>
		    
			<%-- 예정된 휴가 없는 경우 --%>

	 	 </tbody>
		</table>
	  </div>
	<br>
	<%-- 예정 휴가 태이블 끝 --%>
	   
	    
    <%-- 휴가 사용 기록 시작 --%>
    <div id="container" style="width: 99%;">
    	<div>
		<span style="font-size: 15pt; font-weight: bold;">사용 기록</span>
		<form id="searchYear"	name="searchYearFrm">
			<input type="text" id="datepicker" class="date-picker-year" />
		</form>
		</div>
		<table class="table table-borderless table table-hover">
		  <thead>
		    <tr>
		      <th></th>
		      <th></th>
		      <th></th>
		      <th></th>
		      <th></th>
		      <th></th>
		    </tr>
		  </thead>
		  <tbody>
		  	<%-- 사용한 휴가가 있는 경우 --%>
		    <tr>
		      <td>1</td>
		      <td>연차</td>
		      <td>2022.11.11 ~ 2022.11.11 </td>
		      <td></td>
		      <td><span class="badge badge-success rounded-pill d-inline">4일</span></td>
		    </tr>
			<tr>
		      <td>1</td>
		      <td>연차</td>
		      <td>2022.11.11 ~ 2022.11.11 </td>
		      <td></td>
		      <td><span class="badge badge-success rounded-pill d-inline">4일</span></td>
		      <td></td>
		    </tr>
		    
			<%-- 사용한 휴가가 없는 경우 
			<tr>
		      <td><i class="fa fa-ellipsis-h" aria-hidden="true"></i></td>
		      <td>예정된 휴가가 없습니다.</td>
		    </tr>	
		    --%>
	 	 </tbody>
		</table>
	  </div>
    
    <%-- 휴가 사용 기록 끝 --%>     
    
