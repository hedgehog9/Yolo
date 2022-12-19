package com.yolo.hr.jihyunService;

import java.util.List;
import java.util.Map;

public interface InterLeaveService {

	// 휴가 종류와 남은 일수 구해오기
	List<Map<String, String>> getLeaveTypeList(Map<String, String> paraMap);

	// 모달에 들어갈 해당 휴가에 대한 상세 내용 알아오기
	Map<String, String> getLeaveDate(Map<String, String> paraMap);

	// 휴가 신청하기
	void requestLeave(Map<String, String> parameterMap);

	// 휴가 사용 내역 조회하기
	List<Map<String, String>> getLeaveRecode(Map<String, String> paraMap);

	// 휴가 예정 내역 조회하기
	List<Map<String, String>> getLeavePlan(Map<String, String> paraMap);

	// 하위 부서 번호 전부 알아오기
	List<String> getLowerDeptnoList(String fk_deptno);

	// 조회한 부서에 해당하는 사원들의 휴가 신청내역을 불러온다
	List<Map<String, String>> getRequestLeaveList(Map<String, String> paraMap);

	// 조회한 부서에 해당하는 사원들의 휴가 사용/잔여 내역을 불러온다
	List<Map<String, String>> getLeaveStatusList(String deptJoin);

	// 관리자 사원번호 리스트 가져오기
	List<String> getAdminEmpnoList();

	// 휴가신청 번호로 휴가신청 상세 조회
	Map<String, String> getLeaveRequestDetail(String request_leaveno);

	// 휴가신청에 파일 추가 하기
	void addFileToRequestLeave(Map<String, String> paraMap);

	// 휴가신청 삭제하기
	void deleteRequestLeave(Map<String, String> leaveRequestDetail);

	// 승인 / 반려하기 함수 
	void approvalRequestLevae(Map<String, String> leaveRequestDetail);

}
