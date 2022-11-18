<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath=request.getContextPath(); %>

<jsp:include page="/WEB-INF/tiles/admin/jinji/empLeaveManageCategory.jsp"></jsp:include>
    
<style type="text/css">
	
	/* leaveCategory.jsp 시작 */
	
	#cate1, #cate3, #cate4 {
		color: silver;
	}
	
	#cate5 {
		color: black;
	}
	
	/* leaveCategory.jsp 끝 */
	
	#container {
		margin-left: 15px; 
	/* 	width: 100%; */
	}
	
	#tabletitle {
		margin-bottom: 20px;
		font-size: 15pt; 
		font-weight: bold;
	}
	
	/* 달력 이미지 시작  */
	
	.ui-datepicker-trigger {
		padding: 0;
		border-style: none;
		margin-left: 10px;
		background-color: inherit;
	}
	
	button>img {
		width: 20px;
		height: 20px;
	}
	
	/* 달력 이미지 끝 */
	
	table {
		max-width:  100%;
		border-radius: 10px;
		overflow: hidden; 
		height: auto;
		table-layout: fixed;
	}
	
	th, td{
		text-align: center;
		flex: 1;
	}
	
	

</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		$( "#datepicker" ).datepicker({
			dateFormat: 'yy' //Input Display Format 변경
           ,showOtherMonths: false //빈 공간에 현재월의 앞뒤월의 날짜를 표시
           ,showMonthAfterYear: false //년도 먼저 나오고, 뒤에 월 표시
           ,changeYear: true //콤보박스에서 년 선택 가능
           ,changeMonth: false //콤보박스에서 월 선택 가능                
           ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
           ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
  //       ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
           ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
           ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
           ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
   //      ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
   //      ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
   //      ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
           ,minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
           ,maxDate: "+5Y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)       
     
			 
		});
		 
		 //초기값을 오늘 날짜로 설정
      	 $('#datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후) 
		
       	
		
	});

	
	///////// Function Declaration ////////////
	function goAdminLeave() { // 관리자 내 휴가 페이지로 이동 
	 // alert('goPage!');
		location.href="<%= ctxPath%>/jinji/leaveSummary.yolo"
	};
	
	function goempLeaveStatus() { // 구성원 휴가 보유 현황 페이지로 이동
	 // alert('goPage!');
		location.href="<%= ctxPath%>/jinji/empLeaveStatus.yolo"
	};
	
	function goempLeaveUsingList() { // 구성원 휴가 사용 내역 페이지로 이동
		 // alert('goPage!');
			location.href="<%= ctxPath%>/jinji/empLeaveUsingList.yolo"
	};
	
	
</script>	

	<div id="container">
		<div id="title">
		<span id="tabletitle">연차 상세 현황</span>
		<form name="searchYear" style="float: right; text-align: right;">
			<input type="text" id="datepicker" class="date-picker-year" style="width: 150px; border-radius: 10px;"/>
		</form>
		</div>
		<br>

	    <div class="table-responsive">
	      <table class="table table-hover table-bordered">
	        <thead>
	          <tr class="thead-dark">
	            <th>이름</th>
	            <th>사번</th>
	            <th>연차 정보</th>
	            <th>상태</th>
	            <th>연차 사용 계획서</th>
	          </tr>
	        </thead>
	        <tbody>
	          <tr>
	            <td>
	            	<span style='font-size:20px;'>&#128105;</span>
	            	Jacob
	            </td>
	            <td>3333</td>
	            <td class="text-muted "> 11.18 소멸 <i class="fa fa-exclamation-circle" aria-hidden="true"></i></td>
	            <td><label class="badge badge-danger">관리자 작성 필요</label></td>
	            <td><label class="badge badge-success">작성하기</label></td>
	          </tr>
	          <tr>
	            <td>
	            	<span style='font-size:20px;'>&#128105;</span>
	            	Jacob
	            </td>
	            <td>3333</td>
	            <td class="text-muted "> 11.18 소멸 <i class="fa fa-exclamation-circle" aria-hidden="true"></i></td>
	            <td><label class="badge badge-info">작성 완료</label></td>
	            <td><label class="badge badge-light">문서 보기</label></td> <%-- 버튼 --%>
	          </tr>
	           <tr>
	            <td>
	            	<span style='font-size:20px;'>&#128105;</span>
	            	Jacob
	            </td>
	            <td>3333</td>
	            <td class="text-muted "> 11.18 소멸 <i class="fa fa-exclamation-circle" aria-hidden="true"></i></td>
	            <td><label class="badge badge-info">작성 완료</label></td>
	            <td><label class="badge badge-light">문서 보기</label></td> <%-- 버튼 --%>
	          </tr>
	           <tr>
	            <td>
	            	<span style='font-size:20px;'>&#128105;</span>
	            	Jacob
	            </td>
	            <td>3333</td>
	            <td class="text-muted "> 11.18 소멸 <i class="fa fa-exclamation-circle" aria-hidden="true"></i></td>
	            <td><label class="badge badge-info">작성 완료</label></td>
	            <td><label class="badge badge-light">문서 보기</label></td> <%-- 버튼 --%>
	          </tr>
	        </tbody>
	      </table>
	    </div>
	
	</div>
