<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% String ctxPath = request.getContextPath(); %>

<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>

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
	
	.badge {
		font-size: 15px;
	}
	
	td {
		vertical-align: middle !important;
	}
    
</style>

<script>

    $(document).ready(function() {

    	 var calYearKo = new tui.DatePicker('#datepicker-year-ko', {
             date: new Date(),
             language: 'ko',
             type: 'year',
             input: {
                 element: '#datepicker-input-ko',
                 format: 'yyyy'
             }
         });	
    	 
    	 // ?????? ????????? ????????? ???????????? ?????????
    	 calYearKo.on('change', () => {
    		 
    		 let empno = ${sessionScope.loginuser.empno};
    		 
    		 //console.log(empno)
    		 
    		 $.ajax({
 				url:"<%= ctxPath %>/admin/ajaxPayStub.yolo",
 				data:{"empno":empno,
 					  "select_year":$("#datepicker-input-ko").val()},
 			    dataType:"JSON", 
 				success:function(json){
 					
 					if(json.length > 0) {
 						
 						let html = "";
 						
 						$.each(json, function(index,item) {
 							
 							html += "<tr>"+
 								    "<td><span class='badge badge-dark rounded-pill'>"+item.month_payment.substring(0,7)+"</span></td>"+
 								    "<td><span class='badge badge-light rounded-pill'>"+Number(item.salary).toLocaleString('en')+" ??? </span></td>"+
 								    "<td><span class='badge badge-light rounded-pill'>"+Number(item.over_salary).toLocaleString('en')+" ??? </span></td>"+
 								    "<td><span class='badge badge-warning rounded-pill'>"+(Number(item.salary) + Number(item.over_salary)).toLocaleString('en')+" ??? </span></td>"+
 								    "</tr>"
 							
 						})// end of $.each ------------------
 						
 						$("#data-body").html(html)
 						
 						
 					}
 					else {
 						$("#data-body").empty();
 					}
 					
 				},
 				error: function(request, status, error){
 					  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
 				}
 			})
    		 
 		});

    });
    
    

</script>

    <nav class="top-nav border-bottom">
        <span class="text-muted h4 font-weight-bold">??????</span>
    </nav>
    <div id="pay-stub-content">
        <div id="category" class="d-flex">
            <a href="#" class="text-muted font-weight-bold mr-2 detail-category green_bottom"><span>??????????????? ??????</span></a> <!-- border-bottom border-dark ??? ???????????? url??? ?????? ?????? ?????? -->
            <c:if test="${sessionScope.loginuser.empno == 9999}">
            <a href="<%= ctxPath%>/admin/payment.yolo" class="text-muted font-weight-bold mr-2 detail-category"><span>???????????? ??? ??????</span></a>
            </c:if>
            <div style="margin-left: auto" class="pt-3">
                   <div class="tui-datepicker-input tui-datetime-input tui-has-focus">
                        <input type="text" id="datepicker-input-ko" aria-label="Date-Time">
                        <span class="tui-ico-date"></span>
                    </div>
                    <div class="datepicker-cell" id="datepicker-year-ko"></div>
            </div>
        </div>
        <div>
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th><span style='font-size:20px;'>&#128198;</span>???????????? ???</th>
                        <th><span style='font-size:20px;'>&#128178;</span>?????? </th>
                        <th><span style='font-size:20px;'>&#128337;</span>???????????? ??????</th>
                        <th><span style='font-size:20px;'>&#128176;</span>??????</th>
                    </tr>
                </thead>
                <tbody id="data-body">
                <c:forEach var="item" items="${requestScope.payStubList}">
                		<tr>
                        <td><span class='badge badge-dark rounded-pill'>${fn:substring(item.month_payment,0,7)}</span></td>
                        <td><span class='badge badge-light rounded-pill'><fmt:formatNumber value="${item.salary}" pattern="#,###"/>???</span></td>
                        <td><span class='badge badge-light rounded-pill'><fmt:formatNumber value="${item.over_salary}" pattern="#,###"/>???</span></td>
                        <td><span class='badge badge-warning rounded-pill'><fmt:formatNumber value="${item.salary + item.over_salary}" pattern="#,###"/>???</span></td>
                    </tr> 
                </c:forEach>
                </tbody>    
            </table>
        </div>
    </div>