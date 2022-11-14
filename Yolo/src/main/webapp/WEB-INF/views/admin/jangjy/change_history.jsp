<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath();%>    


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
    
    button#change_dept{
    	background-color: #66cc66;
    	color: white;
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
	            <button id="change_dept" type="button" class="btn" onclick="#"><span><i class="fas fa-pen" style="margin:0px; width:20px;"></i>&nbsp;&nbsp;인사 발령하기</span></button>
	        </div>
	    </div>
	    
	    <div>
	    
	    
	    
	    </div>
	    
	    
	    
</div>