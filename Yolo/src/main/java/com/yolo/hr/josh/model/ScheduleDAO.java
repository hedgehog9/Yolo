package com.yolo.hr.josh.model;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ScheduleDAO implements InterScheduleDAO {

	@Resource
	private SqlSessionTemplate sqlsession;
	
	@Override
	public List<MemberVO> searchJoinUserList(String joinuser) {
		List<MemberVO> searchJoinUserList = sqlsession.selectList("josh.searchJoinUserList", joinuser);
		return searchJoinUserList;
	}

}
