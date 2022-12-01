package com.yolo.hr.jjy.employee.service;

import java.util.List;
import java.util.Map;

import com.yolo.hr.jjy.employee.model.EmployeeVO;

public interface InterEmployeeService {

	/** 전체 사원을 조회해오는 메소드 */
	List<EmployeeVO> getEmpList(Map<String, String> empMap);

}
