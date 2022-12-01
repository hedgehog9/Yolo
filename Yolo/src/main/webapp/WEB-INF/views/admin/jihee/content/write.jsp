<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="/WEB-INF/views/admin/jihee/writeHeader2.jsp"></jsp:include>

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
	border: 1px solid #b3b3b3;
	width: 650px;
	height: 45px;
	font-weight: bold;
	font-size: 13pt;

}

    textarea.search {
	border-radius: 0.5rem;
	border: 1px solid #b3b3b3;
	width: 650px;
	font-weight: bold;
	font-size: 13pt;

}
	
	    span#modalprof{
		width: 45px; 
		height: 45px; 
		border-radius: 40%; 
		background-color: #239afe;
		color: white;
		border: 1px solid #ccced0;
		font-size: 12pt;
		text-align: center;
		padding: 9px 7px;
	}
	
	table#mytable{
    border: 1px solid #ccced0;

   /*  border-style: hidden; */
    
    
   /*  box-shadow: 1 1 1 1px #ccced0; */
    width: 400px;
    height : 500px; 
	font-size: 15pt;
    
  }
  
  td {
  	/* padding :10px 15px; */ /* 이거만 살리기 */
  	/* border : 1px solid; */
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

  

</style>

<script type="text/javascript">

	$(document).ready (function(){
		

		
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
    	var textEle = $('textarea');
    	textEle.on('keyup', function() {
    	  adjustHeight(); // 함수를 실행하면 자동으로 textarea의 높이 조절
    	});
        
        
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
	<form name="wirteFrm">
		<div class="row" style="padding: 0px;">
			
				<div class="col-7 content">
					<img src="<%= ctxPath%>/image/jihee/${requestScope.icon}">
					<span id="fontSubject">${requestScope.subject}</span>	
					<div id="information">${requestScope.information}</div>
					
					<input type="hidden" name="icon" value="${requestScopr.icon}" readonly />
					<input type="hidden" name="name" value="${requestScope.subject}" readonly />
					<input type="hidden" name="information" value="${requestScope.information}" readonly />
					
					<div id="contents">
						내용
						<div style="margin-top: 5px;">
						<textarea class="search" name="contents" id="daterange" placeholder="내용을 입력하세요" style="margin-top: 5px; padding: 6px 10px; "></textarea>
						</div>
					</div>
					<div id="contents">
						희망마감날짜<br>
						<div class="daterange" style="margin-top: 5px;">
						 <input type="text" class="startdate search" id="daterange" name="start_Date" placeholder="날짜 선택" style="margin-top: 5px; padding-left: 10px;"/>
						 
						</div>
						<!-- <input id="search" name="date" placeholder="날짜 선택" style="margin-top: 5px; padding-left: 10px;"/> -->
					</div>
						  
	                 <div id="attachArea">
			        	<div class="filebox">
						    <input class="upload-name" value="첨부파일" placeholder="첨부파일">
						    <label for="file">파일찾기</label> 
						    <input type="file" id="file">
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
			    		<tr>
			    			<th colspan="3" style="color:#4d4d4d; font-size: 12pt; font-weight: bold; padding: 0px 25px;">1단계</th>
			    		</tr>
			    		<tr> 
			    			<td rowspan="2" style="padding-left: 25px;"><span id="modalprof">지현</span></td>
			    		    <td class="td-2" style="vertical-align : bottom; padding-bottom : 0px; margin-bottom: 0px; font-weight: bold; font-size: 12pt;">이름</td>
			    			<td rowspan="2" style="padding-right: 25px;"><span id="status2" style="font-size: 12pt; padding: 3px 5px; float: right;"> 
			    			승인</span>	</td>		    			
			    		</tr>    		
			    		<tr> 	
			    			<td style="vertical-align : top; padding-top: 0px; margin-top: 0px; color: gray; font-size: 11pt;">직책</td>
			    		</tr>
			    		<tr>
			    			<td colspan="3" style="padding: 0px 20px;"><hr></td>
			    		</tr>
			    		<!-- 반복 끝 -->
			    		<tr>
			    			<th colspan="3" style="color:#4d4d4d; font-size: 12pt; font-weight: bold; padding: 0px 25px;">1단계</th>
			    		</tr>
			    		<tr> 
			    			<td rowspan="2" style="padding-left: 25px;"><span id="modalprof">지현</span></td>
			    		    <td class="td-2" style="vertical-align : bottom; padding-bottom : 0px; margin-bottom: 0px; font-weight: bold; font-size: 12pt;">이름</td>
			    			<td rowspan="2" style="padding-right: 25px;"><span id="status2" style="font-size: 12pt; padding: 3px 5px; float: right;"> 
			    			승인</span>	</td>		    			
			    		</tr>    		
			    		<tr> 	
			    			<td style="vertical-align : top; padding-top: 0px; margin-top: 0px; color: gray; font-size: 11pt;">직책</td>
			    		</tr>
			    		<tr>
			    			<td colspan="3" style="padding: 0px 20px;"><hr></td>
			    		</tr>
			    		<tr>
			    			<th colspan="3" style="color:#4d4d4d; font-size: 12pt; font-weight: bold; padding: 0px 25px;">1단계</th>
			    		</tr>
			    		<tr> 
			    			<td rowspan="2" style="padding-left: 25px;"><span id="modalprof">지현</span></td>
			    		    <td class="td-2" style="vertical-align : bottom; padding-bottom : 0px; margin-bottom: 0px; font-weight: bold; font-size: 12pt;">이름</td>
			    			<td rowspan="2" style="padding-right: 25px;"><span id="status2" style="font-size: 12pt; padding: 3px 5px; float: right;"> 
			    			승인</span>	</td>		    			
			    		</tr>    		
			    		<tr> 	
			    			<td style="vertical-align : top; padding-top: 0px; margin-top: 0px; color: gray; font-size: 11pt;">직책</td>
			    		</tr>
			    		<tr>
			    			<td colspan="3" style="padding: 0px 20px;"><hr></td>
			    		</tr>
			    		
			    	</tbody>
			    </table>
	   		 </div>
		</div>	
			
			
		</div>
	</form>
</div>


