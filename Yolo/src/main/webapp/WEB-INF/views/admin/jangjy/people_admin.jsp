<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>

<script>


</script>

<style>
div#peopleContent {
	margin-right: 10px;
}

div#header {
	border-bottom: solid 1px #d9d9d9;
	display: flex;
	justify-content: space-between;
}

span.title {
	font-size: 28px;
	margin-right: 20px;
	font-weight: 700;
	letter-spacing: -1.12px;
}

div#header_title, div#button_title {
	margin: 35px 20px 20px 20px;
}

button#registMember {
	background: linear-gradient( to left ,#5bd3ff, #88eb1e );
	color: white;
}

tr {
	font-size: 10pt;
}

.th_200 {
	width: 200px;
}

.th_150 {
	width: 150px;
}

.th_100 {
	width: 100px;
}

.th_50 {
	width: 50px;
}

<%-- 상세 조회 아이콘 css --%> div.profile_icon {
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

<%-- 간단조회 아이콘 css --%> div.profile_icon2 {
	width: 50px;
	height: 50px;
	border-radius: 40%;
	background-color: #239afe;
	color: white;
	text-align: center;
	padding-top: 6px;
	border: 1px solid #ccced0;
	font-weight: bold;
	margin: auto 8px;
	font-size: 15px;
}

div.profile_icon2>div {
	margin-top: 3px;
}

div.profile, div.profile2 {
	display: flex;
	justify-content: start;
}

<%-- 검색버튼, 조직도 버튼, 다운로드 버튼 css --%> 
div#search_buttons {
	display: flex;
	justify-content: end;
	border-bottom: solid 1px #d9d9d9;
	padding: 20px;
}

button.btn_search {
	margin-top: 15px;
}

button.btn_search:hover {
	background-color: #ebebeb;
}

div#div_toggle_buttons {
	background-color: #ebebeb;
	padding: 3px;
	border-radius: 5px;
	margin-top: 15px;
}

button.btn_view_style:focus {
	outline: none;
}

<%--
검색바 input 태그 css --%> input.input_search {
	border: none;
	border-top-right-radius: 10px;
	border-bottom-right-radius: 10px;
}

input.input_search:focus {
	outline: none;
}

div#div_search {
	border: solid 2px #07B419;
	border-radius: 10px;
	height: 30px;
	padding-left: 3px;
	margin-top: 20px;
	position: relative;
	left: 38px;
	display: none;
}

.hidden {
	opacity: 0;
	pointer-events: none;
}

div.dept_position {
	background-color: #F8F9FA;
	padding: 10px;
	border-radius: 10px;
	margin-top: 3px;
}

div.dept_position>span {
	color: #556372;
}

div.dept_position>span:nth-child(2) {
	color: #CDD2D6;
}

div.div_name2 {
	font-size: 20px;
	font-weight: 500;
	color: #242A30;
	line-height: 14px;
	margin-top: 15px;
}

div.div_empInfo:hover {
	background-color: #F8F9FA;
}

#search_result > table > tbody > tr > td{
	height: 55px;
	padding: 0;
	vertical-align: middle;
}

<%--
조직도 상단 조직도 펼치기, 수정 버튼 css --%> button.org_btn:hover {
	background-color: #ebebeb;
}

<%--
조직도에 버튼 오른쪽 끝으로 정렬 --%> div#org_buttons {
	display: flex;
	justify-content: flex-end;
}

<%--
회원 가입 모달 css 시작  --%> <%-- 구성원 초대하기 버튼 css --%> button#regist_member_btn
	{
	height: 50px;
	width: 100%;
	border-radius: 10px;
	color: white;
	background-color: #07B419;
}

div#title {
	font-size: 20pt;
	font-weight: 600;
	text-align: center;
	margin: 100px 0 50px 0px;
}

input.input_modal, button.choice_type {
	width: 100%;
	line-height: 30px;
	border-radius: 10px;
	padding: 5px;
	border: solid 1px #d9d9d9;
}

input.input_modal:focus {
	outline-color: #07B419;
}

button.choice_type:active, button.choice_type:focus {
	border: solid 1px #07B419;
}

button#regist_member_btn>i {
	padding-right: 10px;
}

div.regitst_title {
	padding: 0 0 3px 5px;
}

<%--
form#regist_frm  div.show {
	top: 0px;
	left: 10px;
	will-change: transform;
	border-radius: 10px;
	width: 458px;
}
--%>
<%-- 회원 가입 모달 css 끝 --%>

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
div#search_result{
	width: 95%;
	margin: 0 auto;
}

th,td{
	text-align: center;
	font-size: 14px;	
}

<%-- 검색태그 div css --%>
div#div_searchTag{
	border: solid 1px gray;
	
	padding: 40px 16px;
	display: flex;
	justify-content: space-between;
	
}
<%-- 필터초기화 버튼 css --%>
button.filter_clear{
	border: solid 1px #d9d9d9;
}
<%-- 필터 추가 버튼 css --%>
button#add_searchTag{
	border: solid 1px #d9d9d9;
	padding: 0;
}


</style>

<script>

	$(document).ready(function(){
		
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
		
		<%-- bootstrap 툴팁 --%>
		$(function () {
			$('[data-toggle="tooltip"]').tooltip()
		});
		
		// 테이블 형식 또는 리스트 형식 출력 버튼 클릭시 버튼 css 변경 
		$(document).on("click","button.btn_view_style",function(){
			$("button.btn_view_style").css("background-color","");
			$(this).css("background-color","white");
		});
		
		// 검색 버튼 클릭시 
		$(document).on("click","button#btn_search",function(){
			$("div#div_search").css("display","block");	
			$("button#btn_search").addClass("hidden");
			
		});
		// 검색 div 이외 영역 클릭시 값이 비어있는 경우 div 숨기기
		$('html').click(function(e) {   
			let searchWord = $("input#searchWord").val();
			if($(e.target).parents('div#div_search').length < 1 && searchWord.trim() == "" ){  
				$("div#div_search").css("display","");	
				$("button#btn_search").removeClass("hidden");
			}
		});
		
		
		
		// 다운로드 버튼 클릭시 
		$(document).on("click","button#btn_search",function(){
			
		});
		
		
		// 사원 관련 모든 정보 table 로 보여주는 버튼
		$(document).on("click","button#view_table",function(){
			func_getEmpList();
			
		});
		
		// 사원 관련 부서, 이름 , 직위, 아이콘만 보여주는 버튼
		$(document).on("click","button#view_list",function(){
			$("div#search_result").empty();
			let html ='<div style="display: flex; margin-top:20px;">'
						+'<div class="div_personOne" style="width:100%; padding-top: 15px;">'
							
								<%-- 반복해서 출력할 div 묶음 시작  --%>
								+'<div class="div_empInfo" style="display: flex; justify-content: space-between; margin: 10px; padding:10px;">'
								+'<div class="profile2">'
									+'<div class="profile_icon2">'
										+'<div>길동</div>'
									+'</div>'
										+'<div class="div_name2" style="padding-top:3px;">홍길동</div>'
								+'</div>'
								+'<div class="dept_position">'
									+'<span>직위&nbsp;&nbsp;</span>'
									+'<span>|</span>'
									+'<span>&nbsp;&nbsp;부서</span>'
									+'</div>'
								+'</div>'
								<%-- 반복해서 출력할 div 묶음 끝  --%>
							
						+'</div>'<%-- end of <div style="width:75%; padding-top: 15px;"> --%>
						
					+'</div>';
			$("div#search_result").html(html);
		});
		
		
		// 문서 로딩 시 기본값 테이블 보기로 설정
		$("button#view_table").trigger("click");
		
		
		// 구성원 등록 모달에서 드롭다운으로 나오는 속성 클릭 시 
		$(document).on("click","button.btn_label",function(){
			let selected = $(this).text();
			$(this).parent().parent().find("input").val(selected);
		});
		
		
		
		
	});// end of $(document).ready(function(){}------------------------------------------------
	
	// ajax 통신방식으로 사원 조회하는 메소드		
	function func_getEmpInfo(){ <%-- 파라미터로 사원 번호 전달 받기 --%>
	 	<%-- 특정 사원번호 전달 --%>
		location.href = "<%=ctxPath%>/user_detail.yolo" ;
	}
	
	// 전체 사원을 조회해오는 메소드 
	function func_getEmpList(){
		
		$("div#search_result").empty();
		let html ='<table class="table table-bordered table-hover" style="margin-top: 20px;">'
						+'<thead>'
							+'<tr>'
								+'<th rowspan="2" class="th_100" style="vertical-align: middle; text-align:start;">이름</th>'
								+'<th colspan=6>기본 정보</th>'
								+'<th colspan=2>인사 정보</th>'
								+'<th colspan=3>개인 정보</th>'
							+'</tr>'
							+'<tr>'
								+'<th style="width:5%">상태</th>'
								+'<th class="th_50">사번</th>'
								+'<th style="width:7%">입사일</th>'
								+'<th style="width:7%">퇴직일</th>'
								+'<th style="width:7%">근속기간</th>'
								+'<th class="th_100">근무일수</th>'
								
								+'<th class="th_50">부서</th>'
								+'<th class="th_50">직위</th>'
								
								+'<th class="th_150">이메일</th>'
								+'<th style="width:5%">성별</th>'
								+'<th class="th_150">휴대전화</th>'
								
							+'</tr>'
						+'</thead>'
						+'<tbody>';
		
		$.ajax({
			  url : "<%= request.getContextPath()%>/getEmpList.yolo",
			  // data : {"email":email ,"pwd":pwd}, 나중에 필터값 전달
			  // type : "POST",
			  dataType : "JSON",
			  success : function(json){
				  <%-- ========================== 반복해서 출력할 부분 시작 ========== --%>
				  
				  $.each(json,function(index,emp){
					  
				  html += '<tr onclick="func_getEmpInfo();">'  
							+'<td class="th_150">'
								+'<div class="profile">'
									+'<div class="profile_icon"><div>길동</div></div>'
									+'<div style="padding-top:3px;">'+emp.name+'</div>'
								+'</div>'
							+'</td>'
							+'<td>'+emp.status+'</td>'
							+'<td>'+emp.empno+'</td>'
							+'<td>'+emp.hireDate+'</td>'
							+'<td>'+emp.retireDate+'</td>'
							+'<td>112개월</td>'
							+'<td>15042일</td>'
			
							+'<td>'+emp.dept+'</td>'
							+'<td>'+emp.position+'</td>'
			
							+'<td>'+emp.email+'</td>'
							+'<td>'+emp.gender+'</td>'
							+'<td>'+emp.mobile+'</td>'
						+'</tr>'
						<%-- ========================== 반복해서 출력할 부분 끝 ========== --%>
					
			    });// end of $.each(json,function(index,emp){}----------------------------
				
			    html +='</tbody>'   	
				+'</table>';
				$("div#search_result").html(html);
				
			  },
			  error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		  }); // end of ajax{}----------------------------------------------
		
	}// end of function func_getEmpList(){}--------------------------------------------

</script>

<div id="peopleContent">
	<div id="header">
		<div id="header_title">
			<a class="current" href="<%=ctxPath%>/people.yolo"><span class="title">구성원</span></a>
			<a class="a_title" href="<%=ctxPath%>/organization_chart.yolo"><span class="title">조직도</span></a> 
			<a class="a_title" href="<%=ctxPath%>/change_history.yolo"><span class="title">인사 정보 관리</span></a>
		</div>
		<div id="button_title">
			<button id="registMember" type="button" class="btn"
				data-toggle="modal" data-target="#modal_registMember">
				<span> <i class="fas fa-plus"
					style="margin: 0px; width: 20px;"></i>&nbsp;&nbsp;구성원 추가하기
				</span>
			</button>
		</div>
	</div>
	<!-- ========================== 구성원 추가 모달 시작 ========================== -->
	<div class="modal fade" id="modal_registMember">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content" style="padding: 5px;">
				<!-- Modal header -->
				<div class="modal-header">
					<h2>구성원 등록</h2>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<!-- Modal body -->
				<div class="modal-body">
					<form id="regist_frm" name="regist_frm">
						<div id="div_regist">
							<div style="display: flex; justify-content: space-between;">
								<div>
									<div class="regitst_title">
										이름<span style="color: red;">*</span>
									</div>
									<input name="name" class="input_modal" type="text"
										autocomplete="off" placeholder="이름 입력" />
								</div>
								<div>
									<div class="regitst_title">
										이메일<span style="color: red;">*</span>
									</div>
									<input name="email" class="input_modal" type="text"
										autocomplete="off" placeholder="이메일 입력" />
								</div>
							</div>

							<div style="margin: 10px 0;">
								<%-- daterange --%>
								<div class="regitst_title">
									입사일<span style="color: red;">*</span>
								</div>
								<input name="hire_date" type="text"
									class="input_modal daterange" placeholder="입사일 입력"></input>
							</div>
								<div>
								<div class="regitst_title">
									급여<span style="color: red;">*</span>
								</div>
								<input name="name" class="input_modal" type="text"
									autocomplete="off" placeholder="급여 입력" />
							</div>

							<%-- =========== 부서 선택 =========== --%>
							<div style="margin: 10px 0;">
								<div class="regitst_title">부서 선택</div>
								<input type="hidden" id="department" name="department" />

								<button id="btn" class=" btn choice_type" type="button"
									data-toggle="dropdown">
									<div style="display: flex; justify-content: space-between;">
										<div id="retirement_type">부서 선택</div>
										<i class="fas fa-bars" style="padding: 5px;"></i>
									</div>
								</button>

								<div class="dropdown-menu">
									<button class="btn_label dropdown-item" type="button">부서1</button>
									<button class="btn_label dropdown-item" type="button">부서1</button>
									<button class="btn_label dropdown-item" type="button">부서1</button>
									<button class="btn_label dropdown-item" type="button">부서1</button>
								</div>
							</div>
							<%-- =========== 부서 선택 =========== --%>


							<%-- =========== 세부부서 선택 =========== --%>
							<div style="margin: 10px 0;">
								<div class="regitst_title">세부부서 선택</div>
								<input type="hidden" id="detail_department"
									name="detail_department" />

								<button id="btn" class=" btn choice_type" type="button"
									data-toggle="dropdown">
									<div style="display: flex; justify-content: space-between;">
										<div id="retirement_type">세부부서 선택</div>
										<i class="fas fa-bars" style="padding: 5px;"></i>
									</div>
								</button>

								<div class="dropdown-menu">
									<button class="btn_label dropdown-item" type="button">세부부서1</button>
									<button class="btn_label dropdown-item" type="button">세부부서2</button>
									<button class="btn_label dropdown-item" type="button">세부부서3</button>
									<button class="btn_label dropdown-item" type="button">세부부서4</button>
									<button class="btn_label dropdown-item" type="button">세부부서5</button>
								</div>
							</div>
							<%-- =========== 세부부서 선택 =========== --%>


							<%-- =========== 직위 선택 =========== --%>
							<div style="margin: 10px 0;">
								<div class="regitst_title">직위 선택</div>
								<input type="hidden" name="position" id="position" />

								<button id="btn" class=" btn choice_type" type="button"
									data-toggle="dropdown">
									<div style="display: flex; justify-content: space-between;">
										<div id="retirement_type">직위 선택</div>
										<i class="fas fa-bars" style="padding: 5px;"></i>
									</div>
								</button>

								<div class="dropdown-menu">
									<button class="btn_label dropdown-item" type="button">직위</button>
									<button class="btn_label dropdown-item" type="button">직위</button>
									<button class="btn_label dropdown-item" type="button">직위</button>
									<button class="btn_label dropdown-item" type="button">직위</button>
									<button class="btn_label dropdown-item" type="button">직위</button>
								</div>
							</div>
							<%-- =========== 직위 선택 =========== --%>
							
							
							<%-- =========== 직속상관 선택 =========== --%>
							<div style="margin: 10px 0;">
								<div class="regitst_title">직속 상관</div>
								<input type="hidden" name="position" id="position" />

								<button id="btn" class=" btn choice_type" type="button"
									data-toggle="dropdown">
									<div style="display: flex; justify-content: space-between;">
										<div id="retirement_type">직속상관 선택</div>
										<i class="fas fa-bars" style="padding: 5px;"></i>
									</div>
								</button>

								<div class="dropdown-menu">
									<button class="btn_label dropdown-item" type="button">직속상관1</button>
									<button class="btn_label dropdown-item" type="button">직속상관2</button>
									<button class="btn_label dropdown-item" type="button">직속상관3</button>
									<button class="btn_label dropdown-item" type="button">직속상관4</button>
									<button class="btn_label dropdown-item" type="button">직속상관5</button>
								</div>
							</div>
							<%-- =========== 직속상관 선택 =========== --%>
							
						</div>
					</form>
				</div>
				<!-- Modal footer -->
				<div class="modal-footer"
					style="display: flex; justify-content: space-between;">
					<%-- form 전송 --%>
					<button type="button" class="btn" id="regist_member_btn">
						<i class="fas fa-check"></i>입력완료
					</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ========================== 구성원 추가 모달 끝 ========================== -->
	
	<div id="search_buttons">
		<%-- 검색어 입력 input 태그 --%>
		<div id="div_search">
			<i class="fas fa-search"></i> <input id="searchWord"
				class="input_search" type="text" placeholder="검색" />
		</div>

		<%-- 검색 버튼 (클릭시 input태그 출력)  --%>
		<button type="button" id="btn_search" class="btn btn_search">
			<i class="fas fa-search"></i>
		</button>

		<%-- 구성원 정보 다운로드 버튼 --%>
		<button type="button" id="btn_download" class="btn btn_search"
			data-toggle="tooltip" data-placement="top" title="구성원 정보 다운로드">
			<i class="fas fa-download"></i>
		</button>

		<%-- 모든 정보 출력 or 이름,부서,직위만 출력 --%>
		<div id="div_toggle_buttons">
			<button type="button" id="view_table" class="btn btn_view_style">
				<i class="fas fa-th-large"></i>
			</button>

			<button type="button" id="view_list" class="btn btn_view_style">
				<i class="fas fa-th-list"></i>
			</button>
		</div>
	</div>
	
	<%-- 검색필터 추가 시작  --%>
	<div id="div_searchTag">
		<div id="serchTag_content">
			<div class="dropdown">
				<button id="add_searchTag" data-toggle="dropdown" type="button" class="btn">
					<i class="fas fa-plus"></i>필터 추가하기
				</button>
				
				<div class="dropdown-menu">
					<button class="btn_label dropdown-item" type="button" data-toggle="dropdown">직위</button>
					<div class="dropdown-menu">asdf</div>
					<button class="btn_label dropdown-item" type="button" id="btn_dept"data-toggle="dropdown">부서</button>
					<button class="btn_label dropdown-item" type="button"id="btn_status"data-toggle="dropdown">재직상태</button>
					<button class="btn_label dropdown-item" type="button"id="btn_status"data-toggle="dropdown">입사일</button>
				</div>
			</div>
			
		</div>
		
		<div id="div_search_result">
			<span>n명</span>		
			<button type="button" class="btn filter_clear" >필터초기화</button>
		</div>		
	</div>
	<%-- 검색필터 추가 시작  --%>


	<div id="search_result"></div>
	<%-- end of  <div id="search_result">====== --%>

</div>
<%-- end of peopleContiner div====== --%>



