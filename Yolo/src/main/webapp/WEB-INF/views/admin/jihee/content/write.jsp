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

	margin: 30px 0px;

}

.card:hover {
	background-color: #efefef;
	cursor: pointer;
	border-radius: 0.5rem;
}
	
span#fontSubject {
	
	font-size: 20pt;
	font-weight: bold;
	margin-top: 25px;
	margin-left: 5px;
	vertical-align: bottom; 
	
}

div#information {
	
	font-size: 10pt;
	margin-left: 5px;
	margin-top: 10px;

}

img {

	width: 30px;
	height: 35px;
	margin: 5px;
}

div#contents {
	
	font-size: 12pt;
	color: #4d4d4d;
	font-weight: bold;
	margin: 20px 5px;

}

    input.search {
	border-radius: 0.5rem;
	border: 1px solid #b3b3b3;
	width: 700px;
	height: 35px;
	font-weight: bold;
	font-size: 10pt;

}

    textarea.search {
	border-radius: 0.5rem;
	border: 1px solid #b3b3b3;
	width: 700px;
	font-weight: bold;
	font-size: 10pt;

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
/*     height : 300px; */

    
  }
  
  td {
  	padding :10px 15px;
  	/* border : 1px solid; */
  }
  
  td.td-2 {
  	width: 50%;
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
  
  hr {
    background:#bfbfbf;
    height:1px;
    border:0;
}

  

</style>

<script type="text/javascript">

	$(document).ready (function(){
		

		
        // === 전체 datepicker 옵션 일괄 설정하기 ===  
		 //     한번의 설정으로 $("input#fromDate"), $('input#toDate')의 옵션을 모두 설정할 수 있다.
        $(function() {
            //모든 datepicker에 대한 공통 옵션 설정
            $.datepicker.setDefaults({
                 dateFormat: 'yy/mm/dd' //Input Display Format 변경
                ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
                ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
                ,changeYear: true //콤보박스에서 년 선택 가능
                ,changeMonth: true //콤보박스에서 월 선택 가능                
             //   ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
             // ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
             // ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
             // ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
                ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
                ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
                ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
                ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
                ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
             // ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
             // ,maxDate: "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                    
          
            });
 
            //input을 datepicker로 선언
            $("input#startDate").datepicker();                    
            
            //From의 초기값을 오늘 30일 전으로 설정
//         $('input#startDate').datepicker('setDate', '-30D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
            
            //To의 초기값을 3일후로 설정
//          $('input#endDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)     
        
        });
        
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
		
<div class="container">
	<form name="wirteFrm">
		<div class="row">
			
				<div class="col-8 content">
					<img src="<%= ctxPath%>/image/jihee/${requestScope.icon}">
					<span id="fontSubject">${requestScope.subject}</span>	
					<div id="information">${requestScope.information}</div>
					
					<input type="hidden" name="icon" value="${requestScopr.icon}" readonly />
					<input type="hidden" name="name" value="${requestScope.subject}" readonly />
					<input type="hidden" name="information" value="${requestScope.information}" readonly />
					
					<div id="contents">
						내용
						<div>
						<textarea class="search" name="contents" placeholder="내용을 입력하세요" style="margin-top: 5px; padding: 6px 10px; "></textarea>
						</div>
					</div>
					<div id="contents">
						희망마감날짜
						<div class="daterange" style="display:inline;">
						 <input type="text" class="datepicker search" id="startDate" name="startDate" placeholder="날짜 선택" style="margin-top: 5px; padding-left: 10px;"/>
						</div>
						<!-- <input id="search" name="date" placeholder="날짜 선택" style="margin-top: 5px; padding-left: 10px;"/> -->
					</div>
				</div>	
			
			
		<div class="col-4 " style="margin-top:30px;">
			<div style="float:left;">   
			    <table>
			    	<thead>
			    		<tr>
			    			<th colspan="3" style="padding: 25px 10px 25px 25px; ">승인 · 참조 대상</th>
			    		</tr>
			    	</thead>
			    	<tbody>
			    		<!-- 반복시작 -->
			    		<tr>
			    			<th colspan="3" style="color:#4d4d4d; font-size: 10pt; font-weight: bold; padding: 0px 25px;">1단계</th>
			    		</tr>
			    		<tr> 
			    			<td rowspan="2" style="padding-left: 25px;"><span id="modalprof">지현</span></td>
			    		    <td class="td-2" style="vertical-align : bottom; padding-bottom : 0px; margin-bottom: 0px; font-weight: bold; font-size: 11pt;">이름</td>
			    			<td rowspan="2" style="padding-right: 25px;"><span id="status2" style="font-size: 10pt; padding: 3px 5px; float: right;"> 
			    			승인</span>	</td>		    			
			    		</tr>    		
			    		<tr> 	
			    			<td style="vertical-align : top; padding-top: 0px; margin-top: 0px; color: gray; font-size: 10pt;">직책</td>
			    		</tr>
			    		<tr>
			    			<td colspan="3" style="padding: 0px 20px;"><hr></td>
			    		</tr>
			    		<!-- 반복 끝 -->
			    		<tr>
			    			<th colspan="3" style="color:#4d4d4d; font-size: 10pt; font-weight: bold; padding: 0px 25px;">2단계</th>
			    		</tr>
			    		<tr> 
			    			<td rowspan="2" style="padding-left: 25px;"><span id="modalprof">지현</span></td>
			    		    <td class="td-2" style="vertical-align : bottom; padding-bottom : 0px; margin-bottom: 0px; font-weight: bold; font-size: 11pt;">이름</td>
			    			<td rowspan="2" style="padding-right: 25px;"><span id="status2" style="font-size: 10pt; padding: 3px 5px; float: right;"> 
			    			승인</span>	</td>		    			
			    		</tr>    		
			    		<tr> 	
			    			<td style="vertical-align : top; padding-top: 0px; margin-top: 0px; color: gray; font-size: 10pt;">직책</td>
			    		</tr>
			    		<tr>
			    			<td colspan="3" style="padding: 0px 20px;"><hr></td>
			    		</tr>
			    		
			    		<tr>
			    			<th colspan="3" style="color:#4d4d4d; font-size: 10pt; font-weight: bold; padding: 0px 25px;">3단계</th>
			    		</tr>
			    		<tr> 
			    			<td rowspan="2" style="padding-left: 25px;"><span id="modalprof">지현</span></td>
			    		    <td class="td-2" style="vertical-align : bottom; padding-bottom : 0px; margin-bottom: 0px; font-weight: bold; font-size: 11pt;">이름</td>
			    			<td rowspan="2" style="padding-right: 25px;"><span id="status2" style="font-size: 10pt; padding: 3px 5px; float: right;"> 
			    			승인</span>	</td>		    			
			    		</tr>    		
			    		<tr> 	
			    			<td style="vertical-align : top; padding-top: 0px; margin-top: 0px; color: gray; font-size: 10pt;">직책</td>
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


