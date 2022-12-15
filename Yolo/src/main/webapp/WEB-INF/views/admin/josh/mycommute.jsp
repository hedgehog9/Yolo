<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
   
<% String ctxPath = request.getContextPath(); %>    
    
<style type="text/css">
    a { text-decoration:none !important }
    a:hover { text-decoration:none !important }

    nav.top-nav {
        padding: 30px 40px;
        display: flex;
    }

    div#commute-content {
        padding-top: 16px;
    }

    div#date {
        padding-left: 40px;
        padding-right: 40px;
        padding-bottom: 16px;
    }

    input#daterange {
        width: 195px;
    }

    span#small-button {
        background-color: rgba(85, 99, 114, 0.12);
        color: rgb(26, 30, 34);
        font-size: small;
    }

    div#display-worktime {
        height: 30px;
        margin-top: auto;
    }

    span#plus_worktime {
        font-weight: 600;
        font-size: 20px;
        padding-left: 40px;
    }

    div#gagebar {
        margin: 20px;
        width: 400px;
        height: 8px;
    }

	input:focus{
      outline-color: #07B419;
    }	
    
    .form-control:focus {
	   box-shadow:none;
	   border: 2px solid #07B419;
	}
	
	.select2-container--bootstrap4.select2-container--focus .select2-selection {
		box-shadow: none;
		border: 2px solid #07B419;
	}
	
	.select2-container--bootstrap4 .select2-selection--multiple .select2-search__field {
		width: 80% !important;
	}


</style>

<script>

    

    $(document).ready(function() { 

        let today = new Date();

        getCurrentWeek();
        
        let plus_worktime = "${requestScope.plus_worktime}";
        let hour = Math.floor((plus_worktime/60));
        
        $("span#plus_worktime").text(hour+"시간");
        
        // console.log(hour/40)

        var bar = new ProgressBar.Line(gagebar, { // 게이지바 생성
            strokeWidth: 4,
            easing: 'easeInOut',
            duration: 1400,
            color: '#66cc66',
            trailColor: '#eee',
            trailWidth: 1,
            svgStyle: {width: '100%', height: '100%'}
        });

        bar.animate(hour/40);  // 게이지바 화면에 뿌리는 코드
        
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        // DateRange API 호출 시작
        $("input#daterange").daterangepicker({
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
            },
            "startDate": today,
            "endDate": today,
            "maxDate": today
        }, function(start, end, label) {
        			let html = "";
        	
                start = new Date(start.format('YYYY-MM-DD'))
                const sunday = start.getTime() - 86400000 * start.getDay();
        
                start.setTime(sunday);
            
                const result = [start.toISOString().slice(0, 10)];
        
                for (let i = 1; i < 7; i++) {
                    start.setTime(start.getTime() + 86400000);
                    result.push(start.toISOString().slice(0, 10));
                }
                // console.log(result[1], result[5])
                start = result[1];
                end = result[5];

                $("span#startdate").text(start)
                $("span#enddate").text("~ "+end)

                // 여기서 ajax 시작
                $.ajax({
                		url:"<%=ctxPath%>/commute/ajaxMycommute.yolo",
                		data:{"startdate":start,
                			  "enddate":end,
                			  "fk_empno":'${sessionScope.loginuser.empno}'},
                		dataType:"JSON",
                		success:function(json){
                			plus_worktime = 0;
                			let hour = 0;
                			let minute = 0;
                			
                			if(json.length > 0) {
                				
							$.each(json, function(index,item){
	                					
	            					let worktime = item.worktime;
	            					let overtime = item.overtime;
	            					plus_worktime += Number(worktime);
	            					plus_worktime += Number(overtime);
	            					
	            					if(worktime == 0) {
	            						worktime = worktime+" 시간" 
	            					}
	            					else {
	            						hour = Math.floor(worktime/60);
	            						minute = worktime%60;
	            						worktime = hour+"시간 "+minute+"분"
	            					}
	            					
	            					if(overtime == 0) {
	            						overtime = overtime+" 시간" 
	            					}
	            					else {
	            						hour = Math.floor(worktime/60);
	            						minute = overtime%60;
	            						overtime = hour+"시간 "+minute+"분"
	            					}
	            					
	            					if(item.start_work_time == 'X') {
	            						item.start_work_time = "<i class='fas fa-times'></i>";
	            					}
	            					if(item.end_work_time == 'X') {
	            						item.end_work_time = "<i class='fas fa-times'></i>";
	            					}
	            					
	            					html += "<tr>"+
	            								"<td><span class='badge badge-dark rounded-pill'>"+item.dt+"</span></td>"+
	            								"<td><span class='badge badge-light rounded-pill'>"+item.start_work_time+"</span></td>"+
	            								"<td><span class='badge badge-light rounded-pill'>"+item.end_work_time+"</span></td>"+
	            								"<td><span class='badge badge-light rounded-pill'>"+worktime+"</span></td>"+
	            								"<td><span class='badge badge-warning rounded-pill'>"+overtime+"</span></td>"+
	            							"</tr>"
	            				})// end of $.each ------------------------------
                				
                				$("tbody#schedule-data").html(html)
                				
                				hour = Math.floor((plus_worktime/60));
							
							$("span#plus_worktime").text(hour+"시간");
						    bar.animate(hour/40);
                			}
                			
                		}
                		
                })// end of ajax 
            });
            // end of $("input#daterange").daterangepicker



            $("span#today-btn").click(function() { // '오늘' 버튼을 클릭할시

            		location.reload();
            		
            });// end of $("span#today-btn").click -------------

            

    });// end of $(document).ready --------------------------------------

    
   // Funtion Declation     
   function getCurrentWeek() { // DateRnage 에서 특정날짜 선택시 해당하는 일주일의 평일 '월' 날짜와 '금' 날짜를 가져옴

        let start;
        let end;

        const day = new Date();
        const sunday = day.getTime() - 86400000 * day.getDay();

        day.setTime(sunday);

        const result = [day.toISOString().slice(0, 10)];

        for (let i = 1; i < 7; i++) {
            day.setTime(day.getTime() + 86400000);
            result.push(day.toISOString().slice(0, 10));
        }

        start = result[1];
        end = result[5];

        $("span#startdate").text(start)
        $("span#enddate").text("~ "+end)

    }
       
    

    

</script>

<div style="width: 90%; margin : 0 5% 0 5%;">
    <nav class="top-nav border-bottom">
        <div class="category">
            <a href="#" class="h4 mr-2 text-dark font-weight-bold">나의 출퇴근</a>
            <c:if test="${sessionScope.loginuser.empno == 9999}">
            		<a href="<%= ctxPath %>/admin/commuteManagement.yolo" class="h4 mr-2 text-secondary font-weight-bold">관리</a>
            </c:if>
        </div>
    </nav>
    <div id="commute-content">
        <div id="date" class="border-bottom">
            <input type="text" id="daterange" class="mr-1 text-center" readonly/>
            <span class="btn btn-outline-secondary btn-sm mr-2" id="today-btn">오늘</span>
            <span id="small-button" class="text-muted">조회</span>
            <span id="startdate" class="text-muted small"></span> <!-- 시작날짜 -->
            <span id="enddate" class="text-muted small"></span> <!-- 마지막 날짜 -->
        </div>
        <div id="worktime-gagebar" class="d-flex border-bottom">
            <div id="display-worktime">
                <span id="plus_worktime" style="vertical-align: middle;"></span> <!-- DB에서 일주일 동안 일한 시간가져오기 -->
                <span class="text-secondary"> / 40시간</span>
            </div>
            <div id="gagebar"></div>
        </div>

        <div id="commute-table" class="pt-4">
            <table class="table table-hover">
                <thead class="table-light">
                    <tr>
                        <th><span style='font-size:20px;'>&#128198;</span>날짜</th>
                        <th><span style='font-size:20px;'>&#128337;</span>출근시각</th>
                        <th><span style='font-size:20px;'>&#128337;</span>퇴근시각</th>   
                        <th><span style='font-size:20px;'>&#9203;</span>근무시간</th>   
                        <th><span style='font-size:20px;'>&#9200;</span>초과근무시간</th>   
                    </tr>
                </thead>
                <tbody id="schedule-data">
                		<c:forEach var="commute" items="${requestScope.commuteList}">
                			<tr>
	                         <td><span class='badge badge-dark rounded-pill'>${commute.dt}</span></td>
	                         <c:if test="${commute.start_work_time != 'X'}">
	                         	<td><span class='badge badge-light rounded-pill'>${commute.start_work_time}</span></td>
	                         </c:if>
	                         <c:if test="${commute.start_work_time == 'X'}">
	                         	<td><span class='badge badge-light rounded-pill'><i class="fas fa-times"></i></span></td>
	                         </c:if>
	                         <c:if test="${commute.end_work_time != 'X'}">
	                         	<td><span class='badge badge-light rounded-pill'>${commute.end_work_time}</span></td>
	                         </c:if>
	                         <c:if test="${commute.end_work_time == 'X'}">
	                         	<td><span class='badge badge-light rounded-pill'><i class="fas fa-times"></i></span></td>
	                         </c:if>
	                         <c:if test="${commute.worktime == '0'}">
	                         	<td><span class='badge badge-light rounded-pill'>${commute.worktime} 시간</span></td>
	                         </c:if>
	                         <c:if test="${commute.worktime != '0'}">
	                         	<td><span class='badge badge-light rounded-pill'>${commute.worktime}</span></td>
	                         </c:if>
	                         <c:if test="${commute.overtime == '0'}">
	                         	<td><span class='badge badge-warning rounded-pill'>${commute.overtime} 시간</span></td>
	                         </c:if>
	                         <c:if test="${commute.overtime != '0'}">
	                         	<td><span class='badge badge-warning rounded-pill'>${commute.overtime}</span></td>
	                         </c:if>
                    		</tr>
                		</c:forEach>
                </tbody>
          </table>
        </div>
    </div>
</div>