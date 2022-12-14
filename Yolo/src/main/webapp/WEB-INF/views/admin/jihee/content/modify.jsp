<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="/WEB-INF/views/admin/jihee/writeHeader3.jsp"></jsp:include>

<style type="text/css">

.container {

	/* text-align: center;  */
	
/* 	margin-left: 30%; */
}

.content {

	padding: 50px 0px 0px 70px;

}

.card:hover {
	background-color: #efefef;
	cursor: pointer;
	border-radius: 0.5rem;
}
	
span#fontSubject {
	
	font-size: 25pt;
	font-weight: bold;
	margin-top: 25px;
	margin-left: 5px;
	vertical-align: bottom; 
	
}

div#information {
	
	font-size: 13pt;
	margin-left: 5px;
	margin-top: 10px;

}

img {

	width: 40px;
	height: 40px;
	margin: 5px;
}

div#contents {
	
	font-size: 15pt;
	color: #4d4d4d;
	font-weight: bold;
	margin: 25px 5px;

}

    input.search {
	border-radius: 0.5rem;
	border: 1px solid #dddddd;
	width: 650px;
	height: 45px;
	font-weight: bold;
	font-size: 13pt;

}

    textarea.search {
	border-radius: 0.5rem;
	border: 1px solid #dddddd; /* #b3b3b3 */
	width: 650px;
	height : 200px;
	font-weight: bold;
	font-size: 13pt;

}
	
	    span#modalprof{
		width: 45px; 
		height: 45px; 
		border-radius: 40%; 
		/* background-color: #239afe; */
		color: white;
		border: 0px solid #ccced0;
		font-size: 12pt;
		text-align: center;
		padding: 9px 7px;
	}
	
	table#mytable{
    border: 1px solid #ccced0;
   

   /*  border-style: hidden; */
    
    
   /*  box-shadow: 1 1 1 1px #ccced0; */
    width: 400px;
   /*  height : 500px;   */
	font-size: 15pt;
	
    
  }
  
  td.td-1 {
  	/* padding :10px 15px; */ /* 이거만 살리기 */
  	/* border : 1px solid; */
  	padding-top: 14.5px;
  	padding-bottom: 14.5px;
  }
  
  td.td-2 {
  	width: 50%;
  }
   
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
  
  hr {
    background:#bfbfbf;
    height:1px;
    border:0;
}

input:focus {
	outline : 2px solid #66cc66;
}

textarea:focus {
	outline : 2px solid #66cc66;
}



	
	textarea::placeholder {
    color: #999999;
    font-weight: normal;
	}
	
	
	div#attachArea {
		width: 80%;
		margin: 0 10% 15px 0px;
	}
	
	.filebox .upload-name {
	    display: inline-block;
	    height: 40px;
	    padding: 0 10px;
	    vertical-align: middle;
	    border: 1px solid #dddddd;
	    width: 70%;
	    border-radius: 0.4rem;
	    color: #999999;
	}
	
	.filebox .upload-name:focus {
		outline : 2px solid #66cc66;
	}
	
	.filebox label {
	    display: inline-block;
	    padding: 9px 20px;
	    color: #fff;
	    vertical-align: middle;
	    text-align: center;
	    background-color: #88eb1e;
	    cursor: pointer;
	    width : 25%;
	    height: 40px;
	    margin-left: 5px;
	    margin-top: 5px;
	    border-radius: 0.4rem;
	}
	
	.filebox input[type="file"] {
	    position: absolute;
	    width: 0;
	    height: 0;
	    padding: 0;
	    overflow: hidden;
	    border: 0;
	}
	

</style>

<script type="text/javascript">

	$(document).ready (function(){
		
		$("#file").on('change',function(){
			  var fileName = $("#file").val();
			  $(".upload-name").val(fileName);
		});
		

		
        // === 전체 datepicker 옵션 일괄 설정하기 ===  
		 //     한번의 설정으로 $("input#fromDate"), $('input#toDate')의 옵션을 모두 설정할 수 있다.
        
           
        	 $("input#daterange").daterangepicker({
 				singleDatePicker: true,
 				timePicker: true,
 				timePicker24Hour: true,
 				startDate: new Date(),
 				locale: {
 				"format": 'YYYY-MM-DD',
 				"applyLabel": "확인",
 				"cancelLabel": "취소",
 				"fromLabel": "From",
 				"toLabel": "To",
 				"customRangeLabel": "Custom",
 				"weekLabel": "W",
 				"daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
 				"monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
 				
 				}
 				},function(start, end, label) {
 				
 				});
        
        	 //input을 datepicker로 선언
        
        

    	//textarea 높이 조절    	
    	/* var textEle = $('textarea');
    	textEle.on('keyup', function() {
    	  adjustHeight(); // 함수를 실행하면 자동으로 textarea의 높이 조절
    	});
         */
        
	}); // end of $(document).ready (function()
	
			
	//textarea 높이조절 함수		
	function adjustHeight() {
  	  var textEle = $('textarea');
  	  textEle[0].style.height = 'auto';
  	  var textEleHeight = textEle.prop('scrollHeight');
  	  textEle.css('height', textEleHeight);
  	};		
  	

  

            
</script>
		
<div class="contai" style="overflow-x: hidden;">
	<form name="wirteFrm" enctype="multipart/form-data">
		<div class="row" style="padding: 0px;">
			
				<div class="col-7 content">
					<img src="<%= ctxPath%>/image/jihee/${requestScope.icon}"> 
					<span id="fontSubject">${requestScope.subject}</span>	
					<div id="information">${requestScope.information}</div>
					
					<input type="hidden" name="fk_writer_empno" value="${requestScope.empno}" readonly />
					<input type="hidden" name="deptno" value="${requestScope.deptno}" readonly />
					<input type="hidden" name="icon" value="${requestScope.icon}" readonly />
					<input type="hidden" name="doc_subject" value="${requestScope.subject}" readonly />
					<input type="hidden" name="information" value="${requestScope.information}" readonly />
					
					<div id="contents">
						내용
						<div style="margin-top: 5px;">
						<textarea class="search" name="doc_contents" id="daterange" placeholder="" style="margin-top: 5px; padding: 6px 10px; ">${requestScope.contents}</textarea>
						</div>
					</div>
					<div id="contents">
						희망마감날짜<br>
						<div class="daterange" style="margin-top: 5px;">
						 <input type="text" class="startdate search" id="daterange" name="D_day" placeholder="날짜 선택" style="margin-top: 5px; padding-left: 10px;"/>
						 
						</div>
						<!-- <input id="search" name="date" placeholder="날짜 선택" style="margin-top: 5px; padding-left: 10px;"/> -->
					</div>
						  
			       <div id="attachArea">
			        	<div class="filebox">
			        		<label for="file">파일 찾기</label> 
						    <input class="upload-name" value="${requestScope.orgfilename}" placeholder="첨부파일">
						    <input type="file" id="file" multiple="multiple" name="attach">
						</div>
			        </div>

				</div>	
			
			
		<div class="col-5 " style="margin-top:50px; padding-left: 20px; width: 500px;">
			<div style="float:left;">   
			    <table style="border-collapse: collapse; border-radius: 10px;" id="mytable">
			    	<thead>
			    		<tr>
			    			<th colspan="3" style="padding: 25px 10px 25px 25px; ">승인 · 참조 대상</th>
			    		</tr>
			    	</thead>
			    	<tbody>
			    		<!-- 반복시작 -->
			    		<c:if test="${not empty requestScope.appList}">
			    		<c:forEach var="map" items="${requestScope.appList}">
			    		<tr>
			    			<th colspan="3" style="color:#4d4d4d; font-size: 12pt; font-weight: bold; padding: 0px 25px;">${map.levelno}단계</th>
			    		</tr>
			    		<tr> 
			    			<c:set var="TextValue" value="${map.name}"/>
			    			<td class="td-1" rowspan="2" style="padding-left: 25px;"><span id="modalprof" style="background-color: ${map.profile_color}">${fn:substring(TextValue,1,3)}</span></td>
			    		    <td class="td-2 td-1" style="vertical-align : bottom; padding-bottom : 0px; margin-bottom: 0px; font-weight: bold; font-size: 12pt;">${map.name} </td>
			    			<td class="td-1" rowspan="2" style="padding-right: 25px;"><span id="status2" style="font-size: 12pt; padding: 3px 5px; float: right;"> 
			    			승인</span>	</td>		    			
			    		</tr>    		
			    		<tr> 	
			    			<td class="td-1" style="vertical-align : top; padding-top: 0px; margin-top: 0px; color: gray; font-size: 11pt;">${map.position} · ${map.deptname}</td>
			    		</tr>
			    		<tr>
			    			<td class="td-1" colspan="3" style="padding: 0px 20px;"><hr></td>
			    		</tr>
			    		</c:forEach>
			    		</c:if>
			    		<c:if test="${empty requestScope.appList}">
			    		비었따
			    		</c:if>
			    		<!-- 반복 끝 -->
			    		
			    		
			    	</tbody>
			    </table>
	   		 </div>
		</div>	
			
			
		</div>
	</form>
</div>


