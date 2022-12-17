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
	
}
