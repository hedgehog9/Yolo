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
		margin-left:65%;
		width: 170px;
		height: 45px;
		border: none;
		color: white;
		font-weight: bold;
	}
	
	
</style>    
    
<div style="display: flex; padding-top: 35px; padding-left: 40px; padding-bottom: 35px;]">
	 <span><a class="mylink" href="javascript:location.href='<%= request.getContextPath()%>/workflow.yolo'"style="color: black; font-size: 27pt; font-weight: bold; padding-right: 20px;">내 문서함</a></span>
	 <span><a class="link" href="javascript:location.href='<%= request.getContextPath()%>/cpWorkflow.yolo'" style=" font-size: 27pt; font-weight: bold;">회사 문서함</a></span>
	<button type="button" class="headerBtn" onclick="javascript:location.href='<%= request.getContextPath()%>/workflow/selectWrite.yolo'">
		<i class="bi bi-pencil-fill"></i>
		 작성하기
	</button>
</div>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">