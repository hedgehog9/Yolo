<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	
	a{
	  text-decoration: none;
	}
	
	p, li, a{
	  font-size: 14px;
	}
	
	.container{
	  width: 50%;
	  margin: 0 auto;
	  position: relative;
	  text-align: center;
	}
	
	
	.pagination{
	  padding: 30px 0;
	}
	
	.pagination ul{
	  margin: 0;
	  padding: 0;
	  list-style-type: none;
	}
	
	.pagination a{
	  display: inline-block;
	  width: 40px;
	  height: 40px;
	  text-align: center;
	  padding-top: 7px;
	  color: #2ecc71;
	  font-weight: bold;
	}
	
	
	.p12 a.last{
		border: 2px solid #2ecc71;
	  	background-color: #2ecc71;
	  	color: #fff;
	  	font-weight: bold;
	  	border-radius: 50%;
	}
	
	.p12 .is-active{
		border: 2px solid #2ecc71;
	  	background-color: #2ecc71;
	  	color: #fff;
	  	font-weight: bold;
	  	border-radius: 50%;
	}
	
	.p12 a.box {
		border: 2px solid #2ecc71;
		color : #2ecc71;
		width: 100px;
		font-weight: bold;
		border-radius: 1.8rem;
		margin-left: 5px;
		margin-right: 5px;
	}
	

</style>


<div class="container"> 
    <div class="pagination p12">
      ${requestScope.pageBar}
    </div>
  </div>