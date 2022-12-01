package com.yolo.hr.josh.controller;

import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yolo.hr.josh.service.InterCommuteService;

@Controller
public class AdminController {

	@Autowired
	private InterCommuteService service;
	
	@Resource
	private SqlSessionTemplate sqlsession;
	
	@RequestMapping(value="/admin/commuteManagement.yolo")
	public String commuteManagement(HttpServletRequest request) {
		
		List<HashMap<String, String>> deptList = new ArrayList<>();
		
		// 부서들을 가져오는 메소드
		deptList = sqlsession.selectList("josh.selectDept");
		
		request.setAttribute("deptList", deptList);
		
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
	
	
	
}
