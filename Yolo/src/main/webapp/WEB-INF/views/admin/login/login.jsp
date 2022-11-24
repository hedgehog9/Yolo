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
       font-size: 32pt;
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
		width: 350px;
		height: 50px;
/* 		font-weight: bold; */
		font-size: 13pt;
		float: right;
		display: flex;
		margin-left : 20px;
		margin-top: 9px;
		font-weight: bold;
	}

div#text {
		border-radius: 0.5rem;
		border: 1px solid #b3b3b3;
		width: 410px;
		height: 70px;
		font-weight: bold;
		font-size: 13pt;
		padding-left: 15px;
		margin-top: 10px;
		text-align: left;
		display: flex;
}	


div#borderID {
		border-radius: 0.5rem;
		border: 2px solid #66cc66;
		width: 410px;
		height: 70px;
		font-weight: bold;
		font-size: 13pt;
		padding-left: 15px;
		margin-top: 10px;
		text-align: left;
		display: flex;
}	

	

input::placeholder {
  color: #b3b3b3;
  font-size: 13pt;
}

.icon {

	color: #666666; 
	font-size: 17pt; 
	padding-top: 18px; 
	font-weight: bold;

}
/* div#search:active{

	border : 2px solid #66cc66;
} */

button.headerBtn {
		border-radius: 0.5rem;
		border: 1px solid gray;
		background: linear-gradient( to left ,#5bd3ff, #88eb1e );
		width: 410px;
		height: 70px;
		border: none;
		color: white;
		font-weight: bold;
		font-size : 13pt;
	}

div#findPW:hover {

	background-color: #efefef;
	cursor: pointer;
	border-radius: 0.5rem;

}	

#findPW {
	margin-top: 25px;
	font-size: 13pt;
	color : #00b300;
	font-weight: bold;
	padding-top: 10px;
	padding-bottom: 10px;
}	

.continue {

	width: 70px;
	height: 50px;
	margin: 0px;
	border: 1px solid green;
	background: #00b300;
	color: white;
	border-radius: 0.5rem;
	font-size: 11pt;
	font-weight: white;
}
#continue {

	width: 60px;
	height: 45px;
	margin: 7px 10px 2px 10px;
	border: 1px solid green;
	background: #00b300;
	color: white;
	border-radius: 0.5rem;
	font-size: 11pt;
	font-weight: white;
}

</style>

<script type="text/javascript">

 	$(document).ready (function(){
	
 		/* $("input.userid").focus();	 */
 		/* $("button#continue").hide(); */
 	
 		//input 클릭시 색 바꾸기
 	 	$("div.borderID").click(function(){
	          $(this).css("border", "2px solid #66cc66"); 
	        }); 

 	 	    
 	 	//아이디 입력시  다음창들 나타남
 	    $("input.userid").bind("keyup", function(e) {
 	    	
 	    	goContents();
 	
			   
	   });
 	 	
	
		
	});
	
 	// 비밀번호 찾기
	function goFindPW() {
		
		const frm = document.loginFrm;
		frm.method="POST";
		frm.action="<%= ctxPath%>/findPW.yolo";
		frm.submit();
		
	}
	
 	// 로그인하면 공지사항으로 가기
	function goNotice() {
		
		location.href="<%= request.getContextPath()%>/notice/noticeList.yolo";
	} http:
	
	// 아이디치면 나머지 contents 보이기
	function goContents() {
		  
		  $.ajax({
			  url:"<%= request.getContextPath()%>/loginpw.yolo",
			  data:{},
			  type:"POST",
			  dataType:"JSON",
			  success:function(json){
				  
			
				  

				  let html = "";

					  html += 
						"<div class='borderPW' id='text'>"+
							"<span class='icon'><i class='bi bi-key'></i></span>"+
						 	"<input placeholder='비밀번호' name='pw' id='search'/>"+
						"</div>"+
						"<div style='margin-top: 20px;'>"+
							"<button type='button' class='headerBtn' onclick='goNotice();'>"+
							"로그인하기"+
							"</button>"+
						"</div>"+
						"<div id='findPW' onclick='goFindPW();'>"+
							"비밀번호를 잊으셨나요?"+
						"</div>";	
					
				  $("div#userpw").html(html);
				  
				  $("div.borderID").click(function(){
			          $(this).css("border", "2px solid #66cc66");
			          $("div.borderPW").css("border", "1px solid #b3b3b3");  
			        }); 
		 	 	
		 	 	
		 	 	$("div.borderPW").click(function(){
		 	 		 $(this).css("border", "2px solid #66cc66");
			         $("div.borderID").css("border", "1px solid #b3b3b3"); 
			        });
			  },
			  error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		  });
		  
	  }// end of function goContents()--------------------------- 
	
	
	
</script>

<div class="inner">
	<form name="loginFrm">	
		<div style="margin-bottom: 25px;">
			<span class="gradtext">새로운 HR의 시작 </span>
			<span class="title">yolo</span>
		</div>
		<div class="borderID" id="borderID">
			<span class="icon"><i class="bi bi-envelope"></i></span>
		 	<input placeholder="이메일 주소 " name="userid" id="search" class="userid" autocomplete='off'/>
		</div>
		<div id="userpw">
		</div>		
	</form>
</div>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">