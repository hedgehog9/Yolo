<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath();%>    


<style>
	 div#peopleContent{
    	margin-right:10px;
    }
    
    div#header{
    	display:flex;
    	justify-content: space-between;
    	border-bottom: solid 1px #d9d9d9;
    	margin-bottom: 50px;
    }
    
    span.title{
        font-size: 28px;
        margin-right:20px;
        font-weight: 700;
        letter-spacing:-1.12px;
    }

    div#header_title, div#button_title{
        margin: 35px 20px 20px 20px;
    }
    
    button#change_dept{
    	background-color: #66cc66;
    	color: white;
    }
    
    button.edit_memo{
    	width:30px;
    	height:30px;
    	margin-top:10px;
    }
     <%-- --%>
    button.edit_memo:hover{
    	background-color: #d9d9d9;
    }
    
     <%-- --%>
    div.memo{
    	margin-top: 15px;
    	background-color: #ebebeb;
    	border-radius: 10px;
    }
     <%-- --%>
    div.div_name{
    	height:50px;
    }
    <%--  --%>
    i.edit{
    	position: relative;
	    top: -4px;
	    left: -6px;
    }
    
    div.result_one{
    	margin: 20px 0;
    	display:flex; 
    	justify-content: space-between;
    }
    
    div.div_label{
    	font-size:15px;
    	font-weight:700;
    	line-height: 15px;
    	color:#242A30;
    }
    table#tbl_history > tbody > tr > td{
    	vertical-align: middle;
    }
    
    i.fa-check{
    	margin-right:10px;
    }
    button.changeOk{
    	background-color:#00BB35; 
    	color:white;
    }
    
    button.choice_type{
    	background-color: white; 
    	padding: 3px 0px 3px 5px; 
    	border: solid 1px #d9d9d9; 
    	border-radious: 10px;"
    }
    
    textarea.memo{
    	width:460px;
    	border-radius: 10px;
    	border: solid 1px #d9d9d9;
    	padding: 5px;
    }
    
    button.btn_label, 
    button.btn_dept, 
    button.btn_detail_dept
    {
    	width:460px;
    }
    
   	input#appointment_date{
   		width: 100%;
   		height:34px;
   		border: solid 1px #d9d9d9;
   		border-radius: 5px;
   	}
   	textarea#textarea_memo{
   		height: 300px;
	    width: 100%;
	    border: solid 1px #d9d9d9;
		resize: none;
   	}
   	
   	textarea:focus,
   	input:focus {
		outline-color: #07B419;
	}
	.btn:focus{
		border: solid 1px #07B419;
	}
   	
   	<%-- header a?????? css  --%>
	a.a_title{
		font-size: 28px;
		font-weight: 700;
		letter-spacing: -1.12px;
		text-decoration: none solid rgb(60, 70, 81);
		word-spacing: 0px;
		color: #cdd2d6;
	}
	a.a_title:hover{
		text-decoration: none;
		color: #9e9e9e;
	}
	a.a_title:link, a.a_title:visited, a.a_title:active {
		text-decoration: none;
		color: #9e9e9e;
	}
	a.current,a.current:hover {
		text-decoration: none;
		color : #3C4651;
	}
	
	div#peopleContent {
	margin-right: 10px;
}

div#header {
	border-bottom: solid 1px #d9d9d9;
	display: flex;
	justify-content: space-between;
}

span.title {
	font-size: 28px;
	margin-right: 20px;
	font-weight: 700;
	letter-spacing: -1.12px;
}

div#header_title, div#button_title {
	margin: 35px 20px 20px 20px;
}

button#registMember {
	background: linear-gradient( to left ,#5bd3ff, #88eb1e );
	color: white;
}

tr {
	font-size: 10pt;
}

.th_200 {
	width: 200px;
}

.th_150 {
	width: 150px;
}

.th_100 {
	width: 100px;
}

.th_50 {
	width: 50px;
}

<%-- ?????? ?????? ????????? css --%> div.profile_icon {
	width: 30px;
	height: 30px;
	border-radius: 40%;
	/* background-color: #239afe; */
	color: white;
	text-align: center;
	padding-top: 6px;
	border: 1px solid #ccced0;
	font-weight: bold;
	margin: auto 8px;
	font-size: 5pt;
}

<%-- ???????????? ????????? css --%> div.profile_icon2 {
	width: 50px;
	height: 50px;
	border-radius: 40%;
	background-color: #239afe;
	color: white;
	text-align: center;
	padding-top: 6px;
	border: 1px solid #ccced0;
	font-weight: bold;
	margin: auto 8px;
	font-size: 15px;
}

div.profile_icon2>div {
	margin-top: 3px;
}

div.profile, div.profile2 {
	display: flex;
	justify-content: start;
}

<%-- ????????????, ????????? ??????, ???????????? ?????? css --%> 
div#search_buttons {
	display: flex;
	justify-content: end;
	border-bottom: solid 1px #d9d9d9;
	padding: 10px 20px;
}

button.btn_search:hover {
	background-color: #ebebeb;
}

div#div_toggle_buttons {
	background-color: #ebebeb;
	padding: 3px;
	border-radius: 5px;
}

button.btn_view_style:focus {
	outline: none;
}

<%--
????????? input ?????? css --%> input.input_search {
	border: none;
	border-top-right-radius: 10px;
	border-bottom-right-radius: 10px;
}

input.input_search:focus {
	outline: none;
}

div#div_search {
	border: solid 2px #07B419;
	border-radius: 10px;
	height: 30px;
	padding-left: 3px;
	margin-top: 8px;
	position: relative;
	left: 38px;
	display: none;
}

.hidden {
	opacity: 0;
	pointer-events: none;
}

div.dept_position {
	background-color: #F8F9FA;
	padding: 10px;
	border-radius: 10px;
	margin-top: 3px;
}

div.dept_position>span {
	color: #556372;
}

div.dept_position>span:nth-child(2) {
	color: #CDD2D6;
}

div.div_name2 {
	font-size: 20px;
	font-weight: 500;
	color: #242A30;
	line-height: 14px;
	margin-top: 15px;
}

div.div_empInfo:hover {
	background-color: #F8F9FA;
}

#search_result > table > tbody > tr > td{
	height: 55px;
	padding: 0;
	vertical-align: middle;
}

<%-- ????????? ?????? ????????? ?????????, ?????? ?????? css --%> 
button.org_btn:hover {
	background-color: #ebebeb;
}

<%--
???????????? ?????? ????????? ????????? ?????? --%> 
div#org_buttons {
	display: flex;
	justify-content: flex-end;
}

<%--
?????? ?????? ?????? css ??????  --%> <%-- ????????? ???????????? ?????? css --%> 
button#regist_member_btn {
	height: 50px;
	width: 100%;
	border-radius: 10px;
	color: white;
	background-color: #07B419;
}

div#title {
	font-size: 20pt;
	font-weight: 600;
	text-align: center;
	margin: 100px 0 50px 0px;
}

input.input_modal, button.choice_type {
	width: 100%;
	line-height: 30px;
	border-radius: 10px;
	padding: 5px;
	border: solid 1px #d9d9d9;
}

input.input_modal:focus {
	outline-color: #07B419;
}

button.choice_type:active, button.choice_type:focus {
	border: solid 1px #07B419;
}

button#regist_member_btn>i {
	padding-right: 10px;
}

div.regitst_title {
	padding: 0 0 3px 5px;
}

<%--
form#regist_frm  div.show {
	top: 0px;
	left: 10px;
	will-change: transform;
	border-radius: 10px;
	width: 458px;
}
--%>
<%-- ?????? ?????? ?????? css ??? --%>

<%-- header a?????? css  --%>
a.a_title{
	font-size: 28px;
	font-weight: 700;
	letter-spacing: -1.12px;
	text-decoration: none solid rgb(60, 70, 81);
	word-spacing: 0px;
	color: #cdd2d6;
}
<%-- color : #3C4651; --%>
a.a_title:hover{
	text-decoration: none;
	color: #9e9e9e;
}
a.a_title:link, a.a_title:visited, a.a_title:active {
	text-decoration: none;
	color: #9e9e9e;
}
a.current,a.current:hover {
	text-decoration: none;
	color : #3C4651;
}
div#search_result{
	width: 95%;
	margin: 0 auto;
}

th,td{
	text-align: center;
	font-size: 14px;	
}

<%-- ???????????? div css --%>
div#div_searchTag{

	border-bottom: solid 1px #d9d9d9;
	padding: 10px 16px;
	display: flex;
	justify-content: space-between;
	
}

div#serchTag_content{
	display: flex;
    align-items: center;
}

<%-- ??????????????? ?????? css --%>
button.filter_clear{
	color:#3C4651;
	font-weight:700;
	font-size:13px;
	background-color: #ebebeb;
}
<%-- ?????? ?????? ?????? css --%>
button#add_searchTag{
	border: solid 1px #d9d9d9;
	padding: 0 5px 0 0 ;
    color: #9e9e9e;
}

span#result_cnt{
	margin-right:10px;
}

<%-- dropdown level 2 css (???????????? ??????) --%>
.dropdown-menu li {
position: relative;
}
.dropdown-menu .dropdown-submenu {
display: none;
position: absolute;
left: 100%;
top: -7px;
}
.dropdown-menu .dropdown-submenu-left {
right: 100%;
left: auto;
}
.dropdown-menu > li:hover > .dropdown-submenu {
display: block;
}

<%-- ?????? ?????? span ?????? css --%>
span.span_tag{
    border : solid 1px #d9d9d9;
    padding: 3px;
    border-radius: 5px;
    color: #9e9e9e;
    margin-right: 5px;
}
button.closeTag{
	background-color: transparent;
    border: none;
}


<%-- ???????????? css ?????? --%>
ul.ul_pagebar{
	list-style:none; 
	margin:0 auto;
	width:700px;
	display: flex;
	align-items: baseline;
	padding: 0;
	justify-content: center;
}


li.li_pagebar{
	display: inline-block;
    padding-top: 9px;
    width: 40px;
    height: 40px;
    text-align: center;
    font-weight: 700;
}

li.li_pagebar > a{
	text-decoration: none;
	font-size: 14px;
	color:#2ecc71;
}

li.li_currentpage{
	background-color: #2ecc71;
    color: white;
    font-weight: 700;

    display: inline-block;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    text-align: center;
    vertical-align: middle;
    padding-top: 9px;
}

.dropdown-toggle::after {
    display: none;
    margin-left: 0.255em;
    vertical-align: 0.255em;
    content: "";
    border-top: 0.3em solid;
    border-right: 0.3em solid transparent;
    border-bottom: 0;
    border-left: 0.3em solid transparent;
}

li.li_moveOne{
	display: inline-block;
    width: 100px;
    font-size: 12pt;
    text-align: center;
    padding: 6px;
    border-radius: 100px;
    color: white;
    border: solid 3px #2ecc71;
    margin: 0 10px;
}

li.li_moveOne > a{
	color:#2ecc71;
	text-decoration: none;
}

li.li_moveAll{
	background-color: #2ecc71;
    font-weight: 700;
    border-radius: 50%;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    text-align: center;
    vertical-align: middle;
    padding-top: 9px;
}

li.li_moveAll > a{
	color: white;
	text-decoration: none;
	display: inline-block;
}


	
		
    
</style>

<script>
	
	$(document).ready(function(){
		
		<%-- ===== ?????? ????????? ?????? ?????? =====  --%>
		$("input.daterange").daterangepicker({
            "singleDatePicker": true,
            "locale": {
                "format": "YYYY-MM-DD", // ???????????? ??????
                "separator": " - ",
                "applyLabel": "??????",
                "cancelLabel": "??????",
                "fromLabel": "From",
                "toLabel": "To",
                "customRangeLabel": "Custom",
                "weekLabel": "W",
                "daysOfWeek": ["???","???","???","???","???","???","???"],
                "monthNames": ["1???","2???","3???","4???","5???","6???","7???","8???","9???","10???","11???","12???"],
                "firstDay": 1
            }
        });
		<%-- ===== ?????? ????????? ?????? ??? =====  --%>
		
	}); // end of document.ready()----------------------------------------------------
	
	<%-- bootstrap ?????? --%>
	$(function () {
		$('[data-toggle="tooltip"]').tooltip()
	});
	
	let currentShowPageNo = 1;
	arr_position = [];
	arr_dept = [];
	arr_status = [];

		$(document).ready(function(){
			
			makeCommentPageBar(currentShowPageNo);
			
			<%-- bootstrap ?????? --%>
			$(function () {
				$('[data-toggle="tooltip"]').tooltip();
			});
			<%-- bootstrap ???????????? multi level --%>
			$('.dropdown-toggle').dropdown();
			
			<%-- ===== ?????? ????????? ?????? ?????? =====  --%>
			$("input.daterange").daterangepicker({
	            "singleDatePicker": true,
	            "locale": {
	                "format": "YYYY-MM-DD", // ???????????? ??????
	                "separator": " - ",
	                "applyLabel": "??????",
	                "cancelLabel": "??????",
	                "fromLabel": "From",
	                "toLabel": "To",
	                "customRangeLabel": "Custom",
	                "weekLabel": "W",
	                "daysOfWeek": ["???","???","???","???","???","???","???"],
	                "monthNames": ["1???","2???","3???","4???","5???","6???","7???","8???","9???","10???","11???","12???"],
	                "firstDay": 1
	            }
	        });
			<%-- ===== ?????? ????????? ?????? ??? =====  --%>
			
			// ?????? ?????? ????????? 
			$(document).on("click","button#btn_search",function(){
				$("div#div_search").css("display","block");	
				$("button#btn_search").addClass("hidden");
				$("input#searchWord").focus();
			});
			// ?????? div ?????? ?????? ????????? ?????? ???????????? ?????? div ?????????
			$('html').click(function(e) {   
				let searchWord = $("input#searchWord").val();
				if($(e.target).parents('div#div_search').length < 1 && searchWord.trim() == "" ){  
					$("div#div_search").css("display","");	
					$("button#btn_search").removeClass("hidden");
				}
			});
			// ?????????????????? ????????? ????????? 
			$(document).on("keyup","input#searchWord",function(){
				viewEmpList(currentShowPageNo);
				
			})// end of $(document).on("keyup","input#searchWord",function(){}------
			
						
			viewEmpList(1);
			
			// ???????????? ?????? ????????? (?????? ?????????????????? ????????? ?????? ??????, ???????????? ?????? x )
			$(document).on("click","a.dropdown-item",function(e){
				
				let flag = true;
				
				let searchWord = $(e.target).text();
				let searchType = $(e.target).find("input").val();
				
				if(searchType == undefined){
					return;
				}
				
				$("span.span_tag").each(function(index,item){
					let val = $(this).text();
					if(searchType == val.substr(-2) && searchWord == val.substr(0,val.indexOf("|"))){
						flag = false;
						return;
					}
				})
				
				if(flag){
					$("button#add_searchTag").parent().find("span#span_searchTag").append("<span class='span_tag'>"+searchWord+"|<span style='color:#3C4651;'>"+searchType+"</span><button class='closeTag'><i style='color:#9e9e9e; font-size:14px;' class='fas fa-times'></i></button></span>");

					switch (searchType)
					  {
					    case "??????" :    
					    	arr_position.push(searchWord);
					      break;     

					    case "??????" :    
					    	arr_dept.push(searchWord);
					      break;  
					      
					    case "??????" :    
					    	arr_status.push(searchWord);
					      break;   
					  }
				  	
				}// end of if(flag){}-----------------------------------------
				
				viewEmpList(currentShowPageNo);
				
			});
			
			// ??????????????? ?????? ?????? ?????? ?????????(?????? ?????????)
			$(document).on("click","button.closeTag",function(e){
				let searchWord = $(this).parent().text();
				searchWord = searchWord.substr(0,searchWord.indexOf("|"));
				
				let searchType =  $(this).parent().text();
				searchType = searchType.substr(-2);
				
				switch(searchType) {
				    case "??????" :
				    	arr_position.splice(arr_position.indexOf(searchWord),1);
						// console.log(arr_position);
				      break;     

				    case "??????" :    
				    	arr_dept.splice(arr_dept.indexOf(searchWord),1);
						// console.log(arr_dept);
				      break;  
				      
				    case "??????" :    
				    	arr_status.splice(arr_status.indexOf(searchWord),1);
						// console.log(arr_status);
				      break;   
				  }
				
				$(this).parent().remove();
				
				viewEmpList(currentShowPageNo);
			});
			
			// ?????? ????????? ?????? ????????? 
			$(document).on("click","button#filter_clear",function(){
				$("span#span_searchTag").empty();
				arr_position.length = 0;
				arr_dept.length = 0;
				arr_status.length = 0;
				
				<%-- 
				console.log(arr_position);
				console.log(arr_dept);
				console.log(arr_status);
				--%>
				
				viewEmpList(currentShowPageNo);
				
			})// end of "click","buton.filter_clear"------------------------------------
			
			// ????????? ???????????? ?????? ????????? 
			$(document).on("click","button#registMember",function(){
				getDeptNameModal();
			})// end of $(document).on("click","button#registMember",function(){}-----------
			
			// ?????? ?????? ?????? ????????? 
			$(document).on("click","button.edit_memo",function(){
				let pk_psano = $(this).parent().find("input.pk_psano").val();
				let psa_memo = $(this).parent().find("input.psa_memo").val();
				
				$("textarea#textarea_memo").val(psa_memo);
				$("input#psano").val(pk_psano);
				
			});
					
			// ?????? ?????? ???????????? ?????? ?????? ?????? ??? 
			$("button#changememo").click(function(){
				const frm = document.frm_memo;
	 			frm.method="POST";
	 			frm.action="<%= ctxPath%>/changePsaMemo.yolo";
	 			frm.submit();
			});
					
		});// end of $(document).ready(function(){}------------------------------------------------
		
				
		//null??? ?????? 
		function isEmpty(value){
		    if(value == null || value.length === 0) {
		           return " ";
		     } else{
		            return value;
		     }
		}	
				
				
		// ?????? ?????? ????????? ?????? ???????????? ?????? ???????????? ?????????
		function getDeptName(){
			
			let html = "";
			
			$.ajax({
				 // ?????? ?????? ???????????? 
				  url : "<%= ctxPath%>/getDeptList.yolo",
				  dataType : "JSON",
				  success : function(json){
					  let html ='';
					  $.each(json,function(index,dept){
						  html += '<li id=li_'+dept.deptno+'><a class="dropdown-item" href="javascript:void(0);" onmouseover="getTeam('+dept.deptno+');"><input type="hidden" value="??????" />'+dept.deptname+'</a></li>'
						  
				    });// end of $.each(json,function(index,emp){}----------------------------
				    	
					$("ul#ul_dept").html(html);
					
				  },// end of success
				  error: function(request, status, error){
					  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				  }
			
			}); // end of ajax()----------------------------------------------------------------------
			
		}// end of function getDeptName(){}--------------------------------------		
				
		// ??????????????? ???????????? ??? ???????????? 
		function getTeam(deptno){
			 $.ajax({
				  url : "<%=ctxPath%>/getTeamList.yolo",
				  data:{"deptno":deptno},
				  dataType : "JSON",
				  success : function(json2){
					  let html ='<ul class="dropdown-menu dropdown-submenu">';
					  
					  $.each(json2,function(index,team){
					  		html += '<li><a class="dropdown-item" href="#"><input type="hidden" value="??????" />'+team.deptname+'</a></li>';
				    	});// end of $.each(json,function(index,emp){}----------------------------
				      html += '</ul>';
				      
				      $("li#li_"+deptno).append(html);
				      
				  },// end of success
				  error: function(request, status, error){
					  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				  }
			}); // end of ajax()----------------------------------------------------------------------
		}
		
		// ajax ?????????????????? ?????? ???????????? ?????????		
		function func_getEmpInfo(empno){ <%-- ??????????????? ?????? ?????? ?????? ?????? --%>
		 	<%-- ?????? ???????????? ?????? --%>
			location.href = "<%=ctxPath%>/userDetail.yolo?empno="+empno;
		}
		
		
		// ?????? ?????? ???????????? ????????? 
		function makeCommentPageBar(currentShowPageNo){
			<%-- === ????????? ?????? ????????? ??? ????????????(totalPage)??? ????????? ??????. === --%>
			
			let keyword = $("input#searchWord").val();
			
			$.ajax({
				url:"<%=request.getContextPath()%>/getTotalPsaPage.yolo",
				data:{"sizePerPage":"10"
					 ,"keyword":keyword
					 ,"arr_position":arr_position
					 ,"arr_dept":arr_dept
					 ,"arr_status":arr_status},
				type:"GET",
				dataType:"JSON", 
				success:function(json){
					// json ==>  {"totalPage":4} ?????? {"totalPage":0}
					if(json.totalPage > 0){// ????????? ?????? ?????? 
						
						const totalPage = json.totalPage;
						
						const blockSize = 10;
						
						let loop = 1; //loop??? 1?????? ???????????? 1??? ????????? ????????? ?????????????????? ??????[ ????????? 10???(== blockSize)] ????????? ???????????? ????????????.
				        
				        if( typeof currentShowPageNo == "string"){ // ???????????? ???????????? ????????????????????? ???????????? ????????? ????????? string ???????????? ??????????????? ??????????????? ???????????? ??????.
				        	currentShowPageNo = Number(currentShowPageNo);
				        }
				        
						// *** !! ????????? currentShowPageNo ??? ???????????? pageNo ??? ????????? ????????????. !! ***//
						let pageNo = Math.floor( (currentShowPageNo - 1)/blockSize ) * blockSize + 1;
						
						let pageBarHTML = "<ul class='ul_pagebar'>";
						
						// ==== [?????????] [??????] ????????? === // 
						if(pageNo != 1 ) {
							pageBarHTML +="<li class='li_moveAll li_pagebar' style='display:inline-block;'><a href='javascript:viewEmpList(\"1\")' > << </a></li>";
							pageBarHTML +="<li class='li_moveOne'><a href='javascript:viewEmpList(\""+(pageNo-1)+"\")' >Previous</a></li>";
						}
						while( !(loop > blockSize || pageNo > totalPage ) ) {
							
							if(pageNo == currentShowPageNo) { // ???????????? ???????????? ??????????????? ????????? ???????????? ????????? ?????? ?????? 
								pageBarHTML +="<li class='li_currentpage'>"+pageNo+"</li>";
							}
							else {
								pageBarHTML +="<li class='li_pagebar'><a href='javascript:viewEmpList(\""+pageNo+"\")' >"+pageNo+"</a></li>";
							}
							loop++;
							pageNo++;
						}// end of while()------------------------
						
						
						// ==== [??????] [?????????] ????????? === //
						if(pageNo <= totalPage) {
							pageBarHTML +="<li class='li_moveOne'><a href='javascript:viewEmpList(\""+pageNo+"\")' >Next</a></li>";
							pageBarHTML +="<li class='li_moveAll li_pagebar'><a href='javascript:viewEmpList(\""+totalPage+"\")' > >> </a></li>";
						}
						
						pageBarHTML +="</ul>";
					
						$("div#pageBar").html(pageBarHTML);
					}// end of if(json.totalPage > 0){}----------------------------------
					
				},
				error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }
				
			});
			
		}// end of function makeCommentPageBar(currentShowPageNo){}-----------------------
		
		// ????????? ????????? ?????? ?????? 
		function viewEmpList(currentShowPageNo){
			
			let keyword = $("input#searchWord").val();
			
			$.ajax({
				url:"<%=request.getContextPath()%>/psaListPaging.yolo",
				data:{"currentShowPageNo":currentShowPageNo
					 ,"keyword":keyword
					 ,"arr_position":arr_position
					 ,"arr_dept":arr_dept
					 ,"arr_status":arr_status},
				dataType:"JSON",
				success:function(json){
					
					$("div#search_result").empty();
					
					  let html ='<table id="tbl_history" class="table table-bordered table-hover" style="margin-top: 20px;">'
									+'<thead>'
									+'<tr>'
										+'<th>?????? ??????,??????</th>'
										+'<th>?????? ??? ??????</th>'
										+'<th>?????? ??? ??????</th>'
										+'<th>?????? ??? ??????</th>'
										+'<th>?????? ??? ??????</th>'
										+'<th>??????</th>'
										+'<th>????????????</th>'
									+'</tr>'
								+'</thead>'
							+'<tbody>';
					  $.each(json,function(index,psa){
						  $("span#result_cnt").text(psa.cnt+" ???");
						  html += '<tr>'
									  +'<td>'
										  +'<div class="div_name">'
										  +'<div class="div_label">'+isEmpty(psa.psa_label)+'</div>'							
										  +'<div class="div_label">'+isEmpty(psa.name)+'</div>'							
										  +'<div class="div_name">'+psa.psa_date+'</span></div>'						
										  +'</div>'
									  +'</td>'
									  +'<td>'+isEmpty(psa.before_deptname)+'</td>'
									  +'<td>'+isEmpty(psa.after_deptname)+'</td>'
									  +'<td>'+isEmpty(psa.before_position)+'</td>'
									  +'<td>'+isEmpty(psa.after_position)+'</td>'
									  +'<td>'+isEmpty(psa.memo)+'</td>'
									  +'<td>'
										  +'<span data-toggle="tooltip" data-placement="left" title="?????? ??????">'
										  +'<input class="pk_psano" type="hidden" value="'+psa.pk_psano+'" />'
										  +'<input class="psa_memo" type="hidden" value="'+psa.memo+'" />'
										  +'<button type="button" class="btn edit_memo" data-toggle="modal" data-target="#modal_change_memo" >'
										  +'<i class="fas fa-pen edit"></i>'
										  +'</button>'
										  +'</span>'
									  +'</td>'
								  +'</tr>';
							<%-- ================= ???????????? ????????? ?????? ??? ========== --%>
							
					    });// end of $.each(json,function(index,emp){}----------------------------
						
					    html +='</tbody>'   	
							 +'</table>';
							 
						 $("div#search_result").html(html);
					
					// ???????????? ?????? ??????
					makeCommentPageBar(currentShowPageNo);
				},
				error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }
			
			}); // end of $.ajax({})---------------------------------------
			
		}// end of function viewEmpList(currentShowPageNo){}----------------------------
			
		//null??? ?????? 
		function isEmpty(value){
		    if(value == null || value.length === 0) {
		           return "";
		     } else{
		            return value;
		     }
		}	
		
		
		// ?????? ?????? ???????????? ????????? 
		function registEmployee(){
			
			let regist_flag = true;
			
			let name = $("input[name='name']").val();
			let email = $("input[name='email']").val();
			let hire_date = $("input[name='hire_date']").val();
			let salary = $("input[name='salary']").val();
			let department = $("input[name='department']").val();
			let team = $("input[name='team']").val();
			let position = $("input[name='position']").val();
			
			
			if(name.trim() == "" || email.trim() == "" || hire_date.trim()==""|| salary.trim() == "" ||department.trim() == "" || position.trim() == "" ){
				regist_flag = false;
				alert("?????? ????????? ??????????????????");
			}
			
			let formValues = $("form[name=regist_frm]").serialize() ;
			
			if(regist_flag){ // ?????? ?????? ????????? ?????? 
				$.ajax({
					  url : "<%= ctxPath%>/registEmployee.yolo",
					  data : formValues,    
					  type : "POST",
					  dataType : "JSON",
					  success : function(json){
						  
						  if(json.duplicateEmail == 1){
							  alert('????????? ??????????????????.');
							  return;
						  }
						  else{
							  if(json.registResult == 1){
								  alert('?????? ??????!');
							  }
						  }
						  
					  },
					  error: function(request, status, error){
						  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					  }
				  }); // end of ajax{}-------------------
		  		
		  		}
				
			}
		
		// ?????? ???, ???????????? ???????????? ?????????(?????????)
		function getDeptNameModal(){
			
			let html = "";
			
			$.ajax({
				 // ?????? ?????? ???????????? 
				  url : "<%= ctxPath%>/getDeptList.yolo",
				  dataType : "JSON",
				  success : function(json){
					  let html ='';
					  $.each(json,function(index,dept){
						  html += '<button class="btn_label dropdown-item" type="button" onclick="getTeamModal('+dept.deptno+')"><input class="input_registValue" type="hidden" value='+dept.deptno+'>'+dept.deptname+'</button>';
						  
				    });// end of $.each(json,function(index,emp){}----------------------------
				    	
					$("div#div_dept").html(html);
					
				  },// end of success
				  error: function(request, status, error){
					  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				  }
			}); // end of ajax()----------------------------------------------------------------------
		}// end of function getDeptName(){}--------------------------------------	
		
		
		// ????????? ???????????? ??? ???????????? ????????? (?????? ?????????)
		function getTeamModal(deptno){
			 $.ajax({
				  url : "<%=ctxPath%>/getTeamList.yolo",
				  data:{"deptno":deptno},
				  dataType : "JSON",
				  success : function(json2){
					  let html ='';
					  $.each(json2,function(index,team){
					  		html += '<button class="btn_label dropdown-item" type="button"><input class="input_registValue" type="hidden" value='+team.deptno+'>'+team.deptname+'</button>';
				    	});// end of $.each(json,function(index,emp){}----------------------------
				      
				      $("div#div_team").html(html);
				      
				  },// end of success
				  error: function(request, status, error){
					  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				  }
			}); // end of ajax()----------------------------------------------------------------------
		}
		
		
		
		

</script>


<div id="peopleContent">

		<div id="header">
	        <div id="header_title">
	            <a class="a_title" href="<%= ctxPath%>/people.yolo"><span class="title">?????????</span></a>
	            <a class="a_title" href="<%= ctxPath%>/organization_chart.yolo"><span class="title">?????????</span></a>
	            <c:if test="${sessionScope.loginuser.empno == 9999}">
	            	<a class="current" href="<%= ctxPath%>/change_history.yolo"><span class="title">?????? ?????? ??????</span></a>
	            </c:if>
	        </div>
	        <div id="button_title">
	            <button id="change_dept" type="button" class="btn" data-toggle="modal" data-target="#modal_change_hrInfo"><span><i class="fas fa-pen" style="margin:0px; width:20px;"></i>&nbsp;&nbsp;?????? ????????????</span></button>
	        </div>
	    </div>
	    
	    <div id="search_buttons">
		<%-- ????????? ?????? input ?????? --%>
		<div id="div_search">
			<i class="fas fa-search"></i> <input id="searchWord" class="input_search" type="text" placeholder="??????" />
		</div>

		<%-- ?????? ?????? (????????? input?????? ??????)  --%>
		<button type="button" id="btn_search" class="btn btn_search">
			<i class="fas fa-search"></i>
		</button>

	</div>
	
	<%-- ???????????? ?????? ??????  --%>
	<div id="div_searchTag">
		<div id="serchTag_content">
			<div class="dropdown">
			
			<span id="span_searchTag"></span>
				
				<button id="add_searchTag" data-toggle="dropdown" type="button"
					class="btn dropdown-toggle" id="dropdownMenuButton"
					data-mdb-toggle="dropdown" aria-expanded="false">
					<i class="fas fa-plus" style="font-size: 13px; padding: 0 5px;"></i>?????? ????????????
				</button>

				<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
				<li><a class="dropdown-item" href="#">??????</a>
					<ul class="dropdown-menu dropdown-submenu">
						<li><a class="dropdown-item" data-category="??????"><input type="hidden" value="??????"/>??????</a></li>
						<li><a class="dropdown-item" data-category="??????"><input type="hidden" value="??????"/>?????????</a></li>
						<li><a class="dropdown-item" data-category="??????"><input type="hidden" value="??????"/>??????</a></li>
						<li><a class="dropdown-item" data-category="??????"><input type="hidden" value="??????"/>??????</a></li>
						<li><a class="dropdown-item" data-category="??????"><input type="hidden" value="??????"/>??????</a></li>
						<li><a class="dropdown-item" data-category="??????"><input type="hidden" value="??????"/>??????</a></li>
					</ul>
				</li>
				<li><a class="dropdown-item" href="javascript:void(0);" onmouseover="getDeptName();">??????</a>
					<ul id="ul_dept" class="dropdown-menu dropdown-submenu"></ul>
				</li>
				<li><a class="dropdown-item" href="#">?????? ?????? </a>
					<ul class="dropdown-menu dropdown-submenu">
						<li><a class="dropdown-item" href="#"><input type="hidden" value="??????" />?????? ??????</a></li>
						<li><a class="dropdown-item" href="#"><input type="hidden" value="??????" />?????? ??????</a></li>
						<li><a class="dropdown-item" href="#"><input type="hidden" value="??????" />?????? ??????</a></li>
					</ul>
				</li>
			</ul>
			</div>
			
		</div>
		
		<div id="div_search_result">
			<span id="result_cnt">???</span>		
			<button id="filter_clear" type="button" class="btn filter_clear" >???????????????</button>
		</div>		
	</div>
	<%-- ???????????? ?????? ???  --%>


	<div id="search_result"></div>
	<%-- end of  <div id="search_result">====== --%>
	
	<%-- ???????????? ?????? --%>
	<div id="pageBar" style="width: 80%; height: 100px; margin:0 auto;" ></div>

</div>
<%-- end of peopleContiner div====== --%>
	    
</div>

<!-- ========================== ?????? ???????????? ?????? ?????? ========================== -->
<div class="modal fade" id="modal_change_hrInfo">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<!-- Modal header -->
				<div class="modal-header">
					<h5 class="modal-title">?????? ??????</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<!-- Modal body -->
				<div class="modal-body">
					<form name="frm_appointment">
					<%-- =========== ????????? =========== --%>
					<div>
						<div>
							<div class="modal_title">?????????</div>
							<input id="appointment_date" type="text" class="daterange" />
						</div>
					</div>
					<%-- =========== ????????? =========== --%>
					
					<%-- =========== ???????????? =========== --%>
					<div style="margin: 20px 0px;">
						<div class="modal_title">?????? ?????? </div>
						
						<button id="btn" class=" btn choice_type" type="button" data-toggle="dropdown">
							<div style="display:flex; justify-content: space-between; width:460px;">
								<div id="retirement_type">???????????? ??????</div> <i class="fas fa-bars" style="padding:5px;"></i>
							</div>
						</button>
						
						<div class="dropdown-menu">
							<button class="btn_label dropdown-item" type="button">?????? ??????</button>
							<button class="btn_label dropdown-item" type="button">?????? ??????</button>
							<button class="btn_label dropdown-item" type="button">?????? ??????</button>
						</div>
					</div>
					<%-- =========== ???????????? =========== --%>
					
					<%-- =========== ?????? =========== --%>
					<div style="margin: 20px 0px;">
						<div class="modal_title">??????</div>
						
						<button id="btn" class=" btn choice_type" type="button" data-toggle="dropdown">
							<div style="display:flex; justify-content: space-between; width:460px;">
								<div id="retirement_type">?????? ??????</div> <i class="fas fa-bars" style="padding:5px;"></i>
							</div>
						</button>
						
						<div class="dropdown-menu">
						</div>
					</div>
					<%-- =========== ?????? =========== --%>
					
					<%-- =========== ?????? ?????? =========== --%>
					<div style="margin: 20px 0px;">
						<div class="modal_title">??????</div>
						
						<button id="btn" class=" btn choice_type" type="button" data-toggle="dropdown">
							<div style="display:flex; justify-content: space-between; width:460px;">
								<div id="retirement_type">???????????? ??????</div> <i class="fas fa-bars" style="padding:5px;"></i>
							</div>
						</button>
						
						<div class="dropdown-menu">
						</div>
					</div>
					<%-- =========== ?????? ?????? =========== --%>
					
					<div>
						<div class="modal_title">??????</div>
						<textarea class="memo"rows="5" cols="30" placeholder="?????? ??????"></textarea>
					</div>
					</form>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn " data-dismiss="modal">??????</button>
					<button id="changeOk" type="button" class="btn changeOk"><i class="fas fa-check"></i>????????????</button>
				</div>
			</div>
		</div>
</div>
<!-- ========================== ?????? ???????????? ?????? ??? ========================== -->


<!-- ========================== ?????? ??????  ?????? ?????? ========================== -->
<div class="modal fade" id="modal_change_memo">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<!-- Modal header -->
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<!-- Modal body -->
				<div class="modal-body">
					<form name="frm_memo">
						<%-- DB??? ?????? ???????????? ?????? ?????? ??? ???????????? , ?????? ?????? placeholder ??????  --%>
						<textarea name ="memo" id="textarea_memo" rows="" cols="" placeholder="????????? ???????????????"></textarea>
						<input name="pk_psano" id="psano" type="hidden" />
					</form>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button id="changememo" type="button" class="btn changeOk" style="width: 100%;">??????</button>
				</div>
			</div>
		</div>
</div>
<!-- ========================== ?????? ??????  ?????? ??? ========================== -->




















