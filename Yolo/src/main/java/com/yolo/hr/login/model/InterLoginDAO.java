package com.yolo.hr.login.model;

import java.util.List;
import java.util.Map;

import com.yolo.hr.jjy.employee.model.EmployeeVO;

public interface InterLoginDAO {

	// 아이디와 비밀번호를 입력 받아 vo를 반환
	EmployeeVO checkLogin(Map<String, String> loginMap);

}
