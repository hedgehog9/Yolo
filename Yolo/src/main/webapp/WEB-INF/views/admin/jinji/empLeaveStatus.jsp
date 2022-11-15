<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath=request.getContextPath(); %>

<jsp:include page="/WEB-INF/tiles/admin/jinji/empLeaveManageCategory.jsp"></jsp:include>
    
<style type="text/css">
	
	/* leaveCategory.jsp 시작 */
	
	#cate1 {
		color: silver;
	}
	
	#category {
		cursor: pointer;
	}
	
	/* leaveCategory.jsp 끝 */
	
	table {
		border-radius: 10px;
		overflow: hidden; 
	}
	
	th, td{
		text-align: center;
	}
	

</style>

<script type="text/javascript">

	$(document).ready(function() {
		
	});

	
	///////// Function Declaration ////////////
	function goAdminLeave() { // 관리자 내 휴가 페이지로 이동 
	 // alert('goPage!');
		location.href="<%= ctxPath%>/leave/leaveSummary.yolo"
	};
	
	function goempLeaveUsingList() { // 구성원 휴가 보유 현황 페이지로 이동
		 // alert('goPage!');
			location.href="<%= ctxPath%>/leave/empLeaveUsingList.yolo"
	};
		
	
</script>	    

<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet"/>

<%-- 구성원 휴가 보유 현황 시작 --%>
<div>
	<div id="content" style="margin: 40px 0 0 15px;">
	
	
	<div class="table-responsive" style="width:1200px;" >
	  <table class="table table-hover table-bordered" style="width: 1100px;">
	  	<thead>
		    <tr>
		      <th>이름</th>
		      <th>사번</th>
		      <th>연차</th>
		      <th>산전후</th>
		      <th>병가</th>
		      <th>조의</th>
		      <th>결혼</th>
		      <th>리프레시</th>
		      <th>포상</th>
		      <th>보상</th>
		    </tr>
	    </thead>
	    <tbody>
		    <tr>
		      <td>Data</td>
		      <td>Data</td>
		      <td>Data</td>
		      <td>Data</td>
		      <td>Data</td>
		      <td>Data</td>
		      <td>Data</td>
		      <td>Data</td>
		      <td>Data</td>
		      <td>Data</td>
		    </tr>
		    <tr>
		      <td>Data</td>
		      <td>Data</td>
		      <td>Data</td>
		      <td>Data</td>
		      <td>Data</td>
		      <td>Data</td>
		      <td>Data</td>
		      <td>Data</td>
		      <td>Data</td>
		      <td>Data</td>
		    </tr>
		    <tr>
		      <td>Data</td>
		      <td>Data</td>
		      <td>Data</td>
		      <td>Data</td>
		      <td>Data</td>
		      <td>Data</td>
		      <td>Data</td>
		      <td>Data</td>
		      <td>Data</td>
		      <td>Data</td>
		    </tr>
	    </tbody>
	  </table>
	</div>
	
 </div>
</div>	
<%-- 구성원 휴가 보유 현황  끝 --%>		
	