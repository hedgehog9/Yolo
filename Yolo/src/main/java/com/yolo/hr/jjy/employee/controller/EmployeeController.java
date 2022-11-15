package com.yolo.hr.jjy.employee.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class EmployeeController {

	// 구성원 메인 페이지
	@RequestMapping(value = "/people.yolo")
	public String people() {

		return "/jangjy/people_admin.admin";
	}

	// 인사 발령 내역 조회
	@RequestMapping(value = "/change_history.yolo")
	public String change_history() {

		return "/jangjy/change_history.admin";
	}

	// 조직도
	@RequestMapping(value = "/organization_chart.yolo")
	public String organization_chart() {

		return "/jangjy/organization_chart.admin";
	}

	// 사용자 한명 상세 정보 (admin)
	@RequestMapping(value = "/user_detail.yolo")
	public String user_detail() {

		return "/jangjy/user_detail.admin";
	}

}
