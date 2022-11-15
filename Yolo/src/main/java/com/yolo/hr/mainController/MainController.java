package com.yolo.hr.mainController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	
	// http://localhost:9090/hr/ 입력시 index 페이지로 이동
	@RequestMapping(value = "/")
	public String main() {
		return "redirect:index.yolo";
	}
	
	@RequestMapping(value = "/index.yolo")
	public String viewMain() {
		
		return "main.admin";
	}
	/////////////////////////////////////////////////
	
	
	
	
	
	
}
