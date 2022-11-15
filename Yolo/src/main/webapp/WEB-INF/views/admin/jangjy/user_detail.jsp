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
	
	button#record_search{
		margin: 20px 20px 20px 0;
	}
	
	button#record_search:hover{
		background-color: #ebebeb;
	}
	
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
	
	

</style>
<%-- 말풍선 --%>
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<%-- 말풍선 --%>

<script>
	$(document).ready(function(){
		
		
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
		  toastr.info('출력할 문구');
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
	
	<nav id="hr_info">
		<div id="hr_info_title">
			<div id="div_hr" class="info_title">인사 정보</div>
			<div id="div_ps" class="info_title">개인 정보</div>
		</div>
		<div>
			<button id="record_search" type="button" class="btn btn-sm" onclick="editInfo()"><i class="fas fa-pen" style="margin:0px; width:16px;"></i></button>
		</div>
	</nav>




</div>
