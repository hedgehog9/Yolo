<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath=request.getContextPath(); %>

<jsp:include page="listnav.jsp" />

<style type="text/css">
	
	#listcontent {
		width: 100%
		align-content: center;
	}	
	
	ul {
		list-style-type: none;
		align-content: center;
		transition: all .3s ease 
	}
	
	ul:hover { 
		background-color: #F0F8FF; 
		transition: all .3s ease 
	}

	li {
		list-style-type: none;
		align-content: center;
		position:relative
	}
	span {
		margin-right: 10px;
		line-height: 50px;
		width: 100px;
	}
	
	button {
		margin-top: 10px;
	}
	
	.clearfix:before, .clearfix:after {
    display: block;
    content: '';
    line-height: 0;
	}

	.clearfix:after {
	    clear:both;
	}

</style>

<script type="text/javascript">

	$(document).ready(function() {
		
	});

</script>

    
<%-- 게시판 리스트 시작 --%>
<div id="listcontent" style="display: flex; width: 100%">
   <div id="list" style="margin: auto 15px; width: 100%">
   		<ul style="margin: 0; padding:0;">
   			<li>
				<div style="float: left; width:80%;">
					<span><i class="fa fa-user fa-2x" aria-hidden="true"></i></span> <%-- 프로필  --%>
					<span style="font-weight: bold;">크리스마스 휴일 휴일 공지 사항</span>
					&nbsp;
					<span><i class="fa fa-paperclip" aria-hidden="true"></i></span>
					&nbsp;
					<span class="badge badge-primary text-wrap" style="width: 5rem;">2022.12.25</span>
				</div>
				<div class="btn-group" style="float: right; align-content: center; width:20%;">
					<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
						<i class="fa fa-ellipsis-h" aria-hidden="true"></i>
					</button>	
					<ul class="dropdown-menu">
					    <li><a class="dropdown-item" href="#">Action</a></li>
					    <li><a class="dropdown-item" href="#">Another action</a></li>
					    <li><a class="dropdown-item" href="#">Something else here</a></li>
					</ul>
				</div>
   			</li>
   			<li>
   				<div style="clear: both; width: 100%;">
   					<span class="text-secondary">산타할아버지</span>
   					&nbsp;
   					<span><i class="fa fa-caret-right" aria-hidden="true"></i></span>
   					&nbsp;
   					<span class="badge badge-dark text-wrap" style="width: 3rem;">전체</span> <%-- 부서는 내 부서 or 전체에게 --%>
   				</div>
   			</li>
   			<li>
   				<div style="width: 100%; height: auto;">
   					<span style="display:inline-block; width: 50%; height: auto; line-height: normal;">공지공지공지내용내용내용공지공지공지내용내용내용!!!!!</span>
   				</div>
   			</li>
   		</ul>
   		<br><br>
   		
   		
   		
   		 
   		
   		<ul style="margin: 0; padding:0;">
   			<li>
				<div style="float: left; width:80%;">
					<span><i class="fa fa-user fa-2x" aria-hidden="true"></i></span><%--  프로필 사진 --%>
					<span style="font-weight: bold;">크리스마스 휴일 휴일 공지 사항</span>
					&nbsp;
					<span><i class="fa fa-paperclip" aria-hidden="true"></i></span>
					&nbsp;
					<span class="badge badge-primary text-wrap" style="width: 5rem;">2022.12.25</span>
				</div>
				<div style="float: right; align-content: center; width:20%;">
					<button type="button" class="btn btn-link">
						<i class="fa fa-ellipsis-h" aria-hidden="true"></i>
					</button>
				</div>
   			</li>
   			<li>
   				<div style="clear: both; width: 100%;">
   					<span class="text-secondary">루돌프 빨간코</span>
   					&nbsp;
   					<span><i class="fa fa-caret-right" aria-hidden="true"></i></span>
   					&nbsp;
   					<span class="badge badge-warning text-wrap text-black" style="width: 3rem;">인사부</span>
   				</div>
   			</li>
   			<li>
   				<div style="width: 100%; height: auto;">
   					<span style="display:inline-block; width: 50%; height: auto; line-height: normal;">공지공지공지내용내용내용공지공지공지내용내용내용!!!!!</span>
   				</div>
   			</li>
   		</ul>
   		<br><br>
   		
   		
   		<ul style="margin: 0; padding:0;">
   			<li>
				<div style="float: left; width:80%;">
					<span><i class="fa fa-user fa-2x" aria-hidden="true"></i></span><%--  프로필 사진 --%>
					<span style="font-weight: bold;">크리스마스 휴일 휴일 공지 사항</span>
					&nbsp;
					<span><i class="fa fa-paperclip" aria-hidden="true"></i></span>
					&nbsp;
					<span class="badge badge-primary text-wrap" style="width: 5rem;">2022.12.25</span>
				</div>
				<div style="float: right; align-content: center; width:20%;">
					<button type="button" class="btn btn-link">
						<i class="fa fa-ellipsis-h" aria-hidden="true"></i>
					</button>
				</div>
   			</li>
   			<li>
   				<div style="clear: both; width: 100%;">
   					<span class="text-secondary">루돌프 빨간코</span>
   					&nbsp;
   					<span><i class="fa fa-caret-right" aria-hidden="true"></i></span>
   					&nbsp;
   					<span class="badge badge-warning text-wrap text-black" style="width: 3rem;">인사부</span>
   				</div>
   			</li>
   			<li>
   				<div style="width: 100%; height: auto;">
   					<span style="display:inline-block; width: 50%; height: auto; line-height: normal;">공지공지공지내용내용내용공지공지공지내용내용내용!!!!!</span>
   				</div>
   			</li>
   		</ul>
   		
   </div>
</div>
