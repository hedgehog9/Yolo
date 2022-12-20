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
		width: 98%;
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
		height: 400px;
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

// 	let flag = false;

	$(document).ready(function() {
		
		  // 파일
	      $("#file").on('change',function(){
	           var fileName = $("#file").val();
	           $(".upload-name").val(fileName);
	      });
    
		  
		<%--  
		// 검색시 검색조건 및 검색어 값 유지시키기
		// paraMap 있는지 없는지 까바야징
		if( ${not empty requestScope.searchWord}) { // 있는지 없는지 확인해야 한다.
					
			$("input#searchWord").val("${requestScope.searchWord}");
		} 
		
		// 검색어에 엔터를 햇을경우
		$("input#searchWord").keyup(function(e){
			if(e.keyCode==13){
				goSearch();
			}
		});	
		--%>
	      
		// 전체 선택
		
		// 부서 선택 시 부서 선택되게
		
		
		// 받는 사람 닫기
		$('#choosePerson_outside').on('click', function () {
			choosePerson_close();
		});
		
		
		
		// 받는 부서 선택 버튼 클릭이벤트
		$('button#addPersonBtn').click(function(){
			
			ck_deptno_list = []; 	 // 부서 선택
			ck_deptname_list = []; 	 // 부서 이름 들어가는 곳
			
			$("input.depts:checked").each(function(index, item){
				ck_deptno_list.push($(item).val());
				ck_deptname_list.push($(item).next().text());
			});
			
			if(ck_deptno_list.length>0){
				str_deptno = ck_deptno_list.join(",");
				str_deptname = ck_deptname_list.join(", ");
				
				if(str_deptname.length>50){
					str_deptname = str_deptname.substr(0, 50)+" ...";
				}
				
				$('input[name="fk_deptno"]').val(str_deptno);
				$('button#dropdownMenuButton').find('span').text(str_deptname);
				choosePerson_close();
				
			} else {
				Swal.fire('받는사람이 선택되지 않았습니다.','받는 사람은을 선택해주세요.', 'error');
			}
		});
		
		
		
		// 공지 보내기 버튼 클릭 이벤트
		$("button#sendNotiBtn").click(function(){
			
			// 글제목 유효성 검사(공백일 경우)
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

			// 글제목 유효성 검사(30글자 이상일 경우)
			const subjectLen = $("input#subject").val();
			if(subjectLen >= 30) {
				toastr.options = {
	                      closeButton: true,
	                      progressBar: true,
	                      showMethod: 'slideDown',
	                      timeOut: 2000,
	                      positionClass: 'toast-top-center'
	                  };
	                  toastr.error('', '글제목을 30글자 내외로 입력하세요');
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
			const fk_deptno = $('input[name="fk_deptno"]').val();
			if(fk_deptno == "") {
				toastr.options = {
	                      closeButton: true,
	                      progressBar: true,
	                      showMethod: 'slideDown',
	                      timeOut: 2000,
	                      positionClass: 'toast-top-center'
	                  };
	                  toastr.error('', '받는 사람을 선택하세요');
				return;
			}
			
			var form = $("form")[0];        
	        var queryString = new FormData(form);
			
			$.ajax({
		    	url : "<%= request.getContextPath() %>/notice/sendNotice.yolo",
		    	data : queryString,
		    	type: 'POST',
		    	enctype: 'multipart/form-data',
		    	processData: false,
		        contentType: false,
				success: function(){
					
					const modal_frmArr = document.querySelectorAll("form#noticeFrm");
			  	  	for(let i=0; i<modal_frmArr.length; i++) {
			  			modal_frmArr[i].reset();
			  			$('button#dropdownMenuButton').find('span').text('부서 선택');
			  	  	}
					$(".sendNotice").modal('hide');
					window.location.reload();
					toastr.success('공지작성이 완료되었습니다.');
				},
				error: function(request, status, error){
	                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
			}); // end of ajax
			// $('div.modal-content').empty();
			
		}); // end of 메세지 보내기 버튼 클릭 이벤트
		
		
	}); // end of $(document).ready(function()
	
	
	
	
	// 받는 사람 dropdown 열기
   function search_choosePerson(){
      // toastr.info("정보 변경내역 조회 메소드 호출됨");
      
      $('#choosePerson').addClass('active');
      $('button.dropdownBtn').css({'background-color':'#dddddd'});
      $('#choosePerson_outside').fadeIn();
      
	   openAjax(); // 받는 사람 목록 ajax로 불러오기
	   
	
   }
   
   
   // 받는 사람 dropdown 닫기
   function choosePerson_close(){
	   	$('div#choosedPsnResult').empty();
		$('#choosePerson').removeClass('active');
		$('button.dropdownBtn').css({'background-color':''});
	    $('#choosePerson_outside').fadeOut();
	}
	
	
	// 받는 사람 목록 ajax로 불러오기
   function openAjax(){
      $.ajax({
          url : "<%= request.getContextPath() %>/notice/getDept.yolo", // http://localhost:9090/hr/notice/getDept.yolo
          dataType: "JSON",
          async:false,
         success: function(json){ 
            
            let html = "";
            		
            if(json.length>0){
               
               $.each(json, function(index1, item1){
                  html += '<div style="display: flex; align-items: center;" class="py-1 pt-2">' +
                           '<input type="checkbox" class="ml-3 depts" value="'+item1.deptno+'" /><label class="person ml-2" style="font-weight: bold;" onclick="toggleShow('+item1.deptno+')">'+item1.deptname+'</label>'+
                        '</div>';
               });   
            }
            
            $('div#resultOfAjax').html(html);
            
         },
         error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
         
       }); // end of ajax 
       
   }
	
	
	<%--
	// 검색 클릭 이벤트
	function goSearch(){
		const searchWord = $("input#searchWord").val()
		location.href = "<%=ctxPath%>/notice/noticeList.yolo?searchWord="+searchWord;
	}
	--%>
	
	
	
	
	
</script>

<div id="noticeNav">
	<div id="category">
		<span style="font-size: 20pt; font-weight: bold;">공지사항</span>
		<button type="button" class="headerBtn" data-toggle="modal" data-target=".sendNotice" style="margin-right: 7px;  float: right;">
			<i class="fas fa-regular fa-paper-plane" id="icon"></i>공지 작성하기
		</button>
	</div>
	<br>
	<div id="bottomcate" style="float: none;">
		<span id="cate1" style="font-size: 13pt; font-weight: bold;" onclick="javascript:location.href='<%= ctxPath%>/notice/noticeList.yolo'">전체 공지</span>
		&nbsp; &nbsp; 
		<span id="cate2" style="font-size: 13pt; font-weight: bold;" onclick="javascript:location.href='<%= ctxPath%>/notice/depNoticeList.yolo'">부서 공지</span>
		&nbsp; &nbsp; 
		<span id="cate3" style="font-size: 13pt; font-weight: bold;" onclick="javascript:location.href='<%= ctxPath%>/notice/myNoticeList.yolo'">내가 쓴 공지</span>
		
	<div style="display: inline-block; float:right; margin: 0;">
		<button class="btn" id="advanced-search-button" onclick="goSearch()" type="button" style="border:none; background-color: #66cc66; height: 30px; color: white;">
		<i class="fa fa-search"></i>
		</button> 
		<input id="searchWord"  name="searchWord" style="padding-left:7px; height: 25px; width: 120px; margin-right: 5px; margin-left:2px; border: solid 1px #66cc66; border-radius: 0.4rem;" type="text" placeholder="검색" />
		<input type="text" style="display: none;"/>
	</div>	
		
	<%-- 	
	<form name="searchFrm" style="display: inline-block; float:right; margin: 0;">	
		<button class="btn" id="advanced-search-button" onclick="goSearch()" type="button" style="border:none; background-color: #66cc66; height: 30px; color: white;">
		<i class="fa fa-search"></i>
		</button> 
		<input id="searchWord"  name="searchWord" style="padding-left:7px; height: 25px; width: 120px; margin-right: 5px; margin-left:2px; border: solid 1px #66cc66; border-radius: 0.4rem;" type="text" placeholder="검색" />
		<input type="text" style="display: none;"/>
	</form>
	--%>
	</div>
	
</div>
<hr width = "100%;" style="margin: 7px 0 0 0; border-color: #d1d3d1;">


<!-- sendNotice Modal --> 
<div class="modal fade sendNotice"  id="staticBackdrop" data-backdrop="static">
  <div class="modal-dialog modal-dialog-scrollable modal-lg modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal body -->
      <div class="modal-body">
      <button type="button" class="close my_close" data-dismiss="modal" aria-label="Close">&times;</button> 
      <form id='noticeFrm' name="noticeFrm" enctype="multipart/form-data">
      	<input name="subject" id="subject" name="subject"  placeholder="공지 제목을 입력하세요"/>
      	
      	<button class="dropdownBtn" type="button" id="dropdownMenuButton" onclick="search_choosePerson()">
        	<div class="sentPsnProf"><i class="fas fa-solid fa-user"></i></div> <span style="color: #757575; font-size: 11pt; margin-left: 10px;" >부서 선택</span>
        </button>
        
        <textarea rows="" cols="" name="content" id="noticecontent"></textarea>
        
        <input type="hidden" name="fk_deptno" />
        <input type="hidden" name="deptname" />
       <!--  <input type="text" name="notino" /> -->
        
        <div id="attachArea">
        	<div class="filebox">
			    <input class="upload-name" value="첨부파일" placeholder="첨부파일">
			    <label for="file">파일 찾기</label> 
			    <input type="file" id="file" multiple="multiple" name="attach">
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
		
        <div id="rightDown">
			<button type="button" id="addPersonBtn">받는사람 추가</button>
		</div>
	</div>
	
</div>		
