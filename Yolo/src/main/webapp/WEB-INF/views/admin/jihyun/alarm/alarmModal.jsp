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
		padding: 10px;
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
    	width: 10px;
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
    	bottom: 30px; 
		left: 30px;
	}
	
	div.alarmProf {
		width: 40px; 
		height: 40px; 
		border-radius: 40%; 
		background-color: #239afe;
		color: white;
		text-align: center;
		padding-top: 8px;
		border: 1px solid #ccced0;
		font-weight: bold;
		font-size: 13px;
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
		$('#alarmModal').addClass('active');
	    $('#alarmModal_outside').fadeIn();
		
	}
	
	// 닫기
	function closeAlarm(){
		$('#alarmModal').removeClass('active');
	    $('#alarmModal_outside').fadeOut();
	}

</script>


<div id="alarmModal_outside" onclick="closeAlarm();"></div>

    
<!-- 알람모달 -->
<div id="alarmModal">
   <div class="alarmBody">
      	<!-- 새로운 소식 시작 -->
      	<div class="alarmTitle">
      		<span style="font-size: 14pt; font-weight: bold; margin-left:7px;  flex-grow: 1;">새로운 소식</span>
      		<button id="allReadAlarm">모두 읽음</button>
      	</div>
      	<div class="alarmlRow">
			<div class="alarmRowInside">
				<div class="alarmProf">길동<div class="redCircle"></div></div>
				<div class="alarmcontent1 ml-3">
					<span class="spanBlock" style="font-weight: bold;">조상운님이 출장비 내역 승인을 신청하셨습니다 확인 바랍니다 </span>
					<span class="spanBlock" style="color: gray; font-size: 10pt;" >약 3시간 전 </span>
				</div>
			</div>
		</div>
		<div class="alarmlRow">
			<div class="alarmRowInside">
				<div class="alarmProf">길동<div class="redCircle"></div></div>
				<div class="alarmcontent1 ml-3">
					<span class="spanBlock" style="font-weight: bold;">조상운님이 출장비 내역 승인을 신청하셨습니다 확인 바랍니다 </span>
					<span class="spanBlock" style="color: gray; font-size: 10pt;" >약 3시간 전 </span>
				</div>
			</div>
		</div>
		<div class="alarmlRow">
			<div class="alarmRowInside">
				<div class="alarmProf">길동<div class="redCircle"></div></div>
				<div class="alarmcontent1 ml-3">
					<span class="spanBlock" style="font-weight: bold;">조상운님이 출장비 내역 승인을 신청하셨습니다 확인 바랍니다 </span>
					<span class="spanBlock" style="color: gray; font-size: 10pt;" >약 3시간 전 </span>
				</div>
			</div>
		</div>
		<div class="alarmlRow">
			<div class="alarmRowInside">
				<div class="alarmProf">길동<div class="redCircle"></div></div>
				<div class="alarmcontent1 ml-3">
					<span class="spanBlock" style="font-weight: bold;">조상운님이 출장비 내역 승인을 신청하셨습니다 확인 바랍니다 </span>
					<span class="spanBlock" style="color: gray; font-size: 10pt;" >약 3시간 전 </span>
				</div>
			</div>
		</div>
		<div class="alarmlRow">
			<div class="alarmRowInside">
				<div class="alarmProf">길동<div class="redCircle"></div></div>
				<div class="alarmcontent1 ml-3">
					<span class="spanBlock" style="font-weight: bold;">조상운님이 출장비 내역 승인을 신청하셨습니다 확인 바랍니다 </span>
					<span class="spanBlock" style="color: gray; font-size: 10pt;" >약 3시간 전 </span>
				</div>
			</div>
		</div>
		<!-- 새로운 소식 끝 -->
		<!-- 지난 소식 시작 -->
		<div class="alarmTitle mt-5">
      		<span style="font-size: 14pt; font-weight: bold; margin-left:7px;  flex-grow: 1;">지난 소식</span>
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
				<div class="alarmProf">길동</div>
				<div class="alarmcontent1 ml-3">
					<span class="spanBlock" style="font-weight: bold;">조상운님이 출장비 내역 승인을 신청하셨습니다 확인 바랍니다 </span>
					<span class="spanBlock" style="color: gray; font-size: 10pt;" >약 3시간 전 </span>
				</div>
			</div>
		</div>
		<!-- 지난 소식 끝 -->
    </div>
</div>