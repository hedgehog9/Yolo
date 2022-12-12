package com.yolo.hr.jjy.employee.service;

import java.util.*;


public interface InterEmployeeService {

	/** 전체 사원을 조회해오는 메소드 */
	List<Map<String, String>> getEmpList(Map<String, String> empMap);

	/** 사원 번호를 전달받아 사원 한명의 정보를 조회해오는 메소드 */
	Map<String, String> getEmpOne(Map<String, String> empnoMap);

	/** 시작일, 종료일, 사원번호, 메모, 사원번호를 Map 으로 전달받아 휴직테이블에 insert 하는 메소드  */
	int insertLeave(Map<String, String> leaveMap);

	/** 매일 오전 6시에 사원의 status 컬럼을 휴직 처리 또는 재직 처리로 바꿔주는 메소드  */
	void updateLeaveStatus();

	/** 전체 부서 조회하는 메소드  */
	List<Map<String, String>> getDeptList();

	/** 해당부서 팀 구해오기 */
	List<Map<String, String>> getTeam(Map<String, String> deptMap);

	/** 페이징 처리를 위해 총 사원 수 구해오기  */
	int getTotalCount(Map<String, Object> pageMap);

	/** 페이징 처리한 글목록 가져오기 (검색이 있든지, 검색이 없든지 모두 다 포함한 것) */
	List<Map<String, String>> empListSearchWithPaging(Map<String, Object> pageMap);

	/** 페이징 처리를 위한 총 페이지 수 구해오기 */
	int getTotalPage(Map<String, Object> pageMap);

	/** rno 에 해당하는 사원 목록 가져오기  */
	List<Map<String, String>> empListWithRno(Map<String, String> pageMap);

	/** 신규 사원 등록하기  */
	int registEployee(Map<String, Object> paraMap);

	/** 인사발령처리 (트랜잭션) */
	int personnelAppointment(Map<String, Object> paraMap);

	/** 부서에 부서장 또는 팀장이 있는지 확인하기 */
	int checkManager(Map<String, Object> paraMap);

	/** 사원 개인정보 변경 메소드  */
	int changePsInfo(Map<String, Object> psInfoMap);

	/** 인사발령 내역 페이징 처리를 위한 총 페이지수 구해오기  */
	int getTotalPsaPage(Map<String, Object> pageMap);

	/** 인사발령 내역 페이징 처리를 위한 인사발령 목록 구해오기  */
	List<Map<String, String>> psaListSearchWithPaging(Map<String, Object> pageMap);


}
