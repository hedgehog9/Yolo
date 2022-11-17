<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath();%>
    
<script>


</script>

<style>
    
    div#peopleContent{
    	margin-right:10px;
    }
    
    div#header{
    	display:flex;
    	justify-content: space-between;
    }
    
    span.title{
        font-size: 28px;
        margin-right:20px;
        font-weight: 700;
        letter-spacing:-1.12px;
    }

    div#header_title, div#button_title{
        margin: 35px 20px 20px 20px;
    }
    
    button#addPeople{
    	background-color: #66cc66;
    	color: white;
    }
    
    tr{
    	font-size:10pt;
    }
    
    .th_200{
    	width:200px;
    }
    
    .th_150{
    	width:150px;
    }
    
    .th_100{
    	width:100px;
    }
    
    .th_50{
    	width:50px;
    }
    
    div.profile_icon{
    	width: 30px; 
		height: 30px; 
		border-radius: 40%; 
		background-color: #239afe;
		color: white;
		text-align: center;
		padding-top: 6px;
		border: 1px solid #ccced0;
		font-weight: bold;
		margin: auto 8px;
		font-size:5pt;
    }
    
    div.profile{
    	display:flex;
    }
    

</style>


	
	<div id="peopleContent">
		<div id="header">
	        <div id="header_title">
	            <a href="<%= ctxPath%>/people.yolo"><span class="title">구성원</span></a>
	            <a href="<%= ctxPath%>/organization_chart.yolo"><span class="title">조직도</span></a>
	            <a href="<%= ctxPath%>/change_history.yolo"><span class="title">인사 정보 관리</span></a>
	        </div>
	        <div id="button_title">
	            <button id="addPeople" type="button" class="btn" onclick="#"><span><i class="fas fa-plus" style="margin:0px; width:20px;"></i>&nbsp;&nbsp;구성원 추가하기</span></button>
	        </div>
	    </div>
	    
	    <div id="searchBar">
	    	<select style="height:29px;">
		    	<option value="">선택하세요</option>
		    	<option value="name">사원명</option>
		    	<option value="dept">부서명</option>
		    	<option value="empno">사원번호</option>
	    	</select>
    		<input type="text" placeholder="검색">
	    </div>
	    
	    <div id="result">
	    	<table class="table table-bordered table-hover">
				<thead>
					<tr>
						<th rowspan="2" class="th_100" style="vertical-align: middle">이름</th>
						<th colspan=6>기본 정보</th>
						<th colspan=2>인사 정보</th>
						<th colspan=3>개인 정보</th>
					</tr>
					<tr>
						<th style="width:5%">상태</th>
						<th class="th_50">사번</th>
						<th style="width:7%">입사일</th>
						<th style="width:7%">퇴직일</th>
						<th style="width:7%">근속기간</th>
						<th class="th_100">근무일수</th>
						
						<th class="th_50">부서</th>
						<th class="th_50">직위</th>
						
						<th class="th_150">이메일</th>
						<th style="width:5%">성별</th>
						<th class="th_150">휴대전화</th>
						
					</tr>
				</thead>	
				<%-- ========================== 반복해서 출력할 부분 시작 ========== --%>
				<tbody>
				<tr onclick="#"><%-- tr태그의 인덱스 값을 파라미터로 넘겨서 호출하는 메소드에서 해당 사원의 상세 정보를 출력하도록 작성 필요 --%>
					
					<td class="th_150">
						<div class="profile">
							<div class="profile_icon"><div>길동</div></div>
							<div style="padding-top:3px;">홍길동</div>
						</div>
					</td>
					<td>재직</td>
					<td>333</td>
					<td>2022.10.11</td>
					<td>2022.10.12</td>
					<td>112개월</td>
					<td>15042일</td>

					<td>개발1</td>
					<td>과장</td>

					<td>hongkildong@gmail.com</td>
					<td>남</td>
					<td>010-1234-5678</td>
					
				</tr>
				
				<%-- ========================== 반복해서 출력할 부분 끝 ========== --%>

				<tr>
					<td class="th_150" height="50px;">
						<div class="profile">
							<div class="profile_icon"><div>길동</div></div>
							<div style="padding-top:3px;">홍길동</div>
						</div>
					</td>
					<td class="th_50">재직</td>
					<td class="th_50">333</td>
					<td class="th_100">2022.10.11</td>
					<td class="th_100">2022.10.12</td>
					<td class="th_100">112개월</td>
					<td class="th_100">15042일</td>

					<td class="th_100">개발1</td>
					<td class="th_100">과장</td>

					<td class="th_200">hongkildong@gmail.com</td>
					<td class="th_50">남</td>
					<td class="th_200">010-1234-5678</td>
				</tr>


			</tbody>    	
	    	</table>
	    </div>
	    
    </div>
    
    

