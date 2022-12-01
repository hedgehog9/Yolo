package com.yolo.hr.jjy.employee.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yolo.hr.jjy.employee.model.*;

@Service
public class EmployeeService implements InterEmployeeService {

	@Autowired
	private InterEmployeeDAO dao;
	
	// 전체 사원을 조회 해오는 메소드 
	@Override
	public List<EmployeeVO> getEmpList(Map<String, String> empMap) {
		List<EmployeeVO> empList = dao.getEmpList(empMap);
		return empList;
	}

}
