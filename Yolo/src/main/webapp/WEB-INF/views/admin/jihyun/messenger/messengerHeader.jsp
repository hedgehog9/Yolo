<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<style>

	div#messengerHeader {
		/* border: 1px solid black; */
		height: 110px;
		width: 100%;
		display: flex;
  		align-items: center;
	}
	
	span.headerTitle {
		font-weight: bold;
		font-size: 22pt;
		margin: auto 15px;
		color: #cccece;
	}
	
	span.headerTitle:hover {
		cursor: pointer;
		color: #494949;
	}
	
	button.headerBtn {
		border-radius: 0.5rem;
		border: 1px solid gray;
		background: linear-gradient( to left ,#5bd3ff, #88eb1e );
		margin-left:60%;
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
	
	/* 모달창 부분 */
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
	
	
</style>

<script>
	
	$(document).ready(function(){
		
		$("#file").on('change',function(){
			  var fileName = $("#file").val();
			  $(".upload-name").val(fileName);
		});
		
		$("button.my_close").on("click", function(){
			
			if (confirm("메신저 보내기를 나갈시 내용은 저장되지 않습니다. 나가시겠습니까?")) {
				const modal_frmArr = document.querySelectorAll("form#my_form");
			  	  for(let i=0; i<modal_frmArr.length; i++) {
			  		  modal_frmArr[i].reset();
			  	  }
	        } else {
	        	// $("div#staticBackdrop").modal(); 이거 안되네 나중에 다시 보자
	        }
		  	  
		}); 
		
		
	});

	

</script>

<div id="messengerHeader" class="border-bottom">
		<span class="headerTitle ml-5">받은 메신저</span>
		<span class="headerTitle">보낸 메신저</span>
		<button type="button" class="headerBtn" data-toggle="modal" data-target=".sendMail">
			<i class="fas fa-regular fa-paper-plane" id="icon"></i>메신저 보내기
		</button>
</div>


<!-- Modal -->
<!-- Modal 구성 요소는 현재 페이지 상단에 표시되는 대화 상자/팝업 창입니다. -->
<div class="modal fade sendMail"  id="staticBackdrop" data-backdrop="static">
  <div class="modal-dialog modal-dialog-scrollable modal-lg modal-dialog-centered">
  <!-- .modal-dialog-scrollable을 .modal-dialog에 추가하여 페이지 자체가 아닌 모달 내부에서만 스크롤할 수 있습니다. -->
    <div class="modal-content">

      <!-- Modal body -->
      <div class="modal-body">
      <button type="button" class="close my_close" data-dismiss="modal" aria-label="Close">&times;</button> 
      <form id='my_form'>
      	<input name="subject" placeholder="메신저 제목을 입력하세요"/>
      	<span style="width: 80%; margin: 0 10%;">받는 사람 입력부분 일단 스팬으로</span>
        <textarea rows="" cols="" name="content"></textarea>
        <div id="attachArea">
        	<div class="filebox">
			    <input class="upload-name" value="첨부파일" placeholder="첨부파일">
			    <label for="file">파일찾기</label> 
			    <input type="file" id="file">
			</div>
        </div>
      </form>
        
        <button type="button" class="headerBtn" style="width: 80%; margin: 10px 10% 50px 10%;">
			<i class="fas fa-regular fa-paper-plane" id="icon"></i>메신저 보내기
		</button>
      </div>
      
    </div>
  </div>
</div>