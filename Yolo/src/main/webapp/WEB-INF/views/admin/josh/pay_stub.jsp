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

    	$("#year-select").val() /* 페이지진입할때 백단에서 이번달 값꽂아주기 */
    	
        $("#year-select").monthpicker({
            monthNames: ['1월(JAN)', '2월(FEB)', '3월(MAR)', '4월(APR)', '5월(MAY)', '6월(JUN)',
                '7월(JUL)', '8월(AUG)', '9월(SEP)', '10월(OCT)', '11월(NOV)', '12월(DEC)'],
            monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            changeYear: false,
            yearRange: 'c-2:c+2',
            dateFormat: 'yy-mm'
        });

    });

</script>

    <nav class="top-nav border-bottom">
        <span class="text-muted h4 font-weight-bold">급여</span>
    </nav>
    <div id="pay-stub-content">
        <div id="category" class="d-flex">
            <a href="#" class="text-muted font-weight-bold mr-2 detail-category border-bottom border-dark"><span>급여명세서 목록</span></a> <!-- border-bottom border-dark 을 사용하여 url에 따라 밑줄 생성 -->
            <a href="<%= ctxPath%>/admin/payment.yolo" class="text-muted font-weight-bold mr-2 detail-category"><span>급여정산 및 지급</span></a>
            <div style="margin-left: auto" class="pt-3">
                <input type="text" id="year-select" class="form-control text-center" style="width: 100px" readonly/>
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
                    <tr>
                        <td>2022. 11. 8</td>
                        <td>4,000,000</td>
                        <td>500,000</td>
                        <td>4,500,000</td>
                    </tr> 
                </tbody>    
            </table>
        </div>
    </div>