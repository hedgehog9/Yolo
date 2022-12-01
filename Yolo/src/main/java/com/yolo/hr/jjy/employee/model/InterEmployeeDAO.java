package com.yolo.hr.jjy.employee.model;

import java.util.*;

public interface InterEmployeeDAO {

	// 전체 사원을 조회해오는 메소드 
	List<EmployeeVO> getEmpList(Map<String, String> empMap);

}
