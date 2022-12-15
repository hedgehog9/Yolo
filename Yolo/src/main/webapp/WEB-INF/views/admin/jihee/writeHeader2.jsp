<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>

<style type="text/css">
a.link:link {color: #cccccc;}
a:visited {text-decoration: none; color: #cccccc;}
a.link:hover {text-decoration: none; color: gray;}
a.mylink:hover {text-decoration: none; }
a:active {text-decoration: none; color: #cccccc;}

	button.headerBtn {
		border-radius: 0.5rem;
		border: 1px solid gray;
		background: linear-gradient( to left ,#5bd3ff, #88eb1e );
		margin-left:75%;
		width: 100px;
		height: 45px;
		border: none;
		color: white;
		font-weight: bold;
	}
	

</style>    

<script type="text/javascript">

	function goWrite() {
			
		//줄바꿈 저장
		  const frm = document.wirteFrm;
          frm.method = "POST";
          frm.action = "<%= ctxPath%>/workflow/writeEnd.yolo";
          frm.submit();
		
	}

</script> 

<div style="display: flex; padding-top: 30px; padding-left: 30px; padding-bottom: 40px;]" class="border-bottom">
	 <span ><a class="mylink" href="javascript:location.href='<%= request.getContextPath()%>/workflow/selectWrite.yolo'" style="color: #404040; font-size: 23pt; font-weight: bold; padding-right: 20px;"><</a></span>
	 <span style="color:#404040; font-size: 23pt; font-weight: bold;" onclick="javascript:location.href='<%= request.getContextPath()%>/workflow/selectWrite.yolo'">작성하기</span>
	<button type="button" class="headerBtn" onclick="goWrite();">
		<i class="bi bi-send" style="margin-right: 10px;"></i>
		 보내기
	</button>
</div >


<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">