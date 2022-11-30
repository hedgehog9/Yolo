<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style type="text/css">

	/* Model 시작 */
	div.noticeEdit{
		min-height: 700px;
		max-height: 850px;
	}
	
	input[name='editsubject']{
		height: 50px;
		width: 80%;
		margin: 35px 10% 15px 10%;
		font-size: 20pt;
		font-weight: bold;
		border: none;
	}
	
	input[name='editsubject']:focus {
		outline: none;
	}
	
	textarea[name='editContent'] {
		min-height: 400px;
		width: 80%;
		margin: 10px 10% 5px 10%;
		border: 1px solid #dddddd;
		border-radius: 0.4rem;
	}
	
	textarea#editContent:focus{
		outline : 2px solid #66cc66;
	}
	
	div#attachFile {
		width: 80%;
		margin: 0 10% 15px 10%;
	}
	
	.fileEditbox .uploadName {
	    display: inline-block;
	    height: 40px;
	    padding: 0 10px;
	    vertical-align: middle;
	    border: 1px solid #dddddd;
	    width: 70%;
	    border-radius: 0.4rem;
	    color: #999999;
	}
	
	.fileEditbox label {
	    display: inline-block;
	    padding: 9px 20px;
	    color: #fff;
	    vertical-align: middle;
	    text-align: center;
	    background-color: #88eb1e;
	    cursor: pointer;
	    width : 25%;
	    height: 40px;
	    margin-left: 10px;
	    margin-top: 5px;
	    border-radius: 0.4rem;
	}
	
	.fileEditbox .uploadName:focus {
		outline : 2px solid #66cc66;
	}
	
	.fileEditbox input[type="file"] {
	    position: absolute;
	    width: 0;
	    height: 0;
	    padding: 0;
	    overflow: hidden;
	    border: 0;
	}
	
	.modal::-webkit-scrollbar {
    	width: 10px;
  	}
  	.modal::-webkit-scrollbar-thumb {
    	background-color: #ababab;
    	border-radius: 10px;
  	}
  	.modal::-webkit-scrollbar-track {
    	background-color: #dedfe0;
    	border-radius: 10px;
  	}
  	
  	button.editNoticeBtn {
		border-radius: 0.5rem;
		border: 1px solid gray;
		background: linear-gradient( to left ,#5bd3ff, #88eb1e );
	 	margin-left: 75%;
		width: 170px;
		height: 45px;
		border: none;
		color: white;
		font-weight: bold;
	}
	
	button.editNoticeBtn:hover{
		 filter: brightness(90%);
	}
	
	i#icon{
		color: white;
		margin-right: 15px;
	}

</style>    

<script type="text/javascript">

	$(document).ready(function() {
		
		$("button.editNoticeBtn").click(function(){
			
			// 글제목 유효성 검사
			const subject = $("input#editsubject").val().trim();
			if(subject == "") {
				toastr.options = {
	                      closeButton: true,
	                      progressBar: true,
	                      showMethod: 'slideDown',
	                      timeOut: 2000,
	                      positionClass: 'toast-top-center'
	                  };
	                  toastr.error('', '글제목을 입력하세요');
				return;
			}

			// 글내용 유효성 검사
			const content = $("textarea#editContent").val().trim();
			if(content == "") {
				toastr.options = {
	                      closeButton: true,
	                      progressBar: true,
	                      showMethod: 'slideDown',
	                      timeOut: 2000,
	                      positionClass: 'toast-top-center'
	                  };
	                  toastr.error('', '글내용을 입력하세요');
				return;
			}
	
		});	
		
	});

</script> 
 
<!-- Modal --> 
<div class="modal fade noticeEdit"  id="staticBackdrop" data-backdrop="static">
  <div class="modal-dialog modal-dialog-scrollable modal-lg modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal body -->
      <div class="modal-body">
      <button type="button" class="close my_close" data-dismiss="modal" aria-label="Close">&times;</button> 
      <form id='my_editform'>
      	<input id="editsubject" name="editsubject" placeholder="원래 공지제목 들어가는 곳" value=""/>
      	<span style="width: 80%; margin: 0 10%;">받는 사람</span>
        <textarea rows="" cols="" id="editContent" name="editContent">원래 공지 내용</textarea>
        <div id="attachFile">
        	<div class="fileEditbox">
			    <input class="uploadName" value="첨부파일" placeholder="첨부파일">
			    <label for="editfile">파일 찾기</label> 
			    <input type="file" id="editfile" value="">
			</div>
        </div>
      </form>
        
        <button type="button" class="editNoticeBtn" style="width: 80%; margin: 10px 10% 50px 10%;">
			<i class="fas fa-regular fa-paper-plane" id="icon"></i>공지 수정하기
		</button>
      </div>
    </div>
  </div>
</div>	
		    
    