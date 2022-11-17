package com.yolo.hr.josh.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yolo.hr.josh.model.InterScheduleDAO;
import com.yolo.hr.josh.model.MemberVO;

@Service
public class ScheduleService implements InterScheduleService {
	
	@Autowired
	private InterScheduleDAO dao;

	// 공유자 검색시 자동검색이 되는 기능
	@Override
	public List<MemberVO> searchJoinUserList(String joinuser) {
		List<MemberVO> searchJoinUserList = dao.searchJoinUserList(joinuser);
		return searchJoinUserList;
	}

}
