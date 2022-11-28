package com.yolo.hr.josh.model;

import java.util.List;
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

	// 특정사원의 일주일 출근기록을 가져오는 메소드
	@Override
	public List<CommuteVO> mycommute(Map<String, String> paraMap) {
		List<CommuteVO> commuteList = sqlsession.selectList("josh.mycommute",paraMap);
		return commuteList;
	}
	
}
