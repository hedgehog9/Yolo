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
		margin: 15px auto 0 auto;
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
		height:490px;
		overflow: auto;
		margin: auto;
		padding-top: 30px;
		padding-bottom: 50px;
	}
	
	#sideMiddle::-webkit-scrollbar {
    	width: 10px;
  	}
  	#sideMiddle::-webkit-scrollbar-thumb {
    	background-color: #ababab;
    	border-radius: 10px;
  	}
  	#sideMiddle::-webkit-scrollbar-track {
    	background-color: #dedfe0;
    	border-radius: 10px;
  	}
	
	div#sideBottom{
		width: 80%;
		height : 130px;
		margin: auto;
		padding-top: 30px;
		padding-bottom: 20px;
		
	}
	
	i.sideIcon{
		width: 40px;
		margin-left: 15px;
	}
	
</style>


<script type="text/javascript">

	$(document).ready(function(){
		
		// 화면 높이만큼 body div에 height를 주겠다
		const web_browser_height = $(window).height(); 
		//$("div#sideBar").css({"height":web_browser_height-10});
		
	}); // end of ready

</script>

		<div id="sideBar">
		
			<div id="sideTop" class="border-bottom">
				<div class="sideTr mt-2" style="height: 70px;" onclick="#">
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
				<div class="sideTr" onclick="javascript:location.href='<%= ctxPath%>/messenger/sendedMassage.yolo'">
					<i class="fas fa-regular fa-paper-plane sideIcon"></i><span>메신저</span>
				</div>
				<div class="sideTr" onclick="#">
					<i class="fas fa-regular fa-bell sideIcon"></i><span>새로운 소식</span>
				</div>
			</div>
			
			<div id="sideMiddle" class="border-bottom">
				<div class="sideTr" onclick="#">
					<i class="fas fa-regular fa-flag sideIcon"></i><span>공지사항</span>
				</div>
				<div class="sideTr" onclick="#">
					<i class="fas fa-solid fa-users sideIcon"></i><span>구성원</span>
				</div>
				<div class="sideTr" onclick="javascript:location.href='<%= ctxPath%>/schedule/calendar.yolo'">
					<i class="fas fa-regular fa-calendar-check sideIcon"></i><span>캘린더</span>
				</div>
				<div class="sideTr" onclick="javascript:location.href='<%= ctxPath%>/admin/mycommute.yolo'">
					<i class="fas fa-regular fa-clock sideIcon"></i><span>출퇴근</span>
				</div>
				<div class="sideTr" onclick="javascript:location.href='<%= ctxPath%>/jinji/leaveSummary.yolo'">
					<i class="fas fa-solid fa-plane sideIcon"></i><span>휴가</span>
				</div>
				<div class="sideTr" onclick="#">
					<i class="fas fa-solid fa-pen-nib sideIcon"></i><span>워크플로우</span>
				</div>
				<div class="sideTr" onclick="javascript:location.href='<%= ctxPath%>/admin/payStub.yolo'">
					<i class="fas fa-solid fa-dollar-sign sideIcon"></i><span>급여</span>
				</div>
				<div class="sideTr" onclick="#">
					<i class="fas fa-solid fa-comments-dollar sideIcon"></i><span>급여정산</span>
				</div>
				<div class="sideTr" onclick="#">
					<i class="fas fa-solid fa-chart-pie sideIcon"></i><span>인사이트</span>
				</div>
			</div>
			
			<div id="sideBottom">
				<div class="sideTr mt-1" style="height: 70px;" onclick="#">
					<div id="prof" style="background-color: #d8c5e2;"><i class="fas fa-solid fa-school sideIcon" style="width: 30px; margin: auto;"></i></div>
					<span class="ml-2">쌍용교육센터</span>
				</div>
			</div>
			
		</div>


