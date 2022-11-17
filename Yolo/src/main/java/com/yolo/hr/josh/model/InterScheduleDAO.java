package com.yolo.hr.josh.model;

import java.util.List;

public interface InterScheduleDAO {

	// 공유자 검색시 자동검색이 되는 기능
	List<MemberVO> searchJoinUserList(String joinuser);

}
