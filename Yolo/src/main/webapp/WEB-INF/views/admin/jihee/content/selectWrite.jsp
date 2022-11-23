<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="/WEB-INF/views/admin/jihee/writeHeader.jsp"></jsp:include>

<style type="text/css">

.card {

	width: 200px;
	height : 150px;
	border : 2px solid gray;
	margin: 30px 15px;
	padding: 10px;
	border-color: #cccccc;
	border-radius: 0.5rem;
}

.card:hover {
	background-color: #efefef;
	cursor: pointer;
	border-radius: 0.5rem;
}
	
div#fontSubject {
	
	font-size: 12pt;
	font-weight: bold;
	margin-top: 25px;
	margin-left: 5px;
	color: #4d4d4d;
	
}

div#fontpurpose {
	
	font-size: 9pt;
	margin-left: 5px;
	margin-top: 2px;

}

img {

	width: 30px;
	height: 30px;
	margin: 5px;
}

div#parent {

	width: 100%;
    display: flex;
}

div#child {

	flex:0.15;
}

div#parent2 {

	width: 100%;
    display: flex;
}

div#child2 {

	flex:0.15;
}


</style>

<script type="text/javascript">

	function goWrite() {
		
		  const frm = document.selectFrm;
          frm.method = "POST";
          frm.action = "<%= ctxPath%>/workflow/write.yolo";
          frm.submit();
		
		
	}
	
	function goWrite2() {
		
		const frm = document.selectFrm2;
        /* frm.method = "POST"; */
        frm.action = "<%= ctxPath%>/workflow/write.yolo";
        frm.submit();
		
		
	}
	
	function goWrite3() {
			
			const frm = document.selectFrm3;
	        /* frm.method = "POST"; */
	        frm.action = "<%= ctxPath%>/workflow/write.yolo";
	        frm.submit();
			
			
		}
		
	function goWrite4() {
		
		const frm = document.selectFrm4;
	    /* frm.method = "POST"; */
	    frm.action = "<%= ctxPath%>/workflow/write.yolo";
	    frm.submit();
		
		
	}
	
	function goWrite5() {
			
			const frm = document.selectFrm5;
		    /* frm.method = "POST"; */
		    frm.action = "<%= ctxPath%>/workflow/write.yolo";
		    frm.submit();
			
			
		}
		
	function goWrite6() {
		
		const frm = document.selectFrm6;
	    /* frm.method = "POST"; */
	    frm.action = "<%= ctxPath%>/workflow/write.yolo";
	    frm.submit();
		
		
	}
	
	function goWrite7() {
		
		const frm = document.selectFrm7;
	    /* frm.method = "POST"; */
	    frm.action = "<%= ctxPath%>/workflow/write.yolo";
	    frm.submit();
		
		
	}
	
	function goWrite8() {
		
		const frm = document.selectFrm8;
	    /* frm.method = "POST"; */
	    frm.action = "<%= ctxPath%>/workflow/write.yolo";
	    frm.submit();
		
		
	}
	
	function goWrite9() {
		
		const frm = document.selectFrm9;
	    /* frm.method = "POST"; */
	    frm.action = "<%= ctxPath%>/workflow/write.yolo";
	    frm.submit();
		
		
	}
	
</script> 

<div id="parent">
<form name="selectFrm">
		<div class="card" onclick="goWrite()" id="child" style="margin-left: 30px;">
			<div class="icon">
				<img src="<%= ctxPath%>/image/jihee/tem.png">
				<input type="hidden" name="icon" value="tem.png" readonly />
			</div>
			<div id="fontSubject">
				비품 신청
				<input type="hidden" name="subject" value="비품 신청" readonly />
				<input type="hidden" name="information" value="일하는 데 필요한 물품을 신청해주세요!" readonly />
			</div>
			<div id="fontpurpose">
				구매 신청
			</div>	
		</div>
</form>
<form name="selectFrm2">	
		<div class="card" onclick="goWrite2()" id="child">
			<div class="icon">
				<img src="<%= ctxPath%>/image/jihee/clip.png">
				<input type="hidden" name="icon" value="clip.png" readonly />
			</div>
			<div id="fontSubject">
				경조비 신청
				<input type="hidden" name="subject" value="경조비 신청" readonly />
				<input type="hidden" name="information" value="아래 양식에 맞추어 신청해 주세요" readonly />
			</div>
			<div id="fontpurpose">
				복리 후생
			</div>	
		</div>
</form>
<form name="selectFrm3">	
		<div class="card" onclick="goWrite3()" id="child">
			<div class="icon">
				<img src="<%= ctxPath%>/image/jihee/key.png">
				<input type="hidden" name="icon" value="key.png" readonly />
			</div>
			<div id="fontSubject">
				계정 신청
				<input type="hidden" name="subject" value="계정 신청" readonly />
				<input type="hidden" name="information" value="G Suite, AWS, Zeplin 등 필요한 계정의 담당자를 지정하여 계정 신청을 해주세요." readonly />
			</div>
			<div id="fontpurpose">
				구매 신청
			</div>	
		</div>
</form>
<form name="selectFrm4">	
		<div class="card" onclick="goWrite4()" id="child">
			<div class="icon">
				<img src="<%= ctxPath%>/image/jihee/food.png">
				<input type="hidden" name="icon" value="food.png" readonly />
			</div>
			<div id="fontSubject">
				식비 사용 내역
				<input type="hidden" name="subject" value="식비 사용 내역" readonly />
				<input type="hidden" name="information" value="작성 시 영수증을 첨부해 주세요." readonly />
			</div>
			<div id="fontpurpose">
				복리 후생
			</div>	
		</div>
</form>
<form name="selectFrm5">	
		<div class="card" onclick="goWrite5()" id="child">
			<div class="icon">
				<img src="<%= ctxPath%>/image/jihee/paper.png">
				<input type="hidden" name="icon" value="paper.png" readonly />
			</div>
			<div id="fontSubject">
				계약서 검토 요청
				<input type="hidden" name="subject" value="계약서 검토 요청" readonly />
				<input type="hidden" name="information" value="작성 시 계약 서류를 첨부해주세요." readonly />
			</div>
			<div id="fontpurpose">
				계약
			</div>	
		</div>
</form>
</div>

<div id="parent2">
<form name="selectFrm6">	
		<div class="card" onclick="goWrite6()" id="child2" style="margin-left: 30px;">
			<div class="icon">
				<img src="<%= ctxPath%>/image/jihee/board.png">
				<input type="hidden" name="icon" value="board.png" readonly />
			</div>
			<div id="fontSubject">
				휴직 신청
				<input type="hidden" name="subject" value="휴직 신청" readonly />
				<input type="hidden" name="information" value="아래 양식에 맞추어 신청해주세요." readonly />
			</div>
			<div id="fontpurpose">
				양식구분 없음
			</div>	
		</div>
</form>
<form name="selectFrm7">
		<div class="card" onclick="goWrite7()" id="child2">
			<div class="icon">
				<img src="<%= ctxPath%>/image/jihee/star.png">
				<input type="hidden" name="icon" value="star.png" readonly />
			</div>
			<div id="fontSubject">
				신규 프로젝트
				<input type="hidden" name="subject" value="신규 프로젝트" readonly />
				<input type="hidden" name="information" value="신규 프로젝트를 아래와 같이 작성해주세요." readonly />
			</div>
			<div id="fontpurpose">
				업무 신청
			</div>	
		</div>
</form>
<form name="selectFrm8">	
		<div class="card" onclick="goWrite8()" id="child2">
			<div class="icon">
				<img src="<%= ctxPath%>/image/jihee/bag.png">
				<input type="hidden" name="icon" value="bag.png" readonly />
			</div>
			<div id="fontSubject">
				개인경비청구서 
				<input type="hidden" name="subject" value="개인경비청구서 " readonly />
				<input type="hidden" name="information" value="개인경비청구서 입니다." readonly />
			</div>
			<div id="fontpurpose">
				경비 청구
			</div>	
		</div>
</form>
<form name="selectFrm9">	
		<div class="card" onclick="goWrite9()" id="child2">
			<div class="icon">
				<img src="<%= ctxPath%>/image/jihee/receipt.png">
				<input type="hidden" name="icon" value="receipt.png" readonly />
			</div>
			<div id="fontSubject">
				지출결의서
				<input type="hidden" name="subject" value="지출결의서" readonly />
				<input type="hidden" name="information" value="작성 시 영수증을 첨부해 주세요." readonly />
			</div>
			<div id="fontpurpose">
				원청징수
			</div>	
		</div>
</form>
</div>

