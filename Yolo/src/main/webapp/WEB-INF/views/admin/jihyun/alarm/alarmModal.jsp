<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style>
	
	div#alarmModal {
		/* border:solid 2px green; */
		width : 400px;
		min-height: 200px;
		max-height: 700px;
		overflow: auto;
		display: flex;
		position: fixed;
		top: 1000px;
		left: 0px;
		z-index: 1052;
		background: white;
		border-radius: 0.3rem;
		color: black;
		/* transition: all 0.5s; */
	}
	
	div.alarmBody {
		width:100%;
		margin: 10px auto;
		padding: 5px 15px;
	}
	
	div#alarmModal.active {
		top: 215px;
		left: 360px;
	}
	
	div#alarmModal_outside {
		position: fixed;
		top: 0px;
		left: 0px;
		width: 100%;
		height: 100%;
		background: rgba(0, 0, 0, 0.2);
		z-index: 1051;
		display: none;
	}
	
	#alarmModal::-webkit-scrollbar {
    	width: 8px;
  	}
  	#alarmModal::-webkit-scrollbar-thumb {
    	background-color: #ababab;
    	border-radius: 10px;
  	}
  	#alarmModal::-webkit-scrollbar-track {
    	background-color: #dedfe0;
    	border-radius: 10px;
  	}
	
	div.alarmTitle {
		display: flex;
  		align-items: center;
  		margin: 0px auto 10px auto;
	}
	
	div.alarmlRow {
		border: 1px solid #f9fafa; 
		min-height: 40px;
		padding-top: 5px;
		padding-bottom: 5px;
	}
	
	div.alarmlRow:hover {
		cursor: pointer;
		background-color: #f9fafa;
	}
	
	
	div.alarmRowInside {
		/* border: 1px solid black; */
		width: 97%;
		min-height: 30px;
		margin: 5px auto;
		display: flex;
  		align-items: center;
	}
	
	div.alarmcontent1 {
		width: 280px;
		margin: auto;
	}
	
	span.spanBlock {
		display: block;
		font-size: 11pt;
	}
	
	div.redCircle{
		width: 13px; 
		height: 13px; 
		border-radius: 100%; 
		background: red;
		border: 2px solid white;
		position: relative;
    	bottom: 33px; 
		left: 28px;
	}
	
	div.alarmProf {
		width: 40px; 
		height: 40px; 
		border-radius: 40%; 
		background-color: white;
		color: white;
		text-align: center;
		padding-top: 4px;
		border: 1px solid #ccced0;
		font-weight: bold;
		font-size: 19px;
		margin: auto 4px;
	}
	
	button#allReadAlarm {
		width: 70px;
		height: 27px;
		border : none;
		text-align: center;
		border-radius: 0.5rem;
		margin-right: 7px;
		font-weight: bold;
		font-size : 10pt;
		background-color: #e3f0fd;
		color: #578ec7;
	}
	
	 button#allReadAlarm:hover {
		filter: brightness(90%);
	}  
	
</style>

<script>
	
	// 열기
	function openAlarm(){
		getAlarm();
		getPastAlarm();
		$('#alarmModal').addClass('active');
	    $('#alarmModal_outside').fadeIn();
	}
	
	// 닫기
	function closeAlarm(){
		$('#alarmModal').removeClass('active');
	    $('#alarmModal_outside').fadeOut();
	}
	
	// 새로운 소식 불러오기
	function getAlarm(){
		
		$.ajax({
	    	url : "<%=request.getContextPath()%>/alarm/getAlarmList.yolo",
    		dataType: "JSON",
			success: function(json){ 
				let html = "";
				if(json.length>0){
					$.each(json, function(index, item){
						
						html += '<div class="alarmlRow" onclick="javascript:readAlarm(\''+item.pk_alarmno+'\'); location.href=\'<%=request.getContextPath()%>' + item.url + item.url2 +'\'; ">' +
									'<div class="alarmRowInside">' +
											'<div class="alarmProf">'+item.alarm_type+'<div class="redCircle"></div></div>' +
											'<div class="alarmcontent1 ml-3">' +
												'<span class="spanBlock" style="font-weight: bold;">'+item.alarm_content+'</span>' +
												'<span class="spanBlock" style="color: gray; font-size: 10pt;" >'+item.writedate+' </span>' +
											'</div>' +
									'</div>' +
								'</div>';
						
					});// end of each
					
				} else {
					html+= '<span class="ml-2">새로운 소식이 없습니다.</span>';
				}
				
				$('div#newAlarmResult').html(html);
			},
			error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
			
	    }); // end of ajax 
	}
	
	
	function getPastAlarm(){
		
		$.ajax({
	    	url : "<%=request.getContextPath()%>/alarm/getPastAlarmList.yolo",
    		dataType: "JSON",
			success: function(json){ 
				let html = "";
				if(json.length>0){
					
					$.each(json, function(index, item){
						
						html += '<div class="alarmlRow" onclick="javascript:location.href=\'<%=request.getContextPath()%>' + item.url + item.url2 +'\'; ">' +
									'<div class="alarmRowInside">' +
											'<div class="alarmProf">'+item.alarm_type+'</div>' +
											'<div class="alarmcontent1 ml-3">' +
												'<span class="spanBlock" style="font-weight: bold;">'+item.alarm_content+'</span>' +
												'<span class="spanBlock" style="color: gray; font-size: 10pt;" >'+item.writedate+' </span>' +
											'</div>' +
									'</div>' +
								'</div>';
						
					});// end of each
					
				} else {
					html+= '<span class="ml-2">지난 소식이 없습니다.</span>';
				}
				
				$('div#pastAlarmResult').html(html);
			},
			error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
			
	    }); // end of ajax 
	}
	
	
	// 새로운 소식 읽기 
	function readAlarm(alarmno){
		$.ajax({
	    	url : "<%=request.getContextPath()%>/alarm/readAlarm.yolo",
	    	data:{"alarmno":alarmno},
	    	type: 'POST',
			success: function(){ 
					
			},
			error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
			
	    }); // end of ajax 
	}
	
	
	// 모든 새로운 소식 읽기
	function readAllAlarm(){
		$.ajax({
	    	url : "<%=request.getContextPath()%>/alarm/readAllAlarm.yolo",
			success: function(){ 
				getAlarm();
				getPastAlarm();
			},
			error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
			
	    }); // end of ajax 
	}

</script>


<div id="alarmModal_outside" onclick="closeAlarm();"></div>

    
<!-- 알람모달 -->
<div id="alarmModal">
   <div class="alarmBody">
      	<!-- 새로운 소식 시작 -->
      	<div class="alarmTitle">
      		<span style="font-size: 14pt; font-weight: bold; margin-left:7px;  flex-grow: 1;">새로운 소식</span>
      		<button id="allReadAlarm" onclick="readAllAlarm()">모두 읽음</button>
      	</div>
      	
      	<div id="newAlarmResult"></div>
      	
      	<!-- <div class="alarmlRow">
			<div class="alarmRowInside">
				<div class="alarmProf">&#9200;<div class="redCircle"></div></div>
				<div class="alarmcontent1 ml-3">
					<span class="spanBlock" style="font-weight: bold;">연차촉진 등...</span>
					<span class="spanBlock" style="color: gray; font-size: 10pt;" >약 3시간 전 </span>
				</div>
			</div>
		</div>
		<div class="alarmlRow">
			<div class="alarmRowInside">
				<div class="alarmProf">&#10071;<div class="redCircle"></div></div>
				<div class="alarmcontent1 ml-3">
					<span class="spanBlock" style="font-weight: bold;">결재 취소이면 댈 듯</span>
					<span class="spanBlock" style="color: gray; font-size: 10pt;" >약 3시간 전 </span>
				</div>
			</div>
		</div>
		<div class="alarmlRow">
			<div class="alarmRowInside">
				<div class="alarmProf">&#9989;<div class="redCircle"></div></div>
				<div class="alarmcontent1 ml-3">
					<span class="spanBlock" style="font-weight: bold;"> 결재 승인완료대면? </span>
					<span class="spanBlock" style="color: gray; font-size: 10pt;" >약 3시간 전 </span>
				</div>
			</div>
		</div>
		<div class="alarmlRow">
			<div class="alarmRowInside">
				<div class="alarmProf">&#128161;<div class="redCircle"></div></div>
				<div class="alarmcontent1 ml-3">
					<span class="spanBlock" style="font-weight: bold;"> 공지사항이나 결재문서 들어온거 </span>
					<span class="spanBlock" style="color: gray; font-size: 10pt;" >약 3시간 전 </span>
				</div>
			</div>
		</div>
		<div class="alarmlRow">
			<div class="alarmRowInside">
				<div class="alarmProf">&#128226;<div class="redCircle"></div></div>
				<div class="alarmcontent1 ml-3">
					<span class="spanBlock" style="font-weight: bold;"> 공지사항이나 결재문서 들어온거 </span>
					<span class="spanBlock" style="color: gray; font-size: 10pt;" >약 3시간 전 </span>
				</div>
			</div>
		</div>
		<div class="alarmlRow">
			<div class="alarmRowInside">
				<div class="alarmProf">&#128178;<div class="redCircle"></div></div>
				<div class="alarmcontent1 ml-3">
					<span class="spanBlock" style="font-weight: bold;">급여지급되면??  </span>
					<span class="spanBlock" style="color: gray; font-size: 10pt;" >약 3시간 전 </span>
				</div>
			</div>
		</div> -->
		<!-- 새로운 소식 끝 -->
		
		<!-- 지난 소식 시작 -->
		<div class="alarmTitle mt-5">
      		<span style="font-size: 14pt; font-weight: bold; margin-left:7px;  flex-grow: 1;">지난 소식</span>
      	</div>
      	
      	<div id="pastAlarmResult"></div>
      	
      	<!-- <div class="alarmlRow">
			<div class="alarmRowInside">
				<div class="alarmProf">길동</div>
				<div class="alarmcontent1 ml-3">
					<span class="spanBlock" style="font-weight: bold;">조상운님이 출장비 내역 승인을 신청하셨습니다 확인 바랍니다 </span>
					<span class="spanBlock" style="color: gray; font-size: 10pt;" >약 3시간 전 </span>
				</div>
			</div>
		</div>
		<div class="alarmlRow">
			<div class="alarmRowInside">
				<div class="alarmProf">길동</div>
				<div class="alarmcontent1 ml-3" style="width: 300px;">
					<span class="spanBlock" style="font-weight: bold;">조상운님이 출장비 내역 승인을 신청하셨습니다 확인 바랍니다 </span>
					<span class="spanBlock" style="color: gray; font-size: 10pt;" >약 3시간 전 </span>
				</div>
			</div>
		</div>
		<div class="alarmlRow">
			<div class="alarmRowInside">
				<div class="alarmProf">길동</div>
				<div class="alarmcontent1 ml-3">
					<span class="spanBlock" style="font-weight: bold;">조상운님이 출장비 내역 승인을 신청하셨습니다 확인 바랍니다 </span>
					<span class="spanBlock" style="color: gray; font-size: 10pt;" >약 3시간 전 </span>
				</div>
			</div>
		</div>
		<div class="alarmlRow">
			<div class="alarmRowInside">
				<div class="alarmProf">&#128178;</div>
				<div class="alarmcontent1 ml-3">
					<span class="spanBlock" style="font-weight: bold;">급여지급되면?? </span>
					<span class="spanBlock" style="color: gray; font-size: 10pt;" >약 3시간 전 </span>
				</div>
			</div>
		</div> -->
		<!-- 지난 소식 끝 -->
    </div>
</div>