package com.yolo.hr.josh.service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yolo.hr.josh.model.CommuteVO;
import com.yolo.hr.josh.model.InterCommuteDAO;

@Service
public class CommuteService implements InterCommuteService {

	@Autowired
	private InterCommuteDAO dao;

	// 출근 메소드
	@Override
	public int commuteStart(String fk_empno) {
		int n = dao.commuteStart(fk_empno);
		return n;
	}

	// 출근했는지 확인하는 메소드
	@Override
	public CommuteVO checkCommute(String fk_empno) {
		CommuteVO commentvo = dao.checkCommute(fk_empno);
		return commentvo;
	}

	// 퇴근 메소드
	@Override
	public int commuteEnd(Map<String, String> paraMap) {
		int n = dao.commuteEnd(paraMap);
		return n;
	}

	// 특정사원의 일주일 출근기록을 가져오는 메소드
	@Override
	public List<CommuteVO> mycommute(Map<String, String> paraMap) {
		List<CommuteVO> commuteList = dao.mycommute(paraMap);
		
		return commuteList;
	}

	// 사원들의 근무기록을 가져오는 메소드
	@Override
	public List<HashMap<String, String>> totalCommuteList(Map<String, Object> paraMap) {
		List<HashMap<String, String>> totalCommuteList = dao.totalCommuteList(paraMap);
		return totalCommuteList;
	}
	
}
