package com.yolo.hr.jjy.employee.model;

import java.util.*;

public interface InterEmployeeDAO {

	// 전체 사원을 조회해오는 메소드 
	List<Map<String, String>> getEmpList(Map<String, String> empMap);

	// 사원 번호를 전달받아 사원 한명의 정보를 조회해오는 메소드
	Map<String, String> getEmpOne(Map<String, String> empnoMap);

	// 시작일, 종료일, 사원번호, 메모, 사원번호를 Map 으로 전달받아 휴직테이블에 insert 하는 메소드
	int insertLeave(Map<String, String> leaveMap);

	// 사원번호를 Map 으로 전달받아 휴직 상태로 update 하는 메소드 
	int updateLeave(Map<String, String> leaveMap);

	// 사원번호, 휴직시작일,휴직종료일을 Map 으로 전달받아 가능한 기간인지 조회하는 메소드
	int checkLeave(Map<String, String> leaveCheckMap);

}
