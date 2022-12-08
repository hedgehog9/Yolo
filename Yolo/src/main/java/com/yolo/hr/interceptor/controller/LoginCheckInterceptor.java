package com.yolo.hr.interceptor.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginCheckInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		// 로그인 여부 검사
		HttpSession session = request.getSession();
	      
	      if(session.getAttribute("loginuser") == null) {
	         
	         //로그인이 되지 않은 상태
	         String message = "로그인 후 접근 가능한 페이지입니다.";
	         String loc = request.getContextPath()+"/login.yolo";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	         // 컨트롤러가 아니기때문에 dispatcher 를 이용해 페이지를 이동시킨다.
	         RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
	         try {
	            dispatcher.forward(request, response);
	         } catch (ServletException | IOException e) {
	            e.printStackTrace();
	         }
	         
	         return false; // 로그인 하지 않은 경우
	      }
	      
	      return true; // 로그인한 경우 
		
	}

}
