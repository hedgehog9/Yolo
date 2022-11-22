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
		margin-left:60%;
		width: 170px;
		height: 45px;
		border: none;
		color: white;
		font-weight: bold;
	}
	
	input#search {
		border-radius: 0.5rem;
		border: 1px solid gray;
		margin-left:60%;
		width: 200px;
		height: 30px;
		font-weight: bold;
		font-size: 10pt;
		padding-left: 10px;
		margin-top: 15px;
	
	}
	
	input:focus {
		outline : 1px solid #66cc66;
	}
	
	div#search{
	
	  width: 200px;
	  height: 30px;  
	  border: none;
	  align-items: center;
	
	}
	
	
</style>    
    
<div style="display: flex; padding-top: 30px; padding-left: 30px; padding-bottom: 20px;]" class="border-bottom">
	 <span ><a class="mylink" href="javascript:location.href='<%= request.getContextPath()%>/workflow.yolo'" style="color: #404040; font-size: 23pt; font-weight: bold; padding-right: 20px;"><</a></span>
	 <span style="color:#404040; font-size: 23pt; font-weight: bold; margin-right: 650px; cursor:pointe;" >작성하기</span>
	 <div id="search">
	 	<input id="search" placeholder="양식검색 " />
	 </div>
</div >


<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">