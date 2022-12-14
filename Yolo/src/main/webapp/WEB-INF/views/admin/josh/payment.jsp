<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     

<% String ctxPath = request.getContextPath(); %>

<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>

<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/css/select2.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/js/select2.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@ttskch/select2-bootstrap4-theme@x.x.x/dist/select2-bootstrap4.min.css">

<style>

    a { text-decoration:none !important }
    a:hover { text-decoration:none !important }

    nav.top-nav {
        padding-top: 30px;
        padding-left: 40px;
        padding-right: 40px;
        display: flex;
        align-items: center;
    }

    div#category {
        margin-top: 8px;
        padding-left: 40px;
        padding-right: 40px;
    }

    a.detail-category {
        background-color: var(--colors-white);
        height: 56px;
        padding-left: 8px;
        padding-right: 8px;
        margin-left: -8px;
        display: flex;
        align-items: center;
        font-size: 15px;
        font-weight: 600;
        cursor: pointer;
    }
    
    .select2-container--bootstrap4 .select2-selection--multiple .select2-selection__choice__remove {
		border: none;
	}
	
	div.profile{
		width: 50px; 
		height: 50px; 
		border-radius: 40%; 
		background-color: #239afe;
		color: white;
		text-align: center;
		padding-top: 13px;
		border: 1px solid #ccced0;
		font-weight: bold;
		margin: auto 8px;
	}
	
	button.gopay {
	    height: fit-content;
	}
	
	input:focus{
      outline-color: #07B419;
    }	
    
    .form-control:focus {
	   box-shadow:none;
	   border: 2px solid #07B419;
	}
	
	.select2-container--bootstrap4.select2-container--focus .select2-selection {
		box-shadow: none;
		border: 2px solid #07B419;
	}
	
	.select2-container--bootstrap4 .select2-selection--multiple .select2-search__field {
		width: 80% !important;
	}
	
	.green_bottom {
		border-bottom: 2px solid #07B419 !important;
	}
	
	<%-- 페이지바 css 시작 --%>
	ul.ul_pagebar{
		list-style:none; 
		margin:0 auto;
		width:700px;
		display: flex;
		align-items: baseline;
		padding: 0;
		justify-content: center;
	}
	
	
	li.li_pagebar{
		display: inline-block;
	    padding-top: 9px;
	    width: 40px;
	    height: 40px;
	    text-align: center;
	    font-weight: 700;
	}
	
	li.li_pagebar > a{
		text-decoration: none;
		font-size: 14px;
		color:#2ecc71;
	}
	
	li.li_currentpage{
		background-color: #2ecc71;
	    color: white;
	    font-weight: 700;
	
	    display: inline-block;
	    width: 40px;
	    height: 40px;
	    border-radius: 50%;
	    text-align: center;
	    vertical-align: middle;
	    padding-top: 9px;
	}
	
	.dropdown-toggle::after {
	    display: none;
	    margin-left: 0.255em;
	    vertical-align: 0.255em;
	    content: "";
	    border-top: 0.3em solid;
	    border-right: 0.3em solid transparent;
	    border-bottom: 0;
	    border-left: 0.3em solid transparent;
	}
	
	li.li_moveOne{
		display: inline-block;
	    width: 100px;
	    font-size: 12pt;
	    text-align: center;
	    padding: 6px;
	    border-radius: 100px;
	    color: white;
	    border: solid 3px #2ecc71;
	    margin: 0 10px;
	}
	
	li.li_moveOne > a{
		color:#2ecc71;
		text-decoration: none;
	}
	
	li.li_moveAll{
		background-color: #2ecc71;
	    font-weight: 700;
	    border-radius: 50%;
	    width: 40px;
	    height: 40px;
	    border-radius: 50%;
	    text-align: center;
	    vertical-align: middle;
	    padding-top: 9px;
	}
	
	li.li_moveAll > a{
		color: white;
		text-decoration: none;
		display: inline-block;
	}
	
</style>

<script>

let arrDept = [];

	$(document).ready(function() {
		
		$("input#year-select").val(getDate());
		
		$("#dept-select").select2({
	    		theme: 'bootstrap4',
	    		placeholder:"조직을 선택하세요",
	    		allowClear: true,
	    		tags: true,
	    	    tokenSeparators: [',', ' '],
	    });
		
		$("select#dept-select").change(function() {
        	
	    		$('select#dept-select').each(function(){
			    arrDept = $(this).val();
			    console.log(arrDept)
	    		});
    	
    		});// end of $("select#dept-select").change ------------ 
    		
    		$("#getPaymentList").click(function(){
    			console.log(arrDept)
    			getPaymentList(1);
    			
    		})
    		
    		$(document).on("click","input[name='chk-all']",function(e){
    			
    			let bool = $(this).prop("checked");
    			
    			chkAllNot(bool);
    			
    		})// end of document.on("click","input[name='chk-all']",function()
    				
    				
		$(document).on("click","input[name='chk']",function(e){
    			
			let bool = $(this).prop("checked");
			console.log(bool)
			
			chkClearNot(bool);
    			
    		})// end of document.on("click","input[name='chk']",function()	
    				
    		
    	    $("#checkedPayment").click(function(){
    	    	
    	    		if(check_length() > 0) {
    	    			checkedPayment();
    	    		}
    	    		else {
    	    			toastr.error('지급할 직원에 체크를 해주세요');
    	    			return;
    	    		}
    	    });
    				
		
	});// end of $(document).ready
	
	function check_length() {
		return $("input[name='chk']:checked").length;
	}
    		
    function chkAllNot(bool) {
    		$("input[name='chk']").prop("checked",bool);
    }
	
	function chkClearNot(bool) {
	
		const chk = $("input[name='chk']");
		
		let flag = true
		
		if(bool == false) {
			$("input[name='chk-all']").prop("checked",bool);
		}
		else {
			$.each(chk,function(index,item){
				if(item.checked == false) {
					flag = false 
					return;
				}
			})
			
			if(flag == false) {
				$("input[name='chk-all']").prop("checked",false);
			}
			else {
				$("input[name='chk-all']").prop("checked",true);
			}
		}

	}
	
	
	function getPaymentList(currentShowPageNo) {
		
		//console.log("펑션안에 " + arrDept)
		console.log(arrDept)
		
		let month = getMonth();
		let minus_month = minusGetMonth();
		
		const startdate = minus_month+"-25";
	    const enddate = month+"-25";
	    
	
		$.ajax({
			url:"<%= ctxPath %>/admin/getPaymentList.yolo",
			data:{"startdate": startdate,
				  "enddate":enddate,
				  "month_payment":minus_month,
				  "currentShowPageNo":currentShowPageNo,
				  "arrDept":arrDept},
			dataType:"JSON",
			success:function(json) {
				
				if(json.length > 0) {
					
					let html = "<table class='table table-hover'>"+
					           		"<thead>"+
						           		"<th style='width: 150px; text-align: center;'><input type='checkbox' name='chk-all' id='chk-all'/></th>"+
					        				"<th>이름</th>"+
					                    "<th><span style='font-size:20px;'>&#128198;</span>근무기준 달</th>"+
					                    "<th><span style='font-size:20px;'>&#128178;</span>급여</th>"+
					                    "<th><span style='font-size:20px;'>&#128337;</span>초과근무 수당</th>"+
					                    "<th><span style='font-size:20px;'>&#128176;</span>합계</th>"+
				                    "<tbody>";
					
					$.each(json, function(index,item) {
						
						html += "<tr>"+
			                        "<td class='text-center'><input type='checkbox' name='chk' value='"+item.empno+"'/></td>"+
			                        "<td class='d-flex'>"+
		                            "<div class='profile' style='background-color:"+item.profile_color+"'>"+item.name.substring(1)+"</div>"+
									"<div>"+
									"<span style='display: block; padding-top: 3px;'>"+item.name+"</span>"+
									"<span style='font-weight: normal; color: gray; font-size: 10pt;'>"+item.upper_deptname+" · "+item.deptname+"</span>"+
									"</div>"+
		                            "</td>"+
			                        "<td><span class='badge badge-dark rounded-pill'>"+minus_month+"</span></td>"+
			                        "<td><span class='badge badge-light rounded-pill'>"+Number(item.worktime_salary).toLocaleString('en')+"원</span></td>"+
			                        "<td><span class='badge badge-light rounded-pill'>"+Number(item.overtime_salary).toLocaleString('en')+"원</span></td>"+
			                        "<td><span class='badge badge-warning rounded-pill'>"+Number(item.sum_salary).toLocaleString('en')+"원</span></td>"+
			                    "</tr>"	
						
						
					})// $.each ----------------------------
					
					html += "</tbody>"+
					        "</table>";
					        
					$("#table-div").html(html)
					$("#table-font").hide();
					
					$("#pageBar").show();
					// 페이지바 함수 호출
					makePageBar(currentShowPageNo, startdate, enddate, minus_month);
					
				}
				
				else {
					$("#table-div").html("<span class='text-bold text-muted' id='table-font' style='margin-left:45%'> 검색결과가 없습니다 </span>");
					$("h3#table-font").show();
					$("#pageBar").hide();
				}
				
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
    			}
		})
	} 
	
	
	function checkedPayment() {
		
		Swal.fire({
			   title: '급여지급을 하시겠습니까?',
			   icon: 'warning',
			   
			   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
			   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
			   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
			   confirmButtonText: '승인', // confirm 버튼 텍스트 지정
			   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
			   
			   reverseButtons: true, // 버튼 순서 거꾸로
			   
			}).then(result => {
			   // 만약 Promise리턴을 받으면,
			   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
				   
				   const month = minusGetMonth();
					
					let array = []
					
					const checked = $("input[name='chk']:checked");
					
					$("input[name='chk']:checked").each(function() {
						
						let salary = $(this).parent().next().next().next().text();
						salary = salary.substring(0,salary.length-1).split(',').join('');
						
						let over_salary = $(this).parent().next().next().next().next().text();
						over_salary = over_salary.substring(0,over_salary.length-1)
						
						if(over_salary != '0') {
							over_salary.split(',').join('');
						} 
						
						over_salary = over_salary.substring(0,salary.length-1).split(',').join('');
						
						let object = {"empno":$(this).val(),
								      "month_payment":month,
								      "salary":salary,
								      "over_salary":over_salary}
						
						array.push(object)
						
					});// end of $("input[name='chk']:checked").each ----
					
					const jsonData = JSON.stringify(array);
					jQuery.ajaxSettings.traditional = true;
					
					$.ajax({
						url:"<%= ctxPath %>/admin/checkedPayment.yolo",
						type:"POST",
						data:{"jsonData":jsonData},
						dataType:"JSON",
						success:function(json) {
							
							if(json.n > 0) {
								Swal.fire('급여지급 완료','지급완료','success');
								setTimeout("location.reload()", 1000);
							}
							
						},
						error: function(request, status, error){
				            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			    			}
					})
					
			   }
			   
			});
	}
	
	
	function makePageBar(currentShowPageNo, startdate, enddate, minus_month) {
		
		$.ajax({
			url:"<%= ctxPath %>/admin/paymentListTotalPage.yolo",
			data:{"startdate": startdate,
				  "enddate":enddate,
				  "month_payment":minus_month,
				  "arrDept":arrDept},
			dataType:"JSON",
			success:function(json) {
				
				console.log(json.totalPage)
				
				if(json.totalPage > 0) {
					// 댓글이 있는 경우
					
					const totalPage = json.totalPage;
					
					const blockSize = 10;
					
					let loop = 1; //loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize)] 까지만 증가하는 용도이다.
			        
			        if( typeof currentShowPageNo == "string"){ // 마우스를 클릭해서 들어오는경우는 보고있는 페이지 번호가 string 타입으로 들어오므로 정수형으로 바꿔줘야 한다.
			        	currentShowPageNo = Number(currentShowPageNo);
			        }
			        
					// *** !! 다음은 currentShowPageNo 를 얻어와서 pageNo 를 구하는 공식이다. !! ***//
					let pageNo = Math.floor( (currentShowPageNo - 1)/blockSize ) * blockSize + 1;
					
					let pageBarHTML = "<ul class='ul_pagebar'>";
					
					// ==== [맨처음] [이전] 만들기 === // 
					if(pageNo != 1 ) {
						pageBarHTML +="<li class='li_moveAll li_pagebar'><a href='javascript:getPaymentList(1)' > << </a></li>";
						pageBarHTML +="<li class='li_moveOne'><a href='javascript:getPaymentList("+(pageNo-1)+")' >Previous</a></li>";
					}
					while( !(loop > blockSize || pageNo > totalPage ) ) {
						
						if(pageNo == currentShowPageNo) { // 보고있는 페이지와 페이지바의 선택된 페이지가 같으면 링크 제거 
							pageBarHTML +="<li class='li_currentpage'>"+pageNo+"</li>";
						}
						else {
							pageBarHTML +="<li class='li_pagebar'><a href='javascript:getPaymentList("+pageNo+")' >"+pageNo+"</a></li>";
						}
						loop++;
						pageNo++;
					}// end of while()------------------------
					
					
					// ==== [다음] [마지막] 만들기 === //
					if(pageNo <= totalPage) {
						pageBarHTML +="<li class='li_moveOne'><a href='javascript:getPaymentList("+pageNo+")' >Next</a></li>";
						pageBarHTML +="<li class='li_moveAll li_pagebar'><a href='javascript:getPaymentList("+totalPage+")' > >> </a></li>";
					}
					
					pageBarHTML +="</ul>";
				
					$("div#pageBar").html(pageBarHTML);
				}// end of if(json.totalPage > 0){}----------------------------------
				else {
					$("#table-div").empty();
					$("h3#table-font").show();
					
				}
			}
			
		})
	}
	
	
	function getDate() { // 현재날짜만 가져오는 메소드
		const date = new Date();
		const year = date.getFullYear();
		const month = ('0' + (date.getMonth() + 1)).slice(-2);
		const day = ('0' + date.getDate()).slice(-2);
		const today = year + '-' + month + '-' + day; // 오늘 날짜를 가져옴
		
		return today;
	}
	
	function getMonth() { // 현재날짜만 가져오는 메소드
		const date = new Date();
		const year = date.getFullYear();
		const month = ('0' + (date.getMonth() + 1)).slice(-2);
		const today = year + '-' + month; // 오늘 날짜를 가져옴
		
		return today;
	}
	
	function minusGetMonth() { // 현재날짜 -1달 날짜를 가져오는 메소드
		let now = new Date();
		const date = new Date(now.setMonth(now.getMonth() - 1));
		const year = date.getFullYear();
		const month = ('0' + (date.getMonth() + 1)).slice(-2);
		const today = year + '-' + month; // 오늘 날짜를 가져옴
		
		return today;
	}
	
	
	
</script>

<body>
    <nav class="top-nav border-bottom">
        <span class="text-muted h4 font-weight-bold">급여</span>
    </nav>
    <div id="pay-stub-content">
        <div id="category" class="d-flex">
            <a href="<%= ctxPath%>/admin/payStub.yolo" class="text-muted font-weight-bold mr-2 detail-category"><span>급여명세서 목록</span></a> <!-- border-bottom border-dark 을 사용하여 url에 따라 밑줄 생성 -->
            <a href="#" class="text-muted font-weight-bold mr-2 detail-category green_bottom"><span>급여정산 및 지급</span></a>
            <div id="button-div" style="margin-left: auto" class="pt-3">
                <button type="button" class="btn btn-sm" data-toggle="modal" data-target="#myModal" style="background-color: #66cc66; color: white;">급여정산</button>
            </div>
            <!-- The Modal -->
            <form>
                <div class="modal fade" id="myModal">
                    <div class="modal-dialog">
                    <div class="modal-content">
                    
                        <!-- Modal Header -->
                        <div class="modal-header">
                        <h4 class="modal-title">급여 정산</h4>
                        <button type="button" class="close" data-dismiss="modal">×</button>
                        </div>
                        
                        <!-- Modal body -->
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="email">부서:<small class="text-muted ml-2">* 부서선택을 안할시 자동으로 전체검색</small></label>
                                <select id="dept-select" class="form-control" multiple="multiple">
							        <c:forEach var="map" items="${requestScope.deptList}">
							        <c:if test="${map.level == '1'}">
							        		<option value="${map.deptno}" disabled="disabled" class="bold	">${map.deptname}</option>
							        	</c:if>
							        	<c:if test="${map.level == '2'}">
							        		<option value="${map.deptno}">&nbsp;&nbsp;${map.deptname}</option>
							        	</c:if>
							        </c:forEach>
				  				</select>
                            </div>
                            <div class="form-group">
                                <label for="email">근무기준 달:</label>
                                <input type="text" id="year-select" class="form-control text-center" readonly/>
                            </div>
                        </div>
                        
                        <!-- Modal footer -->
                        <div class="modal-footer">
                        <button type="button" class="btn btn-light btn-outline-success btn-sm" id="getPaymentList" data-dismiss="modal">정산하기</button>
                        </div>
                        
                    </div>
                    </div>
                </div>
            </form>

        </div>
        <div class="border-bottom mt-5" id="table-div">
            <h3 class="text-bold text-muted text-center" id="table-font"> 급여정산 버튼을 눌러주세요</h3>
        </div>
        
        <%-- === 페이지바 ==== --%>
        <div style="display: flex;" class="mt-5">
          <button type="button" class="btn btn-light btn-outline-secondary btn-sm ml-3 gopay" id="checkedPayment">체크지급</button>
      	  <div id="pageBar" style="margin: auto; text-align: center;"></div>
        </div>
		      
    </div>