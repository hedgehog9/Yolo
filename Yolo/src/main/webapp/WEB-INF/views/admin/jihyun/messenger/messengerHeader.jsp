<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

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
		padding-top: 3px;
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
		height: 100%;
		max-height: 390px;
		overflow: auto;
	}
	
	div#rightDown {
		width: 100%;
		height: 50px;
		padding: 15px 0px;
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
	    width : 80%;
	    hight : 35px;
	    margin: 7px 10%;
	    border-radius: 0.4rem;
  	}
  	
  	div.choosedPsn{
  		width: 100%;
  		border-radius: 0.4rem;
  		padding: 5px 5%;
  	}
  	
  	div.choosedPsn:hover {
		cursor: pointer;
		background-color: #f9fafa;
	}
	
	
</style>

<script>
	
	$(document).ready(function(){
		
		$("#file").on('change',function(){
			  var fileName = $("#file").val();
			  $(".upload-name").val(fileName);
		});
		
		
		$("button.my_close").on("click", function(){
			
			Swal.fire({
				   title: '메신저 보내기를 벗어납니다.',
				   text: '작성내용을 임시 저장 할까요?',
				   icon: 'warning',
				   
				   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
				   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
				   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
				   confirmButtonText: '승인', // confirm 버튼 텍스트 지정
				   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
				   
				   // reverseButtons: true, // 버튼 순서 거꾸로
				   
				}).then(result => {
				   // 만약 Promise리턴을 받으면, 
				   if (!result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
					   const modal_frmArr = document.querySelectorAll("form#my_form");
					  	  for(let i=0; i<modal_frmArr.length; i++) {
					  		  modal_frmArr[i].reset();
					  	  }
				   }
				});
		  	  
		}); 
		
		
		// 체크박스 바뀔때 효과
		$(document).on("change", "input.names", function(e){
			ck_list = [];
			
			
		});
		
		
		// 받는 사람 닫기
		$('#choosePerson_outside').on('click', function () {
			choosePerson_close();
		});
		
		
		
		/* $(document).on("click", "span.arrow", function(e){
			const idx = $("span.arrow").index($(e.target));
			const target = $("span.arrow").eq(idx).parent().next()[0];
			target.show();
			console.log(target);
		}); */
		
	}); // end of ready 
	
	
	// 받는사람 열기
	function search_choosePerson(){
		
		$('#choosePerson').addClass('active');
		$('button.dropdownBtn').css({'background-color':'#dddddd'});
	    $('#choosePerson_outside').fadeIn();
	    
		openAjax(); // 받는 사람 목록 ajax로 불러오기
		
		// 부서 토글
        $("div.hidDept").hide();
        $("div.hidTeam").hide();
		
	}
	
	// 받는사람 닫기
	function choosePerson_close(){
		$('#choosePerson').removeClass('active');
		$('button.dropdownBtn').css({'background-color':''});
	    $('#choosePerson_outside').fadeOut();
	}
	
	
	function toggleShow(deptno){
		$("div[id='"+deptno+"']").toggle();
	}
	
	// 받는 사람 목록 ajax로 불러오기
	function openAjax(){
		$.ajax({
	    	url : "<%=ctxPath%>/jihyun/getDept.yolo",
    		dataType: "JSON",
    		async:false,
			success: function(json){ 
				
				let html = "";
				
				if(json.length>0){
					
					$.each(json, function(index1, item1){
						html += '<div style="display: flex; align-items: center;" class="py-1 pt-2">' +
							'<input type="checkbox" class="ml-3"/><label class="person ml-2" style="font-weight: bold;">'+item1.deptname+'</label><span class="arrow" onclick="toggleShow('+item1.deptno+')">&#128317;</span>'+
							'</div>'+
					        '<div class="hidDept pl-5" id="'+item1.deptno+'">';
					        
							// 부서 내 사람 구하기(부서장)
							$.ajax({
						    	url : "<%=ctxPath%>/jihyun/getDeptPerson.yolo",
						    	data : {"deptno" : item1.deptno},
					    		dataType: "JSON",
					    		async:false,
								success: function(json2){
									
									if(json2.length>0){
										$.each(json2, function(index2, item2){
											html +='<div><input type="checkbox" class="names" value="'+item2.name+'" /><label class="person ml-2">'+item2.name+'</label></div>';
										}); // end of for each
									}
								},
								error: function(request, status, error){
					                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					            }
							}); // end of ajax (부서구하기)
						    	
							
							// 부서내 팀 구하기
							$.ajax({
						    	url : "<%=ctxPath%>/jihyun/getTeam.yolo",
						    	data : {"deptno" : item1.deptno},
					    		dataType: "JSON",
					    		async:false,
								success: function(json3){
									
									if(json3.length>0){
										$.each(json3, function(index3, item3){
											html += '<div class="py-1 pt-2">'+
												'<input type="checkbox"/><label class="person ml-2" style="font-weight: bold;">'+item3.deptname+'</label><span class="arrow" onclick="toggleShow('+item3.deptno+')">&#128317;</span>'+
												'</div>'+
												'<div class="hidTeam pl-5" id="'+item3.deptno+'">';
												
											
											// 팀 내 사람 구하기(팀원들)
											$.ajax({
										    	url : "<%=ctxPath%>/jihyun/getTeamPerson.yolo",
										    	data : {"deptno" : item3.deptno},
									    		dataType: "JSON",
									    		async:false,
												success: function(json4){
													
													if(json4.length>0){
														$.each(json4, function(index4, item4){
															html +='<div><input type="checkbox"/><label class="person ml-2">'+item4.name+'</label></div>';
														}); // end of for each
														
														
													}
										        
												},
												error: function(request, status, error){
									                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
									            }
											}); // end of ajax (팀 내 사람 구하기(팀원들))
											
											html += '</div>';
										}); // end of for each
										
										
									}
								},
								error: function(request, status, error){
					                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					            }
							}); // end of ajax (팀구하기)
							
							html += '</div>';
					});// end of each
					
				}
				
				console.log(html);
				$('div#resultOfAjax').html(html);
				
			},
			error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
			
	    }); // end of ajax 
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
		<div style="display: flex; align-items: center;" class="border-bottom py-2">
			<input type="checkbox" class="ml-2"/><label class="person ml-2" style="font-weight: bold;">전체선택</label>
		</div>
		
		<div id="resultOfAjax"></div>
		
		 <!-- <div style="display: flex; align-items: center;" class="py-1 pt-2">
			<input type="checkbox" class="ml-3"/><label class="person ml-2" style="font-weight: bold;">인사부</label><span class="arrow">&#128317;</span>
		</div>
        <div class="hidDept pl-5">
        	<div><input type="checkbox"/><label class="person ml-2">조상운</label></div>
        	<div class="py-1 pt-2">
				<input type="checkbox"/><label class="person ml-2" style="font-weight: bold;">인사부</label><span class="arrow">&#128317;</span>
			</div>
			<div class="hidTeam pl-5">
					<div><input type="checkbox"/><label class="person ml-2">조상운</label></div>
					<div><input type="checkbox"/><label class="person ml-2">조상운</label></div>
					<div><input type="checkbox"/><label class="person ml-2">조상운</label></div>
			</div>
        </div>  -->
        
        
	</div>
	<div id="rightSide">
		<div id="rightUp">
			<div class="choosedPsn" style="width: 100%;">
				<div class="sentPsnProf ml-2" style="background-color: orange;"><span style="font-size: 9pt;">길동</span></div>
				<span class="ml-2" style="padding-top: 3px;">홍길동</span>
				<span class="ml-2" style="font-weight: normal; color: gray; font-size: 10pt;">인사 · 관리자</span>
			</div>
		</div>
		<div id="rightDown">
			<button type="button" id="addPersonBtn">받는사람 추가</button>
		</div>
	
	</div>
</div>