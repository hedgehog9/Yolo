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
    	 
    	 // 달력 년도가 바뀌면 발생하는 이벤트
    	 calYearKo.on('change', () => {
    		    
    		 
    		 
 		});

    });

</script>

    <nav class="top-nav border-bottom">
        <span class="text-muted h4 font-weight-bold">급여</span>
    </nav>
    <div id="pay-stub-content">
        <div id="category" class="d-flex">
            <a href="#" class="text-muted font-weight-bold mr-2 detail-category border-bottom border-dark"><span>급여명세서 목록</span></a> <!-- border-bottom border-dark 을 사용하여 url에 따라 밑줄 생성 -->
            <c:if test="${sessionScope.loginuser.empno == 9999}">
            <a href="<%= ctxPath%>/admin/payment.yolo" class="text-muted font-weight-bold mr-2 detail-category"><span>급여정산 및 지급</span></a>
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
                        <th>근무기준 달</th>
                        <th>급여</th>
                        <th>초과근무 수당</th>
                        <th>합계</th>
                    </tr>
                </thead>
                <tbody id="data-body">
                <c:forEach var="item" items="${requestScope.payStubList}">
                		<tr>
                        <td>${fn:substring(item.month_payment,0,7)}</td>
                        <td><fmt:formatNumber value="${item.salary}" pattern="#,###"/><span> 원</span></td>
                        <td><fmt:formatNumber value="${item.over_salary}" pattern="#,###"/><span> 원</span></td>
                        <td><fmt:formatNumber value="${item.salary + item.over_salary}" pattern="#,###"/><span> 원</span></td>
                    </tr> 
                </c:forEach>
                </tbody>    
            </table>
        </div>
    </div>