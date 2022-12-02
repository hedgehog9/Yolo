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
	public List<Map<String, String>> getEmpList(Map<String, String> empMap) {
		
		List<Map<String, String>> empList = sqlsession.selectList("jangjy.getEmpList", empMap);
		return empList;
	}
	
	// 사원 번호를 전달받아 사원 한명의 정보를 조회해오는 메소드
	@Override
	public Map<String, String> getEmpOne(Map<String, String> empnoMap) {
		Map<String, String> employeeMap = sqlsession.selectOne("jangjy.getEmpOne",empnoMap);
		return employeeMap;
	}

	// 시작일, 종료일, 사원번호, 메모, 사원번호를 Map 으로 전달받아 휴직테이블에 insert 하는 메소드
	@Override
	public int insertLeave(Map<String, String> leaveMap) {
		int result = sqlsession.insert("jangjy.insertLeave",leaveMap);
		return result;
	}
	
	// 사원번호를 Map 으로 전달받아 휴직 상태로 update 하는 메소드 
	@Override
	public int updateLeave(Map<String, String> leaveMap) {
		int leaveUpdate = sqlsession.update("jangjy.updateLeave", leaveMap);
		return leaveUpdate;
	}

	
	// 사원번호, 휴직시작일,휴직종료일을 Map 으로 전달받아 가능한 기간인지 조회하는 메소드
	@Override
	public int checkLeave(Map<String, String> leaveCheckMap) {
		int result = sqlsession.selectOne("jangjy.leaveCheck",leaveCheckMap);
		return result;
	}
	

	
	
	
}
