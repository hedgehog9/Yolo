<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<style>
	
	div#user_detail_content{
		margin: 40px 20px 20px 20px;
	}
	
	div#profile_img{
		width:100px;
		height:100px;
		border-radius: 15%;
		background-color: green;
		
		margin-right:20px;
		
		display: flex;
    	align-items: center;
    	justify-content: center;
	}
	
	div#user_profile{
		display: flex;
	}
	
	div#user_name{
		
		font-size:20pt;
		font-weight: bold;
		color: white;
	}
	
	th.dept_position{
		font-size:12px;
		font-weight:normal;
	}
	
	
	nav#hr_info{
		display: flex;
		justify-content: space-between;
		align-items: end;
		border-bottom: solid 1px #d9d9d9;
	}
	
	
	div#hr_info_title{
		display: flex;
		padding: 30px 30px 0px 0;
		margin-right: 30px;
	}
	
	div#hr_info_title > div.info_title{
		padding: 20px 20px 20px 0;
	}
	
	button#record_search{
		margin: 20px 20px 20px 0;
	}
	
	button#record_search:hover{
		background-color: #ebebeb;
	}
	
	div.info_title{
		font-size: 20px;
	}
	
	div.info_title:hover{
		cursor: pointer;
	}
	

</style>

<div id="user_detail_content">
	
	<span><a href="<%= ctxPath%>/people.yolo">구성원</a> / 홍길동</span>
	<i class="fas fa-camera"></i>
	<div id="user_profile">
	
		<div id="profile_img">
			<div id="user_name">길동</div>
		</div>
		
		<div id="user_info">
		<%-- 
			<div style="font-size">홍길동</div>
			<div>
				<div class="deptposition">부서  개발1팀</div>
				<div class="deptposition">직급  대리</div>
				<div>
					<button type="button" class="btn btn-sm btn-info">a</button>
					<button type="button" class="btn btn-sm btn-info">b</button>
					<button type="button" class="btn btn-sm btn-info">c</button>
				</div>
			</div>
		--%>
		</div>
		<%-- ======================== 프로필 시작 ========================= --%>
		<table>
			<thead>
				<tr>
					<th colspan="2">홍길동</th>
				</tr>

				<tr>
					<th class="dept_position">부서</th>				
					<th class="dept_position">&nbsp;&nbsp;&nbsp;인사</th>				
				</tr>
				<tr>
					<th class="dept_position">직책</th>				
					<th class="dept_position">&nbsp;&nbsp;&nbsp;대리</th>				
				</tr>
				<tr>
					<th>
						<button type="button" class="btn btn-info btn-sm"></button>
					</th>
					<th>
						<button type="button" class="btn btn-info btn-sm"></button>
					</th>
					<th>
						<button type="button" class="btn btn-info btn-sm"></button>
					</th>
				</tr>
			</thead>
		</table>
		<%-- ======================== 프로필 끝 ========================= --%>
	</div>
	
	<nav id="hr_info">
		<div id="hr_info_title">
			<div class="info_title">인사 정보</div>
			<div class="info_title">개인 정보</div>
		</div>
		<div>
			<button id="record_search" type="button" class="btn btn-sm" onclick="#"><i class="fas fa-pen" style="margin:0px; width:16px;"></i></button>
		</div>
	</nav>




</div>
