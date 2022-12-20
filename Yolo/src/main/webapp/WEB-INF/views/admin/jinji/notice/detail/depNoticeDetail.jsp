<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
	/*	height: 100%; */
	}
	
	div.modalFooter {
		width: 90%;
		margin: auto 5%;

	}
	
	/* 공지 상세 모달 content  */
	
	div.modal-listContent {
		width: 90%;
		margin: auto 5%;
	}
	
	div.modal-cmtContent {
		width: 90%;
		margin: auto 5%;
	}
	
	
	span.modalBage {
		font-size:14px; 
		font-weight: normal; 
		margin-right: 7px;
	}
	
	textarea {
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
	
	textarea#commentContent:focus {
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
		$('#commentContent').on('keyup', function() {
			
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
		        $(".commentBnt").attr("disabled", true);
		    } // end of if
		    else{
		    	$(".commentBnt").attr("disabled", false);
		    }
    	}); // end of 댓글 제한 ------
    	
    	
	// 댓글 수정	
	$(document).on("click",'button.MYcommentBnt', function(){
		
	//	console.log('ddd');
		$(this).hide();
		//const commentno = $(this).next().next().next().next().val();
		//console.log(commentno)
		let content = $(this).parent().next().find("#cmtContent").text();
		content = content.substring(1); // ▶ 지우기
	//	console.log(content);
	//	 $(this).parent().next().find("#cmtContent").css({"display":"none"});
		 $(this).parent().next().find("#cmtContent").html("<input type='text' value="+content+">'<button type='button' class='cmtEditBnt mr-0' style='float: right;'>확인</button>'");
		
	});
	    	
    
	// 댓글 삭제
	$(document).on("click",'button.MYcommentCancelBnt', function(){
		
			$(this).hide();
			const commentno = $(this).next().next().next().val();
	//		console.log(commentno);
			const notino = $(this).next().val();
	//		console.log(notino);
			
			Swal.fire({
				   title: '삭제하시겠습니까?',
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
				  
					   $(this).hide();
						const commentno = $(this).next().next().next().val();
				//		console.log(commentno);
						const notino = $(this).next().val();
				//		console.log(notino);
						
						// 댓글 삭제 버튼 누를 경우
						$.ajax({
					    	url : "<%= request.getContextPath() %>/notice/delDepComment.yolo",
					    	type: 'POST',
					    	data : {"commentno" : commentno,
						    		"notino" : notino},
					    	dataType: "JSON",
							success: function(json){
								
							//	console.log(json);
								
							//  json.result;
							//  console.log(json.result);
							 
							 	// 삭제후 댓글 출력 함수 재호출
							 	goReadComment(commentno); 
							 	
							},
							error: function(request, status, error){
				                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				            }
			    		});  // end of $.ajax({
						
						Swal.fire('댓글이 삭제됐습니다.', '삭제완료','success');
						location.reload();	
				   } // end of if
				   
				}); // end of .then(result => 
				
	}); // end of 댓글 삭제 $(document).on 	
    	
    	
    	
    	
	// 댓글 수정 후 확인버튼 누를시		
    $(document).on("click","button.cmtEditBnt", function(){
    	//alert("asd")
    	let content = $(this).prev().val();
    	//console.log(content);
    	let cmtno = $(this).parent().parent().prev().find("#cmtno").val();
    	//console.log(cmtno)
    	let notino = $(this).parent().parent().prev().find("#cmt_notino").val();
    	
    	
    	if(content == ""){
    		alert("댓글 내용을 입력하세요");
    		return;
    	}
    	else{
    		
    		// 댓글 내용 수정 후 확인 누르면 
    		$.ajax({
		    	url : "<%= request.getContextPath() %>/notice/editDepComment.yolo",
		    	type: 'POST',
		    	data : {"content" : content,
			    		"cmtno" : cmtno},
		    	dataType: "JSON",
				success: function(json){
				//	console.log(json);
				//  json.result;
				//  console.log(json.result);
				 
				 	// 댓글 출력해줬던 함수 재호출
				 	goReadComment(notino); 
				 	
				},
				error: function(request, status, error){
	                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
    
    		});  // end of $.ajax({
    		
    	}// end of else
    	
    	
    }) // end of  $(document).on("click","button.cmtEditBnt", function()

    		
    	
	}); // end of $(document).ready(function()-------------------

		
			
			
	// 댓글 쓰기 버튼 누를 경우 
	function goAddCmt() {
		
		// 유효성 검사
		const commentContent = $("textarea#commentContent").val().trim();	//공백은 제거 trim()
		// console.log(commentContent)
		
		if(commentContent == "") { // 공백제거 후의 commentContent가 공백이면 내용 안 쓴 것.
			
			alert("댓글 내용을 입력하세요");
		
	    	return; //메세지 뜨게 하고 종료
		}
		else{
			alert("댓글쓰기가 완료되었습니다.");
			goAddCmtReal();
			location.reload();
		}
	} // end of function goAddWrite()
			

	
	// 유효성 검사 통과한 댓글 쓰기인 경우 
	function goAddCmtReal() {
		
   		$.ajax({
		  url:"<%= request.getContextPath()%>/notice/addDepComment.yolo",
		  data: {//cmtForm,
			  	 "content" : $("textarea#commentContent").val() 
			  	,"fk_empno" : $("input#fk_empno").val()
			  	,"fk_notino" : $("input#notino").val()},
			  
			
			type: "POST",
			dataType: "JSON",
			success: function(json){
			 	
			//	console.log("goAddCmtReal json :" +json);			
			
			//	console.log("json.fk_notino :" + json.fk_notino);
			 
				goReadComment(notino); 
			 	
				$("textarea#commentContent").val("");
				
			},
			error: function(request, status, error){
		           alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		    }
		}); 
   	
	} // end of function oAddWrite_noAttach()
			


	// 작성한 댓글 읽어오기
	function goReadComment(notino) {
	//	console.log(fk_notino);
		$.ajax({
   			url:"<%= request.getContextPath()%>/notice/readDepComment.yolo",
   			data: {"fk_notino" : notino},
   					 // 원글 알아야 한다.
   			dataType:"JSON",
   			success: function(data){
   			
   				let html = "";
   				
   				if(data.length > 0) {
   					
   				
   				$.each(data,function(index, item){
  				// 여러개의 댓글 존재할 수 있음 => for문으로  					
   				//	console.log(item.name);
   				//	console.log(item.fk_empno);
   				
   				const commentno = item.commentno;
   			
  				html +=
  						'<div class="mt-3 mb-2" >'+
   				      	'<div class="commentrow  px-2 py-3">'+
   				       	'<span class="mt-2 mb-3" style="font-size: 12pt; color: gray;"> ┗ <span id="prof" class="py-2" style= "background-color: '+item.profile_color+';">'+item.nickname+'</span><span class="ml-1 mr-1" id="fk_empno" >'+item.name+'</span><span class="ml-3" id="cmtWritedate">'+item.writedate+'</span></span>';
   				
   				  
   				     if( ${sessionScope.loginuser.empno} != item.fk_empno) {
   				    	 
   				     
   				html +=	'<div style="display:inline; float: right;">'+
   				    	'</div>';
   				    	
   				     } 	
   				     else{
   				    	
   				html +=	
   						'<div style="display:inline; float: right;">'+
						    '<button type="button" class="MYcommentBnt mr-0" >수정</button>'+
				     		'<button type="button" class="MYcommentCancelBnt mr-0">삭제</button>'+
				     		'<input type="hidden" name="fk_notino" id="cmt_notino" value=" '+item.fk_notino+' "/>'+
	   			  			'<input type="hidden" name="fk_empno" id="cmt_notino" value=" '+item.fk_empno+' "/>'+
	   			         	'<input type="hidden" name="commentno" id="cmtno" value=" '+item.commentno+' "/>'+
			     		'</div>';
   				     }
   				     
   				 html+=	
   				    	'<div class="mt-3">'+
   			       			'<span name="content" id="cmtContent" class="commentrow mt-3 mb-4 " style="border-style: none; font-size: 12pt; color: gray;" id="cmtContent">▶ '+item.content+'</span>'+
   			       		<%--'<button type="button" class="cmtEditBnt mr-0" style="float: right;">확인</button>'+ --%>
   				       	'</div>'+
   				       	'</div>'+	
   			  			'</div>'+
   				       	'<hr>';
   					
   				}); // end of $.each(data,function(index, item) -----------------
   			} // if
   			
   			else{
   				html += 
   					'<div class="mt-3 mb-2" >'+
				    '<div class="commentrow  px-2 py-2">'+
				    '<span class="mt-2 mb-3" style="font-size: 10pt; color: gray;"> 댓글이 없습니다.</span>'+
				    '</div>'+
				    '</div>';
   			}
   				
   			$("#showCmt").html(html);
   			
   			},
   			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
   			
  
		});	// end of $.ajax({ -------------------
	
	}// end of function goReadComment()
			
			
</script>    
    
    
 <%-- 공지 상세 모달 클릭 시 배경 fade out --%>   
 <div id="myListModal_outside"></div>
    

<%-- 게시글 상세 Modal --%>
<div id="myListModal">
    <%-- Modal content --%>
    <div class="modalHeader">
    	<span style="font-size:20px;">&#128226;</span><span class="myListModalTitle ml-3" style="font-size: 20px; font-weight: bold;"> 부서 공지 </span>
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
		     	
		     	<div class="filedownload" >
		           <span style="font-size:10pt;"><span style='font-size:20px;'>&#128194;</span>
					<span id="noticeFile"></span>
					<input type="hidden" id="file_notino" name="notino" value=""/>
		           </span>
		        </div>
		        
		        
		     	<div>
		     		<span style="display: block; margin-top: 20px; margin-bottom: 10px;"> <span style='font-size:20px;'>&#128312;</span> 공지 내용 </span>
		     		<span id="content" style="display: block; height: 200px; width: 100%; border: 1px solid #e0e0e0; color:gray; overflow: auto;">작성된 공지 내용 들어가는 곳</span>
		     	</div>
     			<input id="notino" type="hidden">
     			
				 <%-- 댓글 입력란 시작 --%>     	
	
		    	 	
		     	 <div style="margin: 30px 0;">
		      	 <span style="font-size: 16px;">&#128313; 댓글</span>
		   		 <div class="commentBox">
		   		 
		      	 <%-- 댓글폼 --%>
		    	<form id="commentFrm" name="commentFrm" style="resize: none; width:100%; margin: 0;">
		       	<textarea id="commentContent" name="content" maxlength="50"  placeholder="댓글을 입력하세요." style="resize: none; width:100%; height: 20%; margin: 0;"></textarea>
		       	<div class="mt-2">
		       		<button type="button" class="commentBnt" onclick="goAddCmt()">댓글쓰기</button>
					<button type="reset" class="commentCancleBnt">취소</button>
		        	<div class="textLengthWrap" style="float: right; color: #808080;">
				   		<span class="textCount">0자</span>
				    	<span class="textTotal">/50자</span>
					</div>
				</div>
				<input type="hidden" name="fk_empno" id="fk_empno"  value="${sessionScope.loginuser.empno}" />  
				<input type="hidden" name="fk_notino" id="fk_notino"  />
	    		</form>
	    		
	    	</div>
			</div> <%-- 댓글 입력란 끝 --%>   
			
	
			</div>
		</div> <%-- modal body --%>
			
		<div  class="modalFooter">
			<div class="modal-cmtContent " id="showCmt">
		      
		      	<%-- 댓글 내용 --%> <%-- 내가 쓴 댓글은 수정, 삭제 버튼 나오게 하기 / 수정시 댓글내용은 입력폼으로 변경된다. --%>
		      	<%--
		      	<div class="mt-3 mb-2" >
		      	
		      	
		      	
		      	<div class="commentrow  px-2 py-2" >
		       	<span class="mt-2 mb-3" style="font-size: 10pt; color: gray;"> ┗ <span id="prof" class="py-2">작성자</span><span class="ml-1 mr-1" id="fk_empno" >김땡땡</span><span class="ml-3" id="cmtWritedate">2022-11-30</span></span>
		       	<div style="display:inline;	float: right;">
	     			<button type="button" class="MYcommentBnt mr-0" >수정</button> 
	     			<button type="button" class="MYcommentCancelBnt mr-0">삭제</button>
	      		</div>
	      		<div class="mt-3">
	       		<span class="commentrow mt-3 mb-4" style="font-size: 10pt; color: gray;" id="cmtContent"> &nbsp; ▶ 좋은 댓글 작성합니다.</span>
	       		<button type="button" class="cmtEditBnt mr-0" style="float: right;">확인</button>
		       	</div>
		       	</div>	
		       	
		       	<hr>
		       
		  		</div>  댓글내용 끝 
		  		--%>
	  		</div>
	  	</div><%-- footer  끝 --%>
	  	
</div>


	    

