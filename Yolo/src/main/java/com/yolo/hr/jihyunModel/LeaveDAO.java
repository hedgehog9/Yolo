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


	// 하위 부서 번호 전부 알아오기
	@Override
	public List<String> getLowerDeptnoList(String fk_deptno) {
		List<String> lowerDeptnoList = sqlsession.selectList("kimjh.getLowerDeptnoList", fk_deptno);
		return lowerDeptnoList;
	}


	// 조회한 부서에 해당하는 사원들의 휴가 신청내역을 불러온다
	@Override
	public List<Map<String, String>> getRequestLeaveList(Map<String, String> paraMap) {
		List<Map<String,String>> requestLeaveList = sqlsession.selectList("kimjh.getRequestLeaveList", paraMap);
		return requestLeaveList;
	}


	// 조회한 부서에 해당하는 사원들의 휴가 사용/잔여 내역을 불러온다
	@Override
	public List<Map<String, String>> getLeaveStatusList(String deptJoin) {
		List<Map<String,String>> leaveStatusList = sqlsession.selectList("kimjh.getLeaveStatusList", deptJoin);
		return leaveStatusList;
	}


	// 관리자 사원번호 리스트 가져오기
	@Override
	public List<String> getAdminEmpnoList() {
		List<String> adminEmpnoList = sqlsession.selectList("kimjh.getAdminEmpnoList");
		return adminEmpnoList;
	}


	// 휴가신청 번호로 휴가신청 상세 조회
	@Override
	public Map<String, String> getLeaveRequestDetail(String request_leaveno) {
		Map<String, String> leaveRequestDetail = sqlsession.selectOne("kimjh.getLeaveRequestDetail", request_leaveno);
		return leaveRequestDetail;
	}


	// 휴가신청에 파일 추가 하기
	@Override
	public void addFileToRequestLeave(Map<String, String> paraMap) {
		sqlsession.update("kimjh.addFileToRequestLeave", paraMap);
	}


	//휴가신청 삭제하기
	@Override
	public void deleteRequestLeave(Map<String, String> leaveRequestDetail) {
		sqlsession.delete("kimjh.deleteRequestLeave", leaveRequestDetail);
	}

	// 휴가 신청 삭제하면서 사용 내역들도 같이 줄여주기
	@Override
	public void minusUsedLeaveAnnual(Map<String, String> leaveRequestDetail) {
		sqlsession.update("kimjh.minusUsedLeaveAnnual", leaveRequestDetail);
	}
	@Override
	public void minusUsedLeaveHalf_annual(Map<String, String> leaveRequestDetail) {
		sqlsession.update("kimjh.minusUsedLeaveHalf_annual", leaveRequestDetail);
	}
	@Override
	public void minusUsedLeave(Map<String, String> leaveRequestDetail) {
		sqlsession.update("kimjh.minusUsedLeave", leaveRequestDetail);
	}


	// 승인 / 반려하기 함수 
	@Override
	public void approvalRequestLevae(Map<String, String> leaveRequestDetail) {
		sqlsession.update("kimjh.approvalRequestLevae", leaveRequestDetail);
	}

}
