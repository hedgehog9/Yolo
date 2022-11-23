<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath=request.getContextPath(); %>

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
		color: #494949;
	}
	
	
		
</style>

<script type="text/javascript">
	
	$(document).ready(function() {
		$("span.headerTitle2").hide();
	});


</script>


<%-- 관리인 연차 상세 페이지 시작 --%>

	<div id="category">
		<span class="headerTitle ml-5" id="myLeave" onclick="javascript:location.href='<%= ctxPath%>/leaveSummary.yolo'">내 휴가</span>
		<span class="headerTitle" id="empLeave" onclick="javascript:location.href='<%= ctxPath%>/empLeaveUsingList.yolo'">구성원 휴가</span>
	</div>
	
	<div id="bottomcate" class="border-bottom pb-3">
		<span class="headerTitle2 ml-5" id="empLeaveSubmit" onclick="javascript:location.href='<%= ctxPath%>/empLeaveUsingList.yolo'">휴가 신청내역</span>
		<span class="headerTitle2" id="empLeaveStatus" onclick="javascript:location.href='<%= ctxPath%>/empLeaveStatus.yolo'">휴가 보유현황</span>
	</div>
	
<%-- 관리인 연차 상세 페이지 끝 --%>