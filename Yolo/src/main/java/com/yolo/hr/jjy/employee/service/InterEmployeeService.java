package com.yolo.hr.jjy.employee.service;

import java.util.List;
import java.util.Map;

import com.yolo.hr.jjy.employee.model.EmployeeVO;

public interface InterEmployeeService {

	/** 전체 사원을 조회해오는 메소드 */
	List<Map<String, String>> getEmpList(Map<String, String> empMap);

	/** 사원 번호를 전달받아 사원 한명의 정보를 조회해오는 메소드 */
	Map<String, String> getEmpOne(Map<String, String> empnoMap);

	/** 시작일, 종료일, 사원번호, 메모, 사원번호를 Map 으로 전달받아 휴직테이블에 insert 하는 메소드  */
	int insertLeave(Map<String, String> leaveMap);

	// 매일 오전 6시에 사원의 status 컬럼을 휴직 처리 또는 재직 처리로 바꿔주는 메소드 
	void updateLeaveStatus();

}
