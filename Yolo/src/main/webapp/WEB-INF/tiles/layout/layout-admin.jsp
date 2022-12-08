<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- === #24. tiles 를 사용하는 레이아웃1 페이지 만들기 === --%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<% String ctxPath = request.getContextPath(); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그룹웨어</title>

<!-- Required meta tags -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> 



<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script> 

<%-- Bootstrap 4.6.1 --%>
<%-- 
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
--%>



<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/bootstrap-4.6.0-dist/css/bootstrap.min.css" >
<script type="text/javascript" src="<%= ctxPath%>/resources/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script>

<%--  ===== 스피너 및 datepicker 를 사용하기 위해  jquery-ui 사용하기 ===== --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.css" />
<script type="text/javascript" src="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.js"></script>

<%-- *** ajax로 파일을 업로드할때 가장 널리 사용하는 방법 ==> ajaxForm *** --%>
<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery.form.min.js"></script>

<meta charset="UTF-8">

<!-- 폰트  -->
<link href="https://webfontworld.github.io/pretendard/Pretendard.css" rel="stylesheet">

<!-- sweet alert -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<!-- toastr css라이브러리 -->
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css"/>
<!-- toastr cdn 라이브러리 둘다 제이쿼리 밑에 있어야함 -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

<style>
	div#sidebar{
		background-color: #f9fafa;
	}
	
	#content::-webkit-scrollbar {
    	width: 10px;
  	}
  	#content::-webkit-scrollbar-thumb {
    	background-color: #ababab;
    	border-radius: 10px;
  	}
  	#content::-webkit-scrollbar-track {
    	background-color: #dedfe0;
    	border-radius: 10px;
  	}
  	
</style>

<script type="text/javascript">

	toastr.options = {
	     "closeButton": false,
	     "debug": false,
	     "newestOnTop": false,
	     "progressBar": true,
	     "positionClass": "toast-top-center",
	     "preventDuplicates": false,
	     "onclick": null,
	     "showDuration": "300",
	     "hideDuration": "1000",
	     "timeOut": "1500",
	     "extendedTimeOut": "1000",
	     "showEasing": "swing",
	     "hideEasing": "linear",
	     "showMethod": "fadeIn",
	     "hideMethod": "fadeOut",
	     "toastClass": 'toastr'
	}

	$(document).ready(function(){
		
		// 화면 높이만큼 body div에 height를 주겠다
		const web_browser_height = $(window).height(); 
		$("div#sidebar").css({"height":web_browser_height-15});
		$("div#content").css({"height":web_browser_height-15, "overflow":"auto"});
		
	}); // end of ready

</script>
<%-- 조상운이 추가한 라이브러리 시작  --%>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />


<%-- progress bar --%>
<script type="text/javascript" src="<%= ctxPath%>/resources/dist/progressbar.min.js"></script>

<%-- monthpicker 라이브러리 --%>
<script type="text/javascript" src="<%= ctxPath%>/resources/dist/jquery.ui.monthpicker.js"></script>

<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js'></script>
<%-- 조상운이 추가한 라이브러리 끝  --%>




</head>
<body>

	<div style="display:flex;">
		<%-- =========================== 사이드바 시작 =========================== --%>
		<div id="sidebar" style="width:20%;">
			<tiles:insertAttribute name="sidebar" />
			
			
		</div>
		<%-- =========================== 사이드바 끝 =========================== --%>


		<%-- =========================== 내용물 시작 =========================== --%>
		<div id="content" style="width:80%;">
	         <tiles:insertAttribute name="content" />

				         
		</div>
		<%-- =========================== 내용물 끝 =========================== --%>
	</div>

</body>
</html>