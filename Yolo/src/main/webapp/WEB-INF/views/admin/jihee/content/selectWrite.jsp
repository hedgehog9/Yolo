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
	height: 35px;
	margin: 5px;
}

div#parent {

	width: 100%;
    display: flex;
}

div#child {

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
				<img src="<%= ctxPath%>/image/jihee/ses.png">
				<input type="hidden" name="icon" value="ses.png" readonly />
			</div>
			<div id="fontSubject">
				비품 신청22
				<input type="hidden" name="subject" value="비품 신청22" readonly />
				<input type="hidden" name="information" value="일하는 데 필요한 물품을 신청해주세요!" readonly />
			</div>
			<div id="fontpurpose">
				구매 신청
			</div>	
		</div>
</form>
</div>