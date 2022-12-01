package com.yolo.hr.jjy.employee.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class EmployeeDAO implements InterEmployeeDAO {

	@Resource
	private SqlSessionTemplate sqlsession; 
	
	// 전체 사원을 조회해오는 메소드 
	@Override
	public List<EmployeeVO> getEmpList(Map<String, String> empMap) {
		
		List<EmployeeVO> empList = sqlsession.selectList("jangjy.getEmpList", empMap);
		return empList;
	}

}
