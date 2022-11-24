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
 	
 	.card-title {
 		font-size: 13pt;
 		font-weight: bold;
 	}
 	
 	.card-text {
 		margin-top: -3px;
 		color: gray;
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
		width: 110px;
	}
	
	/* 모달 */
	.modal.right .modal-dialog {
		position: fixed;
		margin: auto;
		width: 100%;
		height: 100%;
		-webkit-transform: translate3d(0%, 0, 0);
		    -ms-transform: translate3d(0%, 0, 0);
		     -o-transform: translate3d(0%, 0, 0);
		        transform: translate3d(0%, 0, 0);
	}

	.modal.right .modal-content {
		height: 100%;
	/* 	overflow-y: auto; */
	}
	
	.modal.right .modal-body {
	 /* padding: 15px 15px 80px;  */
	 	width: 100%; 
	}
	
	.modal-footer {
		border: none;
	}
	
	.modal.right.fade .modal-dialog {
		right: 0;
		-webkit-transition: opacity 0.3s linear, right 0.3s ease-out;
		   -moz-transition: opacity 0.3s linear, right 0.3s ease-out;
		     -o-transition: opacity 0.3s linear, right 0.3s ease-out;
		        transition: opacity 0.3s linear, right 0.3s ease-out;
	}
	
	.modal.right.fade.in .modal-dialog {
		right: 0;
	}
	
	div.modal-middle {
		width: 90%;
		margin: auto 5%;
	}
	
	span.modalBage {
		font-size:14px; 
		font-weight: normal; 
		margin-right: 7px;
	}
	
	textarea {
		min-height: 100px;
		width: 100%;
		margin: 20px 0 5px 0;
		border: 1px solid #dddddd;
		border-radius: 0.4rem;
	}
	
	button.leaveUsingBnt {
		width: 100px;
		height: 40px;
		border: 1px solid #07b419;
		border-radius: 0.5rem;
		margin-right: 15px;
		font-weight: bold;
		font-size : 11pt;
		text-align : center;
		background-color: #07b419;
		color: white;
	}
	
	 button.leaveUsingBnt:hover {
		filter: brightness(90%);
	}
	
	
</style>

<script type="text/javascript">

	$(document).ready(function () {
		
		$("span#myLeave").css("color", "#494949");
		
		
	});
</script>

	<%-- 대쉬보드 시작 --%>
	<div class="dashBoard">
		<h4 class="my-4">휴가등록</h4>
		<div class="row">
		  <div class="col-lg-3 mb-4">
			  <div class="card"  data-toggle="modal" data-target="#yearLeave">
			    <div class="card-body text-left ml-2">
				 	<span style="font-size:30px;">&#9978;</span>
			     	<h6 class="card-title mt-4">연차</h6>	
			      	<p class="card-text">12일</p>
			    </div>
			  </div>
		  </div>
		  <div class="col-lg-3 mb-4">
			  <div class="card">
			    <div class="card-body text-left ml-2">
				 	<span style="font-size:30px;">&#128340;</span>
			     	<h6 class="card-title mt-4">반차</h6>	
			      	<p class="card-text">25일</p>
			    </div>
			  </div>
		  </div>
		  <div class="col-lg-3 mb-4">
			  <div class="card">
			    <div class="card-body text-left ml-2">
			    	<span style="font-size:30px;">&#9993;</span>
			     	<h6 class="card-title mt-4">조의</h6>	
			      	<p class="card-text">신청시 지급</p>
			    </div>
			  </div>
		  </div>
		  <div class="col-lg-3 mb-4">
			  <div class="card">
			    <div class="card-body text-left ml-2">
			    	<span style="font-size:30px;">&#128138;</span>
			     	<h6 class="card-title mt-4">병가</h6>	
			      	<p class="card-text">90일</p>
			    </div>
			  </div>
		  </div>
		  <div class="col-lg-3 mb-4">
			  <div class="card">
			    <div class="card-body text-left ml-2">
			    	<span style="font-size:30px;">&#128031;</span>
			     	<h6 class="card-title mt-4">여름휴가</h6>	
			      	<p class="card-text">4일</p>
			    </div>
			  </div>
		  </div>
		  <div class="col-lg-3 mb-4">
			  <div class="card">
			    <div class="card-body text-left ml-2">
			    	<span style="font-size:30px;">&#128141;</span>
			     	<h6 class="card-title mt-4">결혼</h6>	
			      	<p class="card-text">신청시 지급</p>
			    </div>
			  </div>
		  </div>
		  <div class="col-lg-3 mb-4">
			  <div class="card">
			    <div class="card-body text-left ml-2">
			    	<span style="font-size:30px;">&#128680;</span>
			     	<h6 class="card-title mt-4">긴급</h6>	
			      	<p class="card-text">신청시 하루지급</p>
			    </div>
			  </div>
		  </div>
		  <div class="col-lg-3 mb-4">
			  <div class="card">
			    <div class="card-body text-left ml-2">
			    	<span style="font-size:30px;">&#9989;</span>
			     	<h6 class="card-title mt-4">기타</h6>	
			      	<p class="card-text">신청시 지급</p>
			    </div>
			   </div>
		   </div>
		</div>
	</div>

	<%-- 대쉬보드 끝 --%>
	
	
	<div style="width: 90%; margin: auto;">
		<select>
			<option selected="selected">2022</option>
			<option>2021</option>
			<option>2020</option>
			<option>2019</option>
			<option>2018</option>
		</select>
	</div>
	
	
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
		      <td class="patop"><span class="badge badge-light rounded-pill">미승인</span></td>
		      <td class="tail"><button type="button" class="btn btn-outline-secondary btn-sm submitCancle">신청 취소</button></td>
		    </tr>
		    <tr>
		      <td class="head"><div class="leaveProf">&#128420;</div></td>
		      <td class="patop">기타</td>
		      <td class="patop">2022.11.11 ~ 2022.11.11<span class="badge badge-light rounded-pill ml-4">1일</span></td>
		      <td class="patop"><span class="badge badge-success rounded-pill">자료 첨부완료</span></td>
		      <td class="patop"><span class="badge badge-dark rounded-pill">승인</span></td>
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
		</div>
		<table class="table table-borderless table table-hover ">
		    <tr>
		      <td class="head"><div class="leaveProf">&#9978;</div></td>
		      <td class="patop">연차</td>
		      <td class="patop">2022.11.11 ~ 2022.11.11<span class="badge badge-light rounded-pill ml-4">4일</span></td>
		      <td class="patop"><span class="badge badge-warning rounded-pill">자료 미첨부</span></td>
		      <td class="patop"><span class="badge badge-light rounded-pill">미승인</span></td>
		      <td class="tail"></td>
		    </tr>
		    <tr>
		      <td class="head"><div class="leaveProf">&#127808;</div></td>
		      <td class="patop">리프레쉬</td>
		      <td class="patop">2022.11.11 ~ 2022.11.11<span class="badge badge-light rounded-pill ml-4">1일</span></td>
		      <td class="patop"><span class="badge badge-success rounded-pill">자료 첨부완료</span></td>
		      <td class="patop"><span class="badge badge-dark rounded-pill">승인</span></td>
		      <td class="tail"></td>
		    </tr>
		</table>
	  </div>
    
    <%-- 휴가 사용 기록 끝 --%>     
 
 
<!-- 연차 Modal -->
<div class="modal right fade" id="yearLeave" tabindex="-1"aria-hidden="true" >
  <div class="modal-dialog modal-dialog-scrollable modal-right modal-md">
  
	    <%-- Modal content --%>
	    <div class="modal-content">
	      <div class="modal-header py-3" >
	        <span style="font-size:21px;">&#9978;</span><span class="miniTitle ml-3"> 연차</span>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
	      </div>
	      <div class="modal-body">
	      	<div class="modal-middle">
		      	<span style="display: block; margin-top: 10px;">&#128204; 휴가정보</span>
		      	<div style="margin: 10px auto;">
		      		<span class="badge modalBage" style="background-color: #AFEEEE;">1년당 25개 사용가능</span>
		      		<span class="badge modalBage" style="background-color: #B0E0E6;">유급</span>
		      		<span class="badge modalBage" style="background-color: #B0C4DE;">연말만료</span>
		      	</div>
		      	<span style="display: block; margin-top: 30px;">&#128161; 사용 가능 연차 </span>
		      	<span class="badge modalBage" style="background-color: #AFEEEE; margin-top: 10px;">6일</span>
		      	<span style="display: block; margin-top: 30px;">&#128221; 휴가 일정 · 필요 정보 입력</span>
		      	<input type="text" id="daterange" class="form-control text-center">
		        <input type="hidden" name="start_date" class="form-control text-center">
		        <input type="hidden" name="end_date" class="form-control text-center">
		        <textarea rows="4" cols="" placeholder="휴가 등록 메세지 입력"></textarea>
		        
		 	</div>
	 	 </div>
	 	 <div class="modal-footer" >
			<button type="button" class="leaveUsingBnt" style="background-color: white; color: #07b419;">취소</button>
			<button type="button" class="leaveUsingBnt">휴가신청</button>
		</div>
  	  </div>
   </div>
   
</div>
