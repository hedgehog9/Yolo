<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<% String ctxPath=request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<jsp:include page="leaveCategory.jsp" />

<style type="text/css">
	
	
	div.dashBoard {
		width: 90%;
		margin: 20px 5% 5px 5%;	
	 	
	}
	
	h4 {
		font-size: 20px; 
		font-weight: bold;
		margin-bottom: 15px;
	}
	
	.card {
		border-radius: 1rem;
		cursor: pointer;
	}
	
	.card:hover {
    	background: #ededed;
 	}
 	
 	.card-title {
 		font-size: 13pt;
 		font-weight: bold;
 	}
 	
 	.card-text {
 		margin-top: -3px;
 		color: gray;
 	}
 	
 	span.miniTitle{
 		font-size: 15pt; 
 		font-weight: bold;
 	}
 	
 	span.miniTitleNumber{
 		font-size: 15pt; 
 		font-weight: bold;
 		color: red;
 		margin-left: 10px;
 	}
	
	table {
		margin-top : 10px;
		width: 100%;
	}
	
	tr:hover {
		cursor: pointer;
	}
	
	div.leaveProf{
		width: 40px; 
		height: 40px; 
		border-radius: 40%; 
		text-align: center;
		border: 1px solid #ccced0;
		font-size: 16pt;
		display: flex;
  		align-items: center;
  		padding-left: 4px;
	}
	
	button.submitCancle {
		height: 30px;
		font-size: 10pt;
		font-weight: bold;
		border-radius: 1rem;
		margin-top: 5px;
	} 
	
	td.patop {
		padding-top: 20px;
	} 
	
	td.head {
		width: 70px;
	}
	
	td.tail{
		text-align: right;
		width: 110px;
	}
	
	/* 모달 */
	
	div#yearLeaveModal {
		/* border:solid 2px green; */
		width: 30%;
		height: 100%;
		overflow: auto;
		display: flex;
		flex-direction: column;
		position: fixed;
		top: 0px;
		left: 2000px;
		z-index: 1052;
		background: white;
		border-radius: 0.3rem;
		color: black;
		transition: all 0.5s; 
		padding: 5px;
	}
	
	div#yearLeaveModal.active {
		top: 0px;
		left: 70%;
	}
	
	div#modal_outside {
		position: fixed;
		top: 0px;
		left: 0px;
		width: 100%;
		height: 100%;
		background: rgba(0, 0, 0, 0.2);
		z-index: 1051;
		display: none;
	}
	
	div.modalTop {
		width: 86%;
		margin: auto 7%;
		height: 7%;
		padding-top: 15px;
	}
	
	div.modalMiddle {
		width: 86%;
		margin: auto 7%;
		height: 86%;
	}
	
	div.modalBottom {
		width: 86%;
		margin: auto 7%;
		height: 7%;
		display : flex; 
	}
	
	span.modalBage {
		font-size:14px; 
		font-weight: normal; 
		margin-right: 7px;
	}
	
	input#daterange:hover{
		cursor: pointer;
	}
	
	textarea {
		min-height: 100px;
		width: 100%;
		margin: 20px 0 5px 0;
		border: 1px solid #dddddd;
		border-radius: 0.4rem;
	}
	
	button.leaveUsingBnt {
		width: 100px;
		height: 40px;
		border: 1px solid #07b419;
		border-radius: 0.5rem;
		margin-right: 15px;
		font-weight: bold;
		font-size : 11pt;
		text-align : center;
		background-color: #07b419;
		color: white;
	}
	
	 button.leaveUsingBnt:hover {
		filter: brightness(90%);
	}
	
	/* 파일 입력 */
	
	div.filebox {
		display: flex;
		align-items: center;
	}
	
	.filebox .upload-name {
	    display: inline-block;
	    height: 35px;
	    padding: 0 10px;
	    vertical-align: middle;
	    border: 1px solid #dddddd;
	    width: 70%;
	    border-radius: 0.4rem;
	    color: #999999;
	}
	
	.filebox label {
	    display: inline-block;
	    padding: 7px 20px;
	    color: #fff;
	    vertical-align: middle;
	    text-align: center;
	    background-color: #88eb1e;
	    cursor: pointer;
	    width : 25%;
	    height: 35px;
	    margin-left: 10px;
	    margin-top: 6px;
	    border-radius: 0.4rem;
	    flex-grow: 1;
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

<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />


<script type="text/javascript">

	$(document).ready(function () {
		
		$("span#myLeave").css("color", "#494949");
		
		// 파일 선택하면 선택창 바뀌도록 
		$(document).on('change', "#file",  function () {
		// $("#file").on('change',function(){
			  var fileName = $("#file").val();
			  $(".upload-name").val(fileName.slice(fileName.lastIndexOf("\\")+1));
		});
		
		
		// 날짜선택
		$(document).on('focus', "input#daterange",  function () {
			
			// 히든 넘버 넣어주기
			let num = $("input:radio:checked").val();
			// console.log(num);
			$("input#hiddenNumber").val(num);
			
			setDate(Number(num));
		});
		
          
		// 바깥영역 누르면 닫히는거
		$('#modal_outside').on('click', function () {
			closeLeaveModal();
		});
		
		// x 자 누르면 닫히는거
		$(document).on('click', "button.close",  function () {
			closeLeaveModal();
		});
		
		
		
		
	}); // end of ready 
	
	
	// 모달에 각자연차에 해당 내용을 집어넣기 위해서 데이터를 얻어온다
	function getModaldata(pk_leave_type){
		$.ajax({
	    	url : "<%=ctxPath%>/leave/getLeaveDate.yolo",
	    	data : {"pk_leave_type" : pk_leave_type},
    		dataType: "JSON",
			success: function(json){
				console.log(json);

				let htmlTop = '<span style="font-size:21px;">'+json.emoji+'</span><span class="miniTitle ml-3">'+json.leave_name+'</span>'+
			        '<button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>';
				$("div.modalTop").html(htmlTop);
				
				
				let htmlMiddle = '<form id="requestLeave" name="requestLeave" enctype="multipart/form-data">'+
					      	'<span style="display: block; margin-top: 10px;">&#128204; 휴가정보</span>'+
					      	'<div style="margin: 10px auto;">'+
					      		'<span class="badge modalBage" style="background-color: #f8edeb;">'+json.info1+'</span>'+
					      		'<span class="badge modalBage" style="background-color: #fcd5ce;">'+json.info2+'</span>'+
					      		'<span class="badge modalBage" style="background-color: #f9dcc4;">'+json.info3+'</span>'+
					      	'</div>';
					      	
				if(json.pk_leave_type == "half_annual"){
					htmlMiddle += '<div style="margin-top: 30px;">'+
										'<span style="display: block; margin-top: 10px;">&#9989; 선택하세요</span>'+
										'<div class="btn-group pt-1" data-toggle="buttons">'+
										 ' <label class="btn btn-outline-primary btn-sm  active">'+
										   ' <input type="radio" name="time" id="option1" value="1" autocomplete="off" checked>오전'+
										  '</label>'+
										  '<label class="btn btn-outline-primary btn-sm">'+
										    '<input type="radio" name="time" id="option2" value="1" autocomplete="off">오후'+
										  '</label>'+
										'</div>'+
									'</div>';
				}
				
				if(json.pk_leave_type == "condolence" ){
					htmlMiddle += '<div style="margin-top: 30px;">'+
										'<span style="display: block; margin-top: 10px;">&#9989; 선택하세요</span>'+
										'<div class="btn-group pt-1" data-toggle="buttons">'+
										 ' <label class="btn btn-outline-primary btn-sm active" >'+
										   ' <input type="radio" name="time" id="option1" value="5" autocomplete="off" checked>부모/배우자/자녀(5일)'+
										  '</label>'+
										  '<label class="btn btn-outline-primary btn-sm">'+
										    '<input type="radio" name="time" id="option2" value="3" autocomplete="off">조부모/형제/자매(3일)'+
										  '</label>'+
										'</div>'+
									'</div>';
				}
				
				if(json.pk_leave_type == "marrige" ){
					htmlMiddle += '<div style="margin-top: 30px;">'+
										'<span style="display: block; margin-top: 10px;">&#9989; 선택하세요</span>'+
										'<div class="btn-group pt-1" data-toggle="buttons">'+
										 ' <label class="btn btn-outline-primary btn-sm active"  >'+
										   ' <input type="radio" name="time" id="option1" value="2" autocomplete="off" checked>본인(2일)'+
										  '</label>'+
										  '<label class="btn btn-outline-primary btn-sm">'+
										    '<input type="radio" name="time" id="option2" value="1" autocomplete="off">자녀(1일)'+
										  '</label>'+
										'</div>'+
									'</div>';
				}
				
					      	
							
					if(json.limit_days != 0){
						htmlMiddle += '<div>'+
							      		'<span style="display: block; margin-top: 30px;">&#128161; 사용 가능 '+json.leave_name+' </span>'+
							      		'<span class="badge modalBage" style="background-color: #ffb5a7; margin-top: 10px; font-weight: bold;">'+json.remaining_leave+'일</span>'+
							      	'</div>';
					}
					      	
					htmlMiddle +='<span style="display: block; margin-top: 30px; margin-bottom: 10px;">&#128221; 휴가 일정 · 필요 정보 입력</span>'+
					      	'<input type="text" id="daterange" class="form-control text-center" placeholder="클릭하여 날짜를 지정해주세요" readonly="readonly">'+
					        '<input type="text" name="start_date" class="form-control text-center">'+
					        '<input type="text" name="end_date" class="form-control text-center">'+
					        '<textarea rows="4" style="padding:5px;" placeholder="휴가 등록 메세지 입력"></textarea>';
					        
			        if(json.add_file == 1){
			        	htmlMiddle += '<span style="display: block; margin-top: 30px;">&#128193; 자료첨부 (추후 업로드 가능)</span>'+
			        					'<div class="filebox">'+
										    '<input class="upload-name" value="첨부파일" placeholder="첨부파일" readonly="readonly">'+
										    '<label for="file">파일찾기</label>'+
										    '<input type="file" id="file">'+
										'</div>';
			        }
					
			        
			        // 히든넘버 넣어주기
					if(json.limit_days != 0){
						 htmlMiddle += '<input type="hidden" id="hiddenNumber" value="'+json.remaining_leave+'">';
					} else{
						 htmlMiddle += '<input type="hidden" id="hiddenNumber">';
					}
			        
			        
					htmlMiddle += '</form>';
					 
				$("div.modalMiddle").html(htmlMiddle);
				
				
				let htmlBottom = '<span style="flex-grow: 1;"> </span>'+
									'<button type="button" class="leaveUsingBnt" style="background-color: white; color: #07b419;" onclick="closeLeaveModal();">취소</button>'+
									'<button type="button" class="leaveUsingBnt">휴가신청</button>';
				$("div.modalBottom").html(htmlBottom);
				
				$("input:radio").hide();
				
				
			},
			error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
		}); // end of ajax
		
		
		openLeaveModal();
	}
	
	function setDate(num){
		
		$('input#daterange').daterangepicker({
			// $("#daterange").change(function(){
            locale: {
                "format": 'YYYY-MM-DD',
                "separator": " ~ ",
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
            	
            
              var stDate = new Date(start._d.getFullYear(), start._d.getMonth(), start._d.getDate());
  			  var endDate = new Date(end._d.getFullYear(), end._d.getMonth(), end._d.getDate());
  			  
  			  var btMs = endDate.getTime() - stDate.getTime() ;
		      var btDay = btMs / (1000*60*60*24) ;
              console.log(btDay+1);
              
              if(btDay+1> num ){
            	  
            	  alert('선택 가능 일수를 벗어났습니다. 다시 클릭하여 날짜를 지정해주세요');
            	  //console.log($(this)[0]);
            	  //$(this).value ="클릭하여 날짜를 지정해주세요";
            	  //$("input#daterange").val('');
            	  //$("input#daterange").value = "";
            	  
            	  //$(this)[0].element[0].value = "클릭하여 날짜를 지정해주세요";
            	  //console.log($(this)[0].element[0]);
            	  $("input#daterange").css('background-color','red');
            	  
              } else {
            	  // alert("2")
            	  $("input#daterange").css('background-color','');
              
            	  $("input[name='start_date']").val(start.format('YYYY-MM-DD'));
                  $("input[name='end_date']").val(end.format('YYYY-MM-DD'));
              }
              
          }); 
	}
	
	
	// 열기
	function openLeaveModal(){
		$('#yearLeaveModal').addClass('active');
	    $('#modal_outside').fadeIn();
		
	}
	
	// 닫기
	function closeLeaveModal(){
		$('#yearLeaveModal').removeClass('active');
	    $('#modal_outside').fadeOut();
	    
	    /* const modal_frmArr = document.querySelectorAll("form#requestLeave");
  	  	for(let i=0; i<modal_frmArr.length; i++) {
  			modal_frmArr[i].reset();
  	  	} */
	}
	
	
</script>

	<%-- 대쉬보드 시작 --%>
	<div class="dashBoard">
		<h4 class="my-4">휴가등록</h4>
		<div class="row">
			<c:forEach var="leveType" items="${ requestScope.leaveTypeList}">
				<div class="col-lg-3 mb-4">
				  <div class="card" onclick="getModaldata('${leveType.pk_leave_type }')">
				    <div class="card-body text-left ml-2">
					 	<span style="font-size:30px;">${leveType.emoji }</span>
				     	<h6 class="card-title mt-4">${leveType.leave_name }
				     		<c:if test="${leveType.add_file eq 1}"><span class="badge badge-light rounded-pill ml-2">자료 첨부 필수</span></c:if>
				     	</h6>
				     	<c:if test="${leveType.limit_days eq 0 }">
				     		<p class="card-text">${leveType.limit_info }</p>
				     	</c:if>
				     	<c:if test="${leveType.limit_days ne 0 }">
				     		<p class="card-text">${leveType.remaining_leave }일 </p>
				     	</c:if>
				    </div>
				  </div>
			   </div>
			</c:forEach>
		</div>
	</div>

	<%-- 대쉬보드 끝 --%>
	
	
	<div style="width: 90%; margin: auto; display: flex;">
		<span style="flex-grow: 1;"></span>
		<select>
			<option selected="selected">2022</option>
			<option>2021</option>
			<option>2020</option>
			<option>2019</option>
			<option>2018</option>
		</select>
	</div>
	
	
	<%-- 예정휴가 테이블 --%>
	<%-- 휴가 신청으로 예정된 휴가 있는 경우 --%>
	<div class="dashBoard">
		<span class="miniTitle">예정 휴가</span><span class="miniTitleNumber">6</span>
		<table class="table table-borderless table table-hover ">
		    <tr data-toggle="modal" data-target="#leaveDetail">
		      <td class="head"><div class="leaveProf">&#9978;</div></td>
		      <td class="patop">연차</td>
		      <td class="patop">2022.11.11(금) ~ 2022.11.11(금)<span class="badge badge-light rounded-pill ml-4">4일</span></td>
		      <td class="patop"><span class="badge badge-warning rounded-pill">자료 미첨부</span></td>
		      <td class="patop"><span class="badge badge-light rounded-pill">미승인</span></td>
		      <td class="tail"><button type="button" class="btn btn-outline-secondary btn-sm submitCancle">신청 취소</button></td>
		    </tr>
		    <tr>
		      <td class="head"><div class="leaveProf">&#128420;</div></td>
		      <td class="patop">기타</td>
		      <td class="patop">2022.11.11(금) ~ 2022.11.11(금)<span class="badge badge-light rounded-pill ml-4">1일</span></td>
		      <td class="patop"><span class="badge badge-success rounded-pill">자료 첨부완료</span></td>
		      <td class="patop"><span class="badge badge-dark rounded-pill">승인</span></td>
		      <td class="tail"><button type="button" class="btn btn-outline-secondary btn-sm submitCancle">신청 취소</button></td>
		    </tr>
		    <tr>
		      <td class="head"><div class="leaveProf">&#128420;</div></td>
		      <td class="patop">기타</td>
		      <td class="patop">2022.11.11(금) ~ 2022.11.11(금)<span class="badge badge-light rounded-pill ml-4">1일</span></td>
		      <td class="patop"></td>
		      <td class="patop"><span class="badge badge-dark rounded-pill">승인</span></td>
		      <td class="tail"><button type="button" class="btn btn-outline-secondary btn-sm submitCancle">신청 취소</button></td>
		    </tr>
		</table>
	  </div>
	<%-- 예정된 휴가 없는 경우 --%>
	<%-- 예정 휴가 태이블 끝 --%>
	   
	    
    <%-- 휴가 사용 기록 시작 --%>
    <div class="dashBoard mt-5">
    	<div>
		<span class="miniTitle">사용 기록</span><span class="miniTitleNumber">6</span>
		</div>
		<table class="table table-borderless table table-hover ">
		    <tr>
		      <td class="head"><div class="leaveProf">&#9978;</div></td>
		      <td class="patop">연차</td>
		      <td class="patop">2022.11.11(금) ~ 2022.11.11(금)<span class="badge badge-light rounded-pill ml-4">4일</span></td>
		      <td class="patop"><span class="badge badge-warning rounded-pill">자료 미첨부</span></td>
		      <td class="patop"><span class="badge badge-light rounded-pill">미승인</span></td>
		      <td class="tail"></td>
		    </tr>
		    <tr>
		      <td class="head"><div class="leaveProf">&#127808;</div></td>
		      <td class="patop">리프레쉬</td>
		      <td class="patop">2022.11.11 ~ 2022.11.11<span class="badge badge-light rounded-pill ml-4">1일</span></td>
		      <td class="patop"><span class="badge badge-success rounded-pill">자료 첨부완료</span></td>
		      <td class="patop"><span class="badge badge-dark rounded-pill">승인</span></td>
		      <td class="tail"></td>
		    </tr>
		</table>
	  </div>
    
    <%-- 휴가 사용 기록 끝 --%>     
 
 
<!-- 휴가 상세 모달 -->
<%@ include file="modal/leaveDetailModal.jsp" %>

<div id="modal_outside"></div>

 
<!-- 연차/병가/여름휴가 Modal -->
<div id="yearLeaveModal">
      <div class="modalTop">
      	<!-- <span style="font-size:21px;">&#9978;</span><span class="miniTitle ml-3"> 연차</span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button> -->
       </div>
      <div class="modalMiddle">
      		<!-- <form id="requestLeave" name="requestLeave" enctype="multipart/form-data">
		      	<span style="display: block; margin-top: 10px;">&#128204; 휴가정보</span>
		      	<div style="margin: 10px auto;">
		      		<span class="badge modalBage" style="background-color: #f8edeb;">1년당 25개 사용가능</span>
		      		<span class="badge modalBage" style="background-color: #fcd5ce;">유급</span>
		      		<span class="badge modalBage" style="background-color: #f9dcc4;">연말만료</span>
		      	</div>
		      	<div style="margin-top: 30px;">
					<span style="display: block; margin-top: 10px;">&#9989; 선택하세요</span>
					<div class="btn-group pt-1" data-toggle="buttons">
					  <label class="btn btn-outline-primary btn-sm">
					    <input type="radio" style="display: none;" name="time" id="option1" autocomplete="off">오전
					  </label>
					  <label class="btn btn-outline-primary btn-sm">
					    <input type="radio" style="display: none;" name="time" id="option2" autocomplete="off">오후
					  </label>
					</div>
				</div>
		      	<div>
		      		<span style="display: block; margin-top: 30px;">&#128161; 사용 가능 연차 </span>
		      		<span class="badge modalBage" style="background-color: #ffb5a7; margin-top: 10px; font-weight: bold;">6일</span>
		      	</div>
		      	<span style="display: block; margin-top: 30px;">&#128221; 휴가 일정 · 필요 정보 입력</span>
		      	<input type="text" id="daterange" class="form-control text-center" >
		        <input type="text" name="start_date" class="form-control text-center">
		        <input type="text" name="end_date" class="form-control text-center">
		        <textarea rows="4" cols="" placeholder="휴가 등록 메세지 입력"></textarea>
		        <div class="filebox">
				    <input class="upload-name" value="첨부파일" placeholder="첨부파일" readonly="readonly">
				    <label for="file">파일찾기</label>
				    <input type="file" id="file">
				</div>
			</form> -->
	 </div>
 	 <div class="modalBottom" >
 	 	<!-- <span style="flex-grow: 1;"> </span>
		<button type="button" class="leaveUsingBnt" style="background-color: white; color: #07b419;" onclick="closeLeaveModal();">취소</button>
		<button type="button" class="leaveUsingBnt">휴가신청</button> -->
	</div> 
</div>


