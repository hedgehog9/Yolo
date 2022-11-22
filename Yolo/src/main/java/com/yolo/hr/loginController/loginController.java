package com.yolo.hr.loginController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class loginController {
	
	@RequestMapping(value = "/login.yolo")
	public String login() {
		
		return "jihee/login/login.admin";
	}

		
}
