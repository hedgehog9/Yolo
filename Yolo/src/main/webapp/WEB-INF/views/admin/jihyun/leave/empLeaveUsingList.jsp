<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath=request.getContextPath(); %>

<jsp:include page="leaveCategory.jsp" />
    
<style type="text/css">
	
	
	table {
		border-radius: 10px;
		overflow: hidden; 
		height: auto;
		max-width: 100%;
		table-layout: fixed;
	}
	
	th, td{
		text-align: center;
		flex: 1;
	}
	

</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		$("span#empLeave").css("color", "#494949");
		$("span.headerTitle2").show();
		$("span#empLeaveSubmit").css("color", "#494949");
		
	});

	
</script>	


<div>
	<div id="content" style="margin: 40px 0 0 15px;">

          <div class="table-responsive" style="width:100%;">
            <table class="table table-hover table-bordered">
              <thead>
                <tr  class="thead-dark">
                  <th>이름</th>
                  <th>사번</th>
                  <th>기간</th>
                  <th>항목</th>
                  <th>사용기간</th>
                  <th>승인</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>
                  	<span style='font-size:15px;'>&#128105;</span>
                  	Jacob
                  	</td>
                  <td>3333</td>
                  <td class="text-muted "> 2022.11.10~2022.11.18 <i class="mdi mdi-arrow-down"></i></td>
                  <td><label class="badge badge-warning">연차</label></td>
                  <td><label class="badge badge-danger">7일</label></td>
                  <td></td>
                </tr>
                <tr>
                  <td>
                  <span style='font-size:15px;'>&#128102;</span>
                  Jacob</td>
                  <td>3333</td>
                  <td class="text-muted"> 2022.11.10~2022.11.18 <i class="mdi mdi-arrow-down"></i></td>
                  <td><label class="badge badge-warning">연차</label></td>
                  <td><label class="badge badge-danger">7일</label></td>
                  <td></td>
                </tr>
                <tr>
                  <td>
                  <span style='font-size:15px;'>&#128102;</span>
                  Jacob</td>
                  <td>3333</td>
                  <td class="text-muted"> 2022.11.10~2022.11.18 <i class="mdi mdi-arrow-down"></i></td>
                  <td><label class="badge badge-warning">연차</label></td>
                  <td><label class="badge badge-danger">7일</label></td>
                  <td></td>
                </tr>
                <tr>
                  <td>
                  <span style='font-size:15px;'>&#128102;</span>
                  Jacob</td>
                  <td>3333</td>
                  <td class="text-muted"> 2022.11.10~2022.11.18 <i class="mdi mdi-arrow-down"></i></td>
                  <td><label class="badge badge-warning">연차</label></td>
                  <td><label class="badge badge-danger">7일</label></td>
                  <td></td>
                </tr>
              </tbody>
            </table>
          </div>
	
	</div>
</div>
