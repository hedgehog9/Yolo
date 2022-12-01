package com.yolo.hr.loginController;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yolo.hr.jjy.employee.model.EmployeeVO;
import com.yolo.hr.login.service.InterLoginServcie;

@Controller
public class loginController {
	
	@Autowired
	private InterLoginServcie service; 
	
	@RequestMapping(value = "/login.yolo")
	public String login() {
		
		
		
		return "login.login";
	}
	
	//ajax
	@ResponseBody
	@RequestMapping(value = "/loginContinue.yolo")
	public String loginContinue(HttpServletRequest request) {
		boolean result = false;
		
		String email = request.getParameter("email"); // 아이디
		String pwd = request.getParameter("pwd");     // 비밀번호 
		
		Map<String,String> loginMap = new HashMap<>();
		
		loginMap.put("email", email);
		loginMap.put("pwd", pwd);
		
		// System.out.println("~~~ 확인용 email = "+email);
		// System.out.println("~~~ 확인용 pwd = "+pwd);
		
		EmployeeVO loginuser = service.checkLogin(loginMap);
		
		if(loginuser != null) {
			HttpSession session = request.getSession();
			session.setAttribute("empno", loginuser.getEmpno());
			session.setAttribute("fk_deptno", loginuser.getFk_deptno());
			session.setAttribute("name", loginuser.getName());
			session.setAttribute("name", loginuser.getPosition());
			session.setAttribute("deptName", "부서명 구해와서 넣기");
			
			result = true;
			
			// System.out.println("확인용 loginuser ="+loginuser);
			
		}
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", result);
		
		return jsonObj.toString();
		
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
