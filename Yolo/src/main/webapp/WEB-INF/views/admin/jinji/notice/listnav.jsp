<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath=request.getContextPath(); %>

<style type="text/css">

	#noticeNav {
		cursor: pointer;
		margin-left: 20px;
		margin-top: 20px;
		align-content: center;
		width: 100%;
	}
	
	button.headerBtn {
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
	
	button.headerBtn:hover{
		 filter: brightness(90%);
	}
	
	i#icon{
		color: white;
		margin-right: 15px;
	}
	
	
	/* Model 시작 */
	div.modal{
		min-height: 700px;
		max-height: 850px;
	}
	
	input[name='subject']{
		height: 50px;
		width: 80%;
		margin: 35px 10% 15px 10%;
		font-size: 20pt;
		font-weight: bold;
		border: none;
	}
	
	input[name='subject']:focus {
		outline: none;
	}
	
	textarea[name='content'] {
		min-height: 400px;
		width: 80%;
		margin: 10px 10% 5px 10%;
		border: 1px solid #dddddd;
		border-radius: 0.4rem;
	}
	
	div#attachArea {
		width: 80%;
		margin: 0 10% 15px 10%;
	}
	
	.filebox .upload-name {
	    display: inline-block;
	    height: 40px;
	    padding: 0 10px;
	    vertical-align: middle;
	    border: 1px solid #dddddd;
	    width: 70%;
	    border-radius: 0.4rem;
	    color: #999999;
	}
	
	.filebox label {
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
	
	.filebox input[type="file"] {
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
  	
  	
  	/* Modal 끝  */
	
</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		$("#file").on('change',function(){
			  var fileName = $("#file").val();
			  $(".upload-name").val(fileName);
		});
		
		$("button.my_close").on("click", function(){
			
			if (!confirm("공지 작성을 취소하시겠습니까?")) {
				const modal_frmArr = document.querySelectorAll("form#my_form");
			  	  for(let i=0; i<modal_frmArr.length; i++) {
			  		  modal_frmArr[i].reset();
			  	  }
	        } else {
	        	
	        }
		  	  
		}); 
		
	});
	
</script>

<div id="noticeNav">
	<div id="category">
		<span style="font-size: 20pt; font-weight: bold;" onclick="">공지사항</span>
		<button type="button" class="headerBtn" data-toggle="modal" data-target=".sendNotice">
		<i class="fas fa-regular fa-paper-plane" id="icon"></i>공지 작성하기
		</button>
	</div>
	<br>
	<div id="bottomcate">
		<span id="cate1" style="font-size: 13pt; font-weight: bold;" onclick="javascript:location.href='<%= ctxPath%>/notice/noticeList.yolo'">전체 공지</span>
		&nbsp; &nbsp; 
		<span id="cate2" style="font-size: 13pt; font-weight: bold;" onclick="javascript:location.href='<%= ctxPath%>/notice/depNoticeList.yolo'">부서 공지</span>
		&nbsp; &nbsp; 
		<span id="cate3" style="font-size: 13pt; font-weight: bold;" onclick="javascript:location.href='<%= ctxPath%>/notice/myNoticeList.yolo'">내가 쓴 공지</span>
	</div>
</div>
<hr width = "100%;">


<!-- Modal --> 
<div class="modal fade sendNotice"  id="staticBackdrop" data-backdrop="static">
  <div class="modal-dialog modal-dialog-scrollable modal-lg modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal body -->
      <div class="modal-body">
      <button type="button" class="close my_close" data-dismiss="modal" aria-label="Close">&times;</button> 
      <form id='my_form'>
      	<input name="subject" placeholder="공지 제목을 입력하세요"/>
      	<span style="width: 80%; margin: 0 10%;">받는 사람</span>
        <textarea rows="" cols="" name="content"></textarea>
        <div id="attachArea">
        	<div class="filebox">
			    <input class="upload-name" value="첨부파일" placeholder="첨부파일">
			    <label for="file">파일 찾기</label> 
			    <input type="file" id="file">
			</div>
        </div>
      </form>
        
        <button type="button" class="headerBtn" style="width: 80%; margin: 10px 10% 50px 10%;">
			<i class="fas fa-regular fa-paper-plane" id="icon"></i>공지 작성하기
		</button>
      </div>
    </div>
  </div>
</div>	
		
