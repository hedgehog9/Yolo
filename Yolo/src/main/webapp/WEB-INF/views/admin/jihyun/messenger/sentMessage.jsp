<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="messengerHeader.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<style>
 
	div#sentMessenger{
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
	
	 button.mailBnt:hover {
		filter: brightness(90%);
	}
	
	/* 메세지 상세 보기  */ 
	div#sentMessageModal{
		
	}
	
	
	div#mailSubject{
		display: flex;
  		align-items: center;
		height: 50px;
		width: 80%;
		margin: 35px 10% 15px auto;
	}
	
	span#mailSubject{
		font-size: 18pt;
		font-weight: bold;
	}
	
	span#sendDate{
		font-size: 11pt;
		color: gray;
		margin-left: 10px;
	}
	

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$('#sentMessageModal').modal('hide');
		
		$("span#sndmsg").css("color", "#494949");
		
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
		
		// 메일 내용 누르면 뜨는 모달
		$("div.mailcontent1").click(function(){
			$('div#sentMessageModal').modal('show');
		});
		
	}); // end of ready

</script>


	
<div id="sentMessenger">
	<div id="messengertop">
		<span style="margin-left:30px;">보낸 메신저(78)</span>
	</div>
	
	
	<c:if test="${ not empty requestScope.sentMsgList }">
		<c:forEach var="msg" items="${requestScope.sentMsgList}">
			<div class="mailRow">
				<div class="mailRowInside">
					<div style="width: 30px;">
					</div>
					<div id="prof" class="mt-3" style="background-color: ${msg.profile_color} ;">${msg.nickname }</div>
					<div class="mailcontent1 ml-4" style="width: 500px;">
						<span style="font-weight: bold;">${msg.subject }</span><span style="margin-left: 20px; font-size: 10pt;">${msg.writedate }</span>
						<span class="spanBlock" style="font-size: 10pt;">${msg.name } · ${msg.deptname } · ${msg.position }</span>
						<span class="spanBlock mt-1" style="color: gray">${msg.content }</span>
					</div>
					<button class="mailBnt" style="background-color: white; color: #07b419; margin-left: 670px;">전달하기</button>
				</div>
			</div>
		</c:forEach>
	</c:if>
	
	<c:if test="${empty requestScope.sentMsgList }">
		<span>보낸 메일함이 비었습니다.</span>
	</c:if>
	
	<!-- 반복시작 -->
	<!-- <div class="mailRow">
		<div class="mailRowInside">
			<div style="width: 30px;">
			</div>
			<div id="prof" class="mt-3">길동</div>
			<div class="mailcontent1 ml-4" style="width: 500px;">
				<span style="font-weight: bold;">메신저 제목 부분 입니다</span><span style="margin-left: 20px; font-size: 10pt;">2022-11-15 14:02:42</span>
				<span class="spanBlock" style="font-size: 10pt;">지현 · 인사</span>
				<span class="spanBlock mt-1" style="color: gray">메신저 내용 미리보기 부분입니다 </span>
			</div>
			<button class="mailBnt" style="background-color: white; color: #07b419; margin-left: 670px;">전달하기</button>
		</div>
	</div> -->
	<!-- 반복끝 -->
	
	
	<!-- Modal -->
	<!-- Modal 구성 요소는 현재 페이지 상단에 표시되는 대화 상자/팝업 창입니다. -->
	<div class="modal fade"  id="sentMessageModal">
	  <div class="modal-dialog modal-dialog-scrollable modal-lg modal-dialog-centered">
	  <!-- .modal-dialog-scrollable을 .modal-dialog에 추가하여 페이지 자체가 아닌 모달 내부에서만 스크롤할 수 있습니다. -->
	    <div class="modal-content">
	
	      <!-- Modal body -->
	      <div class="modal-body">
	      <!-- <form id='my_form'> -->
	      	<div id="mailSubject">
	      		<span id="mailSubject">메신저 제목부분 입니다</span><span id="sendDate">2022-11-23</span>
	      	</div>
	      	<span style="width: 80%; margin: 0 10%;">받는 사람 입력부분 일단 스팬으로</span>
	        <textarea rows="" cols="" name="content"></textarea>
	        <div id="attachArea">
	        	<div class="filebox">
				    <input class="upload-name" value="첨부파일" placeholder="첨부파일">
				    <label for="file">파일찾기</label> 
				    <input type="file" id="file">
				</div>
	        </div>
	      <!-- </form> -->
	        
	        <button type="button" class="headerBtn" style="width: 80%; margin: 10px 10% 50px 10%;">
				<i class="fas fa-regular fa-paper-plane" id="icon"></i>메신저 보내기
			</button>
	      </div>
	      
	    </div>
	  </div>
	</div>
</div>
	
	
