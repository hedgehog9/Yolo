<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath=request.getContextPath(); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 


<jsp:include page="listnav.jsp" />

<style type="text/css">
	
	/* nav 시작 */
	
	#cate1, #cate2 {
		color: #d1d3d1;
	}
	
	/* nav 끝 */
	
	div#boardList{
		height: 100%;
		width: 100%;
	}
	
	
	div.listRow {
		border: 1px solid #f9fafa; 
		min-height: 110px;
	}
	
	
	div.listRowInside {
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
	
	div.listcontent1:hover {
		cursor: pointer;
	}
	
	/* span.spanBlock:hover {
		cursor: pointer;
	} */
	
	button.listBnt {
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
	
	 button.listBnt:hover {
		filter: brightness(90%);
	}  
	
	
	/* 게시물 한 개 사이드 모달  */
	
	.modal.right .modal-dialog {
		position: fixed;
		margin: auto;
		width: 100%;
		height: 100%;
		-webkit-transform: translate3d(0%, 0, 0);
		    -ms-transform: translate3d(0%, 0, 0);
		     -o-transform: translate3d(0%, 0, 0);
		        transform: translate3d(0%, 0, 0);
	}

	.modal.right .modal-content {
		height: 100%;
	/* 	overflow-y: auto; */
	}
	
	.modal.right .modal-body {
	 /* padding: 15px 15px 80px;  */
	 	width: 100%; 
	}
	
	.modal.right.fade .modal-dialog {
		right: 0;
		-webkit-transition: opacity 0.3s linear, right 0.3s ease-out;
		   -moz-transition: opacity 0.3s linear, right 0.3s ease-out;
		     -o-transition: opacity 0.3s linear, right 0.3s ease-out;
		        transition: opacity 0.3s linear, right 0.3s ease-out;
	}
	
	.modal.right.fade.in .modal-dialog {
		right: 0;
	}
	
	.modal-header {
		border-bottom-color: #EEEEEE;
		background-color: #FAFAFA;
	}
	

	
</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		$("div.listRow").hover(function(){
			$(this).css("background-color","#f9fafa");
			$(this).find("button").css("display","block")
		}
		, function(){
			$(this).css("background-color","");
			$(this).find("button").css("display","")
		});
		
		// 모달 바깥영역 누르면 닫히는거
		$('#myListModal_outside').on('click', function () {
			closemyListModal();
		});
		
		// 모달 닫기 x 자 누르면 닫히는거
		$("button.close").on('click', function () {
			closemyListModal();
		});
		
	}); // end of $(document).ready(function() ------

	
	// 모달 열기 (notino 로 해당 공지 내용 Ajax로 가져오기 ( 내가 쓴 공지글 1개 조회에 대한 상세 모달) )
	function openmyListModal(notino){
		
	//	console.log("확인용 공지번호 "+notino);
		
		$.ajax({
	    	url : "<%=ctxPath%>/notice/getMyOneNoticeContent.yolo",
	    	type: 'POST',
	    	data : {"notino" : notino},
	    	dataType: "JSON",
			success: function(json){
			//	console.log(json);
				$("#myListModal span#prof").text(json.nickname);
				$("#myListModal span#prof").css("background-color", json.profile_color);
				$("#myListModal span#name").text(json.name + " · " + json.position + " · " +  json.deptname + " ▶ " + json.showDept);
				$("#myListModal span#writedate").text(json.writedate);
				$("#myListModal span#subject").text(json.subject);
				// 추후에 + 파일 첨부 넣기
				$("#myListModal span#content").text(json.content);
				$("#myListModal input#hidden_notino").val(json.notino);
			},
			error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
		}); // end of jax
		
		$('#myListModal').addClass('active');
	    $('#myListModal_outside').fadeIn();
		
	}
	
	// 모달 닫기
	function closemyListModal(){
		$('#myListModal').removeClass('active');
	    $('#myListModal_outside').fadeOut();
	}

</script>

    
<%-- 게시판 리스트 시작 --%>
<div id="boardList">
	<c:if test="${ not empty requestScope.myNoticeList}">
		<c:forEach var="myNoti" items="${requestScope.myNoticeList}">
			<div class="listRow">
				<div class="listRowInside" style="width: 100%;">
					<div id="prof" class="mt-3" style= "background-color: ${myNoti.profile_color};"> ${myNoti.nickname}</div>
					<div class="listcontent1 ml-4" style="width: 500px;" onclick="openmyListModal(${myNoti.notino})">
						<input type="hidden" id="notino" value="${myNoti.notino}">
						<span style="font-weight: bold;" id="subject"><span style='font-size: 20px;'>&#128226;</span> <%-- 중요 공지사항 이모지 붙이기 --%>
						${myNoti.subject}</span>&nbsp;
						<c:if test="${myNoti.readCount ne 0 }">	
							<span id="readCount"  style="color: green;">[${myNoti.readCount}]</span>	
						</c:if>
						<span><i class="fa fa-paperclip" aria-hidden="true"></i></span> <%-- 파일 첨부할 경우 --%>
						<span id="writedate" style="margin-left: 20px; font-size: 10pt;">${myNoti.writedate}</span>
						<span id="name" style="display:block; font-size: 10pt;">${myNoti.name} · ${myNoti.position } · ${myNoti.deptname} ▶ ${myNoti.showDept } </span>  
						
						<c:choose>
							<c:when test="${fn:length(myNoti.content) gt 20}">
								<span id="content" class="spanBlock mt-2" style="color: gray">
									<c:out value="${fn:substring(myNoti.content,0,19)}">
									</c:out> ........
								</span>
							</c:when>
							<c:otherwise>
								<span id="content" class="spanBlock mt-2" style="color: gray">
									<c:out value="${myNoti.content}">
									</c:out>
								</span>	
							</c:otherwise>
						</c:choose>
						&nbsp;&nbsp;
						<span class="mt-2 mb-2" style="font-size: 10pt; color: gray; display: inline-block;"> <span> ┗ </span><span id="prof" class="py-2"  style= "background-color: ${myNoti.profile_color};">댓글</span><span style="color: green;">[6]</span>	</span>
					</div>
					<button class="listBnt EditModal" style="background-color: white; color: #07b419; margin-left: 620px;"  data-toggle="modal" data-target=".noticeEdit">수정하기</button>
					<button class="listBnt DeleteModal">삭제하기</button>
				</div>
			</div>
		</c:forEach>
	</c:if>
	
	<c:if test="${empty requestScope.myNoticeList }">
		<div class="listRow">
			<div class="listRowInside" style="width: 100%;">
				<div class="px-3">작성된 공지글이 없습니다.</div>
			</div>
		</div>
	</c:if>
</div>

	
<%-- 공지 리스트(boardlist) 끝 --%>

<%-- 공지 상세 모달 --%>
<%@ include file="detail/myNoticeDetail.jsp" %>

<%-- 공지 수정 모달 --%>


