<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath=request.getContextPath(); %>

<jsp:include page="/WEB-INF/tiles/admin/jinji/empLeaveManageCategory.jsp"></jsp:include>
    
<style type="text/css">
	
	/* leaveCategory.jsp 시작 */
	
	#cate1, #cate3, #cate5{
		color: silver;
	}
	
	#cate4 {
		color: black;
	}
	
	#category {
		cursor: pointer;
	}
	
	/* leaveCategory.jsp 끝 */
	
	table {
		border-radius: 10px;
		overflow: hidden; 
		height: auto;
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
		location.href="<%= ctxPath%>/jinji/leaveSummary.yolo"
	};
	
	function goempLeaveStatus() { // 구성원 휴가 보유 현황 페이지로 이동
	 // alert('goPage!');
		location.href="<%= ctxPath%>/jinji/empLeaveStatus.yolo"
	};
		
	
</script>	


<div>
	<div id="content" style="margin: 40px 0 0 15px;">

          <div class="table-responsive" style="width:1200px;">
            <table class="table table-hover table-bordered" style="width: 1100px;">
              <thead>
                <tr>
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
                  <td>Jacob</td>
                  <td>3333</td>
                  <td class="text-muted "> 2022.11.10~2022.11.18 <i class="mdi mdi-arrow-down"></i></td>
                  <td><label class="badge badge-warning">연차</label></td>
                  <td><label class="badge badge-success">7일</label></td>
                  <td></td>
                </tr>
                <tr>
                  <td>Jacob</td>
                  <td>3333</td>
                  <td class="text-muted"> 2022.11.10~2022.11.18 <i class="mdi mdi-arrow-down"></i></td>
                  <td><label class="badge badge-warning">연차</label></td>
                  <td><label class="badge badge-success">7일</label></td>
                  <td></td>
                </tr>
              </tbody>
            </table>
          </div>
	
	</div>
</div>
