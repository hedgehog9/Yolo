<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<% String ctxPath = request.getContextPath(); %>

<style type="text/css">

	* {font-family: 'Pretendard', sans-serif; !important}
    
.inner {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%,-50%);
  text-align: center;
}

.gradtext {
       background: #55ffaa;
       background: -webkit-linear-gradient(to left ,#ff751a, #ff4da6);
       background:    -moz-linear-gradient(right, #ff751a, #ff4da6);
       background:      -o-linear-gradient(right, #ff751a, #ff4da6);
       background:         linear-gradient(to right, #ff751a, #ff4da6);
       -webkit-background-clip: text;
               background-clip: text;
       color: transparent;
       font-size: 22pt;
       font-weight: 800;
   }

.info {
 	font-size: 11pt;
 	color : #999999;
 	margin-bottom: 0px;


}   
.id {
	font-size: 11pt;
 	color : #4d4d4d;
 	font-weight: bold;

}

button.headerBtn {
		border-radius: 0.5rem;
		border: 1px solid #b3b3b3;
		width: 160px;
		height: 40px;
		color: #4d4d4d;
		font-weight: bold;
		font-size: 11pt;
		background-color: white;
		margin-bottom: 20px;
	}
		

button.goback {
		border-radius: 0.5rem;
		border: none;
		width: 120px;
		height: 40px;
		color: #8c8c8c;
		font-weight: bold;
		font-size: 11pt;
		background-color: white;
		margin-bottom: 30px;
	}
	
button:hover {

	background-color: #efefef;
	cursor: pointer;
	border-radius: 0.5rem;

}	
	

 


</style>

<script type="text/javascript">

 	$(document).ready (function(){
	
 		
 	

		
	});
	
 

	
</script>

<div class="inner">
	
	<div style="margin-bottom: 10px;">
		<span class="gradtext">이메일을 확인해주세요. </span>
	</div>
	<div style="margin-bottom: 30px;">
		<span class="info">비밀번호 재설정 메일을 <span class="id">${requestScope.userid}</span>로 보냈어요.<br>
		혹시 이메일이 오지 않았나요? 스팸함을 확인하거나 다시 받아보세요.
		</span>
	</div>
	<div>
		<button type="button" class="headerBtn" onclick="#">
		<i class="bi bi-arrow-clockwise"></i> 이메일 다시 보내기 
		</button>
	</div>
	<button type="button" class="goback" onclick="javascript:location.href='<%= request.getContextPath()%>/login.yolo'">
		이전으로 돌아가기
	</button>
	
		

</div>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">