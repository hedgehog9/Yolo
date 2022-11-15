<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath=request.getContextPath(); %>

<style type="text/css">
	
	#category{cursor: pointer;}


		
</style>

<script type="text/javascript">
	
	$(document).ready(function() {
		
	});


</script>


<%-- 관리인 연차 상세 페이지 시작 --%>
<div>
	<div id="content" style="margin: 40px 0 0 15px;">
		
		<div id="category">
			<div id="outercate">
				<span id="cate1" style="font-size: 20pt; font-weight: bold;" onclick="goAdminLeave()">내 휴가</span>
				&nbsp; &nbsp;
				<span id="cate2" style="font-size: 20pt; font-weight: bold;" onclick="goEmpleaveManage()">구성원 휴가</span>
			</div>
			<br>
			<div id="bottomcate">
				<span id="cate3" style="font-size: 13pt; font-weight: bold;" onclick="goleaveSummary()">휴가 개요</span>
				&nbsp; &nbsp; 
				<span id="cate4" style="font-size: 13pt; font-weight: bold;" onclick="goleaveDetail()">연차 상세</span>
			</div>
		</div>
		<hr width = "100%;" >
		<br>
		
		
	</div>
</div>
<%-- 관리인 연차 상세 페이지 끝 --%>