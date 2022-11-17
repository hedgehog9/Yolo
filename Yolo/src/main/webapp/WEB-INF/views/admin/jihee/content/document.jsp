<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
		color : green;
		font-weight: bold;
	}
	
	span#subject {
		font-weight: bold;
	}

	a.link:link {color: #cccccc;}
	a:visited {text-decoration: none; color: #cccccc;}
	a.link:hover {text-decoration: none; color: gray;}
	a.mylink:hover {text-decoration: none; }
	a:active {text-decoration: none; color: #cccccc;}
		
	/* div#leftFirst { overflow: scroll; }	
	div#rightFirst { overflow: scroll; }	 */
	div#leftFirst  {

	height: 800px;
	}
	
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
    
    label#sub {
     font-size: 10pt;
     padding-top: 0px; 
     margin-top: 0px;
     font-weight: bold;
     
    }
    
   	span#status{
	width: 45px; 
	height: 20px; 
	background-color: #c1f0c1;
	border-radius: 20%; 
	color: black;
	text-align: center;
	/* border: 1px solid #ccced0; */
	margin: auto;
	}
	
	div#contents:hover {
	background-color: #efefef;
	cursor: pointer;
	border-radius: 10px;
	}
	
	span#profile{
		width: 30px; 
		height: 30px; 
		border-radius: 40%; 
		background-color: #239afe;
		color: white;
		border: 1px solid #ccced0;
		font-size: 7pt;
		text-align: center;
		padding: 7px 5px;
	}
	
	div#modalStatus{
	width: 400px; 
	height: 40px; 
	background-color: #eafaea;
	border-radius: 15px; 
	border : 1px solid #c1f0c1;
	color: black;
	text-align: center;
	/* border: 1px solid #ccced0; */
	margin: 10px auto;
	padding-top: 5px;
	}
	
	
	div#modalContents{
	margin-top: 40px; 
	width : 300px;
	height : 300px;
	}
	
	div#modalNumber{
	width : 30px;
	height : 30px;
	border-radius: 50%; 
	border : 1px solid #ccced0;
	color: black;
	text-align: center;
	/* border: 1px solid #ccced0; */
	}
	
	span#modalSubContents{
	width : 300px;
	height : 300px;
	border-radius: 15px; 
	border : 1px solid gray;
	color: black;
	text-align: center;
	/* border: 1px solid #ccced0; */
	margin-top: 10px;
	margin-left : 10px; 
	padding: 20px 10px;
	}

    span#modalprof{
		width: 40px; 
		height: 40px; 
		border-radius: 40%; 
		background-color: #239afe;
		color: white;
		border: 1px solid #ccced0;
		font-size: 10pt;
		text-align: center;
		padding: 9px 7px;
	}
	
	
  table{
    border: 1px solid #ccced0;
    border-collapse: collapse;
    border-radius: 10px;
    border-style: hidden;
    box-shadow: 0 0 0 1px #ccced0;
    width: 350px;
    height : 70px;
    
  }
  
  td {
  	padding :10px;
  }
  
  td.td-2 {
  	width: 60%;
  }
  
  span#status2{
	width: 55px; 
	height: 25px; 
	background-color: #c1f0c1;
	border-radius: 20%; 
	color: black;
	text-align: center;
	/* border: 1px solid #ccced0; */
	margin: auto;
  }
  
  div#modal-body{
  
 	height: 500px;
  }
	
  div#startContents{
  	height: 600px;
  }
  
  span#sizebold{
   font-size: 10pt;
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
  	width: 50px;
  	height: 30px;
  	background-color: #efefef;
	cursor: pointer;
	} 
	  
  div#child{
  	flex:9
  }
  
  button#denial {
  width: 60px;
  height: 30px;
  border : 1px solid #ccced0;
  border-radius: 15px;
  background: white;
  margin-top: 30px;
  font-size: 10pt;
  padding: 4px 5px;
  font-weight: bold;
  color : #404040;
  
  }
  
  button#accept {
  width: 70px;
  height: 30px;
  border : 1px solid #39ac39;
  border-radius: 15px;
  background: #53c653;
  margin-top: 30px;
  font-size: 10pt;
  padding: 4px 5px;
  font-weight: bold;
  color : white;
  
  }
  
  .bhover:hover {
  	background-color: #efefef;
	transition: 0.7s;
  } 
	
  span.font{
  font-size: 12pt;
  font-weight:bold; 
  color:#404040;
  }	
  
  .p:hover {
 	background-color: #efefef;
    transition: 0.7s;
    height:30px;
    border-radius: 15px;
  } 
	
  
  
<script type="text/javascript">

	$(document).ready(function(){
	

	  $('[data-toggle="popover"]').popover();   
	});
		
	}); // end of ready

</script>  
	
</style>
 
 <jsp:include page="/WEB-INF/views/admin/jihee/header.jsp"></jsp:include>
    
 
<div class="border-top"></div>
 
<div class="" >
 <div class="row" >
 
    <div id="leftFirst" class="col-5 border-bottom border-right" >
    	<div style="padding:10px;">
    	 	<a href="#" class="mylink"><span id=subject style="color:black;">내가 쓴 문서 </span><span id="number"> 4 </span></a>
    	 	<a href="#" class="link"><span id=subject style="color:gray;">&nbsp;&nbsp;&nbsp;진행 중 &nbsp;&nbsp;&nbsp;</span></a>
    	 	<a href="#" class="link"><span id=subject style="color:gray;"> 완료</span> <span id="number"> 3</span></a>
    	 </div>
	    <div id="documentContent" class="border-top" style="padding: 20px; "> <!-- height: 200px; -->
	    	<div style="margin : 0 auto; padding-bottom: 10px;]">
		  		<input type="checkbox" id="label-a"/>&nbsp;&nbsp;
		  		<label for="label-a" id="sub" >1-4</label> <span style="font-size: 10pt;"> / 4(코딩)</span>
		 	    <!-- <span id=subject style="font-size: 10pt; padding-top: 0px; margin-top: 0px;" > 1-4 </span><span> / 4(코딩) </span> -->
	    	</div>
	    	
	    	<div id="startContents" class="border-bottom"> 
		    	<div style="margin-bottom : 15px;" class="border-bottom" id="contents" onclick="#" >
		    	
			  		<input type="checkbox" id="label-a"/>&nbsp;&nbsp;
			  		<label for="label-a" id="sub" >이름(코딩)</label> 
			  		<span id="status" style="font-size: 9pt; float:right; margin: 5px;">진행중</span> 
					<br>
					<span style="padding:30px; font-size: 10pt; ">디자인 요청(제목)</span> 
					<span style="font-size: 9pt; float:right; margin: 5px;">11월 16일</span> 
					<br>
					<span style="padding:30px; font-size: 10pt;">요청내용 : 내용</span> 
					<br>
					<span>&nbsp;</span>
					
				
		    	</div>
		    	
		    	<div style="margin : 0 auto;" class="border-bottom" id="contents" onclick="#">
		    	
			  		<input type="checkbox" id="label-a"/>&nbsp;&nbsp;
			  		<label for="label-a" id="sub" >이름(코딩)</label> 
			  		<span id="status" style="font-size: 9pt; float:right; margin: 5px;">진행중</span> 
					<br>
					<span style="padding:30px; font-size: 10pt;">디자인 요청(제목)</span> 
					<span style="font-size: 9pt; float:right; margin: 5px;">11월 16일</span> 
					<br>
					<span style="padding:30px; font-size: 10pt; padding-bottom: 20px;">요청내용 : 내용</span> 
					<br>
					<span>&nbsp;</span>
					
		    	</div>	
		    	
	    	</div>
	    </div> 
	</div>

    <div id="rightFirst" class="col-7" style="text-align: left; padding: 20px 20px;" >
    	
    	<div style="padding : 10px;" id="contents" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="#">
	    	<span id="status" style="font-size: 10pt; "> &nbsp;1/2&nbsp; </span> 
	    	<span style="font-size: 10pt;"> &nbsp;&nbsp;1단계 승인대기 중입니다.</span> 
	    	&nbsp;&nbsp;&nbsp;&nbsp;
	    	<span style="float:right; color:#cccccc; font-weight: bold; padding-left: 20px;">></span>
	    	<span id="profile" style=" float:right;">이름</span>
	    	<span id="profile" style=" float:right;">이름</span> 
    	</div>
    	
    	<div id="parent">
	    	<div id="child" style="margin:17px 0px 10px 10px; font-size: 20pt; font-weight: bold; ">
	    	디자인 요청(제목)</div>
	    	<div id="icon" style="margin-top:22px; float: right;">
	    		<div id="iconhover">
			    	<!-- <i class="bi bi-pencil icon" onclick="#"></i> -->
			    	<div id="iconhover">
					<i class="bi bi-pencil-fill" onclick="#"></i>
					<span>수정</span>
					</div>
		    	</div>
	    	</div>
    	</div>
    	


    	
    	<div style="padding : 10px; padding-bottom: 20px;" class="border-bottom" >
    		<span id="profile" style="margin-right: 10px;">이름</span>
    		<span id="sizebold">이름·</span> <span style="font-size: 10pt;">직책</span>
    		<span style="font-size: 10pt; float:right; color:gray;">2022.11.28(화) 14:25(날짜 코딩)</span>
    	</div>
    	
    	<div style="padding : 10px; padding-bottom: 40px; margin-top: 20px;"  class="border-bottom">
    		<span><i class="bi bi-chat-left-text"></i></span>
    		<span class="font">&nbsp;요청 내용 </span>
    		<div style="font-size: 11pt; margin-top: 5px;">
    			요청내용은 이러합니다.
    			이렇게 들어주셨으면 좋겠습니다. <br>
    			이러이러한 사유로<br>
    			그렇게 됐다.
    		</div>
    		
    		<div style="margin-top: 20px;"> 
	    		<span><i class="bi bi-calendar4-event"></i></span>
	    		<span class="font" style="margin-right: 10px;">&nbsp;희망기한 </span>
	    		<span style="font-size:11pt; color:#262626;">2022.11.28(화) 14:25(날짜 코딩) </span>
			</div>
			
			<button type="button" id="denial" class="bhover">반려</button>
			<button type="button" id="accept" class="bhover">✓ 승인</button>
    		
    	</div>
    	
    	<!-- 첨부파일 토글버튼 -->
    	<div style="padding : 10px;  padding-bottom: 40px; margin-top: 20px;"  class="border-bottom">
	    	<p class="p"  data-bs-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
	    	  <span><i class="bi bi-paperclip"></i></span>
			  <span class="font">
			    첨부파일
			  </span>
			  <span class="font" style="float: right;"> > </span>
			</p>
			<div class="collapse" id="collapseExample">
			  <div class="" style="margin-left: 10px;"> <!-- class="card card-body" -->
			     첨부파일 이지롱<br>
			     그렇게<br>
			     됐다			    
			  </div>
			</div>
		</div>
		
		<!-- 히스토리 토글버튼 -->
    	<div style="padding : 10px; padding-bottom: 40px; margin-top: 20px;">
		   	<p class="p"  data-bs-toggle="collapse" href="#collapseExample2" role="button" aria-expanded="false" aria-controls="collapseExample2">
		   	  <span><i class="bi bi-clock"></i></span>
			  <span class="font">
			    히스토리
			  </span>
			  <span class="font" style="float: right;"> > </span>
			</p>
			<div class="collapse" id="collapseExample2">
			  <div class="" style="margin-left: 10px; margin-bottom: 5px;"> <!-- class="card card-body" -->
			  <span><i class="bi bi-pencil-square"></i></span>
			  <span id="sizebold" style="color: #404040;"> 이름(코딩) </span>
			  <span style="font-size:10pt; color:#404040;"> 님이 문서를 작성했습니다.</span>
			  </div>
			  
			  <div class="" style="margin-left: 10px; margin-bottom: 5px;"> <!-- class="card card-body" -->
			  <span><i class="bi bi-pencil-square"></i></span>
			  <span id="sizebold" style="color: #404040;"> 이름(코딩) </span>
			  <span style="font-size:10pt; color:#404040;"> 님이 문서를 수정했습니다.</span>
			  </div>
			</div>
		</div>
		
    	
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
	       		<span id="status" style="font-size: 10pt; "> &nbsp;1/2&nbsp; </span> 
		    	<span style="font-size: 10pt;"> &nbsp;&nbsp;1단계 승인대기 중입니다.</span> 
		    </div>  
		    
		    <!-- <div id="modalContents">
		    	<span id="modalNumber" style="	margin-top: 10px; margin-left : 30px; ">&nbsp;&nbsp;1&nbsp;&nbsp;</span>
		    	<span id="modalSubContents">
		    		<span id="modalprof">지현</span>
					<span id="status" style="font-size: 9pt; padding: 5px;"> 진행중</span>		
		    	</span>
		    	
		    </div> -->
		    
		    <!-- 내용 시작 -->
		    <div id="modalNumber" style=" float:left; margin-top: 35px; margin-left : 30px; margin-right: 15px; font-size: 10pt; font-weight: bold; padding-top: 5px; color: #333333">
		    &nbsp;&nbsp;1&nbsp;&nbsp;
		    </div>
			<div style="float:left; margin-top: 20px;">   
			    <table>
			    	<tbody>
			    		<tr> 
			    			<td rowspan="2"><span id="modalprof">지현</span></td>
			    		    <td class="td-2" style="vertical-align : bottom; padding-bottom : 0px; margin-bottom: 0px; font-weight: bold; font-size: 11pt;">이름</td>
			    			<td rowspan="2"><span id="status2" style="font-size: 10pt; padding: 3px 5px; float: right;"> 
			    			진행중</span>	</td>
			    		</tr>
			    		<tr> 	
			    			<td style="vertical-align : top; padding-top: 0px; margin-top: 0px; color: gray; font-size: 10pt;">직책</td>
			    		</tr>	
			    	</tbody>
			    </table>
			    <div style="margin-top: 10px;">
			    <span style="font-size: 10pt;"><i class="bi bi-check-lg"></i> 이름님 승인진행중</span>
			    <span style="font-size: 10pt; float:right;">완료시 날짜</span>
			    </div>
     		 </div>
     		  <!-- 내용 끝-->
     		<div id="modalNumber" style=" float:left; margin-top: 35px; margin-left : 30px; margin-right: 15px; font-size: 10pt; font-weight: bold; padding-top: 5px; color: #333333">
		    &nbsp;&nbsp;2&nbsp;&nbsp;
		    </div>
			<div style="float:left; margin-top: 20px;">   
			    <table>
			    	<tbody>
			    		<tr> 
			    			<td rowspan="2"><span id="modalprof">지현</span></td>
			    		    <td class="td-2" style="vertical-align : bottom; padding-bottom : 0px; margin-bottom: 0px; font-weight: bold; font-size: 11pt;">이름</td>
			    			<td rowspan="2"><span id="status2" style="font-size: 10pt; padding: 3px 5px; float: right;"> 
			    			진행중</span>	</td>
			    		</tr>
			    		<tr> 	
			    			<td style="vertical-align : top; padding-top: 0px; margin-top: 0px; color: gray; font-size: 10pt;">직책</td>
			    		</tr>	
			    	</tbody>
			    </table>
			    <div style="margin-top: 10px;">
			    <span style="font-size: 10pt;"><i class="bi bi-check-lg"></i> 이름님 승인진행중</span>
			    <span style="font-size: 10pt; float:right;">완료시 날짜</span>
			    </div>
     		 </div> 
     		 <div id="modalNumber" style=" float:left; margin-top: 35px; margin-left : 30px; margin-right: 15px; font-size: 10pt; font-weight: bold; padding-top: 5px; color: #333333">
		    &nbsp;&nbsp;3&nbsp;&nbsp;
		    </div>
			<div style="float:left; margin-top: 20px;">   
			    <table>
			    	<tbody>
			    		<tr> 
			    			<td rowspan="2"><span id="modalprof">지현</span></td>
			    		    <td class="td-2" style="vertical-align : bottom; padding-bottom : 0px; margin-bottom: 0px; font-weight: bold; font-size: 11pt;">이름</td>
			    			<td rowspan="2"><span id="status2" style="font-size: 10pt; padding: 3px 5px; float: right;"> 
			    			진행중</span>	</td>
			    		</tr>
			    		<tr> 	
			    			<td style="vertical-align : top; padding-top: 0px; margin-top: 0px; color: gray; font-size: 10pt;">직책</td>
			    		</tr>	
			    	</tbody>
			    </table>
			    <div style="margin-top: 10px;">
			    <span style="font-size: 10pt;">✓ 이름님 승인진행중</span>
			    <span style="font-size: 10pt; float:right;">완료시 날짜</span>
			    </div>
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