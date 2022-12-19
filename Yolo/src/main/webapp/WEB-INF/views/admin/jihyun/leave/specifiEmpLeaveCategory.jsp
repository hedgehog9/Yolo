<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath=request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<style type="text/css">
	
	div#category {
		/* border: 1px solid black; */
		padding-top: 30px;
		height: 90px;
		width: 100%;
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
	
	span.headerTitle2 {
		font-weight: bold;
		font-size: 12pt;
		margin: auto 10px;
		color: #cccece;
		display: none;
	}
	
	span.headerTitle2:hover {
		cursor: pointer;
		color: v
	}
	
	div#underBar1 {
		height: 3.5px;
		width: 110px;
		position: relative;
		top : 17px;
		left: 35px;
		background: #494949;
		display: none;
	}
	
	div#underBar2 {
		height: 3.5px;
		width: 140px;
		position: relative;
		top : 17px;
		left: 150px;
		background: #494949;
		display: none;
	}
	
	
		
</style>

<script type="text/javascript">
	
	$(document).ready(function() {
		$("span.headerTitle2").hide();
		
	});
	

</script>


<%-- 관리인 연차 상세 페이지 시작 --%>

	<div id="category">
		<span class="headerTitle ml-5" onclick="javascript:location.href='<%= ctxPath%>/empLeaveStatus.yolo'" id="empLeave" ><<</span>
		<span class="headerTitle " id="myLeave" > ${name }님의 휴가 </span>
	</div>

	
<%-- 관리인 연차 상세 페이지 끝 --%>