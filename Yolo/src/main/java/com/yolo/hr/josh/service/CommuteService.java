package com.yolo.hr.josh.service;


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
	
}
