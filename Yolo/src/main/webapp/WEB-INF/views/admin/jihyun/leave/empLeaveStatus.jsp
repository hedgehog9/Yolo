<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath=request.getContextPath(); %>

<jsp:include page="leaveCategory.jsp" />
    
<style type="text/css">
	
	
	.table {
		width:95%;
		border-radius: 10px;
		overflow : hidden;
        table-layout: fixed;
        max-width: 800x;
        min-width: 1300px;
        white-space: nowrap;
	}
	
	th {
		font-size: 13pt;
		text-align: center;
		height: 70px; 
		flex: 1;
	}

    td {
      	text-align: center;
        flex: 1;
    }

</style>

<script type="text/javascript">

	$(document).ready(function () {
		
		$("span#empLeave").css("color", "#494949");
		$("span.headerTitle2").show();
		$("span#empLeaveStatus").css("color", "#494949");
	  
	});

	
</script>	    

<%-- 구성원 휴가 보유 현황 시작 --%>
	<br>
	 <div id="container" style="width: 95%">
	    <div class="table-responsive">
	      <table class="table table-hover table-bordered">
	        <thead>
	          <tr class="thead-dark">
	             <th style="text-align: center; padding-bottom: 20px;">이름</th>
			     <th style="text-align: center; padding-bottom: 20px;">사번</th>
			     <th style="text-align: center; padding-bottom: 20px;">연차</th>
			     <th style="text-align: center; padding-bottom: 20px;">산전후</th>
			     <th style="text-align: center; padding-bottom: 20px;">병가</th>
			     <th style="text-align: center; padding-bottom: 20px;">조의</th>
			     <th style="text-align: center; padding-bottom: 20px;">결혼</th>
			     <th style="text-align: center; padding-bottom: 20px;">리프레시</th>
			     <th style="text-align: center; padding-bottom: 20px;">포상</th>
			     <th style="text-align: center; padding-bottom: 20px;">보상</th>
	          </tr>
	        </thead>
	        <tbody>
	          <tr>
	            <td>
	            	<div>
	            	<span style='font-size:20px;'>&#128105;</span>
	            	<span style="font-size:13pt;">김안녕</span>
	            	</div>
	            </td>
	            <td>3333</td>
	            <td>5</td>
	            <td>1</td>
	            <td>90</td>
	            <td></td>
	            <td>1</td>
	            <td>2</td>
	            <td></td>
	            <td></td>
	          </tr>
	          <tr>
	            <td>
	            	<div>
	            	<span style='font-size:20px;'>&#128105;</span>
	            	<span style="font-size:13pt;">즐거워</span>
	            	</div>
	            </td>
	            <td>3333</td>
	            <td>5</td>
	            <td>1</td>
	            <td>90</td>
	            <td></td>
	            <td>1</td>
	            <td>2</td>
	            <td></td>
	            <td></td>
	          </tr>
	          <tr>
	            <td>
	            	<div>
	            	<span style='font-size:20px;'>&#128105;</span>
	            	<span style="font-size:13pt;">행복해</span>
	            	</div>
	            </td>
	            <td>3333</td>
	            <td>5</td>
	            <td>1</td>
	            <td>90</td>
	            <td></td>
	            <td>1</td>
	            <td>2</td>
	            <td></td>
	            <td></td>
	          </tr>
	          <tr>
	            <td>
	            	<div>
	            	<span style='font-size:20px;'>&#128105;</span>
	            	<span style="font-size:13pt;">파스타</span>
	            	</div>
	            </td>
	            <td>3333</td>
	            <td>5</td>
	            <td>1</td>
	            <td>90</td>
	            <td></td>
	            <td>1</td>
	            <td>2</td>
	            <td></td>
	            <td></td>
	          </tr>
	        </tbody>
	      </table>
	    </div>
	</div>

<%-- 구성원 휴가 보유 현황  끝 --%>		
	