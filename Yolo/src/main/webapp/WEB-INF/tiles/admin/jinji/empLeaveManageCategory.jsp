<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath=request.getContextPath(); %>

<style type="text/css">
	
	/* leaveCategory.jsp 시작 */
	
	#cate1, #cate4, #cate5, #cate6 {
		color: silver;
	}
	
	#category {
		cursor: pointer;
		margin-left: 15px;
	/* 	width: 100%; */
	}

		
</style>

<script type="text/javascript">
	
	$(document).ready(function() {
		
	});


</script>


<%-- 관리인 연차 상세 페이지 시작 --%>

		<div id="category">
			<div id="outercate">
				<span id="cate1" style="font-size: 20pt; font-weight: bold;" onclick="goAdminLeave()">내 휴가</span>
				&nbsp; &nbsp;
				<span id="cate2" style="font-size: 20pt; font-weight: bold;" onclick="goEmpleaveManage()">구성원 휴가</span>
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
		<hr width = "100%;" >
		
<%-- 관리인 연차 상세 페이지 끝 --%>