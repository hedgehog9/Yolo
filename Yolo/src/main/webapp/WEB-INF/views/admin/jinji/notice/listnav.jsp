<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath=request.getContextPath(); %>

<style type="text/css">

	#noticeNav {
		cursor: pointer;
		margin-left: 15px;
		margin-top: 10px;
		align-content: center;
		width: 100%;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function() {
		
	});
	
</script>

<div id="noticeNav">
	<div id="category">
		<span id="cate1" style="font-size: 20pt; font-weight: bold;" onclick="goAdminLeave()">공지사항</span>
	</div>
	<br>
	<div id="bottomcate">
		<span id="cate3" style="font-size: 13pt; font-weight: bold;" onclick="goempLeaveStatus()">휴가 보유 현황</span>
		&nbsp; &nbsp; 
		<span id="cate4" style="font-size: 13pt; font-weight: bold;" onclick="goempLeaveUsingList()">휴가 사용 내역</span>
		&nbsp; &nbsp; 
		<span id="cate5" style="font-size: 13pt; font-weight: bold;" onclick="goempLeavePromotion()">연차 촉진</span>
	</div>
</div>
<hr width = "100%;">
	
		
