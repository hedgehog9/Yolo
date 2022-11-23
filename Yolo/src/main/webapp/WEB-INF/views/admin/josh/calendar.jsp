<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>

<style type="text/css">

	.kind-color {
		border-radius: 100%; 
		width: 8px;
		height: 8px; 
		flex: 0 0 auto; 
		margin-top: 5px
	}
	
	.kind-name {
		font-size: 13px;
	}

	ul.ui-autocomplete {
       z-index: 1100;
	}

	nav.top-nav {
        padding-top: 30px;
        padding-right: 40px;
        display: flex;
        align-items: center;
    }
    
    div.plusUser {
    		margin-top: 4px;
    		width:100%;
    		background-color: #e6e6e6;
    		border-radius: 5px;
    		margin-right: 4px;
    		text-align: center;
    }
	
	div.plusUser > i {
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
	
	/* 일요일 날짜 빨간색 */
	.fc-day-sun a {
	  color: red;
	  text-decoration: none;
	}
	
	/* 토요일 날짜 파란색 */
	.fc-day-sat a {
	  color: blue;
	  text-decoration: none;
	}
	
	.fc .fc-button-group>.fc-button {
		background: #07B419;
		border: none;
	}
	
	.fc-today-button {
		background: #07B419;
		border: none;
	}
	
	#calendar > div.fc-header-toolbar.fc-toolbar.fc-toolbar-ltr > div:nth-child(1) > button {
		background: #07B419;
		border: none;
	}
	
	button.fc-dayGridMonth-button.fc-button.fc-button-primary.fc-button-active {
		background: #07B419;
		border: none;
		border-right: 1px solid;
	}
	
	#calendar {
		height: 800px;
	}
	
	
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
            
            $('input#daterange').daterangepicker({
              timePicker: true,
              timePicker24Hour: true,
              startDate: info.dateStr+"09:00",
              endDate: info.dateStr+"18:00",
              locale: {
                "format": 'YYYY-MM-DD HH:mm',
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
              $("input[name='start_date']").val(start.format('YYYY-MM-DD HH:mm'))
              $("input[name='end_date']").val(end.format('YYYY-MM-DD HH:mm'))
          });
        },
        select: function(info) {
            $('#scheduleModal').modal('show');
            //$("span#startdate").text(info.startStr)
            //$("span#enddate").text(info.endStr)
            $("input[name='start_date']").val(info.startStr+" 09:00")
            $("input[name='end_date']").val(info.endStr+" 18:00")
            $('input#daterange').daterangepicker({
              timePicker: true,
              timePicker24Hour: true,
              startDate: info.startStr+"09:00",
              endDate: info.endStr+"18:00",
              locale: {
                "format": 'YYYY-MM-DD HH:mm',
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
                $("input[name='start_date']").val(start.format('YYYY-MM-DD HH:mm'))
                $("input[name='end_date']").val(end.format('YYYY-MM-DD HH:mm'))
            });
            
            //alert('selected ' + info.startStr + ' to ' + info.endStr);
        },
          initialDate: new Date(),
      	  events:function(info, successCallback, failureCallback) {
      		  
      		  $.ajax({
      			  url:"<%= ctxPath %>/schedule/selectScheduleList.yolo",
				  dataType:"JSON",
				  success:function(json) {
					  const events = [];
					  const deptno = '${sessionScope.loginuser.deptno}';
					  // console.log("deptno : " + deptno)
					  
					  if(json.length > 0) {
						  $.each(json, function(index, item){
							  
							  if(item.fk_deptno == deptno) { // 내가 속한 조직 캘린더 보기
								  events.push({
                         	            id: item.schedule_no,
                                         title: item.subject,
                                         start: item.start_date,
                                         end: item.end_date,
                                         color: item.color,
                                         cid: 1,  // 사내캘린더 내의 서브캘린더 체크박스의 value값과 일치하도록 만들어야 한다. 그래야만 서브캘린더의 체크박스와 cid 값이 연결되어 체크시 풀캘린더에서 일정이 보여지고 체크해제시 풀캘린더에서 일정이 숨겨져 안보이게 된다. 
                                         mycontent: item.content,
                                         category: item.category,
                                         place: item.place
								  }); // end of events.push({})---------
							  }
							  else { // 전체 조직 캘린더 보기
								  events.push({
                       	              id: item.schedule_no,
                                       title: item.subject,
                                       start: item.start_date,
                                       end: item.end_date,
                                       color: item.color,
                                       cid: 0, 
                                       mycontent: item.content,
                                       category: item.category,
                                       place: item.place
                          		  }); // end of events.push({})---------
							  }
							  
						  })// end of $.each(json, function(index, item){})
						  successCallback(events);
						  
					  }// end of if
				  },
				  error: function(request, status, error){
			            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			      }	
				  
      		  });
      		  
      	  },// end of  events:function(info, successCallback, failureCallback) {} ---------
      	  eventDidMount: function (arg) {
      		
      		$("select#kind-calendar").change(function() {
      			const kind_calendar = $("select#kind-calendar").val();
	        		  
        		    if(kind_calendar == 0) { // 모든부서 캘린더보기 선택시
        				  arg.el.style.display = "block"; // 풀캘린더에서 모든 일정을 보여준다.
        		    }
        		    else {// 내가속한 조직 캘린더만 볼때
        				  if(arg.event.extendedProps.cid == 1) {
        				      arg.el.style.display = "block"; // 풀캘린더에서 내가속한 조직 캘린더만 보여줌
        				  }
        				  else if(arg.event.extendedProps.cid != 1){
        					  arg.el.style.display = "none"; // 풀캘린더에서 다른 부서들의 캘린더 일정은 숨긴다.
        				  }
        		    }	
        		  
      		})// end of $("select#kind-calendar").change
      		  
      		  
      	  },
      	  eventClick: function(info) {
      		
      		$('#modify_scheduleModal').modal('show');
      		const schedule_no = info.event.id;
      		
      		$.ajax({
      			url:"<%= ctxPath %>/schedule/selectDetailSchedule.yolo",
      			data:{"schedule_no" :schedule_no},
      			dataType:"JSON",
      			success:function(json) {
      				
      				if (json.redirect == "true") {
		                window.location.href = "<%= ctxPath %>/schedule/calendar.yolo";
		            }
      				else {
      					const start_date = json.start_date
          				const end_date = json.end_date
          				$("form[name='schedule_modify_delete'] input[name='start_date']").val(start_date)
          				$("form[name='schedule_modify_delete'] input[name='end_date']").val(end_date)
          				
          				$('input#daterange').daterangepicker({
          	                timePicker: true,
          	                timePicker24Hour: true,
          	                startDate: start_date,
          	                endDate: end_date,
          	                locale: {
          	                  "format": 'YYYY-MM-DD HH:mm',
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
          	                $("form[name='schedule_modify_delete'] input[name='start_date']").val(start.format('YYYY-MM-DD HH:mm'))
          	                $("form[name='schedule_modify_delete'] input[name='end_date']").val(end.format('YYYY-MM-DD HH:mm'))
          	            });
          	      		
          				
          				$("form[name='schedule_modify_delete'] input[name='subject']").val(json.subject)
          				$("form[name='schedule_modify_delete'] select[name='category']").val(json.category)
          				
          				if(json.joinuser != undefined) {
          					const joinuser = json.joinuser.split(",")
          					for(var i=0; i<joinuser.length; i++) {
          						$("div.displayUserList").append("<div class='plusUser'>"+joinuser[i]+"&nbsp;<i class='fas fa-times-circle'></i></div>");
          						
          					}
          				}
          				
          				$("form[name='schedule_modify_delete'] input[name='place']").val(json.place)
          				$("form[name='schedule_modify_delete'] textarea[name='content']").val(json.content)
          				$("form[name='schedule_modify_delete'] input[name='schedule_no']").val(schedule_no)
          				
          				if(json.	fk_empno != '${sessionScope.loginuser.empno}') {
          					$("button#schedule_modify").hide();
          					$("button#schedule_delete").hide();
          					
          					$("form[name='schedule_modify_delete'] input").attr("readonly",true);
          					$("form[name='schedule_modify_delete'] select").attr("disabled",true);
          					$("form[name='schedule_modify_delete'] textarea").attr("readonly",true);
          				}
          				
          				else { // 자기가 작성한 글이 맞다면 위에 막아놓은것들을 다풀어준다.
          					$("button#schedule_modify").show();
          					$("button#schedule_delete").show();
          					
          					$("form[name='schedule_modify_delete'] input").attr("readonly",false);
          					$("form[name='schedule_modify_delete'] select").attr("disabled",false);
          					$("form[name='schedule_modify_delete'] textarea").attr("readonly",false);
          				}
      				}
      				
      				
      				
      				
      			},
      			error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }	
      			
      			
      		})// end of $.ajax ----------------------------------------------------------------------------------------------
      		
      	  }
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
      
      
      
      // 모달에서 x 버튼 클릭스 안의 form 초기화
	  $('.modal').on('hidden.bs.modal', function (e) {
		  $(this).find('form')[0].reset();
		  $("div.displayUserList").empty();
	  });
      
      
     
      // 공유자 x 아이콘 클릭스 삭제하는 메소드
	  $(document).on('click','div.displayUserList > div.plusUser > i',function(){
			let text = $(this).parent().text(); // 이순신(leess/leesunsin@naver.com)
			
			Swal.fire({
				   title: '공유자에서 삭제하시겠습니까?',
				   icon: 'warning',
				   
				   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
				   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
				   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
				   confirmButtonText: '승인', // confirm 버튼 텍스트 지정
				   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
				   
				   reverseButtons: true, // 버튼 순서 거꾸로
				   
				}).then(result => {
				   // 만약 Promise리턴을 받으면,
				   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
					  $(this).parent().remove();
				      Swal.fire('공유자에서 삭제했습니다.',text+' 삭제완료','success');
				   }
				});
				
	  });
      
      
      
      // 캘린더 등록버튼 클릭시 이벤트 =======================================================================================
      $("button#schedule_register").click(function () {
    	  
    	  		
    	  		const daterange = $("form[name='schedule_register'] input#daterange").val().trim()
    	  		if("" == daterange) {
    	  			toastr.warning('기간을 선택해주세요');
    	  			return;
    	  		} 
    	  		
    	  		const subject = $("form[name='schedule_register'] input[name='subject']").val().trim()
    	  		if("" == subject) {
    	  			toastr.warning('제목을 입력해주세요');
    	  			return;
    	  		}
    	  		
    	  		
    	  		let plusUser_elm = document.querySelectorAll("form[name='schedule_register'] div.plusUser");
    			let joinUserArr = [];
    			
    			plusUser_elm.forEach(function(item,index,array){
    				joinUserArr.push(item.innerText.trim());
    			});
    			
    			let joinuser = joinUserArr.join(",");
    			$("form[name='schedule_register'] input[name=joinuser]").val(joinuser);
    			
    			const place = $("form[name='schedule_register'] input[name='place']").val().trim()
    			if("" == place) {
    	  			toastr.warning('장소를 입력해주세요');
    	  			return;
    	  		}
    			
    			const content = $("form[name='schedule_register'] textarea[name='content']").val().trim()
    			if("" == content) {
    	  			toastr.warning('내용을 입력해주세요');
    	  			return;
    	  		}
    			
    			const serialize = $("form[name='schedule_register']").serialize();
    			console.log(serialize)
    			
    			$.ajax({
    				url:"<%= ctxPath %>/schedule/insertSchedule.yolo",
    				type:"POST",
    				data:$("form[name='schedule_register']").serialize(),
    				dataType:"JSON",
    				success:function(json) {
    					
    					if(json.n == 1) {
    						toastr.success('스케줄 등록 성공');
    						setTimeout("location.href='<%= ctxPath %>/schedule/calendar.yolo'", 1000);
    						
    					}
    					else {
    						toastr.error('스케줄 등록 실패');
    					}
    					
    				}
    			});
	  });
   // 캘린더 등록버튼 클릭시 이벤트 끝 =======================================================================================
	   
	   // 캘린더 수정 버튼 클릭시 이벤트 시작
	   $("button#schedule_modify").click(function() {
		   
		   
		   Swal.fire({
			   title: '캘린더를 수정하시겠습니까?',
			   icon: 'warning',
			   
			   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
			   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
			   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
			   confirmButtonText: '승인', // confirm 버튼 텍스트 지정
			   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
			   
			   reverseButtons: true, // 버튼 순서 거꾸로
			   
			}).then(result => {
			   // 만약 Promise리턴을 받으면,
			   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
				   const daterange = $("form[name='schedule_modify_delete'] input#daterange").val().trim()
			  		if("" == daterange) {
			  			toastr.warning('기간을 선택해주세요');
			  			return;
			  		} 
			  		
			  		const subject = $("form[name='schedule_modify_delete'] input[name='subject']").val().trim()
			  		if("" == subject) {
			  			toastr.warning('제목을 입력해주세요');
			  			return;
			  		}
			  		
			  		
			  		let plusUser_elm = document.querySelectorAll("form[name='schedule_modify_delete'] div.plusUser");
					let joinUserArr = [];
					
					plusUser_elm.forEach(function(item,index,array){
						joinUserArr.push(item.innerText.trim());
					});
					
					let joinuser = joinUserArr.join(",");
					$("form[name='schedule_modify_delete'] input[name=joinuser]").val(joinuser);
					
					const place = $("form[name='schedule_modify_delete'] input[name='place']").val().trim()
					if("" == place) {
			  			toastr.warning('장소를 입력해주세요');
			  			return;
			  		}
					
					const content = $("form[name='schedule_modify_delete'] textarea[name='content']").val().trim()
					if("" == content) {
			  			toastr.warning('내용을 입력해주세요');
			  			return;
			  		}
					
					const serialize = $("form[name='schedule_modify_delete']").serialize();
					//console.log(serialize)
					
					$.ajax({
						url:"<%= ctxPath %>/schedule/updateSchedule.yolo",
						type:"POST",
						data:$("form[name='schedule_modify_delete']").serialize(),
						dataType:"JSON",
						success:function(json) {
							
							if(json.n == 1) {
								Swal.fire('스케줄 수정 성공','수정완료','success');
								setTimeout("location.href='<%= ctxPath %>/schedule/calendar.yolo'", 1000);
							}
							else {
								toastr.error('스케줄 수정 실패');
							}
							
						}
					}); 
				   
			      
			   }
			});
	   		
		   
	   
	   })// end of $("button#schedule_modify").click ----------------------
	   // 캘린더 수정 버튼 클릭시 이벤트 끝 ----------------------------------------------------------------------------------
	   
	   // 켈린더 삭제 버튼 클릭시 이벤트 시작
	   $("button#schedule_delete").click(function() {
		   
		   
		   Swal.fire({
			   title: '일정을 삭제하시겠습니까?',
			   icon: 'warning',
			   
			   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
			   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
			   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
			   confirmButtonText: '승인', // confirm 버튼 텍스트 지정
			   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
			   
			   reverseButtons: true, // 버튼 순서 거꾸로
			   
			}).then(result => {
			   // 만약 Promise리턴을 받으면,
			   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
				   
				   const schedule_no = $(this).parent().parent().find("input#modify_schedule_no").val();
				   // console.log("확인용 schedule_no => " + schedule_no)
				   
				   $.ajax({
						url:"<%= ctxPath %>/schedule/deleteSchedule.yolo",
						type:"POST",
						data:{"schedule_no":schedule_no},
						dataType:"JSON",
						success:function(json) {
							
							if(json.n == 1) {
								Swal.fire('캘린더에서 삭제했습니다.','삭제완료','success');
								setTimeout("location.href='<%= ctxPath %>/schedule/calendar.yolo'", 1000);
							}
							else {
								toastr.error('스케줄 삭제 실패');
							}
							
						}
					});
				   
			      
			   }
			});
		   
		   
		   
	   });
	   // 켈린더 삭제 버튼 클릭시 이벤트 끝 ----------------------------------------------------------------------------------
	   

	   // 켈린더 등록 끝  

  })// end of $(document).ready --------------------
  
  // Function Declation
  // div.displayUserList 에 공유자를 넣어주는 함수
	function add_joinUser(value){  // value 가 공유자로 선택한이름 이다.
    	  
		let plusUser_es = $("div.displayUserList > div.plusUser").text();
	
		if(plusUser_es.includes(value)) {  // plusUser_es 문자열 속에 value 문자열이 들어있다라면 
			toastr.error('이미 추가한 회원입니다.');
		}
		
		else {
			$("div.displayUserList").append("<div class='plusUser'>"+value+"&nbsp;<i class='fas fa-times-circle'></i></div>");
			
		}
		
		$("input#joinuser").val("");
		
	}// end of function add_joinUser(value){}----------------------------	

		
		   
			
		
    
</script>

</head>
    <nav class="top-nav border-bottom mb-3">
        <span class="text-muted h4 font-weight-bold">캘린더</span>
    </nav>
    
    <div class="mb-4 d-flex" style="width: 80%;">
      <select id="kind-calendar" class="custom-select custom-select-sm" style="width: 125px;">
        <option value="0">전체 조직</option>
        <option value="1">내가 속한 조직</option>
      </select>
      <div style="margin-left: auto; margin-top: 6px">
      	<div class="d-flex">
      		<div class="kind-color mr-1" style="background: #ffd699;"></div>
      		<span class="kind-name mr-3">미팅</span>
      		<div class="kind-color mr-1" style="background: #bfbfbf;"></div>
      		<span class="kind-name mr-3">출장</span>
      		<div class="kind-color mr-1" style="background: #6666ff;"></div>
      		<span class="kind-name mr-3">회의</span>
      		<div class="kind-color mr-1" style="background: #b380ff;"></div>
      		<span class="kind-name">휴가</span>
      	</div>
      </div>
    </div>

    <div id='calendar' style="width: 80%;"></div>

    <!-- register Modal -->
    <div class="modal fade" id="scheduleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">일정 등록</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form name="schedule_register" id="schedule_register">
	               <div class="modal-body">
	                   <div class="form-group" id="daterange-group">
	                     <label for="email">기간<span style="color: red;">＊</span></label><br>
	                     <input type="text" id="daterange" class="form-control text-center">
	                     <input type="hidden" name="start_date" class="form-control text-center">
	                     <input type="hidden" name="end_date" class="form-control text-center">
	                   </div>
	                   <div class="form-group" id="daterange-group">
	                     <label for="subject">제목<span style="color: red;">＊</span></label><br>
	                     <input type="text" name="subject" class="form-control">
	                   </div>
	                   <div class="form-group">
	                       <label for="category">분류<span style="color: red;">＊</span></label>
	                       <select name="category" id="category" name="category" class="custom-select">
	                           <option>출장</option>
	                           <option>회의</option>
	                           <option>미팅</option>
	                       </select>
	                   </div>
	                   <div class="form-group">
	                     <label for="category">공유자:</label>
	                     <input type="text" class="form-control" id="joinuser" placeholder="일정을 공유할 회원명을 입력하세요">
	                     <div class="displayUserList mt-1"></div>
				   		<input type="hidden" name="joinuser"/>
	                   </div>
	                   <div class="form-group">
	                     <label for="category">장소<span style="color: red;">＊</span></label>
	                     <input type="text" name="place" class="form-control">
	                   </div>
	                   <div class="form-group">
	                     <label for="content">내용<span style="color: red;">＊</span></label>
	                     <textarea name="content" class="form-control" rows="5"></textarea>
	                   </div>
	                   <div class="form-group">
	                     <input type="hidden" name="fk_empno" value="${sessionScope.loginuser.empno}"/> <!-- 여기에 작성자 유저아이디 -->
	                     <input type="hidden" name="fk_deptno" value="${sessionScope.loginuser.deptno}"/> <!-- 여기에 작성자 부서번호 -->
	                   </div>
                </div>
                </form>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                    <button type="button" class="btn btn-primary" id="schedule_register">등록</button>
                </div>
            </div>
        </div>
    </div>
    
    
    
    
    <!-- Modify,Delete Modal -->
    <div class="modal fade" id="modify_scheduleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">일정</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form name="schedule_modify_delete" id="schedule_modify_delete">
	               <div class="modal-body">
	                   <div class="form-group" id="daterange-group">
	                     <label for="daterange">기간<span style="color: red;">＊</span></label><br>
	                     <input type="text" id="daterange" class="form-control text-center">
	                     <input type="hidden" name="start_date" class="form-control text-center">
	                     <input type="hidden" name="end_date" class="form-control text-center">
	                   </div>
	                   <div class="form-group" id="daterange-group">
	                     <label for="subject">제목<span style="color: red;">＊</span></label><br>
	                     <input type="text" name="subject" class="form-control" id="modify_subject">
	                   </div>
	                   <div class="form-group">
	                       <label for="category">분류<span style="color: red;">＊</span></label>
	                       <select name="category" id="category" name="category" class="custom-select" id="modify_category">
	                           <option>출장</option>
	                           <option>회의</option>
	                           <option>미팅</option>
	                       </select>
	                   </div>
	                   <div class="form-group">
	                     <label for="category">공유자:</label>
	                     <input type="text" class="form-control" id="modify_joinuser" placeholder="일정을 공유할 회원명을 입력하세요">
	                     <div class="displayUserList mt-1"></div>
				   		<input type="hidden" name="joinuser"/>
	                   </div>
	                   <div class="form-group">
	                     <label for="category">장소<span style="color: red;">＊</span></label>
	                     <input type="text" name="place" class="form-control" id="modify_place">
	                   </div>
	                   <div class="form-group">
	                     <label for="content">내용<span style="color: red;">＊</span></label>
	                     <textarea name="content" class="form-control" rows="5" id="modify_content"></textarea>
	                   </div>
	                   <div class="form-group">
	                     <input type="hidden" name="schedule_no" id="modify_schedule_no"/> <!-- 여기에 작성자 유저아이디 -->
	                   </div>
                </div>
                </form>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                    <button type="button" class="btn btn-primary" id="schedule_modify">수정</button>
                    <button type="button" class="btn btn-danger" id="schedule_delete">삭제</button>
                </div>
            </div>
        </div>
    </div>
    