package com.yolo.hr.loginController;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class loginController {
	
	@RequestMapping(value = "/login.yolo")
	public String login() {
		
		return "login.login";
	}
	
	//ajax
	@ResponseBody
	@RequestMapping(value = "/loginContinue.yolo")
	public String loginContinue(HttpServletRequest request) {
		

		JSONArray jsonArr = new JSONArray();

		return jsonArr.toString();
	}
		
	//ajax
	@ResponseBody
	@RequestMapping(value = "/loginpw.yolo")
	public String loginpw(HttpServletRequest request) {
		

		JSONArray jsonArr = new JSONArray();

		return jsonArr.toString();
	}
	
	@RequestMapping(value = "/findPW.yolo")
	public String findPW(HttpServletRequest request) {
		
		String userid = request.getParameter("userid");
		
		request.setAttribute("userid", userid);
		
		return "finPW.login";
	}

		
}
