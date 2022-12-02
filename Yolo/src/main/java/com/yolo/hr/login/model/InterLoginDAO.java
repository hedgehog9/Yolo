package com.yolo.hr.login.model;

import java.util.List;
import java.util.Map;

import com.yolo.hr.jjy.employee.model.EmployeeVO;

public interface InterLoginDAO {

	// 아이디와 비밀번호를 입력 받아 vo를 반환
	EmployeeVO checkLogin(Map<String, String> loginMap);

	// 휴직중인 사원의 목록을 조회하는 메소드 
	List<Map<String, String>> getLeaveEmpList();

	// 휴직이 끝난 사원 리스트를 전달받아 재직 처리하는 메소드
	void updateLeaveEmp(Map<String, String[]> paraMap);

}
