<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath=request.getContextPath(); %>

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
		
	});

</script>

    
<%-- 공지 리스트 시작 --%>
<div id="boardList" data-toggle="modal" data-target="#myListModal">
	<div class="listRow">
		<div class="listRowInside">
			<div id="prof" class="mt-3">내공지</div>
			<div class="listcontent1 ml-4" style="width: 500px;">
				<span style="font-weight: bold;">연말 파티에 모두 참석하나요?</span>&nbsp;
				<span><i class="fa fa-paperclip" aria-hidden="true"></i></span> <%-- 파일 첨부할 경우 --%>
				<span style="margin-left: 20px; font-size: 10pt;">2022-12-25</span>
				<span class="spanBlock" style="font-size: 10pt;">나공지 ▶ 전체</span> 
				<span class="spanBlock mt-1" style="color: gray">공지 내용 보여주는 곳입니다</span>
			</div>
			<button class="listBnt" style="background-color: white; color: #07b419; margin-left: 620px;">수정하기</button>
			<button class="listBnt">삭제하기</button>
		</div>
	</div>
	
	
	<%-- test row --%>
	
	<div class="listRow" data-toggle="modal" data-target="#myListModal">
		<div class="listRowInside">
			<div id="prof" class="mt-3">내공지</div>
			<div class="listcontent1 ml-4" style="width: 500px;">
				<span style="font-weight: bold;">공지사항입니다.</span>&nbsp;
				<span><i class="fa fa-paperclip" aria-hidden="true"></i></span> <%-- 파일 첨부할 경우 --%>
				<span style="margin-left: 20px; font-size: 10pt;">2022-12-25</span>
				<span class="spanBlock" style="font-size: 10pt;"> 나공지 ▶ 인사부</span>
				<span class="spanBlock mt-1" style="color: gray">공지 내용 보여주는 곳입니다</span>
			</div>
			<button class="listBnt" style="background-color: white; color: #07b419; margin-left: 620px;">수정하기</button>
			<button class="listBnt">삭제하기</button>
		</div>
	</div>
	
	<div class="listRow" data-toggle="modal" data-target="#myListModal">
		<div class="listRowInside">
			<div id="prof" class="mt-3">내공지</div>
			<div class="listcontent1 ml-4" style="width: 500px;">
				<span style="font-weight: bold;">공지사항입니다.</span>&nbsp;
				<span><i class="fa fa-paperclip" aria-hidden="true"></i></span> <%-- 파일 첨부할 경우 --%>
				<span style="margin-left: 20px; font-size: 10pt;">2022-12-25</span>
				<span class="spanBlock" style="font-size: 10pt;"> 나공지 ▶ 전체</span>
				<span class="spanBlock mt-1" style="color: gray">공지 내용 보여주는 곳입니다</span>
			</div>
			<button class="listBnt" style="background-color: white; color: #07b419; margin-left: 620px;">수정하기</button>
			<button class="listBnt">삭제하기</button>
		</div>
	</div>
	
	<div class="listRow" data-toggle="modal" data-target="#myListModal">
		<div class="listRowInside">
			<div id="prof" class="mt-3">내공지</div>
			<div class="listcontent1 ml-4" style="width: 500px;">
				<span style="font-weight: bold;">공지사항입니다.</span>&nbsp;
				<span><i class="fa fa-paperclip" aria-hidden="true"></i></span> <%-- 파일 첨부할 경우 --%>
				<span style="margin-left: 20px; font-size: 10pt;">2022-12-25</span>
				<span class="spanBlock" style="font-size: 10pt;"> 나공지 ▶ 인사부</span>
				<span class="spanBlock mt-1" style="color: gray">공지 내용 보여주는 곳입니다</span>
			</div>
			<button class="listBnt" style="background-color: white; color: #07b419; margin-left: 620px;">수정하기</button>
			<button class="listBnt">삭제하기</button>
		</div>
	</div>
	
</div> <%-- 공지리스트 끝 --%>

<%-- 공지 상세 모달 --%>
<%@ include file="detail/myNoticeDetail.jsp" %>
