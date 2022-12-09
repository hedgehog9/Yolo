<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>    


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<style type="text/css">



	div.row{
			width: 100%;
			margin: 0px;
			padding: 0px;
		}
		
		
	div.v-line {
	  border-left : thin solid #cccccc;
	  height : 80%px;
	  padding: 0px;
	}	
	
	span#number {
		color : #00cc00;
		font-weight: bold;
		font-size: 11pt;
	}
	
	span#subject {
		font-weight: bold;
		font-size: 13pt;
	}

	a.link:link {color: #cccccc;}
	a:visited {text-decoration: none; color: #cccccc;}
	a.link:hover {text-decoration: none; color: gray;}
	a.mylink:hover {text-decoration: none; }
	a:active {text-decoration: none; color: #cccccc;}
		
	/* div#leftFirst { overflow: scroll; }	
	div#rightFirst { overflow: scroll; }	 */
	div#leftFirst  {

	height: 780px;
	padding: 0px;
	}
	
    input[type="checkbox"] {
        -webkit-appearance: none;
        position: relative;
        width: 20px;
        height: 20px;
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
    
    label#sub {
     font-size: 13pt;
     padding-top: 0px; 
     margin-top: 0px;
     font-weight: bold;
     margin-left: 10px;
     
    }
    
   	span#status{
	width: 53px; 
	height: 25px; 
	background-color: #c1f0c1;
	border-radius: 0.5rem;
	color: #4d4d4d;;
	text-align: center;
	/* border: 1px solid #ccced0; */
	margin: auto;


	}
	
	div#contents:hover {
	background-color: #efefef;
	cursor: pointer;
	}
	
	span#profile{
		width: 35px; 
		height: 35px; 
		border-radius: 40%; 
		background-color: #239afe;
		color: white;
		border: 1px solid #ccced0;
		font-size: 9pt;
		text-align: center;
		padding: 7px 5px;
	}
	
		span#profile2{ /*테스트용  */
		width: 35px; 
		height: 35px; 
		border-radius: 40%; 
		background-color: purple;
		color: white;
		border: 1px solid #ccced0;
		font-size: 9pt;
		text-align: center;
		padding: 7px 5px;
	}
	
	div#modalStatus{
	width: 450px; 
	height: 50px; 
	background-color: #eafaea;
	border-radius: 15px; 
	border : 1px solid #c1f0c1;
	color: black;
	text-align: center;
	/* border: 1px solid #ccced0; */
	margin: 10px 8px 20px 8px;
	padding-top: 11.5px;
	}
	
	
	div#modalContents{
	margin-top: 40px; 
	width : 500px;
	height : 100%;
	}
	
	div#modalNumber{
	width : 35px;
	height : 35px;
	border-radius: 50%; 
	border : 1px solid #ccced0;
	color: black;
	text-align: center;
	/* border: 1px solid #ccced0; */
	}
	
	span#modalSubContents{
	width : 500px;
	height : 400%;
	border-radius: 15px; 
	border : 1px solid gray;
	color: black;
	text-align: center;
	/* border: 1px solid #ccced0; */
	margin-top: 10px;
	margin-left : 10px; 
	padding: 20px 10px;
	}

/*     span#modalprof{
		width: 40px; 
		height: 40px; 
		border-radius: 40%; 
		background-color: #239afe;
		color: white;
		border: 1px solid #ccced0;
		font-size: 10pt;
		text-align: center;
		padding: 9px 7px;
	} */
	
	 span#modalprof{
		width: 45px; 
		height: 45px; 
		border-radius: 40%; 
		 background-color: #239afe; 
		color: white;
		border: 0px solid #ccced0;
		font-size: 12pt;
		text-align: center;
		padding: 9px 7px;
	}
	
	
	
  table{
    border: 1px solid #ccced0;
    border-collapse: collapse;
    border-radius: 10px;
    border-style: hidden;
    box-shadow: 0 0 0 1px #ccced0;
    width: 380px;
    height : 80px;
    
  }
  
  td {
   
  }
  
  td.td-2 {
  	width: 50%;
  }
  
    td {
  	/* padding :10px 15px; */ /* 이거만 살리기 */
  	/* border : 1px solid; */
  }
  
/*   td.td-2 {
  	width: 50%;
  }	 */
  
/*   span#status2{
	width: 55px; 
	height: 25px; 
	background-color: #c1f0c1;
	border-radius: 20%; 
	color: black;
	text-align: center;
	 border: 1px solid #ccced0; 
	margin: auto;
  } */
  
  span#status2{
	width: 60px; 
	height: 30px; 
	background-color: #c1f0c1;
	border-radius: 0.5rem;
	font-weight : bold;
	font-size : 14pt;
	color: #4d4d4d;;
	text-align: center;
	/* border: 1px solid #ccced0; */
	margin: auto;
  }
  
    span#status3{
  	width: 53px; 
	height: 25px; 
	background-color: #ff9999;
	border-radius: 20%; 
	color: black;
	text-align: center;
	/* border: 1px solid #ccced0; */
	margin: auto;

	}
  
  div#modal-body{
  	
 	height: 100%;
 	margin-bottom: 30px;
  }
	
  div#startContents{
  	height: 600px;
  }
  
  span#sizebold{
   font-size: 12pt;
   font-weight: bold;
  }
  
  div#parent {
  	width: 100%;
    display: flex;
  }
  
  div#icon{
  	flex:1
 	
  }
  
  

   div#iconhover:hover {
  	width: 63px;
  	height: 32px;
  	background-color: #efefef;
	cursor: pointer;
	border-radius: 15px;
	} 
	  
  div#child{
  	flex:9
  }
  
  button#denial {
  width: 65px;
  height: 35px;
  border : 1px solid #ccced0;
  border-radius: 17.5px;
  background: white;
  margin-top: 30px;
  font-size: 12pt;
  padding: 4px 5px;
  font-weight: bold;
  color : #404040;
  
  }
  
  button#accept {
  width: 75px;
  height: 35px;
  border : 1px solid #39ac39;
  border-radius: 17.5px;
  background: #53c653;
  margin-top: 30px;
  font-size: 12pt;
  padding: 4px 5px;
  font-weight: bold;
  color : white;
  
  }
  
  .bhover:hover {
  	background-color: #efefef;
	transition: 0.7s;
  } 
	
  span.font{
  font-size: 13pt;
  font-weight:bold; 
  color:#404040;
  }	
  
  .p:hover {
 	background-color: #efefef;
    transition: 0.7s;
    height:30px;
    border-radius: 15px;
  } 
  
    button.bottom-line {
  
  	padding : 0px 0px 10px 0px;
  	margin-right: 20px;
  	background-color: white;
  	border: none;
  	
  
  }
  
  .rightFirst {
  	overflow-y: scroll;
  	height: 780px;
  }
  
  	.rightFirst::-webkit-scrollbar {
    	width: 10px;
  	}
  	.rightFirst::-webkit-scrollbar-thumb {
    	background-color: #d9d9d9;
    	border-radius: 10px;
  	}
  	.rightFirst::-webkit-scrollbar-track {
    	background-color: #f2f2f2;
    	border-radius: 10px;
  	}
  
  
  .startContents {
  	overflow-y: scroll;
  }
  
  .startContents::-webkit-scrollbar {
    	width: 10px;
  	}
  	.startContents::-webkit-scrollbar-thumb {
    	background-color: #d9d9d9;
    	border-radius: 10px;
  	}
  	.startContents::-webkit-scrollbar-track {
    	background-color: #f2f2f2;
    	border-radius: 10px;
  	}

	button#delete{
	
	float: right;
	margin-right: 45px;
	background-color: white;
	border: 2px solid #bfbfbf;
	border-radius :5px;
	width: 26px;
	height: 26px;	
	padding: 0px;

	}	
	
	button#delete:hover {
 	background-color: #efefef;
  } 
	

</style>

<script type="text/javascript">

	 $(document).ready(function(){
		
	 	// 문서 띄우기 에이젝스 함수
	 	myDocument();
	 	
	 	const doc_no = ${requestScope.doc_no};
	 	const emp_no = ${requestScope.empno};
	 	//alert(doc_no);
		
	 	goReadDocument(doc_no,emp_no);
		
	  	
	 	//체크박스 체크되면 전체 체크박스 선택
	    $(".allCheckBox").click(function(){
			var bool = $(this).is(":checked");
			$(".checkNum").prop("checked", bool);
		});
		 
	 	//체크박스 하나라도 해체되면 전체 해제
		$(".checkNum").click(function(){
			   var bFlag = false;
			   $(".checkNum").each(function(){
			      var bChecked = $(this).prop("checked");
			      if(!bChecked) {
			         $(".allCheckBox").prop("checked",false);
			         bFlag = true;
			         return false;
			      }
			   });
			   
			   if(!bFlag) {
			      $(".allCheckBox").prop("checked",true);
			   }
			   
			});//end of $(".check").click

	  // $('[data-toggle="popover"]').popover();   
			
			
			// 진행중 완료 버튼 
			$("button#wating").click(function(){
				  $(this).css("border-bottom", "4px solid #00cc00");
		          $("button#mine").css("border-bottom", "none"); 
		          $("button#complete").css("border-bottom", "none"); 
		        }); 
			
			$("button#complete").click(function(){
				  $(this).css("border-bottom", "4px solid #00cc00");
		          $("button#mine").css("border-bottom", "none"); 
		          $("button#wating").css("border-bottom", "none"); 
		        }); 
			
			$("button#mine").click(function(){
				  $(this).css("border-bottom", "4px solid #00cc00");
		          $("button#wating").css("border-bottom", "none"); 
		          $("button#complete").css("border-bottom", "none"); 
		        }); 
			
		
	}); 
	 
	 
	//수정하기 창으로 이동
	function goModify() {
		
		location.href="<%= request.getContextPath()%>/workflow/modify.yolo";
	} 
	

	
	//문서 자세히 에이젝스 
	function goReadDocument(doc_no,emp_no) {
		 
	       // alert("문서번호 " + doc_no +"/ empno:" + emp_no);
	
	  $.ajax({
		  url:"<%= request.getContextPath()%>/workflow/documentDetail.yolo",
		  data:{"doc_no":doc_no,
			  	"emp_no":emp_no},
		  dataType:"JSON",
		  success:function(json){
			  let html = "";
			if(json.doc_no !=null) {
				//console.log(json.doc_subject);
	 				  html += 
						"<div style='padding : 15px 10px' id='contents' data-bs-toggle='modal' data-bs-target='#exampleModal' onclick='approvalModal("+json.doc_no+"," +json.fk_writer_empno+")'>"+
					    	"<span id='status2' style='font-size: 11pt; font-weight:bold; color:#4d4d4d; padding:3px;'> &nbsp;1/2&nbsp; </span>"+
					    	"<span style='font-size: 12pt;'> &nbsp;&nbsp;1단계 승인대기 중입니다.</span>" +
					    	"&nbsp;&nbsp;&nbsp;&nbsp;"+
					    	"<span style='float:right; color:#cccccc; font-weight: bold; padding-left: 20px; font-size:12pt;'>></span>"+
					    	"<span id='profile' style='float:right; margin-bottom: 5px;'>이름</span>"+
					    	"<span id='profile' style='float:right; margin-bottom: 5px;'>이름</span>"+ 
				    	"</div>"+
		   	  			"<div id='parent'>"+
					    	"<div id='child' style='margin:17px 0px 10px 10px; font-size: 25pt; font-weight: bold;'>"+
					    	""+json.doc_subject+"</div>"+
					    	"<div id='icon' style='margin-top:22px; float: right;'>"+
				    			"<div id='iconhover' onclick='goModify();'>"+
										"<i class='bi bi-pencil-fill' style='font-size: 13pt;'></i>"+
										"&nbsp;<span style='font-size: 13pt;'>수정</span>"+
									"</div>"+
						    	"</div>"+
					    	"</div>"+				    	
				    	"</div>"+
				    	"<div style='padding : 10px; padding-bottom: 20px;' class='border-bottom'>"+
			    		"<span id='profile' style='margin-right: 10px;'>"+json.name.substring(1,3)+"</span> "+
			    		"<span id='sizebold'>"+json.name+" ·</span> <span style='font-size: 13pt;'>"+json.position+"</span>"+
			    		"<span style='font-size: 12pt; float:right; color:gray;'>"+
			    		"<i class='bi bi-table'></i> &nbsp;&nbsp;"+
			    		""+json.writeday+"</span>"+
			    	"</div>"+
			    	
			    	"<div style='padding : 10px; padding-bottom: 40px; margin-top: 20px;'  class='border-bottom'>"+
			    		"<span><i class='bi bi-chat-left-text'></i></span>"+
			    		"<span class='font'>&nbsp;&nbsp;요청 내용 </span>"+
			    		"<div style='font-size: 12pt; margin-top: 5px;'>"+
			    			""+json.doc_contents+
			    		"</div>"+
			    		
			    		"<div style='margin-top: 20px;'>"+
				    		"<span><i class='bi bi-calendar4-event'></i></span>"+
				    		"<span class='font' style='margin-right: 10px;'>&nbsp;&nbsp;희망기한 </span>"+
				    		"<span style='font-size:11pt; color:#262626;'>"+json.d_day.substring(0,10)+" </span>"+
						"</div>"+
						
						"<button type='button' id='denial' class='bhover'>반려</button>"+
						"&nbsp;<button type='button' id='accept' class='bhover'>✓ 승인</button>"+
			    		
			    	"</div>"+
			    	
			    	// 첨부파일 토글버튼 
			    	"<div style='padding : 10px;  padding-bottom: 40px; margin-top: 20px;'  class='border-bottom'>"+
				    	"<p class='p'  data-bs-toggle='collapse' href='#collapseExample' role='button' aria-expanded='false' aria-controls='collapseExample'>"+
				    	  "<span><i class='bi bi-paperclip'></i></span>&nbsp;"+
						  "<span class='font'>"+
						    "첨부파일"+
						  "</span>"+
						  "<span class='font' style='float: right;'> > </span>"+
						"</p>"+
						"<div class='collapse' id='collapseExample'>"+
						  "<div class='' style='margin-left: 10px;'>"+  
						    "첨부파일 이지롱<br>"+
						     "그렇게<br>"+
						     "됐다"+		    
						  "</div>"+
						"</div>"+
					"</div>"+
					
					//히스토리 토글버튼 
			    	"<div style='padding : 10px; padding-bottom: 40px; margin-top: 20px;'>"+
					   	"<p class='p'  data-bs-toggle='collapse' href='#collapseExample2' role='button' aria-expanded='false' aria-controls='collapseExample2'>"+
					   	  "<span><i class='bi bi-clock'></i></span>&nbsp;"+
						  "<span class='font'>"+
						   "히스토리"+
						  "</span>"+
						  "<span class='font' style='float: right;'> > </span>"+
						"</p>"+
						"<div class='collapse' id='collapseExample2'>"+
						  "<div class='' style='margin-left: 10px; margin-bottom: 5px;'>"+ 
						  "<span><i class='bi bi-pencil-square'></i></span>"+
						  "<span id='sizebold' style='color: #404040;'> 이름(코딩) </span>"+
						  "<span style='font-size:12pt; color:#404040;'> 님이 문서를 작성했습니다.</span>"+
						  "</div>"+
						  
						  "<div class='' style='margin-left: 10px; margin-bottom: 5px;'>"+ 
						  "<span><i class='bi bi-pencil-square'></i></span>"+
						  "<span id='sizebold' style='color: #404040;'> 이름(코딩) </span>"+
						  "<span style='font-size:12pt; color:#404040;'> 님이 문서를 수정했습니다.</span>"+
						  "</div>"+
						"</div>"+
					"</div>";	
	 				 approvalModal(doc_no,emp_no);
				}
				else {
					html +="<div>"+
					"안나옴"+
					"</div>";
			    	
				}
			  $("div#rightFirst").html(html);
		  },
		  error: function(request, status, error){
			  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		  }
	  });
	  
	  
  }// end of function goReadDocument()--------------------------- 
	
	// 결제라인 알아오는 모달
	function approvalModal(doc_no, emp_no) {
		  
		  $.ajax({
			  url:"<%= request.getContextPath()%>/workflow/modalApproval.yolo",
			  data:{"doc_no":doc_no,
				  	"emp_no":emp_no},
			  dataType:"JSON",
			  success:function(json){
				  let html = ""
				if(json.length > 0) {
					$.each(json, function(index, item){	
						console.log(item.name);
						 html +=  "<div id='modalNumber' style=' float:left; margin: 35px 15px 15px 10px; font-size: 11pt; font-weight: bold; padding-top: 6px; color: #333333'>"+
						 			"&nbsp;&nbsp;"+item.levelno+"&nbsp;&nbsp;"+
						   		  "</div>"+
									"<div style='float:left; margin-top: 25px; margin-bottom :10px;'>"+   
								    	"<table>"+
								    		"<tbody>"+
									    		"<tr>"+
									    			"<td rowspan='2' style='padding-left: 13px;'><span id='modalprof' style='background-color: "+item.profile_color+";'>"+item.name.substring(1,3)+"</span></td>"+
									    		    "<td class='td-2' style='vertical-align : bottom; padding-bottom : 0px; margin-bottom: 0px; font-weight: bold; font-size: 12pt;'>"+item.name+"</td>"+
									    			"<td rowspan='2' style='padding-right: 10px;''><span id='status2' style='font-size: 12pt; padding: 3px 5px; float: right;'>"+
									    			"승인</span>	</td>"+	
									    		"</tr>"+
									    		"<tr>"+	
									    			"<td style='vertical-align : top; padding-top: 0px; margin-top: 0px; color: gray; font-size: 11pt;'>"+item.position+"· "+item.deptname+" </td>"+
									    		"</tr>"+	
									    	"</tbody>"+
									    "</table>"+
									    "<div style='margin-top: 12px;'>"+
										   "<span style='font-size: 12pt;'><i class='bi bi-check-lg'></i> "+item.name+
										   "님 승인진행중</span>"+
										    "<span style='font-size: 12pt; float:right;'>완료시 날짜</span>"+
									    "</div>"+ 
					     		 	"</div>";
		     		
					});
					
					}
					else {
						html +="<div>"+
						"왜이래!!!"+
						"</div>";
				    	
					}
				  $("div#approvalModal").html(html);
			  },
			  error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		  }); 
		  
	  }
  

  //에이젝스 테스트용 ///////////////////////////////////
  	function goReadDocument2() {
	  
	  $.ajax({
		  url:"<%= request.getContextPath()%>/workflow/documentDetail.yolo",
		  data:{},
		  dataType:"JSON",
		  success:function(json){

			  let html = "";

				  html += 
					
		    	
				"<div style='padding : 15px 10px' id='contents' data-bs-toggle='modal' data-bs-target='#exampleModal' onclick='#'>"+
		    	"<span id='status2' style='font-size: 11pt; font-weight:bold; color:#4d4d4d; padding:3px;'> &nbsp;1/2&nbsp; </span>"+
		    	"<span style='font-size: 12pt;'> &nbsp;&nbsp;1단계 승인대기 중입니다.</span>" +
		    	"&nbsp;&nbsp;&nbsp;&nbsp;"+
		    	"<span style='float:right; color:#cccccc; font-weight: bold; padding-left: 20px; font-size:12pt;'>></span>"+
		    	"<span id='profile' style='float:right; margin-bottom: 5px;'>이름</span>"+
		    	"<span id='profile2' style='float:right; margin-bottom: 5px;'>이름</span>"+ 
	    	"</div>"+
	  			"<div id='parent'>"+
		    	"<div id='child' style='margin:17px 0px 10px 10px; font-size: 25pt; font-weight: bold;'>"+
		    	"디자인 요청(제목)</div>"+
		    	"<div id='icon' style='margin-top:22px; float: right;'>"+
	    			"<div id='iconhover' onclick='goModify();'>"+
							"<i class='bi bi-pencil-fill' style='font-size: 13pt;'></i>"+
							"&nbsp;<span style='font-size: 13pt;'>수정</span>"+
						"</div>"+
			    	"</div>"+
		    	"</div>"+				    	
	    	"</div>"+
	    	"<div style='padding : 10px; padding-bottom: 20px;' class='border-bottom'>"+
    		"<span id='profile' style='margin-right: 10px;'>이름</span> "+
    		"<span id='sizebold'>이름 ·</span> <span style='font-size: 13pt;'>직책</span>"+
    		"<span style='font-size: 12pt; float:right; color:gray;'>"+
    		"<i class='bi bi-table'></i> &nbsp;&nbsp;"+
    		"2022.11.28(화) 14:25(날짜 코딩)</span>"+
    	"</div>"+
    	
    	"<div style='padding : 10px; padding-bottom: 40px; margin-top: 20px;'  class='border-bottom'>"+
    		"<span><i class='bi bi-chat-left-text'></i></span>"+
    		"<span class='font'>&nbsp;&nbsp;요청 내용 </span>"+
    		"<div style='font-size: 11.5pt; margin-top: 5px;'>"+
      			"잘나오는지 <br>"+
    			"테스트합니다"+
    		"</div>"+
    		
    		"<div style='margin-top: 20px;'>"+
	    		"<span><i class='bi bi-calendar4-event'></i></span>"+
	    		"<span class='font' style='margin-right: 10px;'>&nbsp;&nbsp;희망기한 </span>"+
	    		"<span style='font-size:11pt; color:#262626;'>2022.11.28(화) 14:25(날짜 코딩) </span>"+
			"</div>"+
			
			"<button type='button' id='denial' class='bhover'>반려</button>"+
			"&nbsp;<button type='button' id='accept' class='bhover'>✓ 승인</button>"+
    		
    	"</div>"+
    	
    	// 첨부파일 토글버튼 
    	"<div style='padding : 10px;  padding-bottom: 40px; margin-top: 20px;'  class='border-bottom'>"+
	    	"<p class='p'  data-bs-toggle='collapse' href='#collapseExample' role='button' aria-expanded='false' aria-controls='collapseExample'>"+
	    	  "<span><i class='bi bi-paperclip'></i></span>&nbsp;"+
			  "<span class='font'>"+
			    "첨부파일"+
			  "</span>"+
			  "<span class='font' style='float: right;'> > </span>"+
			"</p>"+
			"<div class='collapse' id='collapseExample'>"+
			  "<div class='' style='margin-left: 10px;'>"+  
			    "첨부파일 이지롱<br>"+
			     "그렇게<br>"+
			     "됐다"+		    
			  "</div>"+
			"</div>"+
		"</div>"+
		
		//히스토리 토글버튼 
    	"<div style='padding : 10px; padding-bottom: 40px; margin-top: 20px;'>"+
		   	"<p class='p'  data-bs-toggle='collapse' href='#collapseExample2' role='button' aria-expanded='false' aria-controls='collapseExample2'>"+
		   	  "<span><i class='bi bi-clock'></i></span>&nbsp;"+
			  "<span class='font'>"+
			   "히스토리"+
			  "</span>"+
			  "<span class='font' style='float: right;'> > </span>"+
			"</p>"+
			"<div class='collapse' id='collapseExample2'>"+
			  "<div class='' style='margin-left: 10px; margin-bottom: 5px;'>"+ 
			  "<span><i class='bi bi-pencil-square'></i></span>"+
			  "<span id='sizebold' style='color: #404040;'> 이름(코딩) </span>"+
			  "<span style='font-size:12pt; color:#404040;'> 님이 문서를 작성했습니다.</span>"+
			  "</div>"+
			  
			  "<div class='' style='margin-left: 10px; margin-bottom: 5px;'>"+ 
			  "<span><i class='bi bi-pencil-square'></i></span>"+
			  "<span id='sizebold' style='color: #404040;'> 이름(코딩) </span>"+
			  "<span style='font-size:12pt; color:#404040;'> 님이 문서를 수정했습니다.</span>"+
			  "</div>"+
			"</div>"+
		"</div>";
				
			  $("div#rightFirst").html(html);
		  },
		  error: function(request, status, error){
			  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		  }
	  });
	  
  }// end of function goReadDocument()--------------------------- 
  
  
  
  function myDocument() {
	  
	  $.ajax({
		  url:"<%= request.getContextPath()%>/workflow/myDocument_dm.yolo",
		  data:{},
		  dataType:"JSON",
		  success:function(json){
				
			  let html = "";
			  if(json.length > 0) {
				  $.each(json, function(index, item){
					 // console.log(item.name);
					  
					  html += 
							"<div style='padding-top: 15px;' id='contents'>"+
					    		"<div style='margin-left: 35px; margin-right: 25px;' class='border-bottom'>"+
						    		"<input type='checkbox' id='label-a' class='checkNum'/>&nbsp;&nbsp;"+
							  		"<span id='getdocno' onclick='goReadDocument("+item.doc_no+","+item.emp_no+");'>"+
							  		" <input type='hidden' class='doc_no' name='' value="+item.doc_no+" /> "+
								  		"<label for='label-a' id='sub' >"+item.name+"</label>";
								  		if(item.approval == 0){
								  		html += "<span id='status' style='font-size: 10.5pt; float:right; margin: 5px; padding-top:3px; font-weight:bold; color:#4d4d4d;'>진행중</span>";
								  		}
								  		html+= "<br>"+
										"<span style='padding:30px; font-size: 12pt; margin-left:7px; '>"+item.doc_subject+"</span>"+
										"<span style='font-size: 11pt; float:right; margin: 5px 8px; color:#737373;'>"+item.writeday.substring(5,7)+"월 "+item.writeday.substring(8,10)+"일</span>"+
										"<br>"+
										"<span style='padding:30px; font-size: 11.5pt; margin-left:7px;'>요청내용 : "+item.doc_contents.substring(0,6)+"</span>"+
										"<br>"+
										"<span style='padding:30px; font-size: 11.5pt; margin-left:7px;'>첨부파일 : "+item.orgfilename+"</span>"+
										"<br>"+
										"<span>&nbsp;</span>"+
									"</span>"+
								"</div>"+
				    		"</div>";
					  
					  
				  });
				  
			  }
			  
			  else {
				  
				  html += 
						"<div style='padding-top: 15px; text-align: center; font-size: 15pt; margin-top:50%;' >"+
									
									"내가 쓴 문서가 없습니다."+
			    		"</div>";
				  
			  }	
				
			  $("div#startContents").html(html);
		  },
		  error: function(request, status, error){
			  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		  }
	  });
	  
	  
	  
  }// end of function
  
  function waitingDm() {
	  
	  $.ajax({
		  url:"<%= request.getContextPath()%>/workflow/watingDm.yolo",
		  data:{},
		  dataType:"JSON",
		  success:function(json){

			  let html = "";

				  html += 
						"<div style='padding-top: 15px;' id='contents' >"+
			    		"<div style='margin-left: 35px; margin-right: 25px;' class='border-bottom'>"+
				    		"<input type='checkbox' id='label-a' class='checkNum'/>&nbsp;&nbsp;"+
					  		"<span onclick='goReadDocument();'>"+
						  		"<label for='label-a' id='sub' >이름(코딩)</label>"+
						  		"<span id='status' style='font-size: 10.5pt; float:right; margin: 5px; padding-top:3px; font-weight:bold; color:#4d4d4d;'>진행중</span>"+
								"<br>"+
								"<span style='padding:30px; font-size: 11.5pt; margin-left:7px; '>진행중인 문서</span>"+
								"<span style='font-size: 11pt; float:right; margin: 5px 8px; color:#737373;'>11월 16일</span>"+
								"<br>"+
								"<span style='padding:30px; font-size: 11.5pt; margin-left:9px;'>요청내용 : 내용</span>"+
								"<br>"+
								"<span>&nbsp;</span>"+
							"</span>"+
						"</div>"+
		    		"</div>"+
		    		
		    		
		    		"<div style='padding-top: 15px;' id='contents' >"+
		    		"<div style='margin-left: 35px; margin-right: 25px;' class='border-bottom'>"+
			    		"<input type='checkbox' id='label-a' class='checkNum'/>&nbsp;&nbsp;"+
				  		"<span onclick='goReadDocument2();'>"+
					  		"<label for='label-a' id='sub' >에이젝트 테스트</label>"+
					  		"<span id='status' style='font-size: 10.5pt; float:right; margin: 5px; padding-top:3px; font-weight:bold; color:#4d4d4d;'>진행중</span>"+
							"<br>"+
							"<span style='padding:30px; font-size: 11.5pt; margin-left:7px; '>디자인 요청(제목)</span>"+
							"<span style='font-size: 11pt; float:right; margin: 5px 8px; color:#737373;'>11월 16일</span>"+
							"<br>"+
							"<span style='padding:30px; font-size: 11.5pt; margin-left:9px;'>요청내용 : 내용</span>"+
							"<br>"+
							"<span>&nbsp;</span>"+
						"</span>"+
					"</div>"+
	    		"</div>"+
	    		"<div style='padding-top: 15px;' id='contents' >"+
	    		"<div style='margin-left: 35px; margin-right: 25px;' class='border-bottom'>"+
		    		"<input type='checkbox' id='label-a' class='checkNum'/>&nbsp;&nbsp;"+
			  		"<span onclick='goReadDocument();'>"+
				  		"<label for='label-a' id='sub' >이름(코딩)</label>"+
				  		"<span id='status' style='font-size: 10.5pt; float:right; margin: 5px; padding-top:3px; font-weight:bold; color:#4d4d4d;'>진행중</span>"+
						"<br>"+
						"<span style='padding:30px; font-size: 11.5pt; margin-left:7px; '>디자인 요청(제목)</span>"+
						"<span style='font-size: 11pt; float:right; margin: 5px 8px; color:#737373;'>11월 16일</span>"+
						"<br>"+
						"<span style='padding:30px; font-size: 11.5pt; margin-left:9px;'>요청내용 : 내용</span>"+
						"<br>"+
						"<span>&nbsp;</span>"+
					"</span>"+
				"</div>"+
    		"</div>"+
    		"<div style='padding-top: 15px;' id='contents' >"+
    		"<div style='margin-left: 35px; margin-right: 25px;' class='border-bottom'>"+
	    		"<input type='checkbox' id='label-a' class='checkNum'/>&nbsp;&nbsp;"+
		  		"<span onclick='goReadDocument();'>"+
			  		"<label for='label-a' id='sub' >이름(코딩)</label>"+
			  		"<span id='status' style='font-size: 10.5pt; float:right; margin: 5px; padding-top:3px; font-weight:bold; color:#4d4d4d;'>진행중</span>"+
					"<br>"+
					"<span style='padding:30px; font-size: 11.5pt; margin-left:7px; '>디자인 요청(제목)</span>"+
					"<span style='font-size: 11pt; float:right; margin: 5px 8px; color:#737373;'>11월 16일</span>"+
					"<br>"+
					"<span style='padding:30px; font-size: 11.5pt; margin-left:9px;'>요청내용 : 내용</span>"+
					"<br>"+
					"<span>&nbsp;</span>"+
				"</span>"+
			"</div>"+
		"</div>";

				
			  $("div#startContents").html(html);
		  },
		  error: function(request, status, error){
			  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		  }
	  });
	  
  }
  
   function completeDm() {
	  
	  $.ajax({
		  url:"<%= request.getContextPath()%>/workflow/watingDm.yolo",
		  data:{},
		  dataType:"JSON",
		  success:function(json){

			  let html = "";

				  html += 
					  
					  "<div style='padding-top: 15px;' id='contents' >"+
			    		"<div style='margin-left: 35px; margin-right: 25px;' class='border-bottom'>"+
				    		"<input type='checkbox' id='label-a' class='checkNum'/>&nbsp;&nbsp;"+
					  		"<span onclick='goReadDocument();'>"+
						  		"<label for='label-a' id='sub' >이름(코딩)</label>"+
						  		"<span id='status3' style='font-size: 10.5pt; float:right; margin: 5px; padding-top:3px; font-weight:bold; color:#4d4d4d;'>완료</span>"+
								"<br>"+
								"<span style='padding:30px; font-size: 11.5pt; margin-left:7px; '>진행중인 문서</span>"+
								"<span style='font-size: 11pt; float:right; margin: 5px 8px; color:#737373;'>11월 16일</span>"+
								"<br>"+
								"<span style='padding:30px; font-size: 11.5pt; margin-left:9px;'>요청내용 : 내용</span>"+
								"<br>"+
								"<span>&nbsp;</span>"+
							"</span>"+
						"</div>"+
		    		"</div>";
		    		
						
			  $("div#startContents").html(html);
		  },
		  error: function(request, status, error){
			  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		  }
	  });
	  
  }
  
  
  /////////////////////////////////////////////
</script> 
 
 <jsp:include page="/WEB-INF/views/admin/jihee/header.jsp"></jsp:include>
    
 
<div class="border-top"></div>
 
<div class="" > 
 <div class="row" >
 
    <div id="leftFirst" class="col-4" ><!-- border-bottom -->
    <!-- ajax 올릴 것 시작1 -->
<!--     	<div style="padding:10px;">
    	 	<a href="#" class="mylink"><span id=subject style="color:black;">내가 쓴 문서 </span><span id="number"> 4 </span></a>
    	 	<a href="#" class="link"><span id=subject style="color:gray;">&nbsp;&nbsp;&nbsp;진행 중 &nbsp;&nbsp;&nbsp;</span></a>
    	 	<a href="#" class="link"><span id=subject style="color:gray;"> 완료</span> <span id="number"> 3</span></a>
    	 </div> -->
    	 <div style="padding:15px 10px 0px 35px;">
	    	
	    	 	<!-- <a href="#" class="mylink"><span id=subject style="color:black;">내가 쓴 문서 </span><span id="number"> 4 </span></a>	
	    	 	<a href="#" class="link"><span id=subject style="color:gray;">&nbsp;&nbsp;&nbsp;완료</span> <span id="number"> 3</span></a> -->
	    		<button class="bottom-line" id="mine" style="border-bottom : 4px solid #00cc00;" onclick="myDocument();"> 
	    		<span id=subject style="color:black;">내가 쓴 문서 </span><span id="number"> 4 </span>	
	    		</button>
	    		<button class="bottom-line" id="wating" onclick="waitingDm();"> 
	    		<span id=subject style="color:gray;">진행 중 </span>
	    		</button>
	    		<button class="bottom-line" id="complete" onclick="completeDm();"> 
	    		<span id=subject style="color:gray;">완료</span> <span id="number"> 3</span>
	    		</button>
	    	
    	 </div>
	    <div id="documentContent" class="border-top" > <!-- height: 200px; -->
	    	<div style="padding-bottom: 10px; padding-top: 25px; margin-left: 35px; ">
		  		<input type="checkbox" id="label-a" class="allCheckBox" />&nbsp;&nbsp;
		  		<label for="label-a" id="sub" >1-4</label> <span style="font-size: 13pt;"> / 4(코딩)</span>
		  		<button id="delete"><i class="bi bi-trash-fill" style="color: #404040; font-size: 10pt;"></i></button>
		 	    <!-- <span id=subject style="font-size: 10pt; padding-top: 0px; margin-top: 0px;" > 1-4 </span><span> / 4(코딩) </span> -->
	    	</div>
	    	
	    	<div id="startContents" class="border-bottom startContents"> 
		    	
	    	</div>
	    	
	    	<!-- 페이지바 -->
	    	<div style="margin: 15px auto auto 15px;"> 
		    	 <nav aria-label="...">
				  <ul class="pagination">
				    <li class="page-item disabled">
				      <a class="page-link" href="#" tabindex="-1" aria-disabled="true"><</a>
				    </li>
				    <li class="page-item"><a class="page-link" href="#">1</a></li>
				    <li class="page-item active" aria-current="page">
				      <a class="page-link" href="#">2</a>
				    </li>
				    <li class="page-item"><a class="page-link" href="#">3</a></li>
				    <li class="page-item">
				      <a class="page-link" href="#">></a>
				    </li>
				  </ul>
				</nav>
			</div>	
	    </div> 
	<!-- ajax 올릴 것 끝1 -->    
	</div>

    <div id="rightFirst" class="col-8 rightFirst border-left" style="text-align: left; padding: 20px 20px;" >
     <!-- ajax 올릴것 2 -->	
    <!-- ajax 올릴것 2 -->
    </div>
    
  </div>
</div>




<!-- 모달창 시작  -->
<!-- Button trigger modal -->

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <div class="modal-title fs-2" id="exampleModalLabel" style="font-weight: bold; font-size: 15pt;">승인 · 참조 현황</div>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" id="modal-body">
			<div id="modalStatus">    
	       		<span id="status" style="font-size: 13pt; "> &nbsp;1/2&nbsp; </span> 
		    	<span style="font-size: 13pt;"> &nbsp;&nbsp;1단계 승인대기 중입니다.</span> 
		    </div>  
		    
		    <!-- <div id="modalContents">
		    	<span id="modalNumber" style="	margin-top: 10px; margin-left : 30px; ">&nbsp;&nbsp;1&nbsp;&nbsp;</span>
		    	<span id="modalSubContents">
		    		<span id="modalprof">지현</span>
					<span id="statusstatus" style="font-size: 9pt; padding: 5px;"> 진행중</span>		
		    	</span>
		    	
		    </div> -->
		    <!-- 내용 시작 -->
		    <div id="approvalModal">
				    
     		  
     		 

	    		   		
	    		
     		
      	</div>
    </div>
  </div>
</div>
</div>
<!-- 모달창 끝 -->

 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.min.js" integrity="sha384-IDwe1+LCz02ROU9k972gdyvl+AESN10+x7tBKgc9I5HFtuNz0wWnPclzo6p9vxnk" crossorigin="anonymous"></script>
 
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">