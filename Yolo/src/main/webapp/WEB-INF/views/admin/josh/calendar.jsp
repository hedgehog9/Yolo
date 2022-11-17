<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>

<style type="text/css">

	nav.top-nav {
        padding-top: 30px;
        padding-right: 40px;
        display: flex;
        align-items: center;
    }
    
    span.plusUser{
			float:left; 
			background-color:#737373; 
			color:white;
			border-radius: 10%;
			padding: 8px;
			margin: 3px;
			transition: .8s;
			margin-top: 6px;
	}
	
	span.plusUser > i {
		cursor: pointer;
	}
	
	.ui-autocomplete {
		max-height: 100px;
		overflow-y: auto;
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
                $("input[name='end_date']").val(end.format('YYYY-MM-DD hh:mm'))
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
      
      //////////////////////////////////////////////////////////////////////////////////////////////
      // 켈린더 등록 시작
      // 공유자 추가하기
		$("input#joinuser").bind("keyup",function(){
				var joinuser = $(this).val();
			//	console.log("확인용 joinUserName : " + joinUserName);
				$.ajax({
					url:"<%= ctxPath%>/schedule/insertSchedule/searchJoinUserList.yolo",
					data:{"joinuser":joinuser},
					dataType:"json",
					success : function(json){
						var joinUserArr = [];
				    
					//  input태그 공유자입력란에 "이" 를 입력해본 결과를 json.length 값이 얼마 나오는지 알아본다. 
					//	console.log(json.length);
					
						if(json.length > 0){
							
							$.each(json, function(index,item){
								var name = item.name;
								if(name.includes(joinuser)){ // name 이라는 문자열에 joinUserName 라는 문자열이 포함된 경우라면 true , 
									                             // name 이라는 문자열에 joinUserName 라는 문자열이 포함되지 않은 경우라면 false 
								   joinUserArr.push(name+"("+item.email+")");
								}
							});
							//console.log(joinUserArr);
							$("input#joinuser").autocomplete({  // 참조 https://jqueryui.com/autocomplete/#default
								source:joinUserArr,
								select: function(event, ui) {       // 자동완성 되어 나온 공유자이름을 마우스로 클릭할 경우 
									add_joinUser(ui.item.value);    // 아래에서 만들어 두었던 add_joinUser(value) 함수 호출하기 
									                                // ui.item.value 이  선택한이름 이다.
									return false;
						        },
						        focus: function(event, ui) {
						            return false;
						        } 
							}); 
							
						}// end of if------------------------------------
					}// end of success-----------------------------------
				});
		});
      
      
      // 켈린더 등록 끝  
     



  })// end of $(document).ready --------------------
  
  // Function Declation
  // div.displayUserList 에 공유자를 넣어주는 함수
	function add_joinUser(value){  // value 가 공유자로 선택한이름 이다.
    	  
		let plusUser_es = $("div.displayUserList > span.plusUser").text();
	
	  	console.log("확인용 plusUser_es => " + plusUser_es);
	    
	
		if(plusUser_es.includes(value)) {  // plusUser_es 문자열 속에 value 문자열이 들어있다라면 
			alert("이미 추가한 회원입니다.");
		}
		
		else {
			$("div.displayUserList").append("<span class='plusUser'>"+value+"&nbsp;<i class='fas fa-times-circle'></i></span>");
		}
		
		$("input#joinuser").val("");
		
	}// end of function add_joinUser(value){}----------------------------	

    
</script>

</head>
    <nav class="top-nav border-bottom mb-3">
        <span class="text-muted h4 font-weight-bold">캘린더</span>
    </nav>
    
    <div class="mb-4" style="width: 125px;">
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
                        <input type="text" name="joinuser" class="form-control" id="joinuser" placeholder="일정을 공유할 회원명을 입력하세요">
                        <div class="displayUserList"></div>
						<input type="hidden" name="joinuser"/>
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