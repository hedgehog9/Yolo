package com.yolo.hr.josh.model;

import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class CommuteDAO implements InterCommuteDAO {

	@Resource
	private SqlSessionTemplate sqlsession;

	// 출근 메소드
	@Override
	public int commuteStart(String fk_empno) {
		int n = sqlsession.insert("josh.commuteStart",fk_empno);
		return n;
	}

	// 출근했는지 확인하는 메소드
	@Override
	public CommuteVO checkCommute(String fk_empno) {
		CommuteVO commentvo = sqlsession.selectOne("josh.checkCommute",fk_empno);
		return commentvo;
	}

	// 퇴근 메소드
	@Override
	public int commuteEnd(Map<String, String> paraMap) {
		int n = sqlsession.update("josh.commuteEnd",paraMap);
		return n;
	}
	
}
