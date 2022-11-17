<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

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
		
		$("#month").monthpicker({
            monthNames: ['1월(JAN)', '2월(FEB)', '3월(MAR)', '4월(APR)', '5월(MAY)', '6월(JUN)',
                '7월(JUL)', '8월(AUG)', '9월(SEP)', '10월(OCT)', '11월(NOV)', '12월(DEC)'],
            monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            changeYear: false,
            yearRange: 'c-2:c+2',
            dateFormat: 'yy-mm'
        });
		
	});
	
</script>

<body>
    <nav class="top-nav border-bottom">
        <span class="text-muted h4 font-weight-bold">급여</span>
    </nav>
    <div id="pay-stub-content">
        <div id="category" class="d-flex">
            <a href="<%= ctxPath%>/admin/payStub.yolo" class="text-muted font-weight-bold mr-2 detail-category"><span>급여명세서 목록</span></a> <!-- border-bottom border-dark 을 사용하여 url에 따라 밑줄 생성 -->
            <a href="#" class="text-muted font-weight-bold mr-2 detail-category border-bottom border-dark"><span>급여정산 및 지급</span></a>
            <div id="button-div" style="margin-left: auto" class="pt-3">
                <button type="button" class="btn btn-light btn-outline-primary btn-sm" data-toggle="modal" data-target="#myModal">급여정산</button>
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
                                <label for="email">부서:</label>
                                <select id="departmentno" name="departmentno" class="custom-select">
                                    <option>부서선택</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="email">근무기준 달:</label>
                                <input id="month" name="month" class="form-controller">
                            </div>
                        </div>
                        
                        <!-- Modal footer -->
                        <div class="modal-footer">
                        <button type="button" class="btn btn-light btn-outline-success btn-sm" data-dismiss="modal" onclick="getPayment()">정산하기</button>
                        </div>
                        
                    </div>
                    </div>
                </div>
            </form>

        </div>
        <div class="border-bottom">
            <table class="table table-hover">
                <thead>
                    <th style="width: 150px;">전체선택&nbsp;<input type="checkbox"/></th>
                    <th>이름</th>
                    <th>근무기준 달</th>
                    <th>급여</th>
                    <th>초과근무 수당</th>
                    <th>합계</th>
                    <th></th>
                </thead>
                <tbody id="data-body">
                    <tr>
                        <td class="text-center"><input type="checkbox"/></td>
                        <td>이름나오는 곳</td>
                        <td>12월</td>
                        <td>4,000,000</td>
                        <td>500,000</td>
                        <td>4,500,000</td>
                        <td><button type="button" class="btn btn-light btn-outline-secondary btn-sm" onclick="onePayment()">지급하기</button></td>
                    </tr> 
                </tbody>    
            </table>
        </div>
        <div id="button-div" class="mt-5 pl-3">
            <button type="button" class="btn btn-light btn-outline-secondary btn-sm" onclick="checkPayment()">체크지급</button>
        </div>
    </div>