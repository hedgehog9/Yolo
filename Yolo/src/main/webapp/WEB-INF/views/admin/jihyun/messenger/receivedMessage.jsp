<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="messengerHeader.jsp" />

<style>
 
	div#sendedMessenger{
		height: 100%;
		width: 100%;
	}
	
	div#messengertop {
		background-color: #f9fafa;
		color: #575757;
		font-size:10pt;
		font-weight: bold;
		height: 35px;
		width: 100%;
		display: flex;
  		align-items: center;
	}
	
	/* table {
		width: 75%;
		margin: auto;
		text-align: center;
	}
	
	td{
		border: 1px solid black;
	} */
	
	div.mailRow {
		border: 1px solid #f9fafa; 
		min-height: 110px;
	}
	
	
	div.mailRowInside {
		/* border: 1px solid black; */
		width: 97%;
		min-height: 90px;
		margin: 10px auto;
		display: flex;
  		align-items: center;
	}
	
	span.spanBlock {
		display: block;
		font-size: 11pt;
	}
	
	div.mailcontent1:hover {
		cursor: pointer;
	}
	
	/* span.spanBlock:hover {
		cursor: pointer;
	} */
	
	button.mailBnt {
		width: 100px;
		height: 40px;
		border: 1px solid #07b419;
		border-radius: 0.5rem;
		margin-right: 15px;
		font-weight: bold;
		font-size : 11pt;
		background-color: #07b419;
		color: white;
		display: none;
	}
	
	 button.mailBnt:hover, button.mailTopBtn:hover {
		filter: brightness(90%);
	}  
	
	 button.mailTopBtn {
	 	padding : 1px 15px;
		height: 25px;
		border: none;
		border-radius: 1rem;
		margin-right: 20px;
		font-size : 10pt;
		background-color: #C0C0C0;
		color: white;
	 }

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("span#rcvmsg").css("color", "#494949");
		
		// 화면 높이만큼 body div에 height를 주겠다
		/* const web_browser_height = $(window).height(); 
		$("div#right").css({"height":web_browser_height}); */
		
		$("div.mailRow").hover(function(){
									$(this).css("background-color","#f9fafa");
									$(this).find("button").css("display","block")
								}
								, function(){
									$(this).css("background-color","");
									$(this).find("button").css("display","")
								});
		
		
	}); // end of ready

</script>


	
<div id="sendedMessenger">
	<div id="messengertop">
		<input type="checkbox" class="ml-2"/>
		<span class="ml-2" style="flex-grow: 1;">안 읽은 메신저(4)</span>
		<button type="button" class="mailTopBtn">선택 메신저 읽기</button>
		<button type="button"  class="mailTopBtn">안 읽은 메신저 모두 읽기</button>
	</div>
	
	<div class="mailRow">
		<div class="mailRowInside">
			<div style="width: 30px;">
				<input type="checkbox" style=" margin-bottom: 45px; margin-right: 15px;">
			</div>
			<div id="prof" class="mt-3">길동</div>
			<div class="mailcontent1 ml-4" style="width: 500px;">
				<span style="font-weight: bold;">메신저 제목 부분 입니다</span><span style="margin-left: 20px; font-size: 10pt;">2022-11-15 14:02:42</span>
				<span class="spanBlock" style="font-size: 10pt;">지현 · 인사</span>
				<span class="spanBlock mt-1" style="color: gray">메신저 내용 미리보기 부분입니다 </span>
			</div>
			<button class="mailBnt" style="background-color: white; color: #07b419; margin-left: 620px;">전달하기</button>
			<button class="mailBnt">답장하기</button>
		</div>
	</div>
	
	<!-- 반복시작 -->
	<div class="mailRow">
		<div class="mailRowInside">
			<div style="width: 30px;">
				<input type="checkbox" style=" margin-bottom: 45px; margin-right: 15px;">
			</div>
			<div id="prof" class="mt-3">길동</div>
			<div class="mailcontent1 ml-4" style="width: 500px;">
				<span style="font-weight: bold;">메신저 제목 부분 입니다</span><span style="margin-left: 20px; font-size: 10pt;">2022-11-15 14:02:42</span>
				<span class="spanBlock" style="font-size: 10pt;">지현 · 인사</span>
				<span class="spanBlock mt-1" style="color: gray">메신저 내용 미리보기 부분입니다 </span>
			</div>
			<button class="mailBnt" style="background-color: white; color: #07b419; margin-left: 620px;">전달하기</button>
			<button class="mailBnt">답장하기</button>
		</div>
	</div>
	<div class="mailRow">
		<div class="mailRowInside">
			<div style="width: 30px;">
				<input type="checkbox" style=" margin-bottom: 45px; margin-right: 15px;">
			</div>
			<div id="prof" class="mt-3">길동</div>
			<div class="mailcontent1 ml-4" style="width: 500px;">
				<span style="font-weight: bold;">메신저 제목 부분 입니다</span><span style="margin-left: 20px; font-size: 10pt;">2022-11-15 14:02:42</span>
				<span class="spanBlock" style="font-size: 10pt;">지현 · 인사</span>
				<span class="spanBlock mt-1" style="color: gray">메신저 내용 미리보기 부분입니다 </span>
			</div>
			<button class="mailBnt" style="background-color: white; color: #07b419; margin-left: 620px;">전달하기</button>
			<button class="mailBnt">답장하기</button>
		</div>
	</div>
	<div class="mailRow">
		<div class="mailRowInside">
			<div style="width: 30px;">
				<input type="checkbox" style=" margin-bottom: 45px; margin-right: 15px;">
			</div>
			<div id="prof" class="mt-3">길동</div>
			<div class="mailcontent1 ml-4" style="width: 500px;">
				<span style="font-weight: bold;">메신저 제목 부분 입니다</span><span style="margin-left: 20px; font-size: 10pt;">2022-11-15 14:02:42</span>
				<span class="spanBlock" style="font-size: 10pt;">지현 · 인사</span>
				<span class="spanBlock mt-1" style="color: gray">메신저 내용 미리보기 부분입니다 </span>
			</div>
			<button class="mailBnt" style="background-color: white; color: #07b419; margin-left: 620px;">전달하기</button>
			<button class="mailBnt">답장하기</button>
		</div>
	</div>
	<div class="mailRow">
		<div class="mailRowInside">
			<div style="width: 30px;">
				<input type="checkbox" style=" margin-bottom: 45px; margin-right: 15px;">
			</div>
			<div id="prof" class="mt-3">길동</div>
			<div class="mailcontent1 ml-4" style="width: 500px;">
				<span style="font-weight: bold;">메신저 제목 부분 입니다</span><span style="margin-left: 20px; font-size: 10pt;">2022-11-15 14:02:42</span>
				<span class="spanBlock" style="font-size: 10pt;">지현 · 인사</span>
				<span class="spanBlock mt-1" style="color: gray">메신저 내용 미리보기 부분입니다 </span>
			</div>
			<button class="mailBnt" style="background-color: white; color: #07b419; margin-left: 620px;">전달하기</button>
			<button class="mailBnt">답장하기</button>
		</div>
	</div>
	<div class="mailRow">
		<div class="mailRowInside">
			<div style="width: 30px;">
				<input type="checkbox" style=" margin-bottom: 45px; margin-right: 15px;">
			</div>
			<div id="prof" class="mt-3">길동</div>
			<div class="mailcontent1 ml-4" style="width: 500px;">
				<span style="font-weight: bold;">메신저 제목 부분 입니다</span><span style="margin-left: 20px; font-size: 10pt;">2022-11-15 14:02:42</span>
				<span class="spanBlock" style="font-size: 10pt;">지현 · 인사</span>
				<span class="spanBlock mt-1" style="color: gray">메신저 내용 미리보기 부분입니다 </span>
			</div>
			<button class="mailBnt" style="background-color: white; color: #07b419; margin-left: 620px;">전달하기</button>
			<button class="mailBnt">답장하기</button>
		</div>
	</div>
	<div class="mailRow">
		<div class="mailRowInside">
			<div style="width: 30px;">
				<input type="checkbox" style=" margin-bottom: 45px; margin-right: 15px;">
			</div>
			<div id="prof" class="mt-3">길동</div>
			<div class="mailcontent1 ml-4" style="width: 500px;">
				<span style="font-weight: bold;">메신저 제목 부분 입니다</span><span style="margin-left: 20px; font-size: 10pt;">2022-11-15 14:02:42</span>
				<span class="spanBlock" style="font-size: 10pt;">지현 · 인사</span>
				<span class="spanBlock mt-1" style="color: gray">메신저 내용 미리보기 부분입니다 </span>
			</div>
			<button class="mailBnt" style="background-color: white; color: #07b419; margin-left: 620px;">전달하기</button>
			<button class="mailBnt">답장하기</button>
		</div>
	</div>
	<!-- 반복끝 -->
</div>
	
	
