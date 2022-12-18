package com.yolo.hr.jihyunService;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yolo.hr.jihyunModel.InterLeaveDAO;

@Service
public class LeaveService implements InterLeaveService {
	
	@Autowired
	InterLeaveDAO ldao ;

	// 휴가 종류와 남은 일수 구해오기
	@Override
	public List<Map<String, String>> getLeaveTypeList(Map<String, String> paraMap) {
		List<Map<String, String>> leaveTypeList = ldao.getLeaveTypeList(paraMap);
		return leaveTypeList;
	}

	// 모달에 들어갈 해당 휴가에 대한 상세 내용 알아오기
	@Override
	public Map<String, String> getLeaveDate(Map<String, String> paraMap) {
		Map<String, String> leaveData = ldao.getLeaveDate(paraMap);
		return leaveData;
	}

	// 휴가 신청하기
	@Override
	public void requestLeave(Map<String, String> parameterMap) {
		ldao.requestLeave(parameterMap);
		
		// 휴가 신청하면서 휴가 사용내역 같이 업데이트 해주는건데, 연차나 반차일때는 따로 식써야 함
		if(parameterMap.get("pk_leave_type").equals("annual")) {
			ldao.plusUsedLeaveAnnual(parameterMap);
		} else if (parameterMap.get("pk_leave_type").equals("half_annual")) {
			ldao.plusUsedLeaveHalf_annual(parameterMap);
		} else {
			ldao.plusUsedLeave(parameterMap);
		}
		
	}

	
	// 휴가 사용 내역 조회하기
	@Override
	public List<Map<String, String>> getLeaveRecode(Map<String, String> paraMap) {
		List<Map<String, String>> leaveRecodeList = ldao.getLeaveRecode(paraMap);
		return leaveRecodeList;
	}

	
	// 휴가 예정 내역 조회하기
	@Override
	public List<Map<String, String>> getLeavePlan(Map<String, String> paraMap) {
		List<Map<String, String>> leavePlanList = ldao.getLeavePlan(paraMap);
		return leavePlanList;
	}
	
}
