<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

    span#worktime {
        font-weight: 600;
        font-size: 20px;
        padding-left: 40px;
    }

    div#gagebar {
        margin: 20px;
        width: 400px;
        height: 8px;
    }

    th, td {
        text-align: center;
    }

    

</style>

<script>

    

    $(document).ready(function() { 

        let today = new Date();

        getCurrentWeek();

        var bar = new ProgressBar.Line(gagebar, { // 게이지바 생성
            strokeWidth: 4,
            easing: 'easeInOut',
            duration: 1400,
            color: '#FFEA82',
            trailColor: '#eee',
            trailWidth: 1,
            svgStyle: {width: '100%', height: '100%'}
        });

        bar.animate(0.5);  // 게이지바 화면에 뿌리는 코드
        
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

<body>
    <nav class="top-nav border-bottom">
        <div class="category">
            <a href="#" class="h4 mr-2 text-muted font-weight-bold">나의 출퇴근</a>
            <a href="#" class="h4 mr-2 text-muted font-weight-bold">나의 관리</a>
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
                <span id="worktime" style="vertical-align: middle;">20시간</span> <!-- DB에서 일주일 동안 일한 시간가져오기 -->
                <span class="text-secondary"> / 52시간</span>
            </div>
            <div id="gagebar"></div>
        </div>

        <div id="commute-table" class="pt-4">
            <table class="table table-hover">
                <thead class="table-light">
                    <tr>
                        <th>날짜</th>
                        <th>출근시각</th>
                        <th>퇴근시각</th>   
                        <th>근무시간</th>   
                        <th>초과근무시간</th>   
                    </tr>
                </thead>
                <tbody>
                    <div id="schedule-data">
                        <tr>
                            <td>2022.11.07</td>
                            <td>09:00</td>
                            <td>18:00</td>
                            <td>8</td>
                            <td>x</td>
                        </tr>
                    </div>
                </tbody>
          </table>
        </div>
    </div>
</body>