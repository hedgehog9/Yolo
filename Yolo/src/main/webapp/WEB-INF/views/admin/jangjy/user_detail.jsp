<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<style>
	
	div#user_detail_content{
		margin: 40px 20px 20px 20px;
	}
	
	div#profile_img{
		width:100px;
		height:100px;
		border-radius: 15%;
		background-color: green;
		
		margin-right:20px;
		
		display: flex;
    	align-items: center;
    	justify-content: center;
	}
	
	div#user_profile{
		display: flex;
		margin-top: 65px
	}
	
	div#user_name{
		
		font-size:20pt;
		font-weight: bold;
		color: white;
	}
	
	th.dept_position{
		font-size:12px;
		font-weight:normal;
	}
	
	
	nav#hr_info{
		display: flex;
		justify-content: space-between;
		align-items: end;
		border-bottom: solid 1px #d9d9d9;
	}
	
	
	div#hr_info_title{
		display: flex;
		padding: 30px 30px 0px 0;
		margin-right: 30px;
	}
	
	div#hr_info_title > div.info_title{
		padding: 20px 10px 20px 10px;
	}
	
	<%-- 정보 변경 내역 버튼 css --%>
	button#record_search{
		margin: 20px 0px 20px 0;
		border: solid 1px #d9d9d9;
		border-radius: 10px;
	}
	
	button#record_search:hover{
		background-color: #ebebeb;
	}
	<%-- 정보 변경 내역 버튼 css --%>
	
	
	<%-- 인사정보 수정 버튼 css --%>
	button#btn_edit{
		border-radius: 10px;
		margin:0px;
	}	
	button#btn_edit:hover{
		background-color: #ebebeb;		
	}	
	<%-- 인사정보 수정 버튼 css --%>
	
	
	
	div.info_title{
		font-size: 20px;
	}
	
	div.info_title:hover{
		cursor: pointer;
	}
	
	i.fa-phone-alt, i.fa-envelope, i.fa-comment{
		margin:0px;
		width:30px;
	}
	       
	a.communication{
		padding:3px 0px 3px 0px;
		border: solid 1px #d9d9d9;
	}
	
	a.communication:hover{
		background-color: #ebebeb;
	}
	
	div#div_hr_title{
		font-size: 20px;
		font-weight: 700;
	}
	
	span.span_badge{
		background-color: #d9d9d9;
		border-radius: 5px;
		padding: 0 5px;
		
	}
	
	<%-- 프로필 옆에 나오는 근무시간, 휴가, 급여명세서 div css --%>
	div#right_sidebar{
		margin: 30px 0 0 0;
	}
	
	div.div_rightside{
	
		border:solid 1px #d9d9d9;
		margin-bottom: 10px;
		
		width : 300px;
		height : 120px;
		border-radius: 10px;		
	}
	
	div#progressBar {
      margin: 16px 15px 0 0 ;
	  width: 50px;
	  height: 50px;
	}
	
	i.sideIcon{
		margin: 15px 0 0 20px;
		color: #242A30;
	}
	 

</style>
<%-- 말풍선 --%>
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<%-- 말풍선 --%>

<script>
	$(document).ready(function(){
		
		
		
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
		
	  	<%-- 인사정보 클릭시 --%>
		$(document).on("click","div#div_hr", function(e){
	  		$("div.info_title").css("border-bottom","");
	  		$(e.target).css("border-bottom","solid 3px green");
	  	});
  	
  	
	  	<%-- 개인정보 클릭시 --%>
	  	$(document).on("click","div#div_ps", function(e){
	  		$("div.info_title").css("border-bottom","");
	  		$(e.target).css("border-bottom","solid 3px green");
	  	});
		// 문서 로딩시 인사정보 클릭  	
  		$("div#div_hr").trigger("click");
	
	});// end of $(document).ready-----------------------------
	
	function editInfo(){
		toastr.info("정보 변경 메소드 호출됨");
		
		
	}//end of function editInfo(){}---------------
	
	
	// 버튼 클릭시 클립보드에 복사하는 함수 (a태그에서 호출)
	function copy_to_clipboard(str) {
		 // str이 복사하고자 하는 문자열
		  var tempElement = document.createElement("textarea");
		  document.body.appendChild(tempElement);
		  tempElement.value = str;
		  tempElement.select();
		  document.execCommand('copy');
		  document.body.removeChild(tempElement);
		  toastr.info("<div style='text-align:center;'>"+str+"<br>복사되었습니다</div>");
		  // alert(str+'복사되었습니다');
		  // Swal.fire('복사되었습니다.',str, 'success');
	}
</script>

<div id="user_detail_content">
	
	
	
	
	<span><a href="<%= ctxPath%>/people.yolo">구성원</a> / 홍길동</span>
	<i class="fas fa-camera"></i>
	<div id="user_profile">
	
		<div id="profile_img">
			<div id="user_name">길동</div>
		</div>
		
		<div id="user_info">
		<%-- 
			<div style="font-size">홍길동</div>
			<div>
				<div class="deptposition">부서  개발1팀</div>
				<div class="deptposition">직급  대리</div>
				<div>
					<button type="button" class="btn btn-sm btn-info">a</button>
					<button type="button" class="btn btn-sm btn-info">b</button>
					<button type="button" class="btn btn-sm btn-info">c</button>
				</div>
			</div>
		--%>
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
				</tr>
			</thead>
		</table>
		<%-- ======================== 프로필 끝 ========================= --%>
	</div>
	
	<%-- ============== 인사정보, 개인정보, 정보 변경 내역 버튼 시작  ============== --%>
	<nav id="hr_info">
		<div id="hr_info_title">
			<div id="div_hr" class="info_title">인사 정보</div>
			<div id="div_ps" class="info_title">개인 정보</div>
		</div>
		<div>
			<button id="record_search" type="button" class="btn" onclick="editInfo()"><i class="fas fa-history" style="margin:0px; width:16px;"></i>&nbsp;&nbsp;정보 변경 내역</button>
		</div>
	</nav>
	<%-- ============== 인사정보, 개인정보, 정보 변경 내역 버튼 끝  ============== --%>
	
	<%-- ===================== 인사정보 내용 출력 시작 ===================== --%>
	<div style="display:flex; justify-content: space-between;">
		<div id="div_hr_info">
			<div style="display:flex; justify-content: space-between; margin-top: 30px;">
				<div id="div_hr_title">인사 정보</div>
				<button id="btn_edit" type="button" class="btn" onclick="editInfo()"><i class="fas fa-pen" style="margin:0px; width:16px;"></i></button>
			</div>
			<table>
				<thead>
					<tr>
						<th style="width:200px">사번</th>				
						<th>333</th>				
					</tr>			
					<tr>
						<th>입사일</th>				
						<th><span>2022.11.17</span>&nbsp;&nbsp;<span class="span_badge">1개월</span>&nbsp;&nbsp;<span class="span_badge">그룹입사일 : 2022.11.17</span></th>				
					</tr>			
					<tr>
						<th>입사 유형</th>				
						<th>3</th>				
					</tr>			
					<tr>
						<th>부서</th>				
						<th><span>개발 1팀</span>&nbsp;&nbsp;<span class="span_badge">주조직</span></th>				
					</tr>			
					<tr>
						<th>직책</th>				
						<th>대리</th>				
					</tr>			
					<tr>
						<th>직위</th>				
						<th>6</th>				
					</tr>			
				</thead>
			</table>
		</div>
		<%-- ===================== 인사정보 내용 출력 끝 ===================== --%>
		
		<div id="right_sidebar">
			
			<div class="div_rightside" id="work_time">
				<i class="far fa-clock fa-lg sideIcon"></i>
				<div style="display: flex; justify-content: space-between; margin-top: 5px;">
					<div style="margin:15px 0 0 20px;">
						<div style="font-size: 12px; font-weight:600; color:#556372;">근무시간</div>
						<div style="font-size: 20px; color: gray; font-weight:700;">0시간</div>
					</div>
					<div id="progressBar"></div>
				</div>
			</div>
			
			<div class="div_rightside" id="annual">
				<i class="fas fa-leaf fa-lg sideIcon"></i>
				<div style="display: flex; justify-content: space-between; margin-top: 5px;">
					<div style="margin:15px 0 0 20px;">
						<div style="font-size: 12px; font-weight:600; color:#556372;">남은연차</div>
						<div style="font-size: 20px; color: gray; font-weight:700;">0시간</div>
					</div>
				</div>
			</div>
			
			<div class="div_rightside" id="pay_stub">
				<i class="fas fa-won-sign fa-lg sideIcon"></i>
				<div style="display: flex; justify-content: space-between; margin-top: 5px;">
					<div style="margin:15px 0 0 20px;">
						<div style="font-size: 12px; font-weight:600; color:#556372;">급여</div>
						<div style="font-size: 20px; color: gray; font-weight:700;">11월 급여 명세서</div>
					</div>
				</div>
			</div>
			
		</div>
	</div>




</div>
