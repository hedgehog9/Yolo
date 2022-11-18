<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>

<style>
	
	div#user_detail_content {
		margin: 40px 20px 20px 20px;
	}
	
	div.profile_icon {
		width: 30px;
		height: 30px;
		border-radius: 40%;
		background-color: #239afe;
		color: white;
		text-align: center;
		padding-top: 6px;
		border: 1px solid #ccced0;
		font-weight: bold;
		margin: auto 8px;
		font-size: 5pt;
	}
	
	div.profile {
		display: flex;
	}
	
	div#profile_img {
		width: 100px;
		height: 100px;
		border-radius: 15%;
		background-color: green;
		margin-right: 20px;
		display: flex;
		align-items: center;
		justify-content: center;
	}
	
	div#user_profile {
		display: flex;
		margin-top: 65px
	}
	
	div#user_name {
		font-size: 20pt;
		font-weight: bold;
		color: white;
		position: relative;
		left: 15px;
	}
	
	th.dept_position {
		font-size: 12px;
		font-weight: normal;
	}
	
	nav#hr_info {
		display: flex;
		justify-content: space-between;
		align-items: end;
		border-bottom: solid 1px #d9d9d9;
	}
	
	div#hr_info_title {
		display: flex;
		padding: 30px 30px 0px 0;
		margin-right: 30px;
	}
	
	div#hr_info_title>div.info_title {
		padding: 20px 10px 20px 10px;
	}
	
	<%-- 정보 변경 내역 버튼 css --%> 
	button#record_search {
		margin: 20px 0px 20px 0;
		border: solid 1px #d9d9d9;
		border-radius: 10px;
	}
	
	button#record_search:hover {
		background-color: #ebebeb;
	}
	
	<%-- 정보 변경 내역 버튼 css --%> <%-- 인사정보 수정 버튼 css --%> 
	button.btn_edit {
		border-radius: 10px;
		width:30px;
		margin: 0px;
		background-color: transparent;
		border: none;
	}
	
	button.btn_edit:focus{
		background-color: #ebebeb;
		border:none;
	}
	
	button.btn_edit:hover {
		background-color: #ebebeb;
	}
	
	<%-- 인사정보 수정 버튼 css --%> 
	div.info_title {
		font-size: 20px;
	}
	
	div.info_title:hover {
		cursor: pointer;
	}
	
	i.fa-phone-alt, i.fa-envelope, i.fa-comment {
		margin: 0px;
		width: 30px;
	}
	
	a.communication {
		padding: 3px 0px 3px 0px;
		border: solid 1px #d9d9d9;
	}
	
	a.communication:hover {
		background-color: #ebebeb;
	}
	
	div#div_hr_title {
		font-size: 20px;
		font-weight: 700;
	}
	
	span.span_badge {
		background-color: #d9d9d9;
		border-radius: 5px;
		padding: 0 5px;
	}
	
	<%-- 프로필 옆에 나오는 근무시간, 휴가, 급여명세서 div css --%> 
	div#right_sidebar {
		margin: 30px 0 0 0;
	}
	
	div.div_rightside {
		border: solid 1px #d9d9d9;
		margin-bottom: 10px;
		width: 300px;
		height: 120px;
		border-radius: 10px;
	}
	
	div#progressBar {
		margin: 16px 15px 0 0;
		width: 50px;
		height: 50px;
	}
	
	i.sideIcon {
		margin: 15px 0 0 20px;
		color: #242A30;
	}
	
	<%-- a태그 css 효과 없애기 --%> 
	a.a_side:link {
		background-color: transparent;
		text-decoration: none;
	}
	
	// 방문 전 링크 상태
	a.a_side:visited {
		background-color: transparent;
		text-decoration: none;
	}
	
	//방문 후 링크 상태
	a.a_side:hover {
		background-color: transparent;
		text-decoration: underline;
	}
	
	//마우스 오버했을 때 링크 상태
	a.a_side:active {
		background-color: transparent;
		text-decoration: underline;
	}
	
	// 클릭했을 때 링크 상태
	<%-- a태그 css 효과 없애기 --%> 
	tr.tr_info {
		height: 40px;
	}
	
	div#div_info {
		width: 70%;
	}
	
	<%-- 정보 변경 내역 div css --%> 
	div#record {
		/* border:solid 2px green; */
		width: 100%;
		height: 80%;
		position: fixed;
		top: 1000px;
		left: 0px;
		z-index: 999;
		background: white;
		color: black;
		transition: all 0.5s;
		padding: 10px;
	}
	
	div#record.active {
		top: 280px;
	}
	
	<%-- 정보 변경 내역 div css --%> 
	div#edit_info {
		/* border: solid 2px orange; */
		width: 40%;
		height: 100%;
		position: fixed;
		top: 0px;
		left: 100%;
		z-index: 999;
		background: white;
		color: black;
		transition: all 0.5s;
	}
	
	div#edit_info.active {
		left: 60%;
	}
	
	div#record_outside {
		position: fixed;
		top: 0px;
		left: 0px;
		width: 100%;
		height: 100%;
		background: rgba(0, 0, 0, 0.2);
		z-index: 998;
		display: none;
	}
	
	i.fa-question-circle:hover {
		cursor: help;
	}
	
	<%-- 모달 안의 날짜 지정하는 input 태그 css --%> 
	input.daterange {
		border: solid 1px #d9d9d9;
		border-radius: 5px;
	}
	
	<%-- 모달 안에 소제목 부분 css --%> 
	.modal_title {
		font-size: 14px;
		font-weight: 500;
		color: #3C4651;
	}
	
	<%--모달 안에 메모 부분 css --%> 
	textarea.memo {
		border: solid 1px #d9d9d9;
		width: 465px;
		border-radius: 10px;
		padding: 10px;
	}
	
	
	
	
	button#record_close{
		background-color: transparent;
		border: none;
	}
	
	<%-- 변경 내역 조회 클릭시 상단에 나오는 버튼 css --%>
	button.btn_record{
		background-color: white;
		color: black;
		font-size:13px;
		font-weight:600;
		height:32px;
		width:76px;
		border: solid 1px #d9d9d9;
		margin: 0 5px;
		border-radius: 100px;
	}
	
	button.btn_record_clicked {
		background-color: #07B419;
		color:white;
	}
	
	<%-- 정보 변경 내역 수정, 삭제 버튼 css  --%>
	button.btn_leave_edit_delete{
		height: 30px;
	    width: 30px;
	    background-color: transparent;
	    border-radius: 5px;
	}
	
	<%-- 정보 변경 내역 수정 버튼 css --%>
	button.btn_leave_edit{
		border: solid 1px #d9d9d9;
		color: #3C4651;
		margin: 0 10px;
	}
	
	<%-- 정보 변경 내역 삭제 버튼 css --%>
	button.btn_leave_delete{
		border: solid 1px #c32700;
		color: #c32700;
	}
	
	button.btn_save_cancel{
		font-size: 13px;
		font-weight: 600;
		height: 38px;
	}	
	
	i.fa-times{
		color:#556372;
	
	}
	

</style>
<%-- 말풍선 --%>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<%-- 말풍선 --%>

<script>

	$(document).ready(function(){
		
		// 모달에서 x 버튼 클릭스 안의 form 초기화
	    $('.modal').on('hidden.bs.modal', function (e) {
	       $(this).find('form')[0].reset();
	       $("div#retirement_type").text("고용보험 퇴직사유 선택");
	    });
		
		<%-- ===== 달력 하나만 출력 시작 =====  --%>
		$("input.daterange").daterangepicker({
            "singleDatePicker": true,
            "locale": {
                "format": "YYYY-MM-DD", // 날짜표현 형식
                "separator": " - ",
                "applyLabel": "선택",
                "cancelLabel": "취소",
                "fromLabel": "From",
                "toLabel": "To",
                "customRangeLabel": "Custom",
                "weekLabel": "W",
                "daysOfWeek": [
                    "일",
                    "월",
                    "화",
                    "수",
                    "목",
                    "금",
                    "토"
                ],
                "monthNames": [
                    "1월",
                    "2월",
                    "3월",
                    "4월",
                    "5월",
                    "6월",
                    "7월",
                    "8월",
                    "9월",
                    "10월",
                    "11월",
                    "12월"
                ],
                "firstDay": 1
            }
        });
		<%-- ===== 달력 하나만 출력 끝 =====  --%>
		
		
		<%-- ===== 달력 두개짜리 출력 시작 =====  --%>
		$('input#between_date').daterangepicker({
            locale: {
              "format": 'YYYY-MM-DD',
              "separator": ' → ',
              "applyLabel": "확인",
              "cancelLabel": "취소",
              "fromLabel": "From",
              "toLabel": "To",
              "customRangeLabel": "Custom",
              "weekLabel": "W",
              "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
              "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
            },
          },function(start, end, label) {
              $("input[name='start_date']").val(start.format('YYYY-MM-DD'))
              $("input[name='end_date']").val(end.format('YYYY-MM-DD'))
          });
		
		<%-- ===== 달력 두개짜리 출력 끝 =====  --%>
		
		let html = "";
		
		<%-- 근무시간 progressBar 시작  --%>
		let bar = new ProgressBar.Circle(progressBar, {
			color: '#FFEA82',
			trailColor: '#eee',
			trailWidth: 1,
			duration: 1400,
			easing: 'bounce',
			strokeWidth: 15,
			from: {color: '#FFEA82', a:0},
			to: {color: '#ED6A5A', a:1},
			// Set default step function for all animate calls
			step: function(state, circle) {
				circle.path.setAttribute('stroke', state.color);	
			}
		});
		
		bar.animate(0.8);  // progress bar 퍼센트 0.0 ~ 1.0
		<%-- 근무시간 progressBar 끝  --%>
		
		<%-- 말풍선 --%>
	  	$('[data-toggle="tooltip"]').tooltip();   
		
	  	<%-- =========== 인사정보 클릭 시작  =========== --%>
		$(document).on("click","div#div_hr", function(e){
	  		$("div.info_title").css("border-bottom","");
	  		$(e.target).css("border-bottom","solid 3px green");
	  		$("div#div_info").empty();
	  		
	  		html ="";
	  		html += "<div style='display:flex; justify-content: space-between; margin-top: 30px;'>"
						+"<div id='div_hr_title'>인사 정보</div>"
						
						+"<button id='btn_edit_hrInfo' type='button' data-toggle='dropdown' class='btn_edit'>"
							+"<i class='fas fa-pen' style='margin:0px; width:16px;'></i>"
						+"</button>"
						
						+"<div class='dropdown-menu'>"
							+"<a id ='a_edit_hrInfo'class='dropdown-item' href='javascript:void(0);' onclick='edit_hrInfo();'><i class='fas fa-user-alt'></i>&nbsp;&nbsp;인사 정보 변경&nbsp;&nbsp;"
								+"<span class='badge' style='background-color:#3B86C8; color:white;'>발령</span>"
							+"</a>"
							+"<a id='a_edit_basicInfo' class='dropdown-item' href='javascript:void(0);'onclick='edit_basicInfo()'><i class='fas fa-pen'></i>&nbsp;&nbsp;기본 정보 변경</a>" 
						+"</div>"
					+"</div>"
					
					+"<table>"
						+"<thead>"
							+"<tr style='height:40px;'>"
								+"<th style='width:200px'>사번</th>"				
								+"<th>333</th>"				
							+"</tr>"			
							+"<tr style='height:40px;'>"
								+"<th>입사일</th>"				
								+"<th><span>2022.11.17</span>&nbsp;&nbsp;<span class='span_badge'>1개월</span>&nbsp;&nbsp;<span class='span_badge'>그룹입사일 : 2022.11.17</span></th>"				
							+"</tr>"			
							+"<tr style='height:40px;'>"
								+"<th>입사 유형</th>"				
								+"<th>3</th>"				
							+"</tr>"			
							+"<tr style='height:40px;'>"
								+"<th>부서</th>"				
								+"<th><span>개발 1팀</span>&nbsp;&nbsp;<span class='span_badge'>주조직</span></th>"				
							+"</tr>"			
							+"<tr style='height:40px;'>"
								+"<th>직책</th>"				
								+"<th>대리</th>"				
							+"</tr>"			
							+"<tr style='height:40px;'>"
								+"<th>직위</th>"				
								+"<th>6</th>"			
							+"</tr>"			
						+"</thead>"
					+"</table>";
	  		
	  		$("div#div_info").html(html);
	  		
	  	});
		<%-- =========== 인사정보 클릭 끝  =========== --%>
  	
  	
	  	<%-- =========== 개인정보 클릭 시작  =========== --%>
	  	$(document).on("click","div#div_ps", function(e){
	  		$("div.info_title").css("border-bottom","");
	  		$(e.target).css("border-bottom","solid 3px green");
	  		$("div#div_info").empty();
	  		
	  		html ="";
	  		html += "<div style='display:flex; justify-content: space-between; margin-top: 30px;'>"
						+"<div id='div_hr_title'>개인 정보</div>"
						
						+"<button id='btn_edit_psInfo' type='button' class='btn_edit'>"
							+"<i class='fas fa-pen' style='margin:0px; width:16px;'></i>"
						+"</button>"
						
					+"</div>"
					+"<table>"
						+"<thead>"
							+"<tr style='height:40px;'>"
								+"<th style='width:200px'>이메일</th>"				
								+"<th>honggildong@gmail.com</th>"				
							+"</tr>"			
							+"<tr style='height:40px;'>"
								+"<th>이름</th>"				
								+"<th>홍길동</th>"				
							+"</tr>"			
							+"<tr style='height:40px;'>"
								+"<th>회사 내 이름</th>"				
								+"<th>홍길동</th>"				
							+"</tr>"			
							+"<tr style='height:40px;'>"
								+"<th>영문 이름</th>"				
								+"<th>Hong Gil Dong</th>"				
							+"</tr>"			
							+"<tr style='height:40px;'>"
								+"<th>국적, 거주국가, 체류자격 </th>"				
								+"<th>Republic of Korea</th>"				
							+"</tr>"			
							+"<tr style='height:40px;'>"
								+"<th>생년월일</th>";
						<%-- DB 에서 조회해온 성별이 남자인경우 뱃지 하늘색, 여자인 경우 분홍색 --%>	
						if("남"=="남"){		
							html+="<th>1998.06.10&nbsp;&nbsp;<span id='gender' class='span_badge' style='background-color:#b3d9ff; color:#00264d;'>남</span></th>";
							html+="<th>1998.06.10&nbsp;&nbsp;<span id='gender' class='span_badge' style='background-color:#ffccd5; color:#4d000d;'>여</span></th>";
						}
						else{
							
						}
								
						html+="</tr>"			
							+"<tr style='height:40px;'>"
								+"<th>주민등록번호</th>"				
								+"<th>980610-1111111</th>"			
							+"</tr>"			
							+"<tr style='height:40px;'>"
								+"<th>휴대전화번호</th>"				
								+"<th>010-2345-6789</th>"			
							+"</tr>"			
							+"<tr style='height:40px;'>"
								+"<th>집주소</th>"				
								+"<th>서울 특별시 관악구 남부순환로 234길 28(봉천동)</th>"			
							+"</tr>"			
							+"<tr style='height:40px;'>"
								+"<th>급여계좌</th>"				
								+"<th>우리은행 1234512345123</th>"			
							+"</tr>"			
						+"</thead>"
					+"</table>";
	  		
	  		$("div#div_info").html(html);
	  		
	  	});
	  	<%-- =========== 개인정보 클릭 끝  =========== --%>
	  	
		// 문서 로딩시 인사정보 클릭  	
  		$("div#div_hr").trigger("click");
		
		// 현재 월 구해서 사이드 급여명세서 div에 입력
		let now = new Date(); // 현재 날짜 및 시간
		let month = now.getMonth(); // 월
		$("div#month").text(month+1+"월 급여명세서");
		
		$("div#div_annual").text("DB에서 조회한 값");
		
		$("div#div_workTime").text("DB에서 조회한 값");
		
		
		$('#record_outside').on('click', function () {
			record_close();
		});
		
		$("button#record_close").on("click",function(){
			record_close();
		});
		
		
		
		
		
		$("button.btn_leave").on("click",function(e){
			let leave_type = $(e.target).text();
			$("div#leave_type").text(leave_type);
		});
		
		$("button.btn_retirement").on("click",function(e){
			let retirement_type = $(e.target).text();
			$("div#retirement_type").text(retirement_type);
		});
		
		
		
		<%-- 변경내역 조회 화면에서 인사정보 버튼 클릭시 --%>
		$("button#btn_search_hrInfo").on("click",function(){
			
			$("button.btn_record").removeClass("btn_record_clicked");
			$("button#btn_search_hrInfo").addClass("btn_record_clicked");
			
			$("div#div_result").html(""); 
			let html ="";
			
			html += "<table class='table table-hover'>"
						+"<thead>"
							+"<tr>"
								+"<th>발령일</th>"
								+"<th>발령라벨</th>"
								+"<th>부서</th>"
								+"<th>직무</th>"
								+"<th>직위</th>"
								+"<th>메모</th>"
							+"</tr>"
						+"</thead>"
			
						+"<tbody>"
							+"<tr>"
								+"<td>2022.11.17</td>"
								+"<td>발령라벨</td>"
								+"<td>인사</td>"
								+"<td>직무</td>"
								+"<td>대리</td>"
								+"<td>메모1</td>"
							+"</tr>"
							+"<tr>"
								+"<td>2022.11.17</td>"
								+"<td>발령라벨</td>"
								+"<td>인사</td>"
								+"<td>직무</td>"
								+"<td>대리</td>"
								+"<td>메몽2</td>"
							+"</tr>"
							+"<tr>"
								+"<td>2022.11.17</td>"
								+"<td>발령라벨</td>"
								+"<td>인사</td>"
								+"<td>직무</td>"
								+"<td>대리</td>"
								+"<td>메몽3</td>"
							+"</tr>"
						+"</tbody>"
					+"</table>";

			
			$("div#div_result").html(html);
			
		});
		
		<%-- 변경내역 조회 화면에서 휴직이력 버튼 클릭시 --%>
		$("button#btn_search_leaveInfo").on("click",function(){

			$("button.btn_record").removeClass("btn_record_clicked");
			$("button#btn_search_leaveInfo").addClass("btn_record_clicked");
			
			$("div#div_result").html(""); 
			let html ="";
			
			html += "<table class='table table-hover'>"
						+"<thead>"
							+"<tr>"
								+"<th style='width:150px;'>수정,삭제</th>"
								+"<th>휴직기간</th>"
								+"<th>휴직종류</th>"
								+"<th>메모</th>"
								+"<th>기타</th>"
							+"</tr>"
						+"</thead>"
			
						+"<tbody>"
						
							+"<tr>"
								+"<td>"
									+"<button id='' class='btn_leave_edit_delete btn_leave_delete'><i class='fas fa-trash'></i></button>"
									+"<button id='' class='btn_leave_edit_delete btn_leave_edit'> <i class='fas fa-pen'></i></button>"
								+"</td>"
								+"<td>2022.11.17 ~ 2022.11.18</td>"
								+"<td>일반휴직</td>"
								+"<td>직무</td>"
								+"<td>메모1</td>"
							+"</tr>"
							
							+"<tr>"
								+"<td>"
									+"<button id='' class='btn_leave_edit_delete btn_leave_delete'><i class='fas fa-trash'></i></button>"
									+"<button id='' class='btn_leave_edit_delete btn_leave_edit'> <i class='fas fa-pen'></i></button>"
								+"</td>"
								+"<td>2022.11.17 ~ 2022.11.18</td>"
								+"<td>일반휴직</td>"
								+"<td>직무</td>"
								+"<td>메모1</td>"
							+"</tr>"
						
						+"<tr>"
							+"<td>"
								+"<button id='' class='btn_leave_edit_delete btn_leave_delete'><i class='fas fa-trash'></i></button>"
								+"<button id='' class='btn_leave_edit_delete btn_leave_edit'> <i class='fas fa-pen'></i></button>"
							+"</td>"
							+"<td>2022.11.17 ~ 2022.11.18</td>"
							+"<td>일반휴직</td>"
							+"<td>직무</td>"
							+"<td>메모1</td>"
						+"</tr>"
							
						+"</tbody>"
					+"</table>";

			
			$("div#div_result").html(html);
			
		});
		
		<%-- ===== 정보 변경 내역 클릭시 인사정보 버튼 클릭되도록 tirgger 설정 ===== --%>
		$("button#record_search").on("click",function(){
			$("button#btn_search_hrInfo").trigger("click");
		});
		
		<%-- 기본정보 변경에서 경력 div 클릭시 --%>

		$(document).on("click","button#btn_edit_psInfo",function(){
			 editInfo();
			 
			 
			
		});
		
		
		
		$(document).on("change","textarea",function(){
			
			
		
		});
	
		
		
	});// end of $(document).ready-----------------------------
	
	function resize(obj) {
	    obj.style.height = '1px';
	    obj.style.height = (12 + obj.scrollHeight) + 'px';
	}
	
	
	//인사정보 페이지에서 인사 정보 변경 버튼 클릭시
	function edit_hrInfo(){
		$("div#edit_info").empty();
		$('#edit_info').addClass('active');
	    $('#record_outside').fadeIn();
	    
		let html ='';
		
		html += '<div class="container">'
						+'<div style="display: flex; justify-content: space-between; border-bottom: #ebebeb; margin: 10px 0;">'
								+'<div style="font-size: 20px; font-weight: 600;">인사 정보 변경&nbsp;&nbsp;'
									+'<span class="badge badge-primary">발령</span>'
								+'</div>'
							+'<button id="record_close" onclick="record_close();">'
								+'<i class="fas fa-times"></i>'
							+'</button>'
						+'</div>'
						
					+'<form name="frm_basicInfo">'
						+'<div>'
							+'<div>발령일<span style="color: red;">＊</span></div>'
							+'<input type="text" class="daterange" value="" style="width: 100%; height: 30px; border: solid 1px #d9d9d9; border-radius: 5px;" />'
						+'</div>'
						
						+'<div style="margin:5px 0;">'		
							+'<div>발령 라벨</div>'
							+'<button id="btn" class=" btn communication" type="button" data-toggle="dropdown" style="background-color: white; padding: 3px 0px 3px 5px; border: solid 1px #d9d9d9; border-radious: 10px; width: 100%;">'
								+'<div style="display: flex; justify-content: space-between; width: 100%;">'
									+'<div id="retirement_type">발령 라벨</div>'
									+'<i class="fas fa-bars" style="padding: 5px;"></i>'
								+'</div>'
							+'</button>'
					
							+'<div class="dropdown-menu">'
								+'<button class="btn_retirement dropdown-item" type="button" style="width: 100%;">직무 변경</button>'
								+'<button class="btn_retirement dropdown-item" type="button" style="width: 100%;">부서 변경</button>'
								+'<button class="btn_retirement dropdown-item" type="button" style="width: 100%;">인사 발령</button>'
								+'<input id="changeType" name="changeType" type="hidden" />'
							+'</div>'
						+'</div>'
						
						
						+'<div style="margin:5px 0;">'
							+'<div>부서</div>'
							+'<button id="btn" class=" btn communication" type="button"'
								+'data-toggle="dropdown"'
								+'style="background-color: white; padding: 3px 0px 3px 5px; border: solid 1px #d9d9d9; border-radious: 10px; width: 100%;">'
								+'<div style="display: flex; justify-content: space-between; width: 100%;">'
									+'<div id="retirement_type">부서</div>'
									+'<i class="fas fa-bars" style="padding: 5px;"></i>'
								+'</div>'
							+'</button>'
					
							+'<div class="dropdown-menu">'
								+'<button class="btn_retirement dropdown-item" type="button" style="width: 100%;" value="부서">부서 1</button>'
								+'<button class="btn_retirement dropdown-item" type="button" style="width: 100%;" value="부서">부서 1</button>'
								+'<button class="btn_retirement dropdown-item" type="button" style="width: 100%;" value="부서">부서 1</button>'
								+'<input id="dept" name="dept" type="hidden" />'
							+'</div>'
						+'</div>'
						
						+'<div style="margin:5px 0;">'
							+'<div>세부 부서</div>'
							+'<button id="btn" class=" btn communication" type="button" data-toggle="dropdown" style="background-color: white; padding: 3px 0px 3px 5px; border: solid 1px #d9d9d9; border-radious: 10px; width: 100%;">'
								+'<div style="display: flex; justify-content: space-between; width: 100%;">'
									+'<div id="retirement_type">세부 부서</div>'
										+'<i class="fas fa-bars" style="padding: 5px;"></i>'
								+'</div>'
							+'</button>'
					
							+'<div class="dropdown-menu">'
								+'<button class="btn_retirement dropdown-item" type="button" style="width: 100%;" value="세부부서">세부 부서 1</button>'
								+'<button class="btn_retirement dropdown-item" type="button" style="width: 100%;" value="세부부서">세부 부서 2</button>'
								+'<button class="btn_retirement dropdown-item" type="button" style="width: 100%;" value="세부부서">세부 부서 3</button>'
								+'<input id="detailDept" name="detailDept" type="hidden" />'
							+'</div>'
						+'</div>'
						
						+'<div style="margin:5px 0;">'
							+'<div style="width: 100%;">'
								+'<div>직위</div>'
								+'<button id="btn" class=" btn communication" type="button" data-toggle="dropdown"'
									+'style="background-color: white; padding: 3px 0px 3px 5px; border: solid 1px #d9d9d9; border-radious: 10px; width: 100%;">'
									+'<div style="display: flex; justify-content: space-between; width: 100%;">'
										+'<div id="retirement_type">직위</div>'
										+'<i class="fas fa-bars" style="padding: 5px;"></i>'
									+'</div>'
								+'</button>'
					
								+'<div class="dropdown-menu">'
									+'<button class="btn_retirement dropdown-item" type="button" style="width: 100%;" value="직위">직위1</button>'
									+'<button class="btn_retirement dropdown-item" type="button" style="width: 100%;" value="직위">직위2</button>'
									+'<button class="btn_retirement dropdown-item" type="button" style="width: 100%;" value="직위">직위3</button>'
									+'<input id="position" name="position" type="hidden" />'
								+'</div>'
							+'</div>'
						+'</div>'
				
						+'<div style="margin-bottom:290px;">'
							+'<div class="modal_title" style="width:100%;">메모</div>'
							+'<textarea class="memo" rows="5" cols="30" style="width:100%;"></textarea>'
						+'</div>'
				
				
						+'<div style="display: flex; justify-content: flex-end;">'
							+'<button type="button" class="btn btn_save_cancel" style="background-color: #F6F6F6; border: solid 1px #d9d9d9;" onclick="record_close();">취소</button>'
							+'<button type="button" class="btn btn_save_cancel" style="background-color: #06A016; color: white; margin-left: 10px;">'
								+'<i style="color: white;" class="fas fa-check"></i>&nbsp;&nbsp;저장하기'
						+'</button>'
						+'</div>'
					+'</form>'
				+'</div>'
			
			$("div#edit_info").html(html);
			daterange();
	} //인사정보 페이지에서 인사 정보 변경 버튼 클릭 끝 ------------------------------------------------------------------------------------------------------------------------
	
	//인사정보 페이지에서 기본 정보 변경 버튼 클릭시
	function edit_basicInfo(){
		$("div#edit_info").empty();
		$('#edit_info').addClass('active');
	    $('#record_outside').fadeIn();
		
		let html ='';
		
		html += '<div class="container">'
					+'<div style="display: flex; justify-content: space-between; border-bottom: #ebebeb; margin:10px 0;">'
						+'<div style="font-size:20px; font-weight:600;">기본 정보 변경</div>'
						+'<button id="record_close" onclick="record_close();">'
							+'<i class="fas fa-times"></i>'
						+'</button>'
					+'</div>'
					+'<form name="frm_basicInfo">'
						+'<div>'
							+'<div>사번</div>'
							+'<input type="text" value="" style="width:100%; height:30px; border: solid 1px #d9d9d9; border-radius: 5px;"/>'
						+'</div>'
					
					+'<div style="margin: 20px 0;">'
						+'<div>입사일</div>'
						+'<input type="text" value="" class="daterange" style="width:100%; height:30px;" />'
					+'</div>'
					
					+'<div style="width:100%; margin-bottom: 580px;">'
						+'<div>입사 유형</div>'
						+'<button id="btn" class=" btn communication" type="button"'
							+'data-toggle="dropdown"'
								+'style="background-color: white; padding: 3px 0px 3px 5px; border: solid 1px #d9d9d9; border-radious: 10px; width:100%;">'
							+'<div style="display: flex; justify-content: space-between; width: 100%;">'
								+'<div id="retirement_type">입사 유형</div>'
								+'<i class="fas fa-bars" style="padding: 5px;"></i>'
							+'</div>'
					+'</button>'
					
					+'<div class="dropdown-menu">'
						+'<button class="btn_retirement dropdown-item" type="button" style="width: 100%;">신입</button>'
						+'<button class="btn_retirement dropdown-item" type="button" style="width: 100%;">경력</button>'
					+'</div>'
					
					+'<input id="career" name="career" type="hidden"/>'
					+'</div>'
							
					+'<div style="display:flex; justify-content: flex-end;">'
						+'<button type="button" class="btn btn_save_cancel" style="background-color: #F6F6F6;border:solid 1px #d9d9d9;"onclick="record_close();">취소</button>'
						+'<button type="button" class="btn btn_save_cancel" style="background-color: #06A016; color: white; margin-left:10px;"><i style="color:white;" class="fas fa-check"></i>&nbsp;&nbsp;저장하기</button>'
					+'</div>'
				+'</form>'
			+'</div>';
			
			$("div#edit_info").html(html);
			daterange();
		
	}//인사정보 페이지에서 기본 정보 변경 버튼 클릭 끝--------------------------------------------------------------------------------------
	
	
	
	// 정보 변경 닫기 처리 메소드
	function record_close(){
		$('#record').removeClass('active');
	    $('#edit_info').removeClass('active');
	    $('#record_outside').fadeOut();
	}
	
	
	// 정보 변경 내역 버튼 클릭시 
	function searchRecord(){
		// toastr.info("정보 변경내역 조회 메소드 호출됨");
		
		$('#record').addClass('active');
	    $('#record_outside').fadeIn();
		
	}
	
	
	// 인사정보 변경 메소드 
	function editInfo(){
		// toastr.info("정보 변경내역 조회 메소드 호출됨");
		
		$('#edit_info').addClass('active');
	    $('#record_outside').fadeIn();
		
	}
	
	// 버튼 클릭시 클립보드에 복사하는 함수 (a태그에서 호출)
	function copy_to_clipboard(str) {
		  let tempElement = document.createElement("textarea");
		  document.body.appendChild(tempElement);
		  tempElement.value = str;
		  tempElement.select();
		  document.execCommand('copy');
		  document.body.removeChild(tempElement);
		  toastr.info("<div style='text-align:center;'>"+str+"<br>복사되었습니다</div>");
	} // end of function copy_to_clipboard(str) {}------------------------------------------
	
	
	function daterange(){
		
		<%-- ===== 달력 하나만 출력 시작 =====  --%>
		$("input.daterange").daterangepicker({
            "singleDatePicker": true,
            "locale": {
                "format": "YYYY-MM-DD", // 날짜표현 형식
                "separator": " - ",
                "applyLabel": "선택",
                "cancelLabel": "취소",
                "fromLabel": "From",
                "toLabel": "To",
                "customRangeLabel": "Custom",
                "weekLabel": "W",
                "daysOfWeek": [
                    "일",
                    "월",
                    "화",
                    "수",
                    "목",
                    "금",
                    "토"
                ],
                "monthNames": [
                    "1월",
                    "2월",
                    "3월",
                    "4월",
                    "5월",
                    "6월",
                    "7월",
                    "8월",
                    "9월",
                    "10월",
                    "11월",
                    "12월"
                ],
                "firstDay": 1
            }
        });
		<%-- ===== 달력 하나만 출력 끝 =====  --%>
		
	}
	
	
</script>

<div id="user_detail_content">
	
	<span><a href="<%= ctxPath%>/people.yolo">구성원</a> / 홍길동</span>
	
	<div id="user_profile">
		<div id="profile_img">
			<div id="user_name">길동</div>
			
			<button id="btn_profileImg" type="button" data-toggle="dropdown" style="background-color: white; border: solid 1px gray; border-radius: 50%; position:relative; top:40px; left:20px;">
				<i class="fas fa-camera"></i>
			</button>
			
			<div class="dropdown-menu">
				<a class="dropdown-item" href="#"><i class="fas fa-upload"></i>&nbsp;&nbsp;사진 업로드하기</a> 
				<a id = "delete_profileImg" class="dropdown-item" href="#"><span style="color:#e62e00"><i class="fas fa-trash"></i>&nbsp;&nbsp;삭제하기</span></a> 
			</div>
		</div>
		
		<%-- ======================== 프로필 시작 ========================= --%>
		<table>
			<thead>
				<tr>
					<th colspan="2">홍길동</th>
				</tr>
				<tr>
					<th class="dept_position">부서</th>				
					<th class="dept_position">&nbsp;&nbsp;&nbsp;인사</th>				
				</tr>
				<tr>
					<th class="dept_position">직책</th>				
					<th class="dept_position">&nbsp;&nbsp;&nbsp;대리</th>				
				</tr>
				<tr>
					<th>
						<a onclick="copy_to_clipboard('01012345678')" class="btn communication" href="#" data-toggle="tooltip" data-placement="top" title="010-1234-5678"><i class="fas fa-phone-alt"></i></a>
					</th>
					<th>
						<a onclick="copy_to_clipboard('honggildong@gmail.com')" class="btn communication" href="#" data-toggle="tooltip" data-placement="top" title="honggildong@gmail.com"><i class="far fa-envelope"></i></a>
					</th>
					<th>
						<a class="btn communication" href="#" data-toggle="tooltip" data-placement="top" title="채팅하기"><i class="fas fa-comment"></i></a>
					</th>
					<th> 
						<button id="btn" class=" btn communication" type="button" data-toggle="dropdown" style="background-color: white; padding:3px 0px 3px 5px; border: solid 1px #d9d9d9; border-radious:10px;">
							<span style="color:green;">●</span>&nbsp;&nbsp;재직중&nbsp;&nbsp;
						</button>
						
						<div class="dropdown-menu">
							<button class="dropdown-item" type="button" data-toggle="modal" data-target="#modal_leave"><i class="fas fa-user-slash" ></i>&nbsp;&nbsp;휴직 처리하기</button>
							<button class="dropdown-item" type="button" data-toggle="modal" data-target="#modal_retirement"><i class="fas fa-leaf"></i>&nbsp;&nbsp;퇴직 처리하기</button>
						</div>
					</th>
				</tr>
			</thead>
		</table>
		
		<%-- ======================== 프로필 끝 ========================= --%>
	</div>
	
		<!-- ============================= 휴직처리하기 모달 시작 ============================= -->
	<div class="modal fade" id="modal_leave">
		
			<div class="modal-dialog modal-dialog-centered">
				<!-- .modal-dialog-centered 클래스를 사용하여 페이지 내에서 모달을 세로 및 가로 중앙에 배치합니다. -->
				<div class="modal-content">
	
					<!-- Modal header -->
					<div class="modal-header">
						<h5 class="modal-title">휴직</h5>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
	
					<!-- Modal body -->
					<form name="frm_leave">
					<div class="modal-body" style="height: 350px;">
						<div class="modal_title">휴직종류 <span style="color: red;">＊</span></div>
						<button id="btn" class=" btn communication" type="button"
							data-toggle="dropdown"
							style="background-color: white; padding: 3px 0px 3px 5px; border: solid 1px #d9d9d9; border-radious: 10px;">
							<div style="display:flex; justify-content: space-between; width:460px;">
								<div id="leave_type">일반 휴직</div> <i class="fas fa-bars" style="padding:5px;"></i>
							</div>
						</button>
	
						<div class="dropdown-menu">
							<button class="btn_leave dropdown-item" type="button" style ="width:460px;">일반휴직</button>
							<button class="btn_leave dropdown-item" type="button" style ="width:460px;">육아휴직</button>
							<button class="btn_leave dropdown-item" type="button" style ="width:460px;">산재휴직</button>
							<button class="btn_leave dropdown-item" type="button" style ="width:460px;">부상.질병휴직</button>
							<button class="btn_leave dropdown-item" type="button" style ="width:460px;">가족 돌봄휴직</button>
						</div>
						
						<div>
							<div style="margin-top:20px;" class="modal_title">휴직기간 <span style="color: red;">＊</span></div>
							<input id="between_date" class="form-control" style="margin-bottom:20px;" />
							<input type="hidden" name="start_date" />
							<input type="hidden" name="end_date" />
						</div>
	
						<div>
							<div class="modal_title">메모</div>
							<textarea class="memo" rows="5" cols="30"></textarea>
						</div>
					</div>
					</form>
	
					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="button" class="btn " data-dismiss="modal">취소</button>
						<button type="button" class="btn btn-success">적용하기</button>
					</div>
				</div>
			</div>
		
	</div>
	<!-- ============================= 휴직처리하기 모달 끝 ============================= -->
	
	<!-- ========================== 퇴직 처리하기 모달 시작 ========================== -->
	<div class="modal fade" id="modal_retirement">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<!-- Modal header -->
					<div class="modal-header">
						<h5 class="modal-title">퇴직</h5>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
						<div style="width:100%; height:45px; background-color: #FFFBF2; padding: 0 10px; display:flex; justify-content: space-evenly;">
							<i class="fas fa-exclamation-triangle" style="color:#ffe680; margin:auto;"></i>
							<span style="margin:auto;">먼저 퇴직일과 휴가 사용에 대해 합의한 뒤에 퇴직처리를 해주세요.</span>
						</div>
	
					<!-- Modal body -->
					<div class="modal-body">
						<form name="frm_retirement">
					
						<div style="display:flex; justify-content: space-between; ">
							<div>
								<div>
									<label class="modal_title">퇴직일</label>
									<i class="far fa-question-circle" style="color:gray;" data-toggle="tooltip" data-placement="top" title="마지막 근무일을 입력해주세요.(휴가포함)"></i>
									<span style="color: red;">＊</span>
									<input class="daterange" type="text" style="width:225px;"/>
								</div>
							</div>
							
							<div>
								<div>
									<label class="modal_title">yolo 사용 종료일</label>
									<i class="far fa-question-circle" style="color:gray;" data-toggle="tooltip" data-placement="top" title="사용 종료일 다음날로부터  로그인이 제한됩니다."></i>
									<span style="color: red;">＊</span>
								</div>
								<input class="daterange" type="text" style="width:225px;"/>
							</div>
						</div>
						
						<div style="margin: 20px 0px;">
							<div class="modal_title">고용보험 퇴직사유</div>
							
							<button id="btn" class=" btn communication" type="button"
								data-toggle="dropdown"
								style="background-color: white; padding: 3px 0px 3px 5px; border: solid 1px #d9d9d9; border-radious: 10px;">
								<div style="display:flex; justify-content: space-between; width:460px;">
									<div id="retirement_type">고용보험 퇴직사유 선택</div> <i class="fas fa-bars" style="padding:5px;"></i>
								</div>
							</button>
							
							<div class="dropdown-menu">
								<button class="btn_retirement dropdown-item" type="button" style ="width:460px;">개인사정 자진퇴사</button>
								<button class="btn_retirement dropdown-item" type="button" style ="width:460px;">고용주 사유로 자진퇴사</button>
								<button class="btn_retirement dropdown-item" type="button" style ="width:460px;">폐업/도산</button>
								<button class="btn_retirement dropdown-item" type="button" style ="width:460px;">경영상의 인원감축</button>
								<button class="btn_retirement dropdown-item" type="button" style ="width:460px;">근로자 귀책사유에 의한 퇴사</button>
								<button class="btn_retirement dropdown-item" type="button" style ="width:460px;">정년퇴직</button>
								<button class="btn_retirement dropdown-item" type="button" style ="width:460px;">계약기간만료</button>
								<button class="btn_retirement dropdown-item" type="button" style ="width:460px;">고용보험 비적용</button>
								<button class="btn_retirement dropdown-item" type="button" style ="width:460px;">이중고용</button>
							</div>
						</div>
						
						<div>
							<div class="modal_title">메모</div>
							<textarea class="memo"rows="5" cols="30" placeholder="퇴직사유 입력"></textarea>
						</div>
						</form>
					</div>
	
					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="button" class="btn " data-dismiss="modal">취소</button>
						<button type="button" class="btn btn-danger">퇴직 처리하기</button>
					</div>
				</div>
			</div>
	</div>
	<!-- ========================== 퇴직 처리하기 모달 끝 ========================== -->


	<%-- ============== 인사정보, 개인정보, 정보 변경 내역 버튼 시작  ============== --%>
	<nav id="hr_info">
		<div id="hr_info_title">
			<div id="div_hr" class="info_title">인사 정보</div>
			<div id="div_ps" class="info_title">개인 정보</div>
		</div>
		<div>
			<button id="record_search" type="button" class="btn" onclick="searchRecord()"><i class="fas fa-history" style="margin:0px; width:16px;"></i>&nbsp;&nbsp;정보 변경 내역</button>
		</div>
	</nav>
	<%-- ============== 인사정보, 개인정보, 정보 변경 내역 버튼 끝  ============== --%>
	
	<div style="display:flex; justify-content: space-between;">
		<%-- ===================== 인사정보 내용 출력 시작 ===================== --%>
		<div id="div_info"></div>
		<%-- ===================== 인사정보 내용 출력 끝 ===================== --%>
		
		<div id="right_sidebar">
			
			<a class="a_side" href="#">
				<div class="div_rightside" id="work_time">
					<i class="far fa-clock fa-lg sideIcon"></i>
					<div style="display: flex; justify-content: space-between; margin-top: 5px;">
						<div style="margin:15px 0 0 20px;">
							<div style="font-size: 12px; font-weight:600; color:#556372;">근무시간</div>
							<div id="div_workTime" style="font-size: 20px; color: gray; font-weight:700;"></div>
						</div>
						<div id="progressBar"></div>
					</div>
				</div>
			</a>
			
			<a class="a_side" href="#">
				<div class="div_rightside" id="annual">
					<i class="fas fa-leaf fa-lg sideIcon"></i>
					<div style="display: flex; justify-content: space-between; margin-top: 5px;">
						<div style="margin:15px 0 0 20px;">
							<div style="font-size: 12px; font-weight:600; color:#556372;">남은연차</div>
							<div id="div_annual" style="font-size: 20px; color: gray; font-weight:700;"></div>
						</div>
					</div>
				</div>
			</a>
			
			<a class="a_side" href="#">
				<div class="div_rightside" id="pay_stub">
					<i class="fas fa-won-sign fa-lg sideIcon"></i>
					<div style="display: flex; justify-content: space-between; margin-top: 5px;">
						<div style="margin:15px 0 0 20px;">
							<div style="font-size: 12px; font-weight:600; color:#556372;">급여</div>
							<div id="month" style="font-size: 20px; color: gray; font-weight:700;"></div>
						</div>
					</div>
				</div>
			</a>
			
		</div>
	</div>

</div>
<div id="record_outside"></div>

<%-- 정보변경내역 div --%>
<div id="record">
	<div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
		<div>
			<div class="profile" style="display: flex;">
				<div class="profile_icon">
					<div>길동</div>
				</div>
				<div style="padding-top: 3px;">홍길동</div>
				<button class="btn_record" id="btn_search_hrInfo">인사정보</button>
				<button class="btn_record" id="btn_search_leaveInfo">휴직이력</button>
			</div>

		</div>
		<button id="record_close">
			<i class="fas fa-times"></i>
		</button>
	</div>
	<%-- =========== 조회 결과 출력되는 div =========== --%>
	<div id="div_result"></div>
	<%-- =========== 조회 결과 출력되는 div =========== --%>
</div>

<%-- 인사정보 변경, 기본 정보 변경 div --%>
<div id ="edit_info">
		<div class="container">
		
			<div style="display: flex; justify-content: space-between; border-bottom: #ebebeb; margin:10px 0;">
				<div style="font-size:20px; font-weight:600;">개인 정보 수정</div>
				<button id="record_close" onclick="record_close();">
					<i class="fas fa-times"></i>
				</button>
			</div>
			
			<form name="frm_basicInfo">
				<div>
					<div>이름</div>
					<input type="text" value="" style="width:100%; height:30px; border: solid 1px #d9d9d9; border-radius: 5px;"/>
				</div>

				<div>영문 이름</div>
				<div style="display: flex;">
					<input type="text" value="" style="width: 100%; height: 30px; border: solid 1px #d9d9d9; border-radius: 5px;" placeholder="이름(First Name)" />
					<input type="text" value="" style="width: 100%; height: 30px; border: solid 1px #d9d9d9; border-radius: 5px;" placeholder="성(Last Name)"/>
				</div>
				
				<div>
					<textarea id="introduce" rows="1" cols="" style="height: 58px; min-height: 58px; resize: none; overflow-y: hidden;" onkeydown="resize(this)" onkeyup="resize(this)"></textarea>
				</div>
			
				<div style="margin: 20px 0;">
					<div>입사일</div>
					<input type="text" value="" class="daterange" style="width:100%; height:30px;" />
				</div>
			
				<div style="width:100%;">
					<div>입사 유형</div>
					<button id="btn" class=" btn communication" type="button" data-toggle="dropdown"
							style="background-color: white; padding: 3px 0px 3px 5px; border: solid 1px #d9d9d9; border-radious: 10px; width:100%;">
						<div style="display: flex; justify-content: space-between; width: 100%;">
							<div id="retirement_type">입사 유형</div>
							<i class="fas fa-bars" style="padding: 5px;"></i>
						</div>
					</button>
				
					<div class="dropdown-menu">
						<button class="btn_retirement dropdown-item" type="button" style="width: 100%;">신입</button>
						<button class="btn_retirement dropdown-item" type="button" style="width: 100%;">경력</button>
					</div>
					
					<input id="career" name="career" type="hidden"/>
				</div>
					
				<div style="display:flex; justify-content: flex-end;">
					<button type="button" class="btn btn_save_cancel" style="background-color: #F6F6F6;border:solid 1px #d9d9d9;"onclick="record_close();">취소</button>
					<button type="button" class="btn btn_save_cancel" style="background-color: #06A016; color: white; margin-left:10px;"><i style="color:white;" class="fas fa-check"></i>&nbsp;&nbsp;저장하기</button>
				</div>
			</form>
		</div>

</div>
