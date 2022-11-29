<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">

		/* 게시물 상세 사이드 모달  */
	
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
	
	.modal-footer {
		border: none;
	}
	
	/* 게시물 상세 모달 content  */
	
	div.modal-listContent {
		width: 90%;
		margin: auto 5%;
	}
	
	span.modalBage {
		font-size:14px; 
		font-weight: normal; 
		margin-right: 7px;
	}
	
	textarea {
		min-height: 100px;
		width: 100%;
		margin: 20px 0 5px 0;
		border: 1px solid #dddddd;
		border-radius: 0.4rem;
	}
	
	button.commentgBnt, 
	button.commentCancleBnt {
		width: 70px;
		height: 30px;
		border: 1px solid #07b419;
		border-radius: 0.5rem;
		margin-right: 15px;
		font-weight: bold;
		font-size : 11pt;
		text-align : center;
		background-color: #07b419;
		color: white;
	}
	
	 button.commentgBnt:hover, 
	 button.commentCancleBnt:hover {
		filter: brightness(90%);
	}
	
	#prof {
		margin-bottom: 10px;
	}
	
	/* 파일 다운로드 링크  */
	a:link, a:visited, a:active, a:hover {
		text-decoration: none;
		color: #9e9e9e;
	}
	
	
	
	/*  프로필 */
	span#prof{
		width: 5px; 
		height: 5px; 
		border-radius: 40%; 
		background-color: #239afe;
		color: white;
		text-align: center;
		padding-top: 10px;
		border: 1px solid #ccced0;
		font-weight: bold;
		font-size: 10pt;
		margin: auto 5px;
	}
	
	div.cmt:hover {
		filter: brightness(60%);
	}
	
	textarea:focus {
		outline : 2px solid #66cc66;
	}

</style>    
    
<script type="text/javascript">

	$(document).ready(function() {
	

		// 댓글 글자수 제한
		$('.commentForm').on('keyup', function() {
			
			let content = $(this).val();
			
			// 글자수 세기
		    if (content.length == 0 || content == '') {
		    	$('.textCount').text('0자');
		    } else {
		    	$('.textCount').text(content.length + '자');
		    }
		    
		    // 글자수 제한
		    if (content.length > 50) {
		    	// 50자 부터는 타이핑 되지 않도록
		        $(this).val($(this).val().substring(0, 50));
		        // 50자 넘으면 알림창 뜨도록
		        alert('글자수는 50자까지 입력 가능합니다.');
		    };
			
    	});
		
	});

</script>    
    
    
    
    

<%-- 게시글 상세 Modal --%>
<div class="modal right fade" id="myListModal" tabindex="-1" data-backdrop="static" aria-hidden="true" >
  <div class="modal-dialog modal-dialog-scrollable modal-right modal-md">
  
	    <%-- Modal content --%>
	    <div class="modal-content">
	      <div class="modal-header py-3">
	      	<span style="font-size:20px;">&#128226;</span><span class="myListModalTitle ml-3" style="font-size: 20px; font-weight: bold;"> 내가 쓴 공지 </span>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
	      </div>
	      <div class="modal-body" style="height: auto;">
	      	<div class="modal-listContent"> 
	      			<div>
			      		<span class="mt-2 mb-2" style="font-size: 13pt;"><span id="prof" class="py-2">브래드</span><span> 작성자  ▶ 인사부</span></span>
			      		<div style="float: right;">
			      		<span class="badge badge-dark py-1" style="font-size: 10pt;">작성일</span>
			      		<span class="badge badge-dark py-1" style="font-size: 10pt;">2022-12-25</span>
			      		</div>
			      	</div>
			      	<div style="margin: 5px auto; clear: right;">
				      	<span class="badge badge-light mt-3" style="margin-top: 10px; font-size: 13pt;">공지제목 쓰는 곳 &nbsp;</span>
			      	</div>
			      	<div class="filedownload">
			            <span style="font-size:10pt;"><a href="#" class="filedown">[<span style='font-size:20px;'>&#128194;</span>]
						<span>file name.pdf</span></a>	              
			            </span>
		            </div>
			      	<div>
			      		<span style="display: block; margin-top: 20px; margin-bottom: 10px;"> <span style='font-size:20px;'>&#128312;</span> 공지 내용 </span>
			      		<span style="display: block; height: 200px; width: 100%; border: 1px solid #e0e0e0;">작성된 공지 내용 들어가는 곳</span>
			      	</div>
			      	<div style="margin-top: 30px;">
				      	<span style="font-size: 16px;">&#128313; 댓글</span>
			      		<div class="commentBox">
				      		<%-- 댓글 작성란  --%>
				      		<form id="insertFrm" name="insertFrm">
					        	<textarea class="commentForm" maxlength="50" placeholder="댓글을 입력하세요." style="resize: none; max-height: 10px;"></textarea>
					        	<div>
					        		<button type="button" class="commentgBnt">댓글쓰기</button>
									<button type="button" class="commentCancleBnt">취소</button>
						        	<div class="textLengthWrap" style="float: right; color: #808080;">
								   		<span class="textCount">0자</span>
								    	<span class="textTotal">/50자</span>
									</div>
								</div>
					        </form>
					        <%-- 댓글 내용 --%> <%-- 내가 쓴 댓글은 수정, 삭제 버튼 나오게 하기 --%>
					        <div class="mt-5" style="clear: right;">
					        	<div class="cmt">
					        		<span class="mt-2 mb-3" style="display: block; font-size: 10pt; color: gray;"> <span> ┗ </span><span id="prof" class="py-2">작성자</span><span>좋은 댓글 작성합니다.</span><span class="ml-3">2022-11-30</span></span>
					        	</div>
					        	
					        	<%-- 댓글 test --%>
					        	<div class="cmt">
					       			<span class="mt-2 mb-3" style="display: block; font-size: 10pt; color: gray;"> <span> ┗ </span><span id="prof" class="py-2">작성자</span><span>좋은 댓글 </span><span class="ml-3">2022-11-30</span></span>
					       		</div>
					       		<div class="cmt">
					       			<span class="mt-2 mb-3" style="display: block; font-size: 10pt; color: gray;"> <span> ┗ </span><span id="prof" class="py-2">작성자</span><span>좋은 댓글 </span><span class="ml-3">2022-11-30</span></span>
					       		</div>
					       		<div class="cmt">
					       			<span class="mt-2 mb-3" style="display: block; font-size: 10pt; color: gray;"> <span> ┗ </span><span id="prof" class="py-2">작성자</span><span>좋은 댓글 </span><span class="ml-3">2022-11-30</span></span>
					       		</div>
					       		<div class="cmt">
					       			<span class="mt-2 mb-3" style="display: block; font-size: 10pt; color: gray;"> <span> ┗ </span><span id="prof" class="py-2">작성자</span><span>좋은 댓글 </span><span class="ml-3">2022-11-30</span></span>
					       		</div>
					       		<%-- 댓글 페이징-스크롤링 / 익명 댓글? 프로필 --%>
					       	</div>
				        </div>
				    </div>    
	  	 	 </div>
	 	 </div>
  	  </div>
   </div>
</div>