package com.yolo.hr.login.service;

import java.util.List;
import java.util.Map;

import com.yolo.hr.jjy.employee.model.EmployeeVO;

public interface InterLoginServcie {

	/** 아이디와 비밀번호를 입력 받아 vo를 반환 */
	EmployeeVO checkLogin(Map<String, String> loginMap);

	/** 휴직중인 사원의 목록을 조회하는 메소드 */
	List<Map<String, String>> getLeaveEmpList();

	/** 휴직중인 사원의 목록을 전달받아 배열로 변환 후 update 하는 메소드 */
	void updateLeaveEmp(List<Map<String, String>> empList);
	

}
