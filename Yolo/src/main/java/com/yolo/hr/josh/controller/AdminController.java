package com.yolo.hr.josh.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminController {

	
	@RequestMapping(value="/admin/mycommute.yolo")
	public String myschedule() {
		
		
		
		return "/josh/mycommute.admin";
	}
	
}
