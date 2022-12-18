package com.yolo.hr.jihyunModel;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class LeaveDAO implements InterLeaveDAO {
	
	@Resource
	private SqlSessionTemplate sqlsession;

	// 휴가 종류와 남은 일수 구해오기
	@Override
	public List<Map<String, String>> getLeaveTypeList(Map<String, String> paraMap) {
		List<Map<String, String>> leaveTypeList = sqlsession.selectList("kimjh.selectLeaveType",paraMap);
		return leaveTypeList;
	}

	
	// 모달에 들어갈 해당 휴가에 대한 상세 내용 알아오기
	@Override
	public Map<String, String> getLeaveDate(Map<String, String> paraMap) {
		Map<String, String> leaveData = sqlsession.selectOne("kimjh.selectLeaveData",paraMap);
		return leaveData;
	}


	// 휴가 신청하기
	@Override
	public void requestLeave(Map<String, String> parameterMap) {
		sqlsession.insert("kimjh.insertRequestLeave",parameterMap);
	}

	
	// 휴가 신청하면서 사용내역 업데이트 하기
	@Override
	public void plusUsedLeave(Map<String, String> parameterMap) {
		sqlsession.update("kimjh.plusUsedLeave",parameterMap);
	}


	// 연차 사용내역 업데이트 
	@Override
	public void plusUsedLeaveAnnual(Map<String, String> parameterMap) {
		sqlsession.update("kimjh.plusUsedLeaveAnnual",parameterMap);
	}

	// 반차 사용 내역 업데이트
	@Override
	public void plusUsedLeaveHalf_annual(Map<String, String> parameterMap) {
		sqlsession.update("kimjh.plusUsedLeaveHalf_annual",parameterMap);
	}


	// 휴가 사용 내역 조회하기
	@Override
	public List<Map<String, String>> getLeaveRecode(Map<String, String> paraMap) {
		List<Map<String, String>> leaveRecodeList = sqlsession.selectList("kimjh.getLeaveRecode", paraMap);
		return leaveRecodeList;
	}


	// 휴가 예정 내역 조회하기
	@Override
	public List<Map<String, String>> getLeavePlan(Map<String, String> paraMap) {
		List<Map<String, String>> leavePlanList = sqlsession.selectList("kimjh.getLeavePlan", paraMap);
		return leavePlanList;
	}

}
