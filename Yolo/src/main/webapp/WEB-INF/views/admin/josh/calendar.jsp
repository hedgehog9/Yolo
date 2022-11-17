<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">

	nav.top-nav {
        padding-top: 30px;
        padding-right: 40px;
        display: flex;
        align-items: center;
    }
    
    /* ========== full calendar css 시작 ========== */
	.fc-header-toolbar {
		height: 30px;
	}
	
	a, a:hover, .fc-daygrid {
	    color: #000;
	    text-decoration: none;
	    background-color: transparent;
	    cursor: pointer;
	} 
	
	.fc-sat { color: #0000FF; }    /* 토요일 */
	.fc-sun { color: #FF0000; }    /* 일요일 */
	/* ========== full calendar css 끝 ========== */

</style>
    
<script>

  $(document).ready(function() {

        var calendarEl = document.getElementById('calendar');
    
        var calendar = new FullCalendar.Calendar(calendarEl, {
        		initialView: 'dayGridMonth',
        		themeSystem: 'Litera',
            selectable: true,
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek'
            },
            dayMaxEventRows: true, // for all non-TimeGrid views
	    	    views: {
	    	      timeGrid: {
	    	        dayMaxEventRows: 3 // adjust to 6 only for timeGridWeek/timeGridDay
	    	      }
	    	    },
            locale : 'ko',
            dateClick: function(info) {
                //alert('clicked ' + info.dateStr);
                $('#scheduleModal').modal('show');
                $("span#startdate").text(info.dateStr)
                $("span#enddate").text(info.dateStr)
                $("input[name='startdate']").val(info.dateStr)
                $("input[name='enddate']").val(info.dateStr)
            },
            select: function(info) {
                $('#scheduleModal').modal('show');
                $("span#startdate").text(info.startStr)
                $("span#enddate").text(info.endStr)
                $("input[name='startdate']").val(info.startStr)
                $("input[name='enddate']").val(info.endStr)
                //alert('selected ' + info.startStr + ' to ' + info.endStr);
            },
            initialDate: new Date(),
            events: [
                {
                start: '2022-08-11T10:00:00',
                end: '2022-08-11T16:00:00',
                display: 'background',
                color: '#ff9f89'
                },
                {
                start: '2022-08-13T10:00:00',
                end: '2022-08-13T16:00:00',
                display: 'background',
                color: '#ff9f89'
                },
                {
                start: '2022-08-24',
                end: '2022-08-28',
                overlap: false,
                display: 'background'
                },
                {
                start: '2022-08-06',
                end: '2022-08-08',
                overlap: false,
                display: 'background'
                }
            ]
        });
    
        calendar.render();



  })// end of $(document).ready --------------------

    
</script>

</head>
    <nav class="top-nav border-bottom mb-3">
        <span class="text-muted h4 font-weight-bold">캘린더</span>
    </nav>

    <div id='calendar' style="width: 80%;"></div>

    <!-- Modal -->
    <form name="schedule_register">
      <div class="modal fade" id="scheduleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
          <div class="modal-dialog modal-dialog-centered" role="document">
              <div class="modal-content">
                  <div class="modal-header">
                      <h5 class="modal-title" id="exampleModalLongTitle">일정 등록</h5>
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                          <span aria-hidden="true">&times;</span>
                      </button>
                  </div>
                  <div class="modal-body">
                    <div class="form-group" id="daterange-group">
                      <label for="email">기간:</label><br>
                      <span class="font-weight-bold">From :</span>
                      <span id="startdate" class="text-muted mr-3"></span> <%-- 시작날짜 --%>
                      <input type="hidden" value="" name="startdate">
                      <span class="font-weight-bold">Until :</span>
                      <span id="enddate" class="text-muted"></span> <%-- 마지막 날짜 --%>
                      <input type="hidden" value="" name="enddate">
                  </div>
                  <div class="form-group">
                      <label for="category">분류:</label>
                      <select name="category" id="category" name="category" class="custom-select">
                          <option>출장</option>
                          <option>회의</option>
                          <option>미팅</option>
                      </select>
                  </div>
                  <div class="form-group">
                    <label for="content">내용:</label>
                    <textarea name="content" class="form-control" rows="5"></textarea>
                  </div>
                  </div>
                  <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                      <button type="button" class="btn btn-primary" onclick="scheduleRegister()">등록</button>
                  </div>
              </div>
          </div>
      </div>
    </form> 