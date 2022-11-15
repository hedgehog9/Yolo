package com.yolo.hr.josh.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminController {

	
	@RequestMapping(value="/admin/mycommute.yolo")
	public String myschedule() {
		
		
		
		return "josh/mycommute.admin";
	}
	
	@RequestMapping(value="/admin/commuteManagement.yolo")
	public String commuteManagement() {
		
		
		
		return "josh/commute_management.admin";
	}
	
	@RequestMapping(value="/admin/payStub.yolo")
	public String payStub() {
		
		
		
		return "josh/pay_stub.admin";
	}
	
	@RequestMapping(value="/admin/payment.yolo")
	public String payment() {
		
		
		
		return "josh/payment.admin";
	}
	
	@RequestMapping(value="/admin/calendar.yolo")
	public String calendar() {
		
		
		
		return "josh/calendar.admin";
	}
	
}
