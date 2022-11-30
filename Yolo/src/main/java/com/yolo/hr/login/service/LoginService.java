package com.yolo.hr.login.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yolo.hr.jjy.employee.model.EmployeeVO;
import com.yolo.hr.login.model.InterLoginDAO;

@Service
public class LoginService implements InterLoginServcie {
	
	@Autowired
	private InterLoginDAO dao; 

	// 아이디와 비밀번호를 입력 받아 vo를 반환
	@Override
	public EmployeeVO checkLogin(Map<String, String> loginMap) {
		EmployeeVO loginuser = dao.checkLogin(loginMap);
		return loginuser;
	}

}
