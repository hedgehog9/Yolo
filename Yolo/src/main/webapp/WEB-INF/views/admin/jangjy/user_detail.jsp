<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>

<style>
	
	div#user_detail_content {
		padding: 40px 32px;
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
		width: 150px;
		height: 150px;
		border-radius: 2rem;
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
	
	<%-- 프로필 부분 --%>
	div#user_name {
		font-size: 20pt;
		font-weight: bold;
		color: white;
		position: relative;
		/* left: 15px; */
	}
	div#profile_img > img{
		position: relative;
	    border-radius: 2rem;
	    width: 100%;
	    height: 100%;
	    left: 15px;
	    z-index: 4;
	}
	
	button#btn_profileImg{
		position: relative;
	    background-color: white;
	    border: solid 1px gray;
	    border-radius: 50%;
	    top: 60px;
	    
	    z-index: 5;
	}
	<%--
	span#profile_user_name{
	    position: absolute;
	    left: -110px;
	    color: white;
	    left: -90px;
	    top: -15px;
	    width: 100px;
	}
	--%>
	span#profile_user_name{
	    position: absolute;
	    color: white;
	    left: -85px;
	    top: -15px;
	    width: 100px;
	}
	
	th.dept_position {
		font-size: 13px;
		font-weight: normal;
		color:#556372;
	}
	
	th.user_dept_position {
		font-size: 13px;
		font-weight:500;
		color:#242A30;
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
	
	i.i_sideIcon {
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
	{
	text-decoration: none;
	color: #9e9e9e;
	}
	a.a_people:link, a.a_people:visited, a.a_people:active ,a.a_people:hover {
		text-decoration: none;
		color: #556372;
	}
	
	
	
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
		overflow: auto;
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
		overflow: auto;
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
	input.input_edit_info{
		width:100%;
		height:30px;
		border: solid 1px #d9d9d9;
		margin-bottom: 5px;
		border-radius: 5px;
	}	
	
	div#div_edit{
		overflow: auto;
	}
	textarea#introduce{
		width:100%;
		height: 58px; 
		min-height: 58px; 
		resize: none; 
		overflow-y: hidden;
		border: solid 1px #d9d9d9;
	}
	
	input:focus,
	textarea:focus{
		outline-color: #07B419;
	}
	
	div.imgtest{
		width: 200px;
		height:200px;
		border: solid 1px red;
		color: #ebebeb;
	}
	
	
	th.th_title{
		color: #556372;
		font-size: 14px;
		font-weight: 500;
		line-height: 21px;
		text-align: left;
		word-spacing: 0px;
	}
	
	th.th_content{
		color:#242A30;
		font-size: 14px;
		line-height: 21px;
		text-align: left;
		word-spacing: 0px;
		font-weight: normal;
		<%-- 정보 미입력시 색상  #8D96A1 --%>
	}
	
	div#div_warnning{
		display : none;
		color: #C32700;
		font-size: 12px;
		line-height: 16.2px;
		word-spacing: 0px;
		padding: 10px 0 0 10px;
	}
	
	
	
</style>
<%-- 말풍선 --%>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<%-- 지도 --%>
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 

<script>
	let leaveFlag = false; // 휴직 신청 가능 여부 저장
	let html = "";
	
	
	
	$(document).ready(function(){
		
		let today = new Date();
		
		// 모달에서 x 버튼 클릭스 안의 form 초기화
	    $('.modal').on('hidden.bs.modal', function (e) {
	       $(this).find('form')[0].reset();
	       $("div#retirement_type").text("고용보험 퇴직사유 선택");
	    });
		
	 // 휴직처리에서 날짜 선택 클릭시 이미 신청되어있는 휴직이 있는지 조회, 경고창 출력
	 
		$(document).on("change","input#between_date",function(){
		  
	      let empno = $("input#empno").val();
		  let startdate = $("input#start_date").val();
	  	  let enddate = $("input#end_date").val();
			
			$.ajax({
				
				  url : "<%= request.getContextPath()%>/checkLeave.yolo",
				  data : {"empno":empno
					  	 ,"startdate":startdate
					  	 ,"enddate":enddate},
				  type : "POST",
				  dataType : "JSON",
				  success : function(json){
					  if(json.result > 0){
						 $("div#div_warnning").css("display","block");
						 leaveFlag = false;
					  }
					  else{
						  $("div#div_warnning").css("display","");
						  leaveFlag = true;
					  }
				  },
				  error: function(request, status, error){
					  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				  }
			  });
			
		})// end of$(document).on("input","change",function(){}--------------
		
		
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
                "daysOfWeek": ["일","월","화","수","목","금","토"],
                "monthNames": ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
                "firstDay": 1
            },
            
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
            },"minDate": today // 휴직 처리시 과거날짜 선택 못하도록 지정 
           
          },function(start, end, label) {
              $("input[name='start_date']").val(start.format('YYYY-MM-DD'))
              $("input[name='end_date']").val(end.format('YYYY-MM-DD'))
          });
		
		<%-- ===== 달력 두개짜리 출력 끝 =====  --%>
		
		<%-- 말풍선 --%>
	  	$('[data-toggle="tooltip"]').tooltip();   
		
	  	<%-- =========== 인사정보 클릭 시작  =========== --%>
		$(document).on("click","div#div_hr", function(e){
	  		$("div.info_title").css("border-bottom","");
	  		$(e.target).css("border-bottom","solid 3px green");
	  		$("div#div_info").empty();
	  		
	  		html ="";
	  		html += "<div style='display:flex; justify-content: space-between; margin-top: 30px;'>"
						+"<div id='div_hr_title' style=' margin-bottom:20px;'>인사 정보</div>"
						
						+"<button id='btn_edit_hrInfo' type='button' data-toggle='dropdown' class='btn_edit'>"
							+"<i class='fas fa-pen' style='margin:0px; width:16px;'></i>"
						+"</button>"
						
						+"<div class='dropdown-menu'>"
							+"<a id ='a_edit_hrInfo'class='dropdown-item' href='javascript:void(0);' onclick='edit_hrInfo("+`${requestScope.employeeMap.empno}`+");'><i class='fas fa-user-alt'></i>&nbsp;&nbsp;인사 정보 변경&nbsp;&nbsp;"
								+"<span class='badge' style='background-color:#3B86C8; color:white;'>발령</span>"
							+"</a>"
							+"<a id='a_edit_basicInfo' class='dropdown-item' href='javascript:void(0);'onclick='edit_basicInfo()'><i class='fas fa-pen'></i>&nbsp;&nbsp;기본 정보 변경</a>" 
						+"</div>"
					+"</div>"
					
					+"<table>"
						+"<thead>"
							+"<tr style='height:40px;'>"
								+"<th class='th_title' style='width:200px'>사번</th>"				
								+"<th id='th_empno' class='th_content'>"+`${requestScope.employeeMap.empno}`+"</th>"				
							+"</tr>"			
							+"<tr style='height:40px;'>"
								+"<th class='th_title'>입사일</th>"				
								+"<th class='th_content'><span>"+`${requestScope.employeeMap.hiredate}`+"</span>&nbsp;&nbsp;<span class='span_badge'>"+`${requestScope.employeeMap.continuousServiceMonth}`+"</span></th>"				
							+"</tr>"			
							<%--
							+"<tr style='height:40px;'>"
								+"<th class='th_title'>입사 유형</th>"				
								+"<th class='th_content'>3</th>"				
							+"</tr>"			
							--%>
							+"<tr style='height:40px;'>"
								+"<th class='th_title'>부서</th>"				
								+"<th class='th_content'><span>"+`${requestScope.employeeMap.teamname}`+"</span>&nbsp;&nbsp;<span class='span_badge'>"+`${requestScope.employeeMap.deptname}`+"</span></th>"				
							+"</tr>"			
							+"<tr style='height:40px;'>"
								+"<th class='th_title'>직책</th>"				
								+"<th class='th_content'>"+`${requestScope.employeeMap.position}`+"</th>"				
							+"</tr>"	
							<%-- 
							+"<tr style='height:40px;'>"
								+"<th class='th_title'>직위</th>"				
								+"<th class='th_content'>6</th>"			
							+"</tr>"	
							--%>		
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
						+"<div id='div_hr_title' style='margin-bottom:20px;'>개인 정보</div>"
						
						+"<button id='btn_edit_psInfo' type='button' class='btn_edit' onclick='editInfo();'>"
							+"<i class='fas fa-pen' style='margin:0px; width:16px;'></i>"
						+"</button>"
						
					+"</div>"
					+"<table>"
						+"<thead>"
							+"<tr style='height:40px;'>"
								+"<th class='th_title' style='width:200px'>이메일</th>"				
								+"<th class='th_content'>"+`${requestScope.employeeMap.email}`+"</th>"				
							+"</tr>"			
							+"<tr style='height:40px;'>"
								+"<th class='th_title'>이름</th>"				
								+"<th class='th_content'>"+`${requestScope.employeeMap.name}`+"</th>"				
							+"</tr>"			
							<%--
							+"<tr style='height:40px;'>"
								+"<th class='th_title'>회사 내 이름</th>"				
								+"<th class='th_content'>홍길동</th>"				
							+"</tr>"	
							--%>		
							+"<tr style='height:40px;'>"
								+"<th class='th_title'>영문 이름</th>"				
								+"<th class='th_content'>"+`${requestScope.employeeMap.englishName}`+"</th>"				
							+"</tr>"		
							<%--
							+"<tr style='height:40px;'>"
								+"<th class='th_title'>국적, 거주국가, 체류자격 </th>"				
								+"<th class='th_content'>Republic of Korea</th>"				
							+"</tr>"
							--%>			
							+"<tr style='height:40px;'>"
								+"<th class='th_title'>생년월일</th>";
						<%-- DB 에서 조회해온 성별이 남자인경우 뱃지 하늘색, 여자인 경우 분홍색 --%>	
						if("${requestScope.employeeMap.gender}"=="남"){		
							html+="<th class='th_content'>"+`${requestScope.employeeMap.birthday}`+"&nbsp;&nbsp;<span id='gender' class='span_badge' style='background-color:#b3d9ff; color:#00264d;'>남</span></th>";
						}
						else if("${requestScope.employeeMap.gender}"=="여"){
							html+="<th class='th_content'>"+`${requestScope.employeeMap.birthday}`+"&nbsp;&nbsp;<span id='gender' class='span_badge' style='background-color:#ffccd5; color:#4d000d;'>여</span></th>";
						}
						else{
							html+="<th class='th_content'>"+`${requestScope.employeeMap.birthday}`+"&nbsp;&nbsp;</th>";
						}
						
								
						html+="</tr>"			
							+"<tr style='height:40px;'>"
								+"<th class='th_title'>주민등록번호</th>"				
								+"<th class='th_content'>"+`${requestScope.employeeMap.rrn}`+"</th>"			
							+"</tr>"			
							+"<tr style='height:40px;'>"
								+"<th class='th_title'>휴대전화번호</th>"				
								+"<th class='th_content'>"+`${requestScope.employeeMap.mobile}`+"</th>"			
							+"</tr>"			
							+"<tr style='height:40px;'>"
								+"<th class='th_title'>집주소</th>"				
								+"<th class='th_content'>"+`${requestScope.employeeMap.address}`+"</th>"			
							+"</tr>"			
							+"<tr style='height:40px;'>"
								+"<th class='th_title'>급여계좌</th>"				
								+"<th class='th_content'>"+`${requestScope.employeeMap.account}`+"</th>"			
							+"</tr>"			
						+"</thead>"
					+"</table>";
	  		
	  		$("div#div_info").html(html);
	  		
	  	});
	  	<%-- =========== 개인정보 클릭 끝  =========== --%>
	  	
	  	<%-- 휴직처리 모달에서 적용하기 버튼 클릭 시 --%>
	  	$(document).on("click","button#btn_leave",function(){
	  		
	  		let leavetype = $("input#input_leave_type").val();
	  		let startdate = $("input#start_date").val();
	  		let enddate = $("input#end_date").val();
	  		let memo = $("textarea#memo_leave").val();
	  		let empno = $("input#empno").val();
	  		
	  		if(leaveFlag){ // 날짜를 올바르게 입력한 경우에만 휴직 신청가능
	  		
	  		$.ajax({
				  url : "<%= request.getContextPath()%>/leaveAbsence.yolo",
				  data : {"leavetype":leavetype 
					     ,"startdate":startdate
					     ,"enddate":enddate
					     ,"memo":memo
					     ,"empno":empno},
				  type : "POST",
				  dataType : "JSON",
				  success : function(json){
					  
					  if(json.result == 1){
						  toastr.success('휴직 처리가 완료되었습니다.');
						  $("textarea#memo_leave").val("");
					  }
					  else{
						  toastr.warning('휴직 처리가 취소되었습니다.');
					  }
				  },
				  error: function(request, status, error){
					  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				  }
			  });
	  		
	  		}
	  		else{
	  			toastr.error('이미 휴직 신청한 날짜입니다.');
	  			return;
	  		}
	  		
	  		
	  	});// end of $(document).on("click","button#btn_leave",function(){}-------------------------------
	  	
	  	
		// 문서 로딩시 인사정보 클릭  	
  		$("div#div_hr").trigger("click");
		
		// 현재 월 구해 사이드 급여명세서 div에 입력
		let now = new Date(); // 현재 날짜 및 시간
		let month = now.getMonth(); // 월
		$("div#month").text(month+1+"월 급여명세서");
		
		$("div#div_annual").text("DB에서 조회한 값");
		
		
		$('#record_outside').on('click', function () {
			record_close();
		});
		
		$("button#record_close").on("click",function(){
			record_close();
		});
		
		
		
		
		
		$("button.btn_leave").on("click",function(e){
			let leave_type = $(e.target).text();
			$("div#leave_type").text(leave_type);
			$("input#input_leave_type").val(leave_type);
		});
		
		$("button.btn_retirement").on("click",function(e){
			let retirement_type = $(e.target).text();
			$("div#retirement_type").text(retirement_type);
		});
		
		
		
		<%-- 변경내역 조회 화면에서 인사정보 버튼 클릭시 --%>
		$("button#btn_search_hrInfo").on("click",function(){
			
			$("button.btn_record").removeClass("btn_record_clicked");
			$("button#btn_search_hrInfo").addClass("btn_record_clicked");
			
			let empno = $("input#empno").val();
			
			$.ajax({
				 // 부서 이름 구해오기 
				  url : "<%= ctxPath%>/getPsaHistory.yolo",
				  data: {"empno":empno},
				  dataType : "JSON",
				  success : function(json){
					  
				  		$("div#div_result").html(""); 
						let html ="";
						
						html += "<table class='table table-hover'>"
									+"<thead>"
										+"<tr>"
											+"<th>발령일</th>"
											+"<th>발령라벨</th>"
											+"<th>부서</th>"
											+"<th>직위</th>"
											+"<th>메모</th>"
										+"</tr>"
									+"</thead>"
									+"<tbody>";
							  $.each(json,function(index,history){
								  html += "<tr>"
											+"<td>"+history.psa_date+"</td>"
											+"<td>"+history.psa_label+"</td>"
											+"<td>"+isEmptyPsa(history.after_deptname)+"</td>"
											+"<td>"+isEmptyPsa(history.after_position)+"</td>"
											+"<td>"+isEmptyPsa(history.memo)+"</td>"
										 +"</tr>";
									  
						      });// end of $.each(json,function(index,emp){}----------------------------
									
							html += "</tbody></table>";
								
								
						$("div#div_result").html(html);
					
				  },// end of success
				  error: function(request, status, error){
					  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				  }
			
			}); // end of ajax()----------------------------------------------------------------------
			
			
			
			
			

			
		});
		
		<%-- 변경내역 조회 화면에서 휴직이력 버튼 클릭시 --%>
		$("button#btn_search_leaveInfo").on("click",function(){

			$("button.btn_record").removeClass("btn_record_clicked");
			$("button#btn_search_leaveInfo").addClass("btn_record_clicked");
			
			let empno = $("input#empno").val();
			
			
			$.ajax({
				 // 부서 이름 구해오기 
				  url : "<%= ctxPath%>/getLeaveAbsence.yolo",
				  data: {"empno":empno},
				  dataType : "JSON",
				  success : function(json){
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
								+"<tbody>";
							  $.each(json,function(index,leaveMap){
								  html += +"<tr>"
											  +"<td>"
												  +"<button id='' class='btn_leave_edit_delete btn_leave_delete'><i class='fas fa-trash'></i></button>"
												  +"<button id='' class='btn_leave_edit_delete btn_leave_edit'> <i class='fas fa-pen'></i></button>"
											  +"</td>"
											  +"<td>"+leaveMap.startdate+" ~ "+leaveMap.enddate+"</td>"
											  +"<td>"+isEmptyPsa(leaveMap.leavetype)+"</td>"
											  +"<td>"+isEmptyPsa(leaveMap.memo)+"</td>"
											  +"<td></td>"
											+"</tr>";
						      });// end of $.each(json,function(index,emp){}----------------------------			
							
						html +="</tbody></table>";
			
			$("div#div_result").html(html);
				
				}
			});
		});
		
		<%-- ===== 정보 변경 내역 클릭시 인사정보 버튼 클릭되도록 tirgger 설정 ===== --%>
		$("button#record_search").on("click",function(){
			$("button#btn_search_hrInfo").trigger("click");
		});
		
		
		$(document).on("keyup","input#registeration_no",function(){
			
			
		});
		
		// 주민등록번호 입력시 자동 하이픈 입력 
		$("input#registeration_no").bind("keyup", function(e) {
			let no = $(e.target).val();
			
			if(e.keyCode != 8){
				if(no.length == 6){
					$(this).val($(this).val()+"-");
				}
				else if(no.length == 7){
					$(this).val($(this).val().substr(0,6)+"-"+$(this).val().substr(7));
				}
			}
			
		}); // end of $("#registeration_no").bind("keyup", function(e) {}-------------------------
				
		// 핸드폰 번호 입력시 자동 하이픈 입력		
		$("input#mobile").bind("keyup", function(e) {
			let no = $(e.target).val();
			
			if(e.keyCode != 8){
				if(no.length == 3){
					$(this).val($(this).val()+"-");
				}
				else if(no.length == 8){
					$(this).val($(this).val()+"-");
				}
			}
			
		}); // end of $("#registeration_no").bind("keyup", function(e) {}-------------------------		
		
		<%-- =========================== 주소 입력 팝업창 띄우기 시작  ===================== --%>	
		$(document).on("click","input#address",function(){
			new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                let addr = ''; // 주소 변수
	                let extraAddr = ''; // 참고항목 변수

	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }

	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    // document.getElementById("extraAddress").value = extraAddr;
	                    addr += extraAddr;
	                } else {
	                    // document.getElementById("extraAddress").value = '';
	                    extraAddr = '';
	                    addr += extraAddr;
	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                // document.getElementById('postcode').value = data.zonecode;
	                document.getElementById("address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("detailAddress").focus();
	            }
	        }).open(); 	
		});
		<%-- =========================== 주소 입력 팝업창 띄우기 끝  ===================== --%>		
		
		const web_browser_height = $(window).height(); 
		$("div#div_edit").css({"max-height":web_browser_height});
		
		
		// 인사발령 모달에서 항목 선택시 
		$(document).on("click","button.dropdown-item",function(e){
			let parent = $(this).parent();
			let deptno = $(this).val(); // 부서번호
			 // $(this).text() 부서명 
			 
			$(this).parent().parent().find("input").val(deptno);
			parent.parent().find("div.retirement_type").text($(this).text());
			
		})// end of $(document).on("click","button.dropdown-item",function(){}-------------------
		
		// 인사발령 모달에서 저장하기 버튼 클릭시 
		$(document).on("click","#edit_info > div > form > div:nth-child(10) > button:nth-child(2)",function(){
			
			func_psa();
			
		});
		
		// 직위 클릭시 
		
		$(document).on("click","button.manager",function(){
			
			let formValues = $("form[name=frm_ps_appointment]").serialize() ;
			
			$.ajax({
				  url : "<%= ctxPath%>/checkManager.yolo",
				  data : formValues,    
				  type : "POST",
				  dataType : "JSON",
				  success : function(json){
					
					  if(json.manager_yn == 1){
						  Swal.fire({
							   title: '해당 부서에 부서장/팀장이 이미 존재합니다.',
							   text: '변경하시겠습니까?',
							   icon: 'warning',
							   
							   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
							   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
							   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
							   confirmButtonText: '승인', // confirm 버튼 텍스트 지정
							   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
							   
							   reverseButtons: true, // 버튼 순서 거꾸로
							   
							}).then(result => {
							   if (result.isConfirmed) { // 부서장/ 팀장을 바꾸는 경우 
								   
							   }
							   else{ // 부서장/팀장을 안바꾸는 경우 
								   $("input#position").val("");
							   	   $("div#div_retirement_type").text("직위");
							   }
							});
						  
					  }// end of if(josn.manager_yn == 1)
					  
				  }
			});
		}); // end of $(document).on("click","",function(){}-----------------------------
		
		
		// 해당 사원 주 총 근무시간 구하기 
		getWorkTime($("th#th_empno").text());
		

		
		
		
		
	});// end of $(document).ready-----------------------------
	
	function spinner(){
		// 추가 이미지 파일에 스피너 달아주기 // 최소값 최대값
		$("input#spinnerImgQty").spinner({
			spin:function(event,ui){
	            if(ui.value > 10) {
	               $(this).spinner("value", 10);
	               return false;
	            }
	            else if(ui.value < 0) {
	               $(this).spinner("value", 0);
	               return false;
	            }
	         }
		});
		
		
		// ### 스피너의 이벤트는 클릭이 아니고 change도 아니고 "spinstop" 이다 ### //
		// 첨부파일 개수만큼 늘고 줄어들게 만들기
		$("input#spinnerImgQty").bind("spinstop", function(){

			let html = '';
			const cnt = $(this).val();
			
			//console.log(cnt);
			
			for(let i=0; i<Number(cnt); i++){
				html+= '<div class="filebox">'+
						    '<input class="upload-name" name="attachName'+i+'" value="첨부파일" placeholder="첨부파일" readonly="readonly" style="flex-grow: 1;">'+
						    '<label for="attach'+i+'">파일찾기</label>'+
						    '<input type="file" class="file" id="attach'+i+'" name="attach'+i+'">'+
						'</div>';
			}
			
			$("div#divfileattach").html(html);
			
			$("input#attachCount").val(cnt);
			
		}); // end of 첨부파일 개수만큼 늘고 줄어들게 만들기
		
	}
	
	// 개인정보 수정 메소드 
	function changePsInfo(){
		  const frm = document.frm_psInfo;
		  frm.action="<%= ctxPath%>/changePsInfo.yolo";
		  frm.method="POST";
		  frm.submit();
	}
	
	function func_psa(){
		const frm = document.frm_ps_appointment;
		frm.action="<%= ctxPath%>/personnelAppointment.yolo";
		frm.method="POST";
		frm.submit();
	}
	
	//null값 체크 
	function isEmpty(value){
	    if(value == null || value.length === 0) {
	           return "";
	     } else{
	            return "정보 미입력";
	     }
	}	
	
	function isEmptyPsa(value){
	    if(value == null || value.length === 0 || value == undefined) {
	    	return "정보 없음";
	     } else{
	    	 return value;
	     }
	}	
	
	
	// textarea 자동 크기조절 
	function resize(obj) {
	    obj.style.height = '1px';
	    obj.style.height = (12 + obj.scrollHeight) + 'px';
	}
	
	
	// input 태그 숫자만 입력받도록 설정
	function OnlyNumericInput() {
			   
	    if ((event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >= 96 
	         && event.keyCode <= 105) || event.keyCode == 190 || event.keyCode == 110 
	         || event.keyCode == 8) {
	       return true;
	    } else {
	        event.returnValue = false;
	    }
	}

	
	// 현재 날짜에 해당하는 주 구하는 메소드 
   function getCurrentWeek() { 

        let start;
        let end;
		
        const day = new Date();
        const sunday = day.getTime() - 86400000 * day.getDay();
		
        day.setTime(sunday);

        const result = [day.toISOString().slice(0, 10)];

        for (let i = 1; i < 7; i++) {
            day.setTime(day.getTime() + 86400000);
            result.push(day.toISOString().slice(0, 10));
        }

        start = result[1];
        end = result[5];
        
       /*  console.log(start);
        console.log(end); */
        
        let arr_workTime = [];
        
        arr_workTime.push(start);
        arr_workTime.push(end);
        
        return arr_workTime;
    }
	
	// 상세보기를 한 사원의 주별 근무시간 알아오는 메소드 (progressbar 출력)
	function getWorkTime(empno){
		
		let arr_workTime = getCurrentWeek();
		
		let start_date = arr_workTime[0];
		let end_date = arr_workTime[1];
		
		$.ajax({
			 // 부서 이름 구해오기 
			  url : "<%= ctxPath%>/getWorkTime.yolo",
			  data: {"start_date":start_date
				    ,"end_date":end_date
				    ,"empno":empno},
			  dataType : "JSON",
			  success : function(json){
				  let time = Number(json.time);
				  
				  let t = Math.floor(time/60);
				  let m = time%60;
				  
				  $("div#div_workTime").text(t+"시간"+m+"분");
				  
				  <%-- 근무시간 progressBar 시작  --%>
				  var bar = new ProgressBar.Circle(progressBar, {
					  strokeWidth: 15,
					  easing: 'easeInOut',
					  duration: 1000,
					  color: '#00C6c3',
					  trailColor: '#ebecee',
					  trailWidth: 0,
					  svgStyle: null
					});
					
					bar.animate(time/2400);  // progress bar 퍼센트 0.0 ~ 1.0
					<%-- 근무시간 progressBar 끝  --%>
				
			  },// end of success
			  error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		
		}); // end of ajax()----------------------------------------------------------------------
		
	}
	
	
	
	//인사정보 페이지에서 인사 정보 변경 버튼 클릭시
	function edit_hrInfo(empno){
		$("div#edit_info").empty();
		$('#edit_info').addClass('active');
	    $('#record_outside').fadeIn();
	    
		let html ='';
		
		html += '<div class="container">'
						+'<div style="display: flex; justify-content: space-between; border-bottom: #ebebeb; margin: 20px 0;">'
								+'<div style="font-size: 20px; font-weight: 600;">인사 정보 변경&nbsp;&nbsp;'
									+'<span class="badge badge-primary">발령</span>'
								+'</div>'
							+'<button id="record_close" onclick="record_close();">'
								+'<i class="fas fa-times"></i>'
							+'</button>'
						+'</div>'
						
					+'<form name="frm_ps_appointment">'
						+'<input name = "empno" type="hidden" value="'+empno+'"/>'
						+'<input name = "before_deptno" type="hidden" value="'+before_deptno+'"/>'
						+'<input name = "before_position" type="hidden" value="'+before_position+'"/>'
						
						+'<div style="padding-bottom: 10px;">'
							+'<div>발령일<span style="color: red;">＊</span></div>'
							+'<input name="psa_date" type="text" class="daterange" style="width: 100%; height: 30px; border: solid 1px #d9d9d9; border-radius: 5px;" />'
						+'</div>'
						
						+'<div style="margin:5px 0; padding-bottom: 10px;">'		
							+'<div>발령 라벨</div><input id="changeType" name="changeType" type="hidden" />'
							+'<button id="btn" class=" btn communication" type="button" data-toggle="dropdown" style="background-color: white; padding: 3px 0px 3px 5px; border: solid 1px #d9d9d9; border-radious: 10px; width: 100%;">'
								+'<div style="display: flex; justify-content: space-between; width: 100%;">'
									+'<div id="retirement_type" class="retirement_type">발령 라벨</div>'
									+'<i class="fas fa-bars" style="padding: 5px;"></i>'
								+'</div>'
							+'</button>'
					
							+'<div class="dropdown-menu">'
								+'<button class="btn_retirement dropdown-item" type="button" value="직무 변경" style="width: 100%;">직무 변경</button>'
								+'<button class="btn_retirement dropdown-item" type="button" value="부서 변경" style="width: 100%;">부서 변경</button>'
								+'<button class="btn_retirement dropdown-item" type="button" value="인사 변경" style="width: 100%;">인사 발령</button>'
							+'</div>'
						+'</div>'
						
						
						+'<div style="margin:5px 0;padding-bottom: 10px;">'
							+'<div>부서</div>'
							+'<input id="deptno" name="deptno" type="hidden"/>'
							+'<button onclick="getDeptName()" id="btn" class=" btn communication" type="button"'
								+'data-toggle="dropdown"'
								+'style="background-color: white; padding: 3px 0px 3px 5px; border: solid 1px #d9d9d9; border-radious: 10px; width: 100%;">'
								+'<div style="display: flex; justify-content: space-between; width: 100%;">'
									+'<div class="retirement_type">부서</div>'
									+'<i class="fas fa-bars" style="padding: 5px;"></i>'
								+'</div>'
							+'</button>'
					
							+'<div class="div_dept dropdown-menu"></div>'
						+'</div>'
						
						+'<div style="margin:5px 0;padding-bottom: 10px;">'
							+'<div>세부 부서</div>'
							+'<input id="teamno" name="teamno" type="hidden"/>'
							+'<button id="btn" class=" btn communication" type="button" data-toggle="dropdown" style="background-color: white; padding: 3px 0px 3px 5px; border: solid 1px #d9d9d9; border-radious: 10px; width: 100%;">'
								+'<div style="display: flex; justify-content: space-between; width: 100%;">'
									+'<div class="retirement_type">세부 부서</div>'
										+'<i class="fas fa-bars" style="padding: 5px;"></i>'
								+'</div>'
							+'</button>'
					
							+'<div class="div_team dropdown-menu">'
								+'<button class="btn_retirement dropdown-item" type="button" style="width: 100%;" value="세부부서">부서를 선택하세요</button>'
							+'</div>'
						+'</div>'
						
						+'<div style="margin:5px 0; padding-bottom: 10px;">'
							+'<div style="width: 100%;">'
								+'<div>직위</div>'
								+'<input id="position" name="position" type="hidden" />'
								+'<button id="btn" class=" btn communication" type="button" data-toggle="dropdown"'
									+'style="background-color: white; padding: 3px 0px 3px 5px; border: solid 1px #d9d9d9; border-radious: 10px; width: 100%;">'
									+'<div style="display: flex; justify-content: space-between; width: 100%;">'
										+'<div id="div_retirement_type" class="retirement_type">직위</div>'
										+'<i class="fas fa-bars" style="padding: 5px;"></i>'
									+'</div>'
								+'</button>'
								
								<%-- 만약에 오류날 경우 value 직위로 수정  --%>
					
								+'<div class="dropdown-menu">'
									+'<button class="btn_retirement dropdown-item" type="button" style="width: 100%;" value="사장">사장</button>'
									+'<button class="manager btn_retirement dropdown-item" type="button" style="width: 100%;" value="부서장">부서장</button>'
									+'<button class="btn_retirement dropdown-item" type="button" style="width: 100%;" value="차장">차장</button>'
									+'<button class="manager btn_retirement dropdown-item" type="button" style="width: 100%;" value="팀장">팀장</button>'
									+'<button class="btn_retirement dropdown-item" type="button" style="width: 100%;" value="대리">대리</button>'
									+'<button class="btn_retirement dropdown-item" type="button" style="width: 100%;" value="사원">사원</button>'
									+'<button class="btn_retirement dropdown-item" type="button" style="width: 100%;" value="관리자">관리자</button>'
								+'</div>'
							+'</div>'
						+'</div>'
				
						+'<div style="margin-bottom:290px;">'
							+'<div class="modal_title" style="width:100%;">메모</div>'
							+'<textarea name="memo" class="memo" rows="5" cols="30" style="width:100%;"></textarea>'
						+'</div>'
				
				
						+'<div style="display: flex; justify-content: flex-end;">'
							+'<button type="reset" class="btn btn_save_cancel" style="background-color: #F6F6F6; border: solid 1px #d9d9d9;" onclick="record_close();">취소</button>'
							+'<button type="button" class="btn btn_save_cancel" style="background-color: #06A016; color: white; margin-left: 10px;">'
								+'<i style="color: white;" class="fas fa-check"></i>&nbsp;&nbsp;저장하기'
						+'</button>'
						+'</div>'
					+'</form>'
				+'</div>'
			$("div#edit_info").html(html);
			
			daterange();
				$("input[name='before_deptno']").val( $("input#before_deptno").val());
				$("input[name='before_position']").val( $("input#before_position").val());
	} //인사정보 페이지에서 인사 정보 변경 버튼 클릭 끝 ------------------------------------------------------------------------------------------------------------------------
	
	//인사정보 페이지에서 기본 정보 변경 버튼 클릭시
	function edit_basicInfo(){
		$("div#edit_info").empty();
		$('#edit_info').addClass('active');
	    $('#record_outside').fadeIn();
		
		let html ='';
		
		html += '<div class="container">'
					+'<div style="display: flex; justify-content: space-between; border-bottom: #ebebeb; margin:20px 0;">'
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
	
	
	// 개인정보 변경 메소드 
	function editInfo(){
		$("div#edit_info").empty();
		$('#edit_info').addClass('active');
	    $('#record_outside').fadeIn();
	    let empno = $("input#empno").val();
	    
	    let html ='';
	    
	    html += '<div id="div_edit" class="container">'
					+'<div style="display: flex; justify-content: space-between; border-bottom: #ebebeb; margin:20px 0;">'
						+'<div style="font-size:20px; font-weight:600;">개인 정보 수정</div>'
						+'<button id="record_close" onclick="record_close();">'
							+'<i class="fas fa-times"></i>'
						+'</button>'
					+'</div>'
					
					+'<form name="frm_psInfo" enctype="multipart/form-data">'
						+'<div style="margin: 20px 0;">'
							+'<div>이름</div>'
							+'<input name ="name" class="input_edit_info" type="text"/>'
							+'<input name ="empno" type="hidden" value="'+empno+'" />'
						+'</div>'
						+'<div style="margin: 20px 0;">'
							+'<div>영문 이름</div>'
							+'<div style="display: flex;">'
								+'<input name="firstname" type="text" value="" style="width: 100%; height: 30px; border: solid 1px #d9d9d9; border-radius: 5px;" placeholder="이름(First Name)" />'
								+'<input name="lastname" type="text" value="" style="width: 100%; height: 30px; border: solid 1px #d9d9d9; border-radius: 5px;" placeholder="성(Last Name)"/>'
							+'</div>'
						+'</div>'
						+'<div style="margin: 20px 0;">'
							+'<div>내 소개</div>'
							+'<textarea name="introduce" id="introduce" rows="1" cols="" onkeydown="resize(this)" onkeyup="resize(this)"></textarea>'
						+'</div>'
						+'<div>'
							+'<div>주민등록번호</div>'
							+'<input class="input_edit_info" name="rrn" type="text" id="registeration_no" onkeydown="OnlyNumericInput();" maxlength="14" placeholder="주민등록번호 입력" />'
						+'</div>'
					<%--
						+'<div style="margin: 20px 0;">'
							+'<div>생년월일</div>'
							+'<input  class="input_edit_info daterange" type="text" />'
						+'</div>'
					--%>
						+'<div style="margin: 20px 0;">'
							+'<div>휴대전화 번호</div>'
							+'<input class="input_edit_info" type="text" id="mobile" name="mobile" onkeydown=" OnlyNumericInput();" maxlength="13" placeholder="휴대전화번호 입력" />'
						+'</div>'
						
						+'<div style="margin: 20px 0;">'
							+'<div>집 주소</div>'
							+'<input class="input_edit_info" readonly ="readonly" placeholder="주소 검색" type="text" id="address" name="address" /><br/>'
							+'<input class="input_edit_info" placeholder="상세 주소를 입력하세요" type="text" id="detailAddress" name="detailAddress" />&nbsp;'
						+'</div>'
						
						+'<div id="attachArea">'
							+'<span>파일 첨부하기</span>'
							+'<label for="spinnerImgQty">파일갯수 : </label>'
							+'<input id="spinnerImgQty" value="0" style="width: 30px; height: 20px;">'
							+'<div id="divfileattach"></div>'
							+'<input type="hidden" name="attachCount" id="attachCount" />'
						+'</div>'
							
						+'<div style="display:flex; justify-content: flex-end;">'
							+'<button type="button" class="btn btn_save_cancel" style="background-color: #F6F6F6;border:solid 1px #d9d9d9;"onclick="record_close();">취소</button>'
							+'<button type="button" class="btn btn_save_cancel"  onclick="changePsInfo();" style="background-color: #06A016; color: white; margin-left:10px;"><i style="color:white;" class="fas fa-check"></i>&nbsp;&nbsp;저장하기</button>'
						+'</div>'
					+'</form>'
				+'</div>'
	    
	    
	    
	    $("div#edit_info").html(html);
		spinner();
		daterange();
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
	}// end of function daterange(){}----------------------
	
	// 인사발령 부서 select 해오는 메소드 
	function getDeptName(){
		
	  let html ='';
		$.ajax({
			 // 부서 이름 구해오기 
			  url : "<%= ctxPath%>/getDeptList.yolo",
			  dataType : "JSON",
			  success : function(json){
				  $.each(json,function(index,dept){
					  html += "<button onclick='getTeam("+dept.deptno+")' class='btn_retirement dropdown-item' type='button' style='width: 100%;' value='"+dept.deptno+"'>"+dept.deptname+"</button>";
			      });// end of $.each(json,function(index,emp){}----------------------------
			      // html +='<input id="deptno" name="deptno" type="hidden"/>';
				  $("div.div_dept").html(html);
				
			  },// end of success
			  error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		
		}); // end of ajax()----------------------------------------------------------------------
		
	}// end of function getDeptName(){}--------------------------------------	
	
	
	// 부서번호를 전달받아 팀 구해오기 
	function getTeam(deptno){
		  let html ='';
		 $.ajax({
			  url : "<%=ctxPath%>/getTeamList.yolo",
			  data:{"deptno":deptno},
			  dataType : "JSON",
			  success : function(json){
				  
				  $.each(json,function(index,team){
				  		html +='<button class="btn_retirement dropdown-item" type="button" style="width: 100%;" value="'+team.deptno+'">'+team.deptname+'</button>';
			      });// end of $.each(json,function(index,emp){}----------------------------
			      // html +='<input id="teamno" name="teamno" type="hidden"/>';
			      $("div.div_team").html(html);
			      
			  },// end of success
			  error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		}); // end of ajax()----------------------------------------------------------------------
	}// end of function getTeam(deptno){}--------------------------------------
	
	
	
</script>

<div id="user_detail_content">
	
	<span><a class="a_people" href="<%= ctxPath%>/people.yolo">구성원</a> / ${requestScope.employeeMap.name}</span>
	
	
	<div id="user_profile">
	
		<div id="profile_img" style="background-color:${requestScope.employeeMap.profile_color}">
			<div id="user_name">${requestScope.employeeMap.profileName}</div>
			<input id="before_deptno" type="hidden" value="${requestScope.employeeMap.fk_deptno}" />
			<input id="before_position" type="hidden" value="${requestScope.employeeMap.position}" />
			
			
			<%-- 
			<button id="btn_profileImg" type="button" data-toggle="dropdown" style="background-color: white; border: solid 1px gray; border-radius: 50%; position:relative; top:40px; left:20px;">
				<i class="fas fa-camera"></i>
			</button>
			<div class="dropdown-menu">
				<a class="dropdown-item" href="#"><i class="fas fa-upload"></i>&nbsp;&nbsp;사진 업로드하기</a> 
				<a id = "delete_profileImg" class="dropdown-item" href="#"><span style="color:#e62e00"><i class="fas fa-trash"></i>&nbsp;&nbsp;삭제하기</span></a> 
			</div>
			--%>
		</div>
		<%-- ======================== 프로필 시작 ========================= --%>
		<table>
			<thead>
				<tr>
					<th colspan="2">${requestScope.employeeMap.name}</th>
				</tr>
				<tr>
					<th class="dept_position">부서</th>				
					<th class="user_dept_position">&nbsp;&nbsp;&nbsp;${requestScope.employeeMap.teamname}</th>	
				</tr>
				<tr>
					<th class="dept_position">직책</th>				
					<th class="user_dept_position">&nbsp;&nbsp;&nbsp;${requestScope.employeeMap.position}</th>				
				</tr>
				<tr>
					<th>
						<a onclick="copy_to_clipboard('${requestScope.employeeMap.mobile}')" class="btn communication" href="#" data-toggle="tooltip" data-placement="top" title="${requestScope.employeeMap.mobile}"><i class="fas fa-phone-alt"></i></a>
					</th>
					<th>
						<a onclick="copy_to_clipboard('${requestScope.employeeMap.email}')" class="btn communication" href="#" data-toggle="tooltip" data-placement="top" title="${requestScope.employeeMap.email}"><i class="far fa-envelope"></i></a>
					</th>
					<th>
						<a class="btn communication" href="<%= ctxPath%>/messenger/receivedMessage.yolo?empno=${requestScope.employeeMap.empno}" data-toggle="tooltip" data-placement="top" title="메신저"><i class="fas fa-comment"></i></a>
						<%-- 메시지 받는사람 파라미터로 넘겨줘야 함. --%>
					</th>
					<th> 
						<button id="btn" class=" btn communication" type="button" data-toggle="dropdown" style="background-color: white; padding:3px 0px 3px 5px; border: solid 1px #d9d9d9; border-radious:10px;">
							<c:if test="${requestScope.employeeMap.status == '재직'}"> <%-- 재직중인 경우 --%>
								<span style="color:#07B419;">●</span>&nbsp;&nbsp;재직중&nbsp;&nbsp;
							</c:if>
							
							<c:if test="${requestScope.employeeMap.status == '휴직'}"> <%-- 휴직중인 경우 --%>
								<span style="color:#8F40DE;">●</span>&nbsp;&nbsp;휴직중&nbsp;&nbsp;
							</c:if>
							
							<c:if test="${requestScope.employeeMap.status == '퇴직'}"> <%-- 퇴사자인 경우 --%>
								<span style="color:green;">●</span>&nbsp;&nbsp;퇴직&nbsp;&nbsp;
							</c:if>
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
						
						<input type="hidden" id="input_leave_type" value="일반휴직"/>
						<input type="hidden" id="empno" value="${requestScope.employeeMap.empno}" />
						<div class="dropdown-menu">
							<button class="btn_leave dropdown-item" type="button" style ="width:460px;">일반휴직</button>
							<button class="btn_leave dropdown-item" type="button" style ="width:460px;">육아휴직</button>
							<button class="btn_leave dropdown-item" type="button" style ="width:460px;">산재휴직</button>
							<button class="btn_leave dropdown-item" type="button" style ="width:460px;">부상.질병휴직</button>
							<button class="btn_leave dropdown-item" type="button" style ="width:460px;">가족 돌봄휴직</button>
						</div>
						
						<div>
							<div style="margin-top:20px;" class="modal_title">휴직기간 <span style="color: red;">＊</span></div>
							<input id="between_date" class="form-control"  />
							<div id="div_warnning">이미 휴직이 등록된 날짜입니다.</div>
							<input type="hidden" id="start_date"  name="start_date" />
							<input type="hidden" id="end_date" name="end_date" />
						</div>
	
						<div>
							<div class="modal_title" style="margin-top:20px;">메모</div>
							<textarea id="memo_leave" class="memo" rows="5" cols="30"></textarea>
						</div>
					</div>
					</form>
	
					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="button" class="btn " data-dismiss="modal">취소</button>
						<button id="btn_leave" type="button" class="btn btn-success">적용하기</button>
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
			
			<a class="a_side" href="<%= ctxPath%>/commute/mycommute.yolo">
				<div class="div_rightside" id="work_time">
					<i class="far fa-clock fa-lg i_sideIcon"></i>
					<div style="display: flex; justify-content: space-between; margin-top: 5px;">
						<div style="margin:15px 0 0 20px;">
							<div style="font-size: 12px; font-weight:600; color:#556372;">근무시간</div>
							<div id="div_workTime" style="font-size: 20px; color: gray; font-weight:700;"></div>
						</div>
						<div id="progressBar"></div>
					</div>
				</div>
			</a>
			
			<a class="a_side" href="<%= ctxPath%>/leaveSummary.yolo">
				<div class="div_rightside" id="annual">
					<i class="fas fa-leaf fa-lg i_sideIcon"></i>
					<div style="display: flex; justify-content: space-between; margin-top: 5px;">
						<div style="margin:15px 0 0 20px;">
							<div style="font-size: 12px; font-weight:600; color:#556372;">남은연차</div>
							<div id="div_annual" style="font-size: 20px; color: gray; font-weight:700;"></div>
						</div>
					</div>
				</div>
			</a>
			
			<a class="a_side" href="<%= ctxPath%>/admin/payStub.yolo">
				<div class="div_rightside" id="pay_stub">
					<i class="fas fa-won-sign fa-lg i_sideIcon"></i>
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
				<div class="profile_icon" style="background-color:${requestScope.employeeMap.profile_color}">
					<div>${requestScope.employeeMap.profileName}</div>
				</div>
				<div style="padding-top: 3px;">${requestScope.employeeMap.name}</div>
				<button class="btn_record" id="btn_search_hrInfo">인사정보</button>
				<button class="btn_record" id="btn_search_leaveInfo">휴직이력</button>
			</div>

		</div>
		<button id="record_close">
			<i class="fas fa-times"></i>
		</button>
	</div>
	<%-- =========== 조회 결과 출력되는 div =========== --%>
	<div id="div_result">
		<form name="frm_send"></form>
	</div>
	<%-- =========== 조회 결과 출력되는 div =========== --%>
</div>

<%-- 인사정보 변경, 기본 정보 변경 div --%>
<div id ="edit_info">

</div>
