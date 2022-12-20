package com.yolo.hr.jihyunModel;

import java.util.List;
import java.util.Map;

public interface InterLeaveDAO {

	// 휴가 종류와 남은 일수 구해오기
	List<Map<String, String>> getLeaveTypeList(Map<String, String> paraMap);

	// 모달에 들어갈 해당 휴가에 대한 상세 내용 알아오기
	Map<String, String> getLeaveDate(Map<String, String> paraMap);

	// 휴가 신청하기
	void requestLeave(Map<String, String> parameterMap);

	// 휴가 신청하면서 사용내역 업데이트 하기
	void plusUsedLeave(Map<String, String> parameterMap);

	// 연차 사용내역 업데이트 
	void plusUsedLeaveAnnual(Map<String, String> parameterMap);

	// 반차 사용 내역 업데이트
	void plusUsedLeaveHalf_annual(Map<String, String> parameterMap);

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

	//휴가신청 삭제하기
	void deleteRequestLeave(Map<String, String> leaveRequestDetail);

	// 휴가 취소 하면서 연차 사용내역 줄이기
	void minusUsedLeaveAnnual(Map<String, String> leaveRequestDetail);

	// 휴가 취소 하면서 반차 사용내역 줄이기
	void minusUsedLeaveHalf_annual(Map<String, String> leaveRequestDetail);

	// 휴가 취소 하면서 휴차 사용내역 줄이기
	void minusUsedLeave(Map<String, String> leaveRequestDetail);

	// 승인 / 반려하기 함수 
	void approvalRequestLevae(Map<String, String> parameterMap);

}
