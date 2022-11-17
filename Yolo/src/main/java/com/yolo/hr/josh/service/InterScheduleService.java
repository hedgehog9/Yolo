package com.yolo.hr.josh.service;

import java.util.List;

import com.yolo.hr.josh.model.MemberVO;

public interface InterScheduleService {

	// 공유자 검색시 자동검색이 되는 기능
	List<MemberVO> searchJoinUserList(String joinuser);

}
