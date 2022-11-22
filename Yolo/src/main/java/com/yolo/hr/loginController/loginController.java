package com.yolo.hr.loginController;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class loginController {
	
	@RequestMapping(value = "/login.yolo")
	public String login() {
		
		return "login.login";
	}
	
	@RequestMapping(value = "/findPW.yolo")
	public String findPW(HttpServletRequest request) {
		
		String userid = request.getParameter("userid");
		
		request.setAttribute("userid", userid);
		
		return "finPW.login";
	}

		
}
