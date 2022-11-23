<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>

<style type="text/css">
a.link:link {color: #cccccc;}
a:visited {text-decoration: none; color: #cccccc;}
a.link:hover {text-decoration: none; color: gray;}
a.mylink:hover {text-decoration: none; }
a:active {text-decoration: none; color: #cccccc;}

/* 	
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
	
	} */
	
	input:focus {
		outline : none;
	}
	
	
	.mylink:hover {
	background-color: #efefef;
	border-radius: 0.5rem;	
	}
	
div#text {
		border-radius: 0.5rem;
		border: 1px solid #b3b3b3;
		width: 220px;
		height: 35px;
		font-weight: bold;
		font-size: 13pt;
		padding-left: 0px;
		margin-top: 10px;
		text-align: right;
		display: flex;
}	

input#search {
		border-radius: 0.5rem;
		border: none;
		width: 160px;
		height: 30px;
/* 		font-weight: bold; */
		font-size: 12pt;
		float: left;
		display: flex;
		margin-left : 8px;
		margin-right: 18px;
		margin-top: 1px;
	}

input::placeholder {
  color: #b3b3b3;
  font-size: 10pt;
}

.icon {

	color: #666666; 
	font-size: 13pt;  
	font-weight: bold;
	margin-top: 5px;

}
	
</style>   

<script type="text/javascript">

 	$(document).ready (function(){
	
 		
 	
 	 	$('div.searchWord').click(function(){
	          $(this).css("border", "2px solid #66cc66");
	        }); 
 	 	
 	 	$(document).click(function() {
 	 	    var searchWord = $("div.searchWord");
 	 	    if (!searchWord.is(event.target) && !searchWord.has(event.target).length) {
 	 	    	$("div.searchWord").css("border", "1px solid #b3b3b3");
 	 	    }
 	 	});
 	 	

		
	});
	
 

</script> 
    
<div style="display: flex; padding-top: 30px; padding-left: 30px; padding-bottom: 20px;]" class="border-bottom">
	 <span ><a class="mylink" href="javascript:location.href='<%= request.getContextPath()%>/workflow.yolo'" style="color: #404040; font-size: 23pt; font-weight: bold; padding-right: 20px;"><</a></span>
	 <span style="color:#404040; font-size: 23pt; font-weight: bold; margin-right: 65%; cursor:pointe;" >작성하기</span>
	 <!-- <div id="search">
	 	<input id="search" placeholder="양식검색 " />
	 </div> -->
	 <form name="searchFrm">
	 <div class="searchWord" id="text">
	 	<input placeholder="양식검색 " name="searchWord" id="search"/>
		<span class="icon" onclick="goSearch();"><i class="bi bi-search"></i></span>
	</div>
	</form>
</div >


<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">