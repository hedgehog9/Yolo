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
	
	// 재직 처리해야 할 사원들의 목록을 조회하는 메소드  
	List<Map<String, String>> getLeaveEmpList();

	// 휴직 처리해야할 사원들의 목록을 조회하는 메소드 
	List<Map<String, String>> getLeaveStartEmpList();

	// 휴직중인 사원의 목록을 전달받아 배열로 변환 후 재직 상태로 update 하는 메소드
	void updateLeaveEmp(Map<String, String[]> paraMap);

	// 재직중인 사원의 목록을 전달받아 배열로 변환 후 휴직 상태로 update 하는 메소드
	void updateLeaveStartEmp(Map<String, String[]> paraMap);

	// 전체 부서번호, 부서명 조회하는 메소드 
	List<Map<String, String>> getDeptList();

	// 해당부서 팀 구해오기
	List<Map<String, String>> getTeam(Map<String, String> deptMap);

	// 페이징 처리를 위해 총 사원 수 구해오기 
	int getTotalCount(Map<String, Object> empMap);

	// 페이징 처리한 글목록 가져오기 (검색이 있든지, 검색이 없든지 모두 다 포함한 것)
	List<Map<String, String>> empListSearchWithPaging(Map<String, Object> pageMap);

	// 페이징 처리를 위해 총 페이지 수 구해오기 
	int getTotalPage(Map<String, Object> pageMap);

	// rno 에 해당하는 사원 목록 가져오기 
	List<Map<String, String>> empListWithRno(Map<String, String> pageMap);

	// 회원가입시 이메일 중복 여부 확인 
	int checkDuplicateEmail(Map<String, Object> paraMap);

	// 신규 사원 등록 
	int registEployee(Map<String, Object> paraMap);

	//** 사원번호, 월요일(날짜), 금요일(날짜) 를 전달받아 한 주의 총 근무시간 구해오기 */
	String getWorkTime(Map<String, Object> workTimeMap);

}
