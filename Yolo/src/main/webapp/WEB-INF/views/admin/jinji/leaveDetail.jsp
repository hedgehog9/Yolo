<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath=request.getContextPath(); %>

<jsp:include page="/WEB-INF/tiles/admin/jinji/leaveCategory.jsp"></jsp:include>

<style type="text/css">
	
	/* leaveCategory.jsp 시작 */
	#cate2, #cate3 {
		color: silver;
	}
	
	#container{
	 	margin-left: 15px;
	/* 	width: 100%; */
	}

	/* leaveCategory.jsp 시작 */
	
	table{
		border-radius: 10px; /* not working...  */
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
	 	margin-right: 65px; 
	/* 	width: 100px;   */
		float: right;
	}
	
	
	/* datepicker 끝 */
		
</style>

<script type="text/javascript">

	$(document).ready(function () {
		
		 $( "#datepicker" ).datepicker({
			  dateFormat: 'yy' //Input Display Format 변경
             ,showOtherMonths: false //빈 공간에 현재월의 앞뒤월의 날짜를 표시
             ,showMonthAfterYear: false //년도 먼저 나오고, 뒤에 월 표시
             ,changeYear: true //콤보박스에서 년 선택 가능
             ,changeMonth: false //콤보박스에서 월 선택 가능                
             ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
             ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
             ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
             ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
             ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
             ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
     //      ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
     //      ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
     //      ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
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
	
	function goEmpleaveManage() { // 연차촉진 페이지로 이동 
		 // alert('goPage!');
			location.href="<%= ctxPath%>/jinji/empLeaveStatus.yolo"
	};
	
</script>


<%-- 연차 상세 현황 테이블 --%>
	<div id="container">
		<div>
			<span style="font-size: 15pt; font-weight: bold;">연차 상세 현황</span>
			<form id="searchYear" name="searchYearFrm">
				<input type="text" id="datepicker" class="date-picker-year" />
			</form>
		</div>	
		<br>
		<div class="row" style="width: 95%; margin: 0;">
		<table class="table table-bordered" style="border-radius: 10px; overflow: hidden;">
		  <thead style="text-align: left;">
		    <tr style="border-bottom: hidden;">
		      <th><span style="color: green; ">│</span>자동 부여</th>
		      <th><span style="color: orange; ">│</span>자동 소멸</th>
		      <th><span style="color: red; ">│</span>사용</th>
		    </tr>
		  </thead>
		  <tbody>
		    <tr>
		      <td><span class="text-success" style="font-size: 15pt; font-weight: bold;"> &nbsp; + 1일 </span></td>
		      <td><span class="text-muted" style="font-size: 15pt; font-weight: bold;"> &nbsp; 없음 </span></td> <%-- 없움일 경우  silver color / 있으면 orange  --%>
		      <td><span class="text-danger" style="font-size: 15pt; font-weight: bold;"> &nbsp; - 4일 </span></td>
		    </tr>
		  </tbody>
		</table>
		</div>
	</div>
	<br>
	
	<div id="container">
		<div id="row">
		<table class="table table-bordered table-hover"  style="width: 95%;">
		  <thead style="text-align: right;">
		    <tr>
		      <th style="color: gray; ">날짜</th>
		      <th style="color: gray; ">자동 부여</th>
		      <th style="color: gray; ">자동 소멸</th>
		      <th style="color: gray; ">사용</th>
		      <th style="color: gray; ">잔여</th>
		    </tr>
		  </thead>
		  <tbody>
		    <tr>
		      <td>
		      <span>2022.11</span>
		      <span class="badge badge-secondary rounded-pill d-inline">입사월</span>
		      <span class="badge badge-warning rounded-pill d-inline">이번달</span>
		      </td>
		      <td></td>
		      <td></td>
		      <td></td>
		      <td></td>
		    </tr>
		  </tbody>
		</table>
		</div>
	</div>
	<%-- 연차상세 현황 테이블 끝 --%>