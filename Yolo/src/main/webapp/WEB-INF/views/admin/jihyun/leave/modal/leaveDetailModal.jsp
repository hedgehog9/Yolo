<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>

	div.tableProf {
		display : inline-block;
		width: 40px; 
		height: 40px; 
		border-radius: 40%; 
		background-color: #239afe;
		color: white;
		text-align: center;
		padding-top: 8px;
		border: 1px solid #ccced0;
		font-weight: bold;
		font-size: 13px;
		margin: auto 10px auto 5px;;
	}
	
	span.spanName {
		display: block;
		font-size: 11pt;
	}
	
	span.spanTime {
		color: gray;
		font-size: 9pt;
	}
	
	div.box {
		border: 1px solid #dddddd;
		border-radius: 0.4rem;
		width: 100%;
		min-height: 160px;
		max-height: 300px;
		margin: 10px auto;
	}
	
	/* ul {
		list-style-type: none;
		padding-left: 15px;
		margin-top: 20px;
		margin-bottom : 20px;
		font-size: 11pt;
		line-height: 20px;
	} */
	
	div.inbox {
		margin-top: 20px;
		margin-bottom : 20px;
		font-size: 11pt;
	}
	
	div.ininbox {
		display: flex;
		width: 90%;
		margin: 5px auto;
	}
	
	div.label {
		width: 30%;
		display: inline-block;
	}
	
	div.list {
		width: 70%;
		display: inline-block;
	}
	

</style>
    
<!-- 휴가상세 Modal -->
<div class="modal fade" id="leaveDetail" tabindex="-1"aria-hidden="true" >
  <div class="modal-dialog modal-dialog-centered">
  
	    <%-- Modal content --%>
	    <div class="modal-content">
	      <div class="modal-header py-3" >
	        <div class="tableProf">지현</div>
	        <div>
	        	<span class="spanName">김지현님의 휴가요청</span>
	        	<span class="spanTime">2022-11-17 00:08</span>
	        </div>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
	      </div>
	      <div class="modal-body">
	      	<div class="modal-middle">
		      	<span style="display: block; margin-top: 7px;"><i class="fas fa-regular fa-paper-plane mr-2"></i>요청내역</span>
		      	<div class="box">
		      		<div class="inbox">
		      			<div class="ininbox"><div class="label">·휴가종류</div><div class="list">연차</div></div>
		      			<div class="ininbox"><div class="label">·휴가기간</div><div class="list">2022.11.11(금) ~ 2022.11.11(금)</div></div>
		      			<div class="ininbox"><div class="label">·사용시간</div><div class="list">오후</div></div>
		      			<div class="ininbox"><div class="label">·휴가내용</div><div class="list">늦잠자떠여</div></div>
		      			<div class="ininbox"><div class="label">·첨부파일</div><div class="list">단가라.jpg</div></div>
		      		</div>
		      	</div>
		      	<button type="button">취소하기</button>
		 	</div>
	 	 </div>
  	  </div>
   </div>
</div>