<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>

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
  	
  	/* 받는 사람 드롭다운 시작 */
  	
  	div.sentPsnProf{
  		display: inline-block;
		width: 30px; 
		height: 30px; 
		border-radius: 40%; 
		text-align: center;
		background-color: #757575;
		color : white;
		font-size: 12pt;
		display: flex;
  		align-items: center;
	}
	
	i.fa-user {
		margin: auto;
	}
	
	button.dropdownBtn {
		width: 22%;
		margin-left : 10%;
		display: flex;
		align-items: center;
		background-color: white;
		border-radius: 0.4rem;
		border: none;
	}
	
	button.dropdownBtn:hover {
		 background-color: #dddddd;
	}
	
	
	/* 받는 사람 팝업 */
	
	div#choosePerson {
		/* border:solid 2px green; */
		min-height: 300px;
		max-height: 400px;
		width: 470px;
		display: flex;
		position: fixed;
		top: 1000px;
		left: 0px;
		z-index: 1052;
		background: white;
		border-radius: 0.3rem;
		color: black;
		/* transition: all 0.5s; */
		padding: 10px;
	}
	
	div#choosePerson.active {
		top: 208px;
		left: 654px;
	}
	
	div#choosePerson_outside {
		position: fixed;
		top: 0px;
		left: 0px;
		width: 100%;
		height: 100%;
		background: rgba(0, 0, 0, 0.2);
		z-index: 1051;
		display: none;
	}
	
	div#leftSide {
		width: 55%;
		max-height: 390px;
		overflow: auto;
	}
	
	div#rightSide {
		width: 45%;
		display: flex;
		flex-direction: column;
	}
	
	div#rightUp {
		width: 100%;
		height: 85%;
		max-height: 390px;
		overflow: auto;
	}
	
	div#rightDown {
		width: 100%;
		height: 15%;
	}
	
	#leftSide::-webkit-scrollbar {
    	width: 10px;
  	}
  	#leftSide::-webkit-scrollbar-thumb {
    	background-color: #ababab;
    	border-radius: 10px;
  	}
  	#leftSide::-webkit-scrollbar-track {
    	background-color: #dedfe0;
    	border-radius: 10px;
  	}
  	
  	#rightUp::-webkit-scrollbar {
    	width: 10px;
  	}
  	#rightUp::-webkit-scrollbar-thumb {
    	background-color: #ababab;
    	border-radius: 10px;
  	}
  	#rightUp::-webkit-scrollbar-track {
    	background-color: #dedfe0;
    	border-radius: 10px;
  	}
  	
  	label.person {
  		font-size: 11pt;
  		margin: auto 5px;
  	}
  	
  	label.person:hover, span.arrow:hover {
  		cursor: pointer;
  	}
  	
  	button#addPersonBtn {
  		display: inline-block;
	    color: #fff;
	    font-size: 11pt;
	  	font-weight: bold;
	    vertical-align: middle;
	    text-align: center;
	    background-color: #88eb1e;
	    border: none;
	    cursor: pointer;
	    width : 90px;
	    hight : 35px;
	    margin-top: 5px;
	    border-radius: 0.4rem;
  	}
  	
  	
	
	
</style>

<script>
	
	$(document).ready(function(){
		
		$("#file").on('change',function(){
			  var fileName = $("#file").val();
			  $(".upload-name").val(fileName);
		});
		
		$("button.my_close").on("click", function(){
			
			if (!confirm("메신저 보내기를 벗어납니다. 작성내용을 임시 저장 할까요?")) {
				const modal_frmArr = document.querySelectorAll("form#my_form");
			  	  for(let i=0; i<modal_frmArr.length; i++) {
			  		  modal_frmArr[i].reset();
			  	  }
	        } else {
	        	// $("div#staticBackdrop").modal(); 이거 안되네 나중에 다시 보자
	        }
		  	  
		}); 
		
		
		$('#choosePerson_outside').on('click', function () {
			choosePerson_close();
		});
		
		
		// 부서 토글
        $("div.hid").hide();
		
		
	}); // end of ready 
	
	
	// dropdown 열기
	function search_choosePerson(){
		// toastr.info("정보 변경내역 조회 메소드 호출됨");
		
		$('#choosePerson').addClass('active');
		$('button.dropdownBtn').css({'background-color':'#dddddd'});
	    $('#choosePerson_outside').fadeIn();
		
	}
	
	// dropdown 닫기
	function choosePerson_close(){
		$('#choosePerson').removeClass('active');
		$('button.dropdownBtn').css({'background-color':''});
	    $('#choosePerson_outside').fadeOut();
	}
	
	
	// 부서 토글
	function toggleDept() {
		$('div#insa').toggle();
	}

	

</script>

<div id="messengerHeader" class="border-bottom">
		<span class="headerTitle ml-5" id="rcvmsg" onclick="javascript:location.href='<%= ctxPath%>/messenger/receivedMessage.yolo'">받은 메신저</span>
		<span class="headerTitle" id="sndmsg" onclick="javascript:location.href='<%= ctxPath%>/messenger/sentMessage.yolo'">보낸 메신저</span>
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
      	
      	<button class="dropdownBtn" type="button" id="dropdownMenuButton" onclick="search_choosePerson()">
		   <div class="sentPsnProf"><i class="fas fa-solid fa-user"></i></div> <span style="color: #757575; font-size: 11pt; margin-left: 10px;">받는 사람 선택</span>
	  	</button>
	  	
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



<!-- 받는 사람 팝업 -->
<div id="choosePerson_outside"></div>

<div id="choosePerson">
	<div id="leftSide">
		<div style="display: flex; align-items: center;" class="border-bottom">
			<label class="person ml-2" style="font-weight: bold;">전체선택</label><input type="checkbox" class="ml-2"/>
		</div>
		<div style="display: flex; align-items: center;">
			<span class="mr-1 arrow" onclick="toggleDept()">&#128317;</span><label class="person" style="font-weight: bold;">인사부</label><input type="checkbox" class="ml-2"/>
		</div>
        <div id="insa" class="hid ml-5">
        	<div><label class="person">조상운<input type="checkbox"  class="ml-2"/></label></div>
        	<div><label class="person">조상운<input type="checkbox"  class="ml-2"/></label></div>
        	<div><label class="person">조상운<input type="checkbox"  class="ml-2"/></label></div>
        	<div><label class="person">조상운<input type="checkbox"  class="ml-2"/></label></div>
        	<div><label class="person">조상운<input type="checkbox"  class="ml-2"/></label></div>
        </div>
        <div style="display: flex; align-items: center;">
			<span class="mr-1 arrow" onclick="toggleDept()">&#128317;</span><label class="person" style="font-weight: bold;">인사부</label><input type="checkbox" class="ml-2"/>
		</div>
        <div id="insa" class="hid ml-5">
        	<div><label class="person">조상운<input type="checkbox"  class="ml-2"/></label></div>
        	<div><label class="person">조상운<input type="checkbox"  class="ml-2"/></label></div>
        	<div><label class="person">조상운<input type="checkbox"  class="ml-2"/></label></div>
        	<div><label class="person">조상운<input type="checkbox"  class="ml-2"/></label></div>
        	<div><label class="person">조상운<input type="checkbox"  class="ml-2"/></label></div>
        </div>
        <div style="display: flex; align-items: center;">
			<span class="mr-1 arrow" onclick="toggleDept()">&#128317;</span><label class="person" style="font-weight: bold;">인사부</label><input type="checkbox" class="ml-2"/>
		</div>
        <div id="insa" class="hid ml-5">
        	<div><label class="person">조상운<input type="checkbox"  class="ml-2"/></label></div>
        	<div><label class="person">조상운<input type="checkbox"  class="ml-2"/></label></div>
        	<div><label class="person">조상운<input type="checkbox"  class="ml-2"/></label></div>
        	<div><label class="person">조상운<input type="checkbox"  class="ml-2"/></label></div>
        	<div><label class="person">조상운<input type="checkbox"  class="ml-2"/></label></div>
        </div>
        
	</div>
	<div id="rightSide">
		<div id="rightUp">
		
		</div>
		<div id="rightDown">
			<button type="button" id="addPersonBtn" style="width: 80%; margin: 10px 10% 50px 10%;">받는사람 추가</button>
		</div>
	
	</div>
</div>