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
          selectable: true,
          themeSystem: 'Litera',
          headerToolbar: {
              left: 'prev,next today',
              center: 'title',
              right: 'dayGridMonth,timeGridWeek'
          },
          locale : 'ko',
          dateClick: function(info) {
            //alert('clicked ' + info.dateStr);
            $('#scheduleModal').modal('show');
            //$("span#startdate").text(info.dateStr)
            //$("span#enddate").text(info.dateStr)
            $("input[name='start_date']").val(info.dateStr+" 09:00")
            $("input[name='end_date']").val(info.dateStr+" 18:00")
            
            $('input[name="daterange"]').daterangepicker({
              timePicker: true,
              timePicker24Hour: true,
              startDate: info.dateStr+"09:00",
              endDate: info.dateStr+"18:00",
              locale: {
                "format": 'YYYY-MM-DD hh:mm',
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
              $("input[name='start_date']").val(start.format('YYYY-MM-DD hh:mm'))
              $("input[name='end_date']").val(end.format('YYYY-MM-DD hh:mm'))
          });
        },
        select: function(info) {
            $('#scheduleModal').modal('show');
            //$("span#startdate").text(info.startStr)
            //$("span#enddate").text(info.endStr)
            $("input[name='start_date']").val(info.startStr+" 09:00")
            $("input[name='end_date']").val(info.endStr+" 18:00")
            $('input[name="daterange"]').daterangepicker({
              timePicker: true,
              timePicker24Hour: true,
              startDate: info.startStr+"09:00",
              endDate: info.endStr+"18:00",
              locale: {
                "format": 'YYYY-MM-DD hh:mm A',
                "separator": " ~ ",
                "applyLabel": "확인",
                "cancelLabel": "취소",
                "fromLabel": "From",
                "toLabel": "To",
                "customRangeLabel": "Custom",
                "weekLabel": "W",
                "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
                "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
                
              },
              
            },function(start, end, label) {
                $("input[name='start_date']").val(start.format('YYYY-MM-DD hh:mm'))
                $("input[name='end_date']").val(end.format('YYYY-MM-DD'))
            });
            
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
    
    <div class="mb-4" style="width: 100px;">
      <select class="custom-select custom-select-sm">
        <option>전체 조직</option>
        <option>내가 속한 조직</option>
      </select>
    </div>

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
                        <input type="text" name="daterange" class="form-control text-center">
                        <input type="hidden" name="start_date" class="form-control text-center">
                        <input type="hidden" name="end_date" class="form-control text-center">
                      </div>
                      <div class="form-group" id="daterange-group">
                        <label for="email">제목:</label><br>
                        <input type="text" name="subject" class="form-control">
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
                        <label for="category">공유자:</label>
                        <input type="text" name="joinuser" class="form-control">
                      </div>
                      <div class="form-group">
                        <label for="category">장소:</label>
                        <input type="text" name="place" class="form-control">
                      </div>
                      <div class="form-group">
                        <label for="content">내용:</label>
                        <textarea name="content" class="form-control" rows="5"></textarea>
                      </div>
                      <div class="form-group">
                        <input type="hidden" name="fk_userid" value=""/> <!-- 여기에 작성자 유저아이디 -->
                        <input type="hidden" name="fk_departmentno" value=""/> <!-- 여기에 작성자 부서번호 -->
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