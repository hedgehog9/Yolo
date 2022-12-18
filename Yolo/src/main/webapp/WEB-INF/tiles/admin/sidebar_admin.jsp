<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
	
	#start_work {
		cursor: pointer;
	}
	
	#position {
		top: -27px;
	    left: 151px;
	}
	
	/* 체크박스 CSS */
	input[type="checkbox"] {
        -webkit-appearance: none;
        position: relative;
        width: 18px;
        height: 18px;
        cursor: pointer;
        outline: none !important;
        border: 2px solid #cccccc;
        border-radius: 2px;
        background: #fbfbfb;
    }
 
    input[type="checkbox"]::before {
        content: "\2713";
        position: absolute;
        top: 50%;
        left: 50%;
        overflow: hidden;
        transform: scale(0) translate(-50%, -50%);
        line-height: 1;
    }
 
    input[type="checkbox"]:hover {
        border-color: rgba(170, 170, 170, 0.5);
    }
 
    input[type="checkbox"]:checked {
        background-color: #2eb82e;
        border-color: rgba(255, 255, 255, 0.3);
        color: white;
    }
 
    input[type="checkbox"]:checked::before {
        border-radius: 2px;
        transform: scale(1) translate(-50%, -50%)
    }
	
	
</style>


<script type="text/javascript">

	let distance = 0;

	let start_work_time = "";

	$(document).ready(function(){
		
		
		// 화면 높이만큼 body div에 height를 주겠다
		const web_browser_height = $(window).height(); 
		//$("div#sideBar").css({"height":web_browser_height-10});
		
		check_commute(); // 출근을 했는지 가져오는 메소드
		
		setInterval("plus_time()", 60000); // 1 분마다 distance 를 1분증가시키고 찍는다
		
		
		// 출근하기 버튼 클릭이벤트 시작
		$(document).on("click","#start_work",function(){
			//alert('asd')
			Swal.fire({
				   title: '출근하시겠습니까?',
				   icon: 'warning',
				   
				   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
				   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
				   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
				   confirmButtonText: '승인', // confirm 버튼 텍스트 지정
				   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
				   
				   reverseButtons: true, // 버튼 순서 거꾸로
				   
				}).then(result => {
				   // 만약 Promise리턴을 받으면,
				   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
					   
					   let html = "";
				   
					   $.ajax({
						   url:"<%= ctxPath %>/commute/commuteStart.yolo",
						   type:"POST",
						   data:{"fk_empno":'${sessionScope.loginuser.empno}'},
						   dataType:"JSON",
						   success:function(json){
							   if(json.n == 1) {
								   Swal.fire('출근처리가 완료되었습니다.','출근완료','success');
								   
								   const hour = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
								   let minute = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
								   
								   if(minute < 10) {
							    			minute = "0"+minute;
							    	    }
								    
								   const time = hour +"시간 "+ minute +"분";
								   
								   html += "<a class='btn btn-outline-secondary dropdown-toggle' href='#' role='button' id='dropdownMenuLink' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false' style='width: 90%;margin: auto 5%;'>"+
								    		   "<small class='border rounded bg-success text-white text-sm mr-2'>근무중</small><span id='work-time'>"+time+"</span></a>"+
									  	   "<div class='dropdown-menu' aria-labelledby='dropdownMenuLink' style='width: 90%;'>"+
									    	   "<div id='start_or_end'><a class='dropdown-item' id='end_work'>퇴근하기</a></div>"+
									  	   "</div>"
									
									$("#commute-div").html(html);  	   
							   }
						   },
						   error: function(request, status, error){
					            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					       }
					   })
				   
				   }
				});
		})
		
		// 출근하기 버튼 클릭이벤트 끝 ------------------------------------------------------------------------------------------
		
		
		// 퇴근하기 버튼 클릭이벤트 
		$(document).on("click","#end_work", function(){
			
			let html = "";
			let endtime = distance;
			let message = "";
			
			const getminute = getMinute().substring(0,2); // 현재시간을 가져오는 메소드
			
			// console.log(start_work_time.toTimeString().split(' ')[0].substring(0,2))
			
			let chul = start_work_time.toTimeString().split(' ')[0].substring(0,2)
		
			if(endtime > 18000000 && chul < 14) { // 출근한지 5시간 이상이고 14시 이전에 출근하였으면 -1시간을 해준다
				endtime = endtime - 3600000;
				
			}
			
		   	const hour = Math.floor((endtime % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
		    let minute = Math.floor((endtime % (1000 * 60 * 60)) / (1000 * 60));
		    
		    if(minute < 10) {
    				minute = "0"+minute;
    	    		}
		    
			const showWorktime = hour +"시간 "+minute+"분";
			const worktime = Math.floor(endtime/60000);
			
			let overtime;
			
			if(endtime > 28800000) {
				overtime = endtime - 28800000;
				overtime = Math.floor(overtime / 60000);
				const overtime_hour = Math.floor((endtime % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
				const overtime_minute = Math.floor((endtime % (1000 * 60 * 60)) / (1000 * 60));
				showOvertime = overtime_hour +"시간 "+overtime_minute+"분";
			}
			else {
				overtime = 0;
			}
			
			if(endtime > 18000000) { // 13시라면 1시간 휴계시간 공제
				message = '<b style="color: blue">'+showWorktime+' 근무 </b><br>'+
  			  			  '<small>휴게시간 1시간 공제</small>';
			}
			else {
				message = '<b style="color: blue">'+showWorktime+' 근무 </b><br>'
			}
			console.log(worktime)
			   console.log(overtime)
			
			Swal.fire({
				   title: '퇴근하시겠습니까?',
				   icon: 'warning',
				   html: message,
				   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
				   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
				   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
				   confirmButtonText: '승인', // confirm 버튼 텍스트 지정
				   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
				   
				   reverseButtons: true, // 버튼 순서 거꾸로
				   
				}).then(result => {
				   // 만약 Promise리턴을 받으면,
				   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
					   
					  $.ajax({
						  url:"<%= ctxPath %>/commute/commuteEnd.yolo",
						  type:"POST",
						  data:{"fk_empno":'${sessionScope.loginuser.empno}',
							    "worktime":worktime,
							    "overtime":overtime},
						  dataType:"JSON",
						  success:function(json){
							  if(json.n == 1) {
								  html += "<a id='dropdown' class='btn btn-outline-secondary dropdown-toggle' href='#' role='button' id='dropdownMenuLink' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false' style='width: 90%;margin: auto 5%;'>"+
									      "금일퇴근완료</a>"
									      
							  }
							  
							  $("#commute-div").html(html);
							  
							  Swal.fire('퇴근이 완료되었습니다.','퇴근완료','success');
							  
						  }
					  }) 
					   
				      
				   }
				});
			
		});// end of $(document).ready("click","#end_work", function(){}) ------------------
		
	}); // end of ready
	
	// Function Declation
	function getDateMinute() { // 현재날짜와 시간까지 가져오는 메소드
		const date = new Date();
		const year = date.getFullYear();
		const month = ('0' + (date.getMonth() + 1)).slice(-2);
		const day = ('0' + date.getDate()).slice(-2);
		const time = date.toTimeString().split(' ')[0];
		const today = year + '-' + month + '-' + day + " " + time; // 오늘 날짜를 가져옴
		
		return today;
	}
	
	
	function getDate() { // 현재날짜만 가져오는 메소드
		const date = new Date();
		const year = date.getFullYear();
		const month = ('0' + (date.getMonth() + 1)).slice(-2);
		const day = ('0' + date.getDate()).slice(-2);
		const today = year + '-' + month + '-' + day; // 오늘 날짜를 가져옴
		
		return today;
	}
	
	function getMinute() {
		const date = new Date();
		const time = date.toTimeString().split(' ')[0];
		
		return time;
	}
	
	
	
	function check_commute() { // 오늘 출근을 했는지 확인하는 메소드
		
		$.ajax({
			url:"<%= ctxPath %>/commute/checkCommute.yolo",
			data:{"fk_empno":'${sessionScope.loginuser.empno}'},
			dataType:"JSON",
			success:function(json) {
				
				let html = "";
				
				if(json.isExist) {	// 오늘날짜로 출근한 데이터가 있다면
					
					//console.log("확인용 => " + json.start_work_time)
				    //console.log("확인용 => " + getDateMinute())
				    start_work_time = json.start_work_time
				    let sysdate = getDateMinute()
				   
				    start_work_time = new Date(start_work_time);
				    sysdate = new Date(sysdate);
				    
				    //console.log("확인용 => " + start_work_time)
				    //console.log("확인용 => " + sysdate)
				   
				    distance = sysdate - start_work_time;
				   
				    const hour = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
				    let minute = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
				    
				    if(minute < 10) {
			    			minute = "0"+minute;
			    		}
				    
				    const time = hour +"시간 "+ minute +"분";
				    
				    //console.log(json.end_work_time)
				    
				    if(json.end_work_time == undefined) {
					    	html += "<a id='dropdown' class='btn btn-outline-secondary dropdown-toggle' href='#' role='button' id='dropdownMenuLink' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false' style='width: 90%;margin: auto 5%;'>"+
					    		    "<small class='border rounded bg-success text-white text-sm mr-2'>근무중</small><span id='work-time'>"+time+"</span></a>"+
						  	    "<div class='dropdown-menu' aria-labelledby='dropdownMenuLink' style='width: 90%;'>"+
						    	    "<div id='start_or_end'><a class='dropdown-item' id='end_work'>퇴근하기</a></div>"+
						  	    "</div>"
				    }
				    else {
					    	html += "<a class='btn btn-outline-secondary dropdown-toggle' href='#' role='button' id='dropdownMenuLink' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false' style='width: 90%;margin: auto 5%;' disabled>"+
						        "금일퇴근완료</a>"
						        
				    }
					
			
				   $("#commute-div").html(html);
					  	    
				   
				}
				
				
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});// end of $.ajax -----------------------------
		
	}// end of function check_commute() {} --------------------------------
	
	
	
    function plus_time() {
    		const gethour = getMinute() // 시간을 가져옴
    		
		distance += 60000
		
		const hour = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
	    let minute = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
	    
	    if(minute < 10) {
	    		minute = "0"+minute;
	    }
	    
	    const time = hour +"시간 "+ minute +"분";
	    
	    if(distance > 32400000) {
	    		$("#work-time").html("<span style=color:'red';>"+time+"</span>");
	    }
	    else {
	    		$("#work-time").text(time);
	    }
	    
	    // console.log("확인용 distance : " +distance)
		
	}  
	
    if(distance > 32400000) {
		toastr.warning('근무시간이 경과하였습니다. 퇴근버튼을 누르세요');
	}
    
    function logout(){
    	location.href='<%= ctxPath%>/logout.yolo';
    }

</script>

		<div id="sideBar">
		
			<div id="sideTop" class="border-bottom">
				<div data-toggle="dropdown" class="sideTr mt-2" style="height: 70px;">
					<div id="prof" style="background-color:${sessionScope.loginuser.profile_color}">
						<c:set var="name" value="${sessionScope.loginuser.name}" />
						${fn:substring(name,1,3) }
					</div>
					<div>
						<span class="ml-2" style="display: block; padding-top: 3px;">${sessionScope.loginuser.name}</span>
						<span class="ml-2" style="font-weight: normal; color: gray; font-size: 10pt;">${sessionScope.loginuser.deptname} · ${sessionScope.loginuser.position}</span>
					</div>
				</div>
				
				<div id="div_team" class="dropdown-menu">
					<button class="dropdown-item" type="button" onclick="javascript:location.href='<%= ctxPath%>/userDetail.yolo?empno=${sessionScope.loginuser.empno}'">내 정보</button>
					<button class="dropdown-item" type="button" onclick="logout();">로그아웃</button>
				</div>
				
				<div class="dropdown my-4" id="commute-div">
				  <a class="btn btn-outline-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="width: 90%;margin: auto 5%;">
				    출근하기
				  </a>
				  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink" style="width: 90%;">
				    <div id="start_or_end"><a class="dropdown-item" id="start_work"><i class="fa-solid fa-laptop-file"></i>출근하기</a></div>
				  </div>
				</div>
				<div class="sideTr" onclick="javascript:location.href='<%= ctxPath%>/messenger/receivedMessage.yolo'">
					<i class="fas fa-regular fa-paper-plane sideIcon"></i><span>메신저</span><span class="badge badge-danger rounded-pill" style="margin-left: 60%">5</span>
				</div>
				<div class="sideTr" onclick="openAlarm()">
					<i class="fas fa-regular fa-bell sideIcon"></i><span>새로운 소식</span><span class="badge badge-danger rounded-pill" style="margin-left: 50%">5</span>
				</div>
			</div>
			
			<div id="sideMiddle" class="border-bottom">
				<div class="sideTr" onclick="javascript:location.href='<%= ctxPath%>/notice/noticeList.yolo'">
					<i class="fas fa-regular fa-flag sideIcon"></i><span>공지사항</span>
				</div>
				<div class="sideTr" onclick="javascript:location.href='<%= ctxPath%>/people.yolo'">
					<i class="fas fa-solid fa-users sideIcon"></i><span>구성원</span>
				</div>
				<div class="sideTr" onclick="javascript:location.href='<%= ctxPath%>/schedule/calendar.yolo'">
					<i class="fas fa-regular fa-calendar-check sideIcon"></i><span>캘린더</span>
				</div>
				<div class="sideTr" onclick="javascript:location.href='<%= ctxPath%>/commute/mycommute.yolo'">
					<i class="fas fa-regular fa-clock sideIcon"></i><span>출퇴근</span>
				</div>
				<div class="sideTr" onclick="javascript:location.href='<%= ctxPath%>/leaveSummary.yolo'">
					<i class="fas fa-solid fa-plane sideIcon"></i><span>휴가</span>
				</div>
				<div class="sideTr" onclick="javascript:location.href='<%= request.getContextPath()%>/workflow.yolo'">
					<i class="fas fa-solid fa-pen-nib sideIcon"></i><span>워크플로우</span>
				</div>
				<div class="sideTr" onclick="javascript:location.href='<%= ctxPath%>/admin/payStub.yolo'">
					<i class="fas fa-solid fa-dollar-sign sideIcon"></i><span>급여</span>
				</div>
				<c:if test="${sessionScope.loginuser.empno == '9999'}">
				<div class="sideTr" onclick="javascript:location.href='<%= ctxPath%>/admin/severance_pay.yolo'">
	               <i class="fas fa-solid fa-comments-dollar sideIcon"></i><span>퇴직금</span>
	            </div>
	            </c:if>
				<div class="sideTr" onclick="javascript:location.href='<%= ctxPath%>/insight.yolo'">
					<i class="fas fa-solid fa-chart-pie sideIcon"></i><span>인사이트</span>
				</div>
			</div>
			
			<div id="sideBottom">
				<div class="sideTr mt-1" style="height: 70px;">
					<div id="prof" style="background-color: #d8c5e2;"><i class="fas fa-solid fa-school sideIcon" style="width: 30px; margin: auto;"></i></div>
					<span class="ml-2">쌍용교육센터</span>
				</div>
			</div>
			
			<!-- <div id="commute-kind-category" class="border bg-white" style="position: relative; left: 265px; top:-710px; width: 100px;">
		  		<div><span style="margin-right: 10px"><i class="fa-solid fa-building"></i></span><span>근무</span></div>
		  		<div>외근</div>
		  		<div>출장</div>
		  	</div> -->
		  	
			
		</div>
		
		
<%@ include file="../../views/admin/jihyun/alarm/alarmModal.jsp" %>


