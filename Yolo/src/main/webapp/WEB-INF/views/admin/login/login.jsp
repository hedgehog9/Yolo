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
       background: -webkit-linear-gradient(to left ,#88eb1e, #5bd3ff);
       background:    -moz-linear-gradient(right, #88eb1e, #5bd3ff);
       background:      -o-linear-gradient(right, #5b#88eb1e, #5bd3ff);
       background:         linear-gradient(to right, #88eb1e, #5bd3ff);
       -webkit-background-clip: text;
               background-clip: text;
       color: transparent;
       font-size: 25pt;
       font-weight: 800;
   }

.title {
	
   font-size: 25pt;
   font-weight: bold;
   color: gray;
}  

 input:focus {
	outline : none;
} 

input#search {
		border-radius: 0.5rem;
		border: none;
		width: 310px;
		height: 40px;
/* 		font-weight: bold; */
		font-size: 12pt;
		float: right;
		display: flex;
		margin-left : 15px;
		margin-top: 5px;
	}

div#text {
		border-radius: 0.5rem;
		border: 1px solid #b3b3b3;
		width: 380px;
		height: 55px;
		font-weight: bold;
		font-size: 13pt;
		padding-left: 15px;
		margin-top: 10px;
		text-align: left;
		display: flex;
}	
	

input::placeholder {
  color: #b3b3b3;
  font-size: 10pt;
}

.icon {

	olor: #666666; 
	font-size: 13pt; 
	padding-top: 12px; 
	font-weight: bold;

}
/* div#search:active{

	border : 2px solid #66cc66;
} */

button.headerBtn {
		border-radius: 0.5rem;
		border: 1px solid gray;
		background: linear-gradient( to left ,#5bd3ff, #88eb1e );
		width: 380px;
		height: 55px;
		border: none;
		color: white;
		font-weight: bold;
	}

div#findPW:hover {

	background-color: #efefef;
	cursor: pointer;
	border-radius: 0.5rem;

}	

#findPW {

	margin-top: 25px;
	font-size: 12pt;
	color : #00b300;
	font-weight: bold;
	padding-top: 10px;
	padding-bottom: 10px;
}	


</style>

<script type="text/javascript">

 	$(document).ready (function(){
	
 		
 	
 	 	$('div.borderID').click(function(){
	          $(this).css("border", "2px solid #66cc66");
	          $("div.borderPW").css("border", "1px solid #b3b3b3");
	        }); 
 	 	
 	 	$('div.borderPW').click(function(){
 	 		 $(this).css("border", "2px solid #66cc66");
	          $("div.borderID").css("border", "1px solid #b3b3b3");
	        }); 
		
	});
	
 
	function goFindPW() {
		
		const frm = document.loginFrm;
		frm.method="get";
		frm.action="<%= ctxPath%>/findPW.yolo";
		frm.submit();
		
	}
	
</script>

<div class="inner">
	<form name="loginFrm">	
		<div style="margin-bottom: 25px;">
			<span class="gradtext">새로운 HR의 시작 </span>
			<span class="title">yolo</span>
		</div>
		<div class="borderID" id="text">
			<span class="icon"><i class="bi bi-envelope"></i></span>
		 	<input placeholder="이메일 주소 " name="userid" id="search"/>
		</div>
		<div class="borderPW" id="text">
			<span class="icon"><i class="bi bi-key"></i></span>
		 	<input placeholder="비밀번호" name="pw" id="search"/>
		</div>
		<div style="margin-top: 20px;">
			<button type="button" class="headerBtn" onclick="javascript:location.href='<%= request.getContextPath()%>/messenger/sendedMassage.yolo'">
			 로그인하기
			</button>
		</div>
		<div id="findPW" onclick="goFindPW();">
			비밀번호를 잊으셨나요?
		</div>
		
	</form>	

</div>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">