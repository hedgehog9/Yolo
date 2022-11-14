package com.yolo.hr.common;

import javax.servlet.http.HttpServletRequest;

public class MyUtil {

	// *** ? 다음의 데이터까지 포함한 현재 URL 주소를 알려주는 메소드 생성하기 *** //
	public static String getCurrentURL(HttpServletRequest request) {
		
		// 만약에 현재 URL 이 
		// http://localhost:9090/MyMVC/member/memberList.up?sizePerPage=10&currentShowPageNo=5&searchType=name&searchWord=정 
		// 이라면 
		
		String currentURL = request.getRequestURL().toString();
		// http://localhost:9090/MyMVC/member/memberList.up 
		
		String queryString = request.getQueryString();
		// sizePerPage=10&currentShowPageNo=5&searchType=name&searchWord=정 (GET 방식일 경우)
		// null (POST 방식일 경우)
		
		if(queryString != null) { // GET 방식일 경우
			currentURL += "?" + queryString;
		}
		
		String ctxPath = request.getContextPath();
		//     /MyMVC 
		
		int beginIndex = currentURL.indexOf(ctxPath) + ctxPath.length();
		//      27     =           21                +        6
		
		currentURL = currentURL.substring(beginIndex);
		//           /member/memberList.up?sizePerPage=10&currentShowPageNo=5&searchType=name&searchWord=정 
		
		return currentURL;
	}
	
	
	// *** 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어 코드) 작성하기 ***//
	public static String secureCode(String str) {
	
	/*
	 	=== 스마트에디터를 사용 안 할 경우  ===
		str = str.replaceAll("<", "&lt;");
		str = str.replaceAll(">", "&gt;");
	*/	
		
		// === 스마트에디터를 사용 할 경우  ===
		str = str.replaceAll("<script", "&lt;script");
		
		return str;
	}
	
	
	
	
	
}
