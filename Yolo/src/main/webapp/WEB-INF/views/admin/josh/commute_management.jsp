<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>       
    
<% String ctxPath = request.getContextPath(); %>  

<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/css/select2.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/js/select2.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@ttskch/select2-bootstrap4-theme@x.x.x/dist/select2-bootstrap4.min.css">

<style>

    a { text-decoration:none !important }
    a:hover { text-decoration:none !important }

    nav.top-nav {
        padding: 30px 40px;
        display: flex;
    }

    div#schedule-management-content {
        height: 100%;
        padding-top: 8px;
        margin-top: 0px;
    }
    
    div#management-categoty-div {
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

    div#date {
        padding-left: 40px;
        padding-right: 40px;
        padding-bottom: 16px;
        padding-top: 16px;
    }

    input#daterange {
        width: 195px;
    }

    span#small-button {
        background-color: rgba(85, 99, 114, 0.12);
        color: rgb(26, 30, 34);
        font-size: small;
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

    div#gagebar {
        width: 400px;
        height: 8px;
    }
    
	
	.select2-container--bootstrap4 .select2-selection--multiple .select2-selection__choice__remove {
		border: none;
	}
	
	
</style>

<script>

    $(document).ready(function() {

        let today = new Date();
        
        let arrDept = new Array();

        getCurrentWeek();
        
        $("#dept-select").select2({
        		theme: 'bootstrap4',
        		placeholder:"조직을 선택하세요",
        		allowClear: true,
        		tags: true,
        	    tokenSeparators: [',', ' '],
        	    //data : data , // 실제 Select Option에 들어갈 데이터 
        });
        
        totalCommuteList(1, null);
        
        /*
        var bar = new ProgressBar.Line(gagebar, { // 게이지바 생성
            strokeWidth: 4,
            easing: 'easeInOut',
            duration: 1400,
            color: 'yellow',
            trailColor: '#eee',
            trailWidth: 1,
            svgStyle: {width: '100%', height: '100%'}
        }); 

        bar.animate(0.1);  // 게이지바 화면에 뿌리는 코드
        */

        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        // DateRange API 호출 시작
        $("input#daterange").daterangepicker({
            "singleDatePicker": true,
            "locale": {
                "format": "YYYY-MM-DD", // 날짜표현 형식
                "separator": " - ",
                "applyLabel": "선택",
                "cancelLabel": "취소",
                "fromLabel": "From",
                "toLabel": "To",
                "customRangeLabel": "Custom",
                "weekLabel": "W",
                "daysOfWeek": [
                    "일",
                    "월",
                    "화",
                    "수",
                    "목",
                    "금",
                    "토"
                ],
                "monthNames": [
                    "1월",
                    "2월",
                    "3월",
                    "4월",
                    "5월",
                    "6월",
                    "7월",
                    "8월",
                    "9월",
                    "10월",
                    "11월",
                    "12월"
                ],
                "firstDay": 0
            },
            "startDate": today,
            "endDate": today,
            "maxDate": today
        }, function(start, end, label) {
                start = new Date(start.format('YYYY-MM-DD'))
                const sunday = start.getTime() - 86400000 * start.getDay();
        
                start.setTime(sunday);
            
                const result = [start.toISOString().slice(0, 10)];
        
                for (let i = 1; i < 7; i++) {
                    start.setTime(start.getTime() + 86400000);
                    result.push(start.toISOString().slice(0, 10));
                }
                // console.log(result[1], result[5])
                start = result[1];
                end = result[5];

                $("span#startdate").text(start)
                $("span#enddate").text("~ "+end)

                $('select#dept-select').each(function(){
				    arrDept = $(this).val();
				    console.log(arrDept)
            		});
                
                // 여기서 ajax 시작
                totalCommuteList(1, arrDept);
            });
            // end of $("input#daterange").daterangepicker


            $("span#today-btn").click(function() {

                getCurrentWeek();
                $("input#daterange").val(today.toISOString().slice(0, 10))
                
                $('select#dept-select').each(function(){
				    arrDept = $(this).val();
				    console.log(arrDept)
            		});

                // 여기서 ajax 시작
                totalCommuteList(1, arrDept);

            });// end of $("span#today-btn").click -------------

            /* $("select#dept-select").on("select2:select", function (e) {
            		alert("asd")
            	}); */
            
            
            $("select#dept-select").change(function() {
            	
            		$('select#dept-select').each(function(){
				    arrDept = $(this).val();
				    console.log(arrDept)
            		});
            		
            		 totalCommuteList(1, arrDept);
            	
            });// end of $("select#dept-select").change ------------ 

        
    })// end of $(document).ready 


    // Funtion Declation
    function getCurrentWeek() { // DateRnage 에서 특정날짜 선택시 해당하는 일주일의 평일 '월' 날짜와 '금' 날짜를 가져옴

        let start;
        let end;

        const day = new Date();
        const sunday = day.getTime() - 86400000 * day.getDay();

        day.setTime(sunday);

        const result = [day.toISOString().slice(0, 10)];

        for (let i = 1; i < 7; i++) {
            day.setTime(day.getTime() + 86400000);
            result.push(day.toISOString().slice(0, 10));
        }

        start = result[1];
        end = result[5];

        $("span#startdate").text(start)
        $("span#enddate").text("~ "+end)

    }
    
    function totalCommuteList(currentShowPageNo, arrDept) {
    		
    	    const startdate = $("span#startdate").text();
    	    const enddate = $("span#enddate").text().substring(2);
    	
    		$.ajax({
    			url:"<%= ctxPath %>/admin/selectCommuteList.yolo",
    			data:{"startdate": startdate,
    				  "enddate":enddate,
    				  "currentShowPageNo":currentShowPageNo,
    				  "arrDept":arrDept},
    			dataType:"JSON",
    			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    			success:function(json) {
    				
    				let html = "";
    				let arr_worktime = [];
    				
    				if(json.length > 0) {
    					$.each(json, function(index,item) {
    						
    						arr_worktime.push(Math.floor(item.total_worktime/60))
    						
    						html += "<tr>"+
	                            "<td class='d-flex'>"+
	                            "<div class='profile' style='background-color:"+item.profile_color+"'>"+item.name.substring(1)+"</div>"+
								"<div>"+
								"<span style='display: block; padding-top: 3px;'>"+item.name+"</span>"+
								"<span style='font-weight: normal; color: gray; font-size: 10pt;'>"+item.upper_deptname+" · "+item.deptname+"</span>"+
								"</div>"+
	                            "</td>"+
	                            "<td>"+item.empno+"</td>"+
	                            "<td><div id ='gagebar"+index+"' style='width: 400px; height: 8px;'></div></td>"+
	                            "<td>"+Math.floor(item.total_worktime/60)+"시간</td>"+
	                            "<td>"+Math.floor(item.total_overtime/60)+"시간</td>"+
	                            "<td>"+Math.floor((Number(item.total_worktime)+Number(item.total_overtime))/60)+"시간</td>"+
	                        "</tr>"
    						
    					})// $.each ----------------------------
    					
    					$("#data-body").html(html);
    					
    					for(var i=0; i<json.length; i++) {
    		                var bar = new ProgressBar.Line('#gagebar'+i, { // 게이지바 생성
    		                    strokeWidth: 4,
    		                    easing: 'easeInOut',
    		                    duration: 1400,
    		                    color: 'yellow',
    		                    trailColor: '#eee',
    		                    trailWidth: 1,
    		                    svgStyle: {width: '100%', height: '100%'}
    		                });

    		                bar.animate(arr_worktime[i]/40);  // 게이지바 화면에 뿌리는 코드
    		                
    		            }
    					
    					// 페이지바 함수 호출
    					makePageBar(currentShowPageNo, arrDept, startdate, enddate);
    				}
    				
    				else {
    					$("#data-body").empty();
    					$("div#pageBar").empty();
    				}
    				
    			},
    			error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		    }
    		})
    } 
    
    
    function makePageBar(currentShowPageNo, arrDept, startdate, enddate) {
    		
    		$.ajax({
    			url:"<%= ctxPath %>/admin/commuteTotalPage.yolo",
    			data:{"startdate": startdate,
  				  "enddate":enddate,
  				  "arrDept":arrDept},
  			dataType:"JSON",
  			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
  			success:function(json) {
  				
  				if(json.totalPage > 0) {
					// 댓글이 있는 경우
					
					const totalPage = json.totalPage;
					
					const blockSize = 10;
					
					let loop = 1; // 증가해야 하기 때문에 const 가 아닌 let 으로 선언
					
					if(typeof currentShowPageNo == "string") {
						// currentShowPageNo 는 웹에서 받아오면 String 타입이기 때문에 Number 타입으로 변환해준다.
						currentShowPageNo = Number(currentShowPageNo);
					}
					
					// *** !! 다음은 currentShowPageNo 를 얻어와서 pageNo 를 구하는 공식이다. !! ***//
					let pageNo = Math.floor((currentShowPageNo - 1)/blockSize) * blockSize + 1; 
					
					
					let pageBarHTML = "<ul class='pagination'>";
					
					if(pageNo != 1) {
						pageBarHTML += "<li class='page-item'><a class='page-link' href='javascript:totalCommuteList(\"1\")'>[맨처음]</a></li>";
						pageBarHTML += "<li class='page-item'><a class='page-link' href='javascript:totalCommuteList("+pageNo-1+","+arrDept+")'>[이전]</a></li>";
					}
					
					while( !(loop > blockSize || pageNo > totalPage) ) {
						
						if(pageNo == currentShowPageNo) {
							pageBarHTML += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>";
						}
						else {
							pageBarHTML += "<li class='page-item'><a class='page-link' href='javascript:totalCommuteList("+pageNo+","+arrDept+")'>"+pageNo+"</a></li>";
						}
						
						loop++;
						pageNo++;
					}// end of while -----------------------------------
					
					// === [다음] [마지막] 만들기 === //
					
					if(pageNo <= totalPage) {
						pageBarHTML += "<li class='page-item'><a class='page-link' href='javascript:totalCommuteList("+pageNo+","+arrDept+")'>[다음]</a></li>";
						pageBarHTML += "<li class='page-item'><a class='page-link' href='javascript:totalCommuteList("+totalPage+","+arrDept+")'>[마지막]</a></li>";
					}
					
					pageBarHTML += "</ul>";
					
					$("div#pageBar").html(pageBarHTML);
					
					
				}// end of if(json.totalPage > 0) ------------------
				else {
					$("#data-body").empty();
					$("div#pageBar").empty();
				}
  			}
    			
    		})
    }
	
    
</script>

<div style="width: 90%; margin : 0 5% 0 5%;">
    <nav class="top-nav border-bottom">
        <div class="category">
            <a href="<%= ctxPath %>/commute/mycommute.yolo" class="h4 mr-2 text-secondary font-weight-bold">나의 출퇴근</a>
            <a href="#" class="h4 mr-2 text-dark font-weight-bold">관리</a>
        </div>
    </nav>
    <div id="schedule-management-content">
        <div id="management-categoty-div" class="d-flex border-bottom">
            <a href="#" class="text-muted font-weight-bold mr-2 detail-category border-bottom border-dark"><span>주기별 근무</span></a> <!-- border-bottom border-dark 을 사용하여 url에 따라 밑줄 생성 -->
            <a href="#" class="text-muted font-weight-bold mr-2 detail-category"><span>보상휴가</span></a>
            <div style="margin-left: auto">
                <select id="dept-select" class="form-control" multiple="multiple" style="width: 300px">	
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
        </div>
        <div id="date" class="border-bottom">
            <input type="text" id="daterange" class="mr-1 text-center" readonly/>
            <span class="btn btn-outline-secondary btn-sm mr-2" id="today-btn">오늘</span>
            <span id="small-button" class="text-muted">조회</span>
            <span id="startdate" class="text-muted small"></span> <!-- 시작날짜 -->
            <span id="enddate" class="text-muted small"></span> <!-- 마지막 날짜 -->
        </div>
        <div id="commute-management-div">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th width="15%">이름</th>
                        <th width="5%">사번</th>
                        <th width="35%">시간 차트</th>
                        <th width="10%">근무 시간</th>
                        <th width="10%">초과 시간</th>
                        <th width="10%">합계</th>
                    </tr>
                </thead>
                <tbody id="data-body">
                </tbody>    
            </table>
        </div>
        
        <%-- === 페이지바 ==== --%>
      <div style="display: flex; margin-bottom: 50px;">
      	<div id="pageBar" style="margin: auto; text-align: center;"></div>
      </div>
    </div>
</div>