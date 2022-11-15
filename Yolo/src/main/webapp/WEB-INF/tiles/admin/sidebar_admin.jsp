<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<style type="text/css">

	* {font-family: 'Pretendard', sans-serif; !important}

	div{
		/* border: 1px solid black; */
	}
	
	div#sideBar{
		/* width: 17%; */
		height: 100%;
		background-color: #f9fafa;
	}
	
	div#sideTop{
		width: 80%;
		height: 260px;
		margin: 35px auto 0 auto;
		/* border: 1px solid black; */
	}
	
	.sideTr{
		width: 100%;
		height: 40px;
		border-radius: 0.5rem;
		display: flex;
  		align-items: center;
  		font-weight: bold;
  		color: #687482;
  		margin-top: 3px;
	}
	
	.sideTr:hover {
		background-color: #efefef;
		cursor: pointer;
	}
	
	div#prof{
		width: 50px; 
		height: 50px; 
		border-radius: 40%; 
		background-color: #239afe;
		color: white;
		text-align: center;
		padding-top: 13px;
		border: 1px solid #ccced0;
		font-weight: bold;
		margin: auto 8px;
	}
	
	div#sideMiddle{
		width: 80%;
		margin: auto;
		padding-top: 30px;
		padding-bottom: 50px;
	}
	
	div#sideBottom{
		width: 80%;
		margin: auto;
		padding-top: 30px;
		padding-bottom: 20px;
		
	}
	
	i{
		width: 40px;
		margin-left: 15px;
	}
	
</style>

<!-- Optional JavaScript -->
<!-- 
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 
-->
<!-- JQuery UI CSS 밒 js -->
<!--
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>
-->
<script type="text/javascript">

	$(document).ready(function(){
		
		// 화면 높이만큼 body div에 height를 주겠다
		const web_browser_height = $(window).height(); 
		$("div#body").css({"height":web_browser_height});
		
	}); // end of ready

</script>

	<div id="body">
		<div id="sideBar">
		
			<div id="sideTop" class="border-bottom">
				<div class="sideTr mt-1" style="height: 70px;" onclick="#">
					<div id="prof">길동</div>
					<div>
						<span class="ml-2" style="display: block; padding-top: 3px;">홍길동</span>
						<span class="ml-2" style="font-weight: normal; color: gray; font-size: 10pt;">인사 · 관리자</span>
					</div>
				</div>
				<div class="dropdown my-4">
				  <a class="btn btn-outline-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="width: 90%;margin: auto 5%;">
				    출근하기
				  </a>
				  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink" style="width: 90%;">
				    <a class="dropdown-item" href="#">출근하기</a>
				  </div>
				</div>
				<div class="sideTr" onclick="#">
					<i class="fas fa-regular fa-paper-plane"></i><span>메신저</span>
				</div>
				<div class="sideTr" onclick="#">
					<i class="fas fa-regular fa-bell"></i><span>새로운 소식</span>
				</div>
			</div>
			
			<div id="sideMiddle" class="border-bottom">
				<div class="sideTr" onclick="#">
					<i class="fas fa-regular fa-flag"></i><span>공지사항</span>
				</div>
				<div class="sideTr" onclick="#">
					<i class="fas fa-solid fa-users"></i><span>구성원</span>
				</div>
				<div class="sideTr" onclick="#">
					<i class="fas fa-regular fa-calendar-check"></i><span>캘린더</span>
				</div>
				<div class="sideTr" onclick="#">
					<i class="fas fa-regular fa-clipboard"></i><span>게시판</span>
				</div>
				<div class="sideTr" onclick="#">
					<i class="fas fa-regular fa-clock"></i><span>근무</span>
				</div>
				<div class="sideTr" onclick="#">
					<i class="fas fa-solid fa-plane"></i><span>휴가</span>
				</div>
				<div class="sideTr" onclick="#">
					<i class="fas fa-solid fa-pen-nib"></i><span>워크플로우</span>
				</div>
				<div class="sideTr" onclick="#">
					<i class="fas fa-solid fa-dollar-sign"></i><span>급여</span>
				</div>
				<div class="sideTr" onclick="#">
					<i class="fas fa-solid fa-comments-dollar"></i><span>급여정산</span>
				</div>
				<div class="sideTr" onclick="#">
					<i class="fas fa-solid fa-chart-pie"></i><span>인사이트</span>
				</div>
			</div>
			
			<div id="sideBottom">
				<div class="sideTr mt-1" style="height: 70px;" onclick="#">
					<div id="prof" style="background-color: #d8c5e2;"><i class="fas fa-solid fa-school" style="width: 30px; margin: auto;"></i></div>
					<span class="ml-2">쌍용교육센터</span>
				</div>
			</div>
			
		</div>
	</div>

