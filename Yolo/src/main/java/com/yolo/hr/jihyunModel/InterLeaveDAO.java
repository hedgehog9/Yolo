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

}
