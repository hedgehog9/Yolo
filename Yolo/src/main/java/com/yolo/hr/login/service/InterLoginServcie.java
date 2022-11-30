package com.yolo.hr.login.service;

import java.util.Map;

import com.yolo.hr.jjy.employee.model.EmployeeVO;

public interface InterLoginServcie {

	/** 아이디와 비밀번호를 입력 받아 vo를 반환 */
	EmployeeVO checkLogin(Map<String, String> loginMap);
	

}
