<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath=request.getContextPath(); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<style type="text/css">

	#noticeNav {
		cursor: pointer;
		margin-left: 20px;
		margin-top: 20px;
		align-content: center;
		width: 100%;
	}
	
	button.headerBtn,
	button.writeSubmitBtn {
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
	
	button.headerBtn:hover,
	button.writeSubmitBtn:hover {
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
	
	textarea#noticecontent:focus{
		outline : 2px solid #66cc66;
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
	
	.filebox .upload-name:focus {
		outline : 2px solid #66cc66;
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
  	
  	/* 받는 사람 */
  	
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
		min-width: 22%;
		max-width : 100%;
		height : 40px;
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
		width: 500px;
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
		width: 50%;
		max-height: 390px;
		overflow: auto;
	}
	
	div#rightSide {
		width: 50%;
		display: flex;
		flex-direction: column;
	}
	
	div#rightTitle {
		width: 100%;
		height: 35px;
		padding: 3px auto;
	}
	
	div#rightUp {
	
		width: 100%;
		height: 100%;
		max-height: 390px;
		overflow: auto;
	}
	
	div#rightDown {
		width: 100%;
		height: 45px;
		padding: 3px 0px;
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
	    width : 70%;
	    hight : 38px;
	    margin: 3px 15%;
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
  	
  	/* Modal 끝  */
	
</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		$("#file").on('change',function(){
			  var fileName = $("#file").val();
			  $(".upload-name").val(fileName);
		});
		
		
		
		// 공지 작성 시 받는 사람 설정할 경우
		//$('#choosePerson_outside').on('click', function () {
	    //     choosePerson_close();
	    //});
		
		
		// 체크박스 바뀔때 효과
		$(document).on("change", "input.names", function(e){
			ck_empno_list = [];
			$("input.names:checked").each(function(index, item){
				ck_empno_list.push($(item).val());
			});
			
			$('div#choosedPsnResult').empty();
			
			if(ck_empno_list.length>0){
				str_empno = ck_empno_list.join(",");
				
				$.ajax({
			    	url : "<%=ctxPath%>/notice/chooseUser.yolo",
			    	data:{"str_empno":str_empno },
		    		dataType: "JSON",
		    		async:false,
					success: function(json){ 
						let html = "";
						if(json.length>0){
							
							$.each(json, function(index, item){
								
								html += '<div class="choosedPsn" style="width: 100%;" name="'+item.empno+'">'+
										'<div class="sentPsnProf ml-2" style="background-color: '+item.profile_color+';"></div>'+
										'<span class="ml-3" style="padding-top: 3px;">'+item.name+'</span>'+
										'<span class="ml-2" style="font-weight: normal; color: gray; font-size: 10pt;">'+item.deptname+' · '+item.position+'</span>'+
										'</div>';
									
							});// end of each
						}
						
						$('div#choosedPsnResult').html(html);
					},
					error: function(request, status, error){
		                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		            }
					
			    }); // end of ajax 
			}
		});// end of 체크박스 바뀔때 효과
		
		
		// 전체선택
		$("input#allCheck").change(function(){
			const bool = $("input#allCheck").prop("checked");
			$("input.names").prop("checked",bool); 
			$("input.depts").prop("checked",bool); 
			$("input.names").trigger("change");
		});
		
		
		// 부서 선택시 부서 선택되게
		$(document).on('change', "input.depts",  function (e) {
			const bool = $(e.target).prop("checked");
			$("input."+$(e.target).val()).prop("checked",bool); 
			$("input.names").trigger("change");
		});
		
		
		// 프로필 클릭시 삭제 되도록 
		$(document).on('click', "div.choosedPsn",  function () {
			$('input#'+$(this).attr('name')).prop("checked",false); 
			$(this).remove()
		});
		
		
		// 받는 사람 닫기
		$('#choosePerson_outside').on('click', function () {
			choosePerson_close();
		});
		
		
		// 받는사람 선택 버튼 클릭이벤트
		$('button#addPersonBtn').click(function(){
			ck_empno_list = [];
			ck_name_list = [];
			
			$("input.names:checked").each(function(index, item){
				ck_empno_list.push($(item).val());
				ck_name_list.push($(item).next().text());
			});
			
			if(ck_empno_list.length>0){
				str_empno = ck_empno_list.join(",");
				str_name = ck_name_list.join(", ");
				
				if(str_name.length>50){
					str_name = str_name.substr(0, 50)+" ...";
				}
				
				$('input[name="fk_recipientno"]').val(str_empno);
				$('button#dropdownMenuButton').find('span').text(str_name);
				choosePerson_close();
				
			} else {
				Swal.fire('받는사람이 선택되지 않았습니다.','받는 사람은 한명이상 선택해주세요.', 'error');
			}
		});
		
		
		
		// 공지 보내기 버튼 클릭 이벤트
		$("button#sendNotiBtn").click(function(){
			
			// 글제목 유효성 검사
			const subject = $("input#subject").val().trim();
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
			const content = $("textarea#noticecontent").val().trim();
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
			
			// 받는 사람 유효성 검사
			if($('input[name="fk_recipientno"]').val() == "" ){
				Swal.fire('받는사람을 선택하세요','', 'error');
				return;
			}
		
			const queryString = $("form[name='noticeFrm']").serialize();
			
			$.ajax({
		    	url : "<%=ctxPath%>/notice/sendNotice.yolo",
		    	data : queryString,
				success: function(){
					
					const modal_frmArr = document.querySelectorAll("form#noticeFrm");
			  	  	for(let i=0; i<modal_frmArr.length; i++) {
			  			modal_frmArr[i].reset();
			  			$('button#dropdownMenuButton').find('span').text('받는 사람 선택');
			  	  	}
					$(".sendNotice").modal('hide');
					toastr.success('공지작성이 완료되었습니다.');
					
				},
				error: function(request, status, error){
	                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
			}); // end of ajax
			
		}); // end of 메세지 보내기 버튼 클릭 이벤트
		
		
	}); // end of $(document).ready(function()
	
	
	
	
	// 받는 사람 dropdown 열기
   function search_choosePerson(){
      // toastr.info("정보 변경내역 조회 메소드 호출됨");
      
      $('#choosePerson').addClass('active');
      $('button.dropdownBtn').css({'background-color':'#dddddd'});
      $('#choosePerson_outside').fadeIn();
      
   
	
	   openAjax(); // 받는 사람 목록 ajax로 불러오기
	   
	   // 부서 토글
	   $("div.hidDept").hide();
	   $("div.hidTeam").hide();
	
   }
   
   
   // 받는 사람 dropdown 닫기
   function choosePerson_close(){
	   	$('div#choosedPsnResult').empty();
		$('#choosePerson').removeClass('active');
		$('button.dropdownBtn').css({'background-color':''});
	    $('#choosePerson_outside').fadeOut();
	}
	
	
	// 부서 토글
	function toggleShow(deptno){
		$("div[id='"+deptno+"']").toggle();
	}
	

	// 받는 사람 목록 ajax로 불러오기
	function openAjax(){
		$.ajax({
	    	url : "<%=ctxPath%>/jinji/getDept.yolo",
    		dataType: "JSON",
    		async:false,
			success: function(json){ 
				
				let html = "";
				
				if(json.length>0){
					
					$.each(json, function(index1, item1){
						html += '<div style="display: flex; align-items: center;" class="py-1 pt-2">' +
									'<input type="checkbox" class="ml-3 depts" value="'+item1.deptno+'" /><label class="person ml-2" style="font-weight: bold;" onclick="toggleShow('+item1.deptno+')">'+item1.deptname+'</label>'+
									'<span class="arrow" onclick="toggleShow('+item1.deptno+')">&#128317;</span>'+
								'</div>'+
						        '<div class="hidDept pl-5" id="'+item1.deptno+'">';
						        
							// 부서 내 사람 구하기(부서장)
							$.ajax({
						    	url : "<%=ctxPath%>/jinji/getDeptPerson.yolo",
						    	data : {"deptno" : item1.deptno},
					    		dataType: "JSON",
					    		async:false,
								success: function(json2){
									
									if(json2.length>0){
										$.each(json2, function(index2, item2){
											html +='<div><input type="checkbox" class="names '+item1.deptno+'" value="'+item2.empno+'" id="'+item2.empno+'" /><label class="person ml-2" for="'+item2.empno+'">'+item2.name+'</label></div>';
										}); // end of for each
									}
								},
								error: function(request, status, error){
					                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					            }
							}); // end of ajax (부서구하기)
						    	
							
							// 부서내 팀 구하기
							$.ajax({
						    	url : "<%=ctxPath%>/jinji/getTeam.yolo",
						    	data : {"deptno" : item1.deptno},
					    		dataType: "JSON",
					    		async:false,
								success: function(json3){
									
									if(json3.length>0){
										$.each(json3, function(index3, item3){
											html += '<div class="py-1 pt-2">'+
												'<input type="checkbox" class="depts '+item1.deptno+'" value="'+item3.deptno+'" /><label class="person ml-2" style="font-weight: bold;" onclick="toggleShow('+item3.deptno+')">'+item3.deptname+'</label><span class="arrow" onclick="toggleShow('+item3.deptno+')">&#128317;</span>'+
												'</div>'+
												'<div class="hidTeam pl-5" id="'+item3.deptno+'">';
												
											
											// 팀 내 사람 구하기(팀원들)
											$.ajax({
										    	url : "<%=ctxPath%>/jinji/getTeamPerson.yolo",
										    	data : {"deptno" : item3.deptno},
									    		dataType: "JSON",
									    		async:false,
												success: function(json4){
													
													if(json4.length>0){
														$.each(json4, function(index4, item4){
															html +='<div><input type="checkbox" class="names '+item1.deptno+' '+item3.deptno+'" value="'+item4.empno+'" id="'+item4.empno+'" /><label class="person ml-2" for="'+item4.empno+'" >'+item4.name+'</label></div>';
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
				
				$('div#resultOfAjax').html(html);
				
			},
			error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
			
	    }); // end of ajax 
	    
	    
	}
	
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
      <button type="button" class="close my_writeClose" data-dismiss="modal" aria-label="Close">&times;</button> 
      
      <form id='noticeFrm' name="noticeFrm">
      	<input name="subject" id="subject" placeholder="공지 제목을 입력하세요"/>
      	
      	<button class="dropdownBtn" type="button" id="dropdownMenuButton" onclick="search_choosePerson()">
        	<div class="sentPsnProf"><i class="fas fa-solid fa-user"></i></div> <span style="color: #757575; font-size: 11pt; margin-left: 10px;">받는 사람 선택</span>
        </button>
        
        <textarea rows="" cols="" name="content" id="noticecontent"></textarea>
        <input type="text" name="fk_recipientno" />
       <!--  <input type="text" name="notino" /> -->
        
        <div id="attachArea">
        	<div class="filebox">
			    <input class="upload-name" value="첨부파일" placeholder="첨부파일">
			    <label for="file">파일 찾기</label> 
			    <input type="file" id="file" multiple="multiple">
			</div>
        </div>
      </form>
        
        <button type="button" class="writeSubmitBtn" id="sendNotiBtn" style="width: 80%; margin: 10px 10% 50px 10%;">
			<i class="fas fa-regular fa-paper-plane" id="icon"></i>공지 작성하기
		</button>
      </div>
    </div>
  </div>
</div>	


<%-- 받는 사람 모달 --%>
<!-- 받는 사람 팝업 -->
<div id="choosePerson_outside"></div>

<div id="choosePerson">
	<div id="leftSide">
		<div style="display: flex; align-items: center;" class="border-bottom py-2">
			<input type="checkbox" class="ml-2" id="allCheck" /><label class="person ml-2" style="font-weight: bold;">전체선택</label>
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
		<div id="rightTitle"><span style="font-weight:bold;" class="mx-3 mt-2">받는사람 목록</span></div>
		<div id="rightUp">
			<div id="choosedPsnResult"></div>
			
			<!-- <div class="choosedPsn" style="width: 100%;">
				<div class="sentPsnProf ml-2" style="background-color: orange;"><span style="font-size: 9pt;">길동</span></div>
				<span class="ml-2" style="padding-top: 3px;">홍길동</span>
				<span class="ml-2" style="font-weight: normal; color: gray; font-size: 10pt;">인사 · 관리자</span>
			</div> -->
		</div>
		<div id="rightDown">
			<button type="button" id="addPersonBtn">받는사람 추가</button>
		</div>
	
	</div>
	
</div>		
