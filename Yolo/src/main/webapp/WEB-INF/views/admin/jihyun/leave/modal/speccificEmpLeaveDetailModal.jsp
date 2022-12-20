<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>

	div.tableProf {
		display : flex;
		width: 45px; 
		height: 45px; 
		border-radius: 40%; 
		background-color: #239afe;
		color: white;
		text-align: center;
		align-items : center;
		border: 1px solid #ccced0;
		font-weight: bold;
		font-size: 14px;
		margin: auto 10px auto 5px;;
	}
	
	span.spanName {
		display: block;
		font-weight: bold;
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
	
	
	span.mailFiles {
		text-decoration: underline;
		color: gray;
	}
	
	span.mailFiles:hover {
		font-weight: bold;
		color: black;
		cursor: pointer;
	}
	

</style>

<script>


// 휴가 상세 모달 채우기
function openLeaveDetail(request_leaveno) {
	
	$.ajax({
    	url : "<%=request.getContextPath()%>/leave/getLeaveDetail.yolo",
    	data : {'request_leaveno' : request_leaveno},
    	dataType: "JSON",
		success: function(json){
			
			// console.log(json);
			var now = new Date();
			var start = new Date(json.start_day);
			
			html = '<div class="modal-header py-3" >'+
				        '<div class="tableProf" style="background-color:'+ json.profile_color +' ;"><span style="margin: auto; ">'+ json.nickname +'</span></div>'+
				        '<div class="ml-2">'+
				        	'<span class="spanName">'+ json.name +'님의 휴가요청</span>'+
				        	'<span class="spanTime">2022-11-17 00:08</span>'+
				        '</div>'+
				        '<button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>'+
				      '</div>'+
				      '<div class="modal-body">'+
				      	'<div class="modal-middle">'+
					      	'<span style="display: block; margin-top: 5px;">'+
					      		'<span style="font-weight: bold; margin-left:6px;">요청내역</span>';
					      		
					      		if(json.opproval_status==0){
					      			html+='<span class="badge badge-light rounded-pill ml-2">미승인</span>';
					      		} else if(json.opproval_status==2) {
					      			html+='<span class="badge badge-danger rounded-pill ml-2">반려</span>';
					      		} else {
					      			html+='<span class="badge badge-dark rounded-pill ml-2">승인</span>';
					      		}
					      		
					      		if(json.add_file ==1 && json.filename!=null){
					      			html+='<span class="badge badge-success rounded-pill ml-2">자료 첨부완료</span>';
					      			
					      		} else if(json.add_file ==1 && json.filename==null){
					      			html+='<span class="badge badge-warning rounded-pill ml-2">자료 미첨부</span>';
					      		}
					      		
					 	 html+='</span>'+
					      	'<div class="box my-3 py-1">'+
					      		'<div class="inbox">'+
					      			'<div class="ininbox"><div class="label">· 휴가종류</div><div class="list">'+ json.leave_name +'</div></div>'+
					      			'<div class="ininbox"><div class="label">· 휴가기간</div><div class="list">'+ json.start_day +' '+ json.start_name +' ~ '+ json.end_day +' '+ json.end_name +'</div></div>'+
					      			'<div class="ininbox"><div class="label">· 사용시간</div><div class="list">'+ json.use_days +'일</div></div>'+
					      			'<div class="ininbox"><div class="label">· 휴가내용</div><div class="list">'+ json.use_reason +'</div></div>';
					      			
								 	if(json.add_file ==1 && json.filename!=null){
						      			html+='<div class="ininbox"><div class="label">· 첨부파일</div><div class="list"><span class="mailFiles" onclick="javascript:location.href=\'<%=ctxPath%>/leave/downloadLeaveFile.yolo?fileName='+json.filename+'&orgFilename='+json.orgfilename+'\'" >'+json.orgfilename+'</span></div></div>';
						      		}
					      			
					    html+='</div>';
					    
						html+='</div>';
					      	
					      	
					      		
					      		
					      		if(json.opproval_status == 0){
					      			html+= '<div style="display: flex; align-items: center;">';
						  			html+='<button type="button" onclick="approvalRequestLevae( \'1\' ,\''+ json.pk_request_leaveno +'\', \''+ json.fk_empno +'\')" class="btn btn-outline-secondary submitCancle" style="margin: 2px 3px 10px auto; height: 35px; font-weight: bold;">승인하기</button>'+
						      			'<button type="button" onclick="approvalRequestLevae( \'2\' ,\''+ json.pk_request_leaveno +'\', \''+ json.fk_empno +'\')" class="btn btn-outline-secondary submitCancle" style="margin: 2px auto 10px 3px; height: 35px; font-weight: bold;">반려하기</button>';
						  		 
					      		
					      		html+= '</div>';
					      	}
					      	
					 	html +='</div>'+
				 	 '</div>';
			
			
			
			$("div.modal-content").html(html);
			
			
		},
		error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
	}); // end of ajax
}


//승인 / 반려하기 함수 
function approvalRequestLevae( approval_status ,request_leaveno, empno){
	$.ajax({
    	url : "<%=request.getContextPath()%>/leave/approvalRequestLevae.yolo",
    	data : {"request_leaveno" : request_leaveno,
    			"approval_status" : approval_status,
    			"empno" : empno},
    			
		success: function(){
			
			window.location.reload();
			
		},
		error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
	}); // end of ajax
}

</script>
    
<!-- 휴가상세 Modal -->
<div class="modal fade" id="leaveDetail" tabindex="-1" role="dialog" aria-labelledby="modal-default" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
  
	    <%-- Modal content --%>
	    <div class="modal-content">
	      <!-- <div class="modal-header py-3" >
	        <div class="tableProf"><span style="margin: auto;">지현</span></div>
	        <div class="ml-2">
	        	<span class="spanName">김지현님의 휴가요청</span>
	        	<span class="spanTime">2022-11-17 00:08</span>
	        </div>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
	      </div>
	      <div class="modal-body">
	      	<div class="modal-middle">
		      	<span style="display: block; margin-top: 5px;">
		      		<i class="fas fa-regular fa-paper-plane mr-2" style="color: gray;"></i>
		      		<span style="font-weight: bold;">요청내역</span>
		      		 <span class="badge badge-light rounded-pill ml-2">미승인</span>
		      		 <span class="badge badge-dark rounded-pill ml-2">승인</span>
		      	</span>
		      	<div class="box my-3 py-1">
		      		<div class="inbox">
		      			<div class="ininbox"><div class="label">·휴가종류</div><div class="list">연차</div></div>
		      			<div class="ininbox"><div class="label">·휴가기간</div><div class="list">2022.11.11(금) ~ 2022.11.11(금)</div></div>
		      			<div class="ininbox"><div class="label">·사용시간</div><div class="list">오후</div></div>
		      			<div class="ininbox"><div class="label">·휴가내용</div><div class="list">늦잠자떠여</div></div>
		      			<div class="ininbox"><div class="label">·첨부파일</div><div class="list">단가라.jpg</div></div>
		      		</div>
		      	</div>
		      	<div style="display: flex; align-items: center;">
		      		<button type="button" class="btn btn-outline-secondary submitCancle" style="margin: 2px auto 10px auto; height: 35px; font-weight: bold;">휴가신청 취소</button>
		      	</div>
		      	
		 	</div>
	 	 </div> -->
  	  </div>
   </div>
</div>