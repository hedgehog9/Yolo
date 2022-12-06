<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="messengerHeader.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<% String ctxPath = request.getContextPath(); %>

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
	
	div.mailRow {
		border: 1px solid #f9fafa; 
		min-height: 110px;
	}
	
	div.mailRow:hover {
	 	background-color: #f9fafa;
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
	 
	 div#mailSubject{
		display: flex;
  		align-items: center;
		height: 50px;
		width: 80%;
		margin: 35px 10% 10px auto;
	}
	
	span#mailSubject{
		font-size: 18pt;
		font-weight: bold;
	}
	
	span#writedate{
		font-size: 11pt;
		color: gray;
		margin-left: 15px;
	}
	
	span#mailContent {
		width: 80%;
		margin: 20px 10% 15px 10%;
		display: block;
		min-height: 300px;
		max-height: 400px;
	}
	
	div#mailAttachArea{
		width: 80%;
		margin: 10px 10% 25px auto;
	}
	
	span.mailFiles {
		text-decoration: underline;
		color: gray;
	}
	
	span.mailFiles:hover {
		font-weight: bold;
		color: black;
		cursor: pointer;
	}
	
	
	button.headerBtn2 {
		border-radius: 0.5rem;
		border: 1px solid gray;
		/* background: linear-gradient( to left ,#5bd3ff, #88eb1e ); */
		width: 47%;
		height: 45px;
		border: none;
		color: white;
		font-weight: bold;
	}

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("span#rcvmsg").css("color", "#494949");
		
		// 화면 높이만큼 body div에 height를 주겠다
		/* const web_browser_height = $(window).height(); 
		$("div#right").css({"height":web_browser_height}); */
		
		$("div.mailRow").hover(function(){
									$(this).find("button").css("display","block")
								}
								, function(){
									$(this).find("button").css("display","")
								});
		
		// 전체선택
		$("input#checkAllMsg").change(function(){
			const bool = $("input#checkAllMsg").prop("checked");
			$("input.msgno").prop("checked",bool); 
		});
		
		
		// 메신저 내용 누르면 뜨는 모달
		$("div.mailcontent1").click(function(){
			const msgno = $(this).find($('input')).val();
			readMailContent(msgno);
		});
		
		
		// 메일 리스트에서 답장하기
		$("button.reply").click(function(){
			let msgno = $(this).parent().find($("input#pk_msgno")).val();
			let subject = $(this).parent().find($("span#subject")).text();
			let empno = $(this).parent().find($("input#empno")).val();
			let sender = $(this).parent().find($("span#sender")).text();
			
			$("div.sendMail input[name='origin_msgno']").val(msgno);
			$("div.sendMail input[name='subject']").val("Re:"+subject);
			$('div.sendMail button#dropdownMenuButton').find('span').text(sender);
			$('div.sendMail input[name="fk_recipientno"]').val(empno);
			
			$(".sendMail").modal('show');
		});
		
		
		// 메신저 상세에서 답장하기
		$("button#modalReplyBtn").click(function(){
			let msgno = $(this).parent().parent().find($("input#hidden_pk_msgno")).val();
			let subject = $(this).parent().parent().find($("span#mailSubject")).text();
			let empno = $(this).parent().parent().find($("input#hidden_empno")).val();
			let sender = $(this).parent().parent().find($("span#empName")).text();
			
			$("div.sendMail input[name='origin_msgno']").val(msgno);
			$("div.sendMail input[name='subject']").val("Re:"+subject);
			$('div.sendMail button#dropdownMenuButton').find('span').text(sender);
			$('div.sendMail input[name="fk_recipientno"]').val(empno);
			
			$("#MessengerContentModal").modal('hide');
			$(".sendMail").modal('show');
		});
		
		
		// 메일 리스트에서 전달하기 누르면 
		$("button.deliver").click(function(){
			let msgno = $(this).parent().find($("input#pk_msgno")).val();
			openDeliverMsg(msgno);
		});
		
		
		// 메신저 상세에서 전달하기 누르면
		$("button#modalDeliverBtn").click(function(){
			let msgno = $(this).parent().parent().find($("input#hidden_pk_msgno")).val();
			$("#MessengerContentModal").modal('hide');
			openDeliverMsg(msgno);
		});
		
		
	}); // end of ready
	
	
	// 선택 메세지 읽기
	function readCheckedMsg(){
		ck_msgno_list = [];
		$("input.msgno:checked").each(function(index, item){
			ck_msgno_list.push($(item).val());
		});
		
		if(ck_msgno_list.length>0){
			str_msgno = ck_msgno_list.join(",");
			
			$.ajax({
		    	url : "<%=ctxPath%>/messenger/updateCheckedMsg.yolo",
		    	type: 'POST',
		    	data:{"str_msgno":str_msgno },
				success: function(){ 
					window.location.reload();
				},
				error: function(request, status, error){
	                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
				
		    }); // end of ajax 
		}
	}
	
	
	// 모든 안읽은 메세지 읽기
	function readAllMsg(){
		$.ajax({
	    	url : "<%=ctxPath%>/messenger/updateAllMsg.yolo",
			success: function(){ 
				window.location.reload();
			},
			error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
			
	    }); // end of ajax 
	}
	
	
	// 원글 보기 
	function readOrigin(origin_msgno) {
		readMailContent(origin_msgno);
	}
	
	
	// 메신저 내용 불러오기
	function readMailContent(msgno){
		$.ajax({
	    	url : "<%=ctxPath%>/messenger/getMailContent2.yolo",
	    	type: 'POST',
	    	data : {"msgno" : msgno},
	    	dataType: "JSON",
			success: function(json){
				
				$("span#mailSubject").text(json.subject);
				$("span#writedate").text(json.writedate);
				$("span#mailContent").text(json.content);
				$("span#empNick").text(json.nickname);
				$("div#empProf").css("background-color", json.profile_color);
				$("span#empName").text(json.name);
				$("span#empTeam").text(json.deptname+ " · "+ json.position);
				$("input#hidden_pk_msgno").val(json.pk_msgno);
				$("input#hidden_empno").val(json.empno);
				
				if(json.origin_msgno!=null){
					$("div#readOrigin").html('<span style="flex-grow: 1;"></span><button onclick="readOrigin(\''+json.origin_msgno+'\')" class="btn btn-outline-secondary btn-sm" style="border-radius: 1rem;">원글보기</button>');
				} else {
					$("div#readOrigin").html('');
				}
				
				// 첨부 파일을 구해오는 ajax
				if(Number(json.having_attach) >0){
					$.ajax({
				    	url : "<%=ctxPath%>/messenger/getMailFile.yolo",
				    	data : {"group_msgno" : json.group_msgno},
				    	dataType: "JSON",
						success: function(json2){
							if(json2.length>0){
								let html = '<span style="display: block; margin-bottom:5px; font-weight: bold">첨부파일</span>';
								$.each(json2, function(index2, item2){
									html+='<span style="font-size: 10pt; color: gray;"><i class="fas fa-solid fa-paperclip ml-3 mr-1"></i></span>'+
							        	'<span class="mailFiles" onclick="javascript:location.href=\'<%=ctxPath%>/messenger/downloadMailFile.yolo?fileName='+item2.fileName+'&orgFilename='+item2.orgFilename+'\'" >'+item2.orgFilename+'</span><br>';
								});
								
								$("div#mailAttachArea").html(html);
							}
						},
						error: function(request, status, error){
			                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			            }
					}); // end of 첨부파일 ajax
				} else {
					$("div#mailAttachArea").html('');
				}
			},
			error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
		}); // end of ajax
		
		$('div#MessengerContentModal').modal('show');
	}
	
	
	// 메신저 전달하기 
	function openDeliverMsg(msgno) {
			$.ajax({
		    	url : "<%=ctxPath%>/messenger/getMailContent2.yolo",
		    	type: 'POST',
		    	data : {"msgno" : msgno},
		    	dataType: "JSON",
				success: function(json){
					
					$("div.deliverMail input[name='subject']").val(json.subject);
					$("div.deliverMail textarea[name='content']").val(json.content);
					$("div.deliverMail input[name='origin_msgno']").val(json.pk_msgno);
					
					// 첨부 파일을 구해오는 ajax
					if(Number(json.having_attach) >0){
						$.ajax({
					    	url : "<%=ctxPath%>/messenger/getMailFile.yolo",
					    	data : {"group_msgno" : json.group_msgno},
					    	dataType: "JSON",
							success: function(json2){
								if(json2.length>0){
									let html = '<span style="display: block; margin-bottom:5px; font-weight: bold">첨부파일</span>';
									$.each(json2, function(index2, item2){
										html+='<span style="font-size: 10pt; color: gray;"><i class="fas fa-solid fa-paperclip ml-3 mr-1"></i></span>'+
								        	'<span class="mailFiles" onclick="javascript:location.href=\'<%=ctxPath%>/messenger/downloadMailFile.yolo?fileName='+item2.fileName+'&orgFilename='+item2.orgFilename+'\'" >'+item2.orgFilename+'</span><br>';
									});
									
									$("div.deliverMail div#mailAttachArea").html(html);
								}
							},
							error: function(request, status, error){
				                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				            }
						}); // end of 첨부파일 ajax
					} else {
						$("div.deliverMail div#mailAttachArea").html('');
					}
				},
				error: function(request, status, error){
	                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
			}); // end of ajax
			
			$(".deliverMail").modal('show');
		
	}
	

</script>


	
<div id="sendedMessenger">
	<div id="messengertop">
		<input type="checkbox" class="ml-2" id="checkAllMsg"/>
		<span class="ml-2" style="flex-grow: 1;">안 읽은 메신저(4)</span>
		<button type="button" class="mailTopBtn" onclick="readCheckedMsg()">선택 메신저 읽기</button>
		<button type="button"  class="mailTopBtn" onclick="readAllMsg()">안 읽은 메신저 모두 읽기</button>
	</div>
	
	<c:if test="${ not empty requestScope.receivedMsgList }">
		<c:forEach var="msg" items="${requestScope.receivedMsgList}">
			<c:choose>
				<c:when test="${msg.view_status eq 0}">
					<div class="mailRow">
				</c:when>
				<c:otherwise>
					<div class="mailRow" style="background-color: #f9fafa;">
				</c:otherwise>
			</c:choose>
				<div class="mailRowInside">
					<div style="width: 30px;">
						<c:if test="${msg.view_status eq 0}">
							<input type="checkbox" class="msgno" value="${msg.pk_msgno }" style=" margin-bottom: 45px; margin-right: 15px;">
						</c:if>
					</div>
					<div id="prof" class="mt-3" style="background-color: ${msg.profile_color} ;">${msg.nickname }</div>
					<div class="mailcontent1 ml-4" style="width: 500px;  flex-grow: 1;">
						<input id="pk_msgno" type="hidden" value="${msg.pk_msgno}">
						<span style="font-weight: bold;" id="subject">${msg.subject }</span>
						<c:if test="${ msg.having_attach ne 0 }">
							<span style="font-size: 10pt; color: gray; margin-left: 5px;"><i class="fas fa-solid fa-paperclip"></i></span>
						</c:if>
						<input type="hidden" id="empno" value="${msg.empno }">
						<span style="margin-left: 20px; font-size: 10pt;">${msg.writedate }</span>
						<span class="spanBlock" style="font-size: 10pt;" id="sender">${msg.name } · ${msg.deptname } · ${msg.position }</span>
						<span class="spanBlock mt-1" style="color: gray">${msg.content }</span>
					</div>
					<button class="mailBnt deliver" style="background-color: white; color: #07b419; ">전달하기</button>
					<button class="mailBnt reply">답장하기</button>				
				</div>
			</div>
		</c:forEach>
	</c:if>
	
	<c:if test="${empty requestScope.receivedMsgList }">
		<span class="ml-4 mt-4" style="display: block">받은 메신저가 비었습니다.</span>
	</c:if>
	
	<!-- <div class="mailRow">
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
	</div> -->
	
	
	
	<!-- Modal -->
	<!-- Modal 구성 요소는 현재 페이지 상단에 표시되는 대화 상자/팝업 창입니다. -->
	<div class="modal fade"  id="MessengerContentModal">
	  <div class="modal-dialog modal-dialog-scrollable modal-lg modal-dialog-centered">
	  <!-- .modal-dialog-scrollable을 .modal-dialog에 추가하여 페이지 자체가 아닌 모달 내부에서만 스크롤할 수 있습니다. -->
	    <div class="modal-content">
	
	      <!-- Modal body -->
	      <div class="modal-body">
	      
	      	<div style="display: flex" id="readOrigin"></div>
	      	<div id="mailSubject">
	      		<span id="mailSubject"></span><span id="writedate"></span>
	      	</div>
	      	<div style="width: 80%; margin: 5px 10%">
	      		<span style="color: gray; font-size: 10pt; display: block; margin-bottom: 4px;">보낸 사람</span>
				<div class="sentPsnProf" id="empProf"><span style="font-size: 9pt;" id="empNick"></span></div>
				<span class="ml-2" style="padding-top: 3px;" id="empName"></span>
				<span class="ml-2" id="empTeam" style="font-weight: normal; color: gray; font-size: 10pt;"></span>
			</div>
	        <span id="mailContent"></span>
	        <div id="mailAttachArea"></div>
	      	<input id="hidden_pk_msgno" type="hidden">
	      	<input id="hidden_empno" type="hidden">
	      	
	      	<div style="width: 80%; margin: 10px 10% 50px 10%; display: block;">
		        <button type="button" class="headerBtn2" id="modalDeliverBtn" style="background: linear-gradient( to left ,#68dabc, #88eb1e ); margin-right: 5%;">
					<i class="fas fa-solid fa-retweet mr-2"></i>전달하기
				</button>
				<button type="button" class="headerBtn2" id="modalReplyBtn" style="background: linear-gradient( to left ,#5bd3ff, #68dabc );">
					<i class="fas fa-solid fa-reply mr-2"></i>답장하기
				</button>
			</div>
	      </div>
	      
	    </div>
	  </div>
	</div>
	<jsp:include page="messengerPageBar.jsp" />
</div>
	
	
