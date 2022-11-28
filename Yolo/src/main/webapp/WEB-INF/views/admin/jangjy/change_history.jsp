<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath();%>    


<style>
	 div#peopleContent{
    	margin-right:10px;
    }
    
    div#header{
    	display:flex;
    	justify-content: space-between;
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
    button#changeOk{
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
   	
    
</style>

<script>
	
	$(document).ready(function(){
		
		<%-- ===== 달력 하나만 출력 시작 =====  --%>
		$("input.daterange").daterangepicker({
            "singleDatePicker": true,
            "locale": {
                "format": "YYYY-MM-DD", // 날짜표현 형식
                "separator": " - ",
                "applyLabel": "선택",
                "cancelLabel": "취소",
                "fromLabel": "From",
                "toLabel": "To",
                "customRangeLabel": "Custom",
                "weekLabel": "W",
                "daysOfWeek": [
                    "일",
                    "월",
                    "화",
                    "수",
                    "목",
                    "금",
                    "토"
                ],
                "monthNames": [
                    "1월",
                    "2월",
                    "3월",
                    "4월",
                    "5월",
                    "6월",
                    "7월",
                    "8월",
                    "9월",
                    "10월",
                    "11월",
                    "12월"
                ],
                "firstDay": 1
            }
        });
		<%-- ===== 달력 하나만 출력 끝 =====  --%>
		
	}); // end of document.ready()----------------------------------------------------
	
	
	
	<%-- bootstrap 툴팁 --%>
	$(function () {
		$('[data-toggle="tooltip"]').tooltip()
	});
	
	
	

	
</script>






<div id="peopleContent">

		<div id="header">
	        <div id="header_title">
	            <a href="<%= ctxPath%>/people.yolo"><span class="title">구성원</span></a>
	            <a href="<%= ctxPath%>/organization_chart.yolo"><span class="title">조직도</span></a>
	            <a href="<%= ctxPath%>/change_history.yolo"><span class="title">인사 정보 관리</span></a>
	        </div>
	        <div id="button_title">
	            <button id="change_dept" type="button" class="btn" data-toggle="modal" data-target="#modal_change_hrInfo"><span><i class="fas fa-pen" style="margin:0px; width:20px;"></i>&nbsp;&nbsp;인사 발령하기</span></button>
	        </div>
	    </div>
	    
	    <div  style="margin:10px 20px;">
	    	<h2 style="margin-bottom: 20px;">인사발령 내역 조회</h2>
			<table id="tbl_history" class="table table-hover">
				<thead>
					<tr>
						<th>발령 라벨,이름,시간</th>
						<th>발령 전 부서</th>
						<th>발령 후 부서</th>
						<th>발령 전 직급</th>
						<th>발령 후 직급</th>
						<th>메모</th>
						<th>버튼</th>
					</tr>
				</thead>
				<tbody>
					<%-- ===================== 반복문으로 출력할 묶음 시작  ===================== --%>
					<tr>
						<td>
							<div class="div_name">
								<div class="div_label">인사발령 라벨</div>							
								<div class="div_name">홍길동 ,<span class="span_time">2022.11.17(목) 오후 5:33</span></div>							
							</div>
						</td>
						<td>인사</td>
						<td>마케팅</td>
						<td>대리</td>
						<td>과장</td>
						<td>메모 n 글자 이상인 경우 ... 으로 출력</td>
					<td>
						<span data-toggle="tooltip" data-placement="left" title="메모 수정">
							<button type="button" class="btn edit_memo" data-toggle="modal" data-target="#modal_change_memo" >
								<i class="fas fa-pen edit"></i>
							</button>
						</span>
					</td>
				</tr>
			    	<%-- ===================== 반복문으로 출력할 묶음 끝  ===================== --%>
					
				</tbody>
			</table>
	</div>
</div>



<!-- ========================== 퇴직 처리하기 모달 시작 ========================== -->
<div class="modal fade" id="modal_change_hrInfo">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<!-- Modal header -->
				<div class="modal-header">
					<h5 class="modal-title">인사 발령</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<!-- Modal body -->
				<div class="modal-body">
					<form name="frm_appointment">
					<%-- =========== 발령일 =========== --%>
					<div>
						<div>
							<div class="modal_title">발령일</div>
							<input id="appointment_date" type="text" class="daterange" />
						</div>
					</div>
					<%-- =========== 발령일 =========== --%>
					
					<%-- =========== 발령라벨 =========== --%>
					<div style="margin: 20px 0px;">
						<div class="modal_title">발령 라벨 </div>
						
						<button id="btn" class=" btn choice_type" type="button" data-toggle="dropdown">
							<div style="display:flex; justify-content: space-between; width:460px;">
								<div id="retirement_type">발령라벨 선택</div> <i class="fas fa-bars" style="padding:5px;"></i>
							</div>
						</button>
						
						<div class="dropdown-menu">
							<button class="btn_label dropdown-item" type="button">직무 변경</button>
							<button class="btn_label dropdown-item" type="button">부서 변경</button>
							<button class="btn_label dropdown-item" type="button">인사 변경</button>
						</div>
					</div>
					<%-- =========== 발령라벨 =========== --%>
					
					<%-- =========== 부서 =========== --%>
					<div style="margin: 20px 0px;">
						<div class="modal_title">부서</div>
						
						<button id="btn" class=" btn choice_type" type="button" data-toggle="dropdown">
							<div style="display:flex; justify-content: space-between; width:460px;">
								<div id="retirement_type">부서 선택</div> <i class="fas fa-bars" style="padding:5px;"></i>
							</div>
						</button>
						
						<div class="dropdown-menu">
							<button class="btn_dept dropdown-item" type="button">부서1</button>
							<button class="btn_dept dropdown-item" type="button">부서2</button>
							<button class="btn_dept dropdown-item" type="button">부서3</button>
						</div>
					</div>
					<%-- =========== 부서 =========== --%>
					
					<%-- =========== 세부 부서 =========== --%>
					<div style="margin: 20px 0px;">
						<div class="modal_title">부서</div>
						
						<button id="btn" class=" btn choice_type" type="button" data-toggle="dropdown">
							<div style="display:flex; justify-content: space-between; width:460px;">
								<div id="retirement_type">세부부서 선택</div> <i class="fas fa-bars" style="padding:5px;"></i>
							</div>
						</button>
						
						<div class="dropdown-menu">
							<button class="btn_detail_dept dropdown-item" type="button">세부부서1</button>
							<button class="btn_detail_dept dropdown-item" type="button">세부부서2</button>
							<button class="btn_detail_dept dropdown-item" type="button">세부부서3</button>
						</div>
					</div>
					<%-- =========== 세부 부서 =========== --%>
					
					<div>
						<div class="modal_title">메모</div>
						<textarea class="memo"rows="5" cols="30" placeholder="메모 입력"></textarea>
					</div>
					</form>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn " data-dismiss="modal">취소</button>
					<button id="changeOk" type="button" class="btn"><i class="fas fa-check"></i>발령하기</button>
				</div>
			</div>
		</div>
</div>
<!-- ========================== 퇴직 처리하기 모달 끝 ========================== -->


<!-- ========================== 퇴직 처리하기 모달 시작 ========================== -->
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
						<%-- DB에 값이 입력되어 있는 경우 값 불러오기 , 아닌 경우 placeholder 출력  --%>
						<textarea id="textarea_memo" rows="" cols="" placeholder="메모를 입력하세요"></textarea>
					</form>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button id="changeOk" type="button" class="btn" style="width: 100%;">저장</button>
				</div>
			</div>
		</div>
</div>
<!-- ========================== 퇴직 처리하기 모달 끝 ========================== -->




















