<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<style type="text/css">

	/* 공지 상세 사이드 모달  */
	
	div#myListModal {
		/* border:solid 2px green; */
		width: 40%;
		height: 100%;
		overflow: auto;
		display: flex;
		flex-direction: column;
		position: fixed;
		top: 0px;
		left: 2000px;
		z-index: 1052;
		background: white;
		border-radius: 0.3rem;
		color: black;
		transition: all 0.5s; 
		padding: 5px;
	}

	div#myListModal.active {
		top: 0px;
		left: 60%;
	}
	
	div#myListModal_outside {
		position: fixed;
		top: 0px;
		left: 0px;
		width: 100%;
		height: 100%;
		background: rgba(0, 0, 0, 0.2);
		z-index: 1051;
		display: none;
	}
	
	div.modalHeader {
		width: 90%;
		margin: auto 5%;
		height: 7%;
		padding-top: 15px;
	}
	
	div.modalBody {
		width: 90%;
		margin: auto 5%;
		height: 86%;
	}
	
	/* 공지 상세 모달 content  */
	
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
	
	button.commentBnt, 
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
	
	button.MYcommentBnt,
	button.MYcommentCancelBnt {
		width: 40px;
		height: 20px;
		border: 1px solid #07b419;
		border-radius: 0.5rem;
		margin-right: 10px;
		font-weight: bold;
		font-size : 9pt;
		text-align : center;
		background-color: #FFFFFF;
		color: #07b419;
	}
	
	button.cmtEditBnt {
		width: 40px;
		height: 20px;
		border: 1px solid #07b419;
		border-radius: 0.5rem;
		margin-right: 10px;
		font-weight: bold;
		font-size : 9pt;
		text-align : center;
		background-color: #07b419;
		color: white;
	}
	
	 button.commentBnt:hover, 
	 button.commentCancleBnt:hover,
	 button.MYcommentBnt:hover,
	 button.MYcommentCancelBnt:hover, 
	 button.cmtEditBnt:hover {
		filter: brightness(90%);
	}
	
	#prof {
		margin-bottom: 10px;
	}
	
	/* 파일 다운로드 링크  */
	a.filedown:link, a.filedown:visited, a.filedown:active, a.filedown:hover {
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
	
	textarea.commentForm:focus {
		outline : 2px solid #66cc66;
		border-radius: 0.5rem;
		
	}
	
	div.commentrow {
		align-content: center;
		border: 1px solid #e8e5e5;
		border-radius: 0.5rem;
		
	}
	
	div.commentrow:hover {
		background-color: #f4f2f2;
		border-radius: 0.5rem;
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
		        toastr.options = {
	                      closeButton: true,
	                      progressBar: true,
	                      showMethod: 'slideDown',
	                      timeOut: 2000,
	                      positionClass: 'toast-top-center'
	                  };
	                  toastr.error('', '글자수는 50자까지 입력 가능합니다.');
		    };
			
    	});
		
	});

</script>    
    
    
 <%-- 공지 상세 모달 클릭 시 배경 fade out --%>   
 <div id="myListModal_outside"></div>
    

<%-- 게시글 상세 Modal --%>
<div id="myListModal">
    <%-- Modal content --%>
    <div class="modalHeader">
    	<span style="font-size:20px;">&#128226;</span><span class="myListModalTitle ml-3" style="font-size: 20px; font-weight: bold;"> 전체 공지 </span>
      <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
    </div>
   	<div class="modalBody">
  	 	<div class="modal-listContent"> 
				<div>
		 			<span class="mt-2 mb-2" style="font-size: 13pt;"><span id="prof" class="py-2">브래드</span><span id="name"> 작성자  ▶ 인사부</span></span>
		 			<div style="float: right;">
		  			<span class="badge badge-pill badge-dark py-1" style="font-size: 10pt;">작성일</span>
		  			<span id="writedate" class="badge badge-pill badge-dark py-1" style="font-size: 10pt;">2022-12-25</span>
		 			</div>
		   		</div>
		     	<div style="margin: 5px auto; clear: right;">
		      	<span  id="subject" class="badge badge-light mt-3" style="margin-top: 10px; font-size: 13pt;">공지제목 쓰는 곳 &nbsp;</span>
		     	</div>
		     	<div class="filedownload">
		           <span style="font-size:10pt;"><a href="#" class="filedown">[<span style='font-size:20px;'>&#128194;</span>]
					<span>file name.pdf</span></a>	              
		           </span>
		        </div>
		     	<div>
		     		<span style="display: block; margin-top: 20px; margin-bottom: 10px;"> <span style='font-size:20px;'>&#128312;</span> 공지 내용 </span>
		     		<span id="content" style="display: block; height: 200px; width: 100%; border: 1px solid #e0e0e0; color:gray;">작성된 공지 내용 들어가는 곳</span>
		     	</div>
     	
			 <%-- 댓글 입력란 시작 --%>     	
	     	<div style="margin: 30px 0;">
	      	<span style="font-size: 16px;">&#128313; 댓글</span>
	   		<div class="commentBox">
		    	<form id="insertFrm" name="insertFrm">
		       	<textarea class="commentForm" maxlength="50" placeholder="댓글을 입력하세요." style="resize: none; max-height: 10px;"></textarea>
		       	<div class="mt-2">
		       		<button type="button" class="commentBnt">댓글쓰기</button>
					<button type="button" class="commentCancleBnt">취소</button>
		        	<div class="textLengthWrap" style="float: right; color: #808080;">
					   		<span class="textCount">0자</span>
					    	<span class="textTotal">/50자</span>
						</div>
					</div>
		        </form>
	    	</div>
			</div> <%-- 댓글 입력란 끝 --%>   

	      	<%-- 댓글 내용 --%> <%-- 내가 쓴 댓글은 수정, 삭제 버튼 나오게 하기 / 수정시 댓글내용은 입력폼으로 변경된다. --%>
	      	<div class="mt-3 mb-2">
	      	<div class="commentrow  px-2 py-2">
	       	<span class="mt-2 mb-3" style="font-size: 10pt; color: gray;"> ┗ <span id="prof" class="py-2">작성자</span><span class="ml-1 mr-1">김땡땡</span><span class="ml-3">2022-11-30</span></span>
	       	<div style="display:inline;	float: right;">
	      			<button type="button" class="MYcommentBnt mr-0" >수정</button> <%-- 수정 누를시 수정, 삭제 버튼 없애고 수정 후 확인 버튼만 오게 하기 --%>
	      			<button type="button" class="MYcommentCancelBnt mr-0">삭제</button>
	      		</div>
	      		<div class="mt-3">
	       		<span class="commentrow mt-3 mb-4" style="font-size: 10pt; color: gray;"> &nbsp; ▶ 좋은 댓글 작성합니다.</span>
	       		<button type="button" class="cmtEditBnt mr-0" style="float: right;">확인</button><%-- 댓글 수정시에만 보여주기 --%>
	       	</div>
	       	</div>	
	       	<hr>
	       
	      	<%-- 댓글 test --%>
			<div class="commentrow  px-2 py-2">
		       	<span class="mt-2 mb-3" style="font-size: 10pt; color: gray;"> ┗ <span id="prof" class="py-2">작성자</span><span class="ml-1 mr-1">김땡땡</span><span class="ml-3">2022-11-30</span></span>
		       	<div style="display:inline;	float: right;">
		      			<button type="button" class="MYcommentBnt mr-0" >수정</button> <%-- 수정 누를시 수정, 삭제 버튼 없애고 수정 후 확인 버튼만 오게 하기 --%>
		      			<button type="button" class="MYcommentCancelBnt mr-0">삭제</button>
		      		</div>
		      		<div class="mt-3">
		       		<span class="commentrow mt-3 mb-4" style="font-size: 10pt; color: gray;"> &nbsp; ▶ 좋은 댓글 작성합니다.</span>
		       		<button type="button" class="cmtEditBnt mr-0" style="float: right;">확인</button><%-- 댓글 수정시에만 보여주기 --%>
		       	</div>
			</div>	
	        <hr>
	       			        
	      	<div class="commentrow  px-2 py-2">
	       	<span class="mt-2 mb-3" style="font-size: 10pt; color: gray;"> ┗ <span id="prof" class="py-2">작성자</span><span class="ml-1 mr-1">김땡땡</span><span class="ml-3">2022-11-30</span></span>
	       	<div style="display:inline;	float: right;">
	      			<button type="button" class="MYcommentBnt mr-0" >수정</button> <%-- 수정 누를시 수정, 삭제 버튼 없애고 수정 후 확인 버튼만 오게 하기 --%>
	      			<button type="button" class="MYcommentCancelBnt mr-0">삭제</button>
	      		</div>
	      		<div class="mt-3">
	       		<span class="commentrow mt-3 mb-4" style="font-size: 10pt; color: gray;"> &nbsp; ▶ 좋은 댓글 작성합니다.</span>
	       		<button type="button" class="cmtEditBnt mr-0" style="float: right;">확인</button><%-- 댓글 수정시에만 보여주기 --%>
	       	</div>
	       </div>	
	       <hr>	
	       <%-- 댓글 test 끝--%>
       
	   </div> <%-- 댓글 --%>
	 </div>
   </div> <%-- modal body --%>
</div>


	    

