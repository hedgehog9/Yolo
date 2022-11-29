<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>  

<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/css/select2.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/js/select2.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@ttskch/select2-bootstrap4-theme@x.x.x/dist/select2-bootstrap4.min.css">

<style>

    a { text-decoration:none !important }
    a:hover { text-decoration:none !important }

    nav.top-nav {
        padding: 30px 40px;
        display: flex;
    }

    div#schedule-management-content {
        height: 100%;
        padding-top: 8px;
        margin-top: 0px;
    }
    
    div#management-categoty-div {
        margin-top: 8px;
        padding-left: 40px;
        padding-right: 40px;
    }

    a.detail-category {
        background-color: var(--colors-white);
        height: 56px;
        padding-left: 8px;
        padding-right: 8px;
        margin-left: -8px;
        display: flex;
        align-items: center;
        font-size: 15px;
        font-weight: 600;
        cursor: pointer;
    }

    div#date {
        padding-left: 40px;
        padding-right: 40px;
        padding-bottom: 16px;
        padding-top: 16px;
    }

    input#daterange {
        width: 195px;
    }

    span#small-button {
        background-color: rgba(85, 99, 114, 0.12);
        color: rgb(26, 30, 34);
        font-size: small;
    }
    
    div.profile{
		width: 50px; 
		height: 50px; 
		border-radius: 40%; 
		background-color: #239afe;
		color: white;
		text-align: center;
		padding-top: 13px;
		border: 1px solid #ccced0;
		font-weight: bold;
		margin: auto 8px;
	}

    div#gagebar {
        width: 400px;
        height: 8px;
    }
    
    .table td, .table th {
    padding: 0.75rem;
    vertical-align: middle;
    border-top: 1px solid #dee2e6;
	}
	
	.select2-container--bootstrap4 .select2-selection--multiple .select2-selection__choice__remove {
		border: none;
	}
	
</style>

<script>

    $(document).ready(function() {

        let today = new Date();

        getCurrentWeek();
        
        $("#dept-select").select2({
        		theme: 'bootstrap4',
        });
        
        /*
        var bar = new ProgressBar.Line(gagebar, { // 게이지바 생성
            strokeWidth: 4,
            easing: 'easeInOut',
            duration: 1400,
            color: 'yellow',
            trailColor: '#eee',
            trailWidth: 1,
            svgStyle: {width: '100%', height: '100%'}
        }); 

        bar.animate(0.1);  // 게이지바 화면에 뿌리는 코드
        */

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
                "firstDay": 0
            },
            "startDate": today,
            "endDate": today,
            "maxDate": today
        }, function(start, end, label) {
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
            });
            // end of $("input#daterange").daterangepicker


            $("span#today-btn").click(function() {

                getCurrentWeek();
                $("input#daterange").val(today.toISOString().slice(0, 10))

                // 여기서 ajax 시작

            });// end of $("span#today-btn").click -------------

            ////////////////////////////////////////////////////////////////////////////////////////////////
            // 이 코드가 ajax 실행후 들어가게 만들자
            html = "";
            
            for(var i=0; i<10; i++) {

                html += "<tr>"+
                            "<td class='d-flex'>"+
                            "<div class='profile'>길동</div>"+
							"<div>"+
							"<span style='display: block; padding-top: 3px;'>홍길동</span>"+
							"<span style='font-weight: normal; color: gray; font-size: 10pt;'>인사 · 관리자</span>"+
							"</div>"+
                            "</td>"+
                            "<td>123</td>"+
                            "<td><div id ='gagebar"+i+"' style='width: 400px; height: 8px;'></div></td>"+
                            "<td>20</td>"+
                            "<td>60</td>"+
                        "</tr>"
                
            }

            $("#data-body").html(html);

            for(var i=0; i<10; i++) {
                var bar = new ProgressBar.Line('#gagebar'+i, { // 게이지바 생성
                    strokeWidth: 4,
                    easing: 'easeInOut',
                    duration: 1400,
                    color: 'yellow',
                    trailColor: '#eee',
                    trailWidth: 1,
                    svgStyle: {width: '100%', height: '100%'}
                });

                bar.animate(0.1*i);  // 게이지바 화면에 뿌리는 코드
                
            }
            /////////////////////////////////////////////////////////////////////////////////////////////////
    

        
    })// end of $(document).ready 


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
            <a href="<%= ctxPath %>/commute/mycommute.yolo" class="h4 mr-2 text-secondary font-weight-bold">나의 출퇴근</a>
            <a href="#" class="h4 mr-2 text-dark font-weight-bold">관리</a>
        </div>
    </nav>
    <div id="schedule-management-content">
        <div id="management-categoty-div" class="d-flex border-bottom">
            <a href="#" class="text-muted font-weight-bold mr-2 detail-category border-bottom border-dark"><span>주기별 근무</span></a> <!-- border-bottom border-dark 을 사용하여 url에 따라 밑줄 생성 -->
            <a href="#" class="text-muted font-weight-bold mr-2 detail-category"><span>보상휴가</span></a>
            <div style="margin-left: auto">
                <select id="dept-select" class="form-control" multiple="multiple" style="width: 300px">	
			        <option value="apple" selected="selected">개발</option>
			        <option value="watermelon">인사</option>
			        <option value="peach">경영지원</option>
    				</select>
            </div>
        </div>
        <div id="date" class="border-bottom">
            <input type="text" id="daterange" class="mr-1 text-center" readonly/>
            <span class="btn btn-outline-secondary btn-sm mr-2" id="today-btn">오늘</span>
            <span id="small-button" class="text-muted">조회</span>
            <span id="startdate" class="text-muted small"></span> <!-- 시작날짜 -->
            <span id="enddate" class="text-muted small"></span> <!-- 마지막 날짜 -->
        </div>
        <div id="commute-management-div">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>이름</th>
                        <th>사번</th>
                        <th>시간 차트</th>
                        <th>초과 시간</th>
                        <th>합계</th>
                    </tr>
                </thead>
                <tbody id="data-body">
                    <tr>
                        <td>이름나오는 곳</td>
                        <td>123</td>
                        <td><div id="gagebar"></div></td>
                        <td>20</td>
                        <td>60</td>
                    </tr> 
                </tbody>    
            </table>
        </div>
    </div>
</div>