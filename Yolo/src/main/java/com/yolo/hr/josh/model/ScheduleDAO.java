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

	// 켈린더에 일정을 등록하는 메소드
	@Override
	public int insertSchedule(ScheduleVO scvo) {
		int n = sqlsession.insert("josh.insertSchedule", scvo);
		return n;
	}

	// 캘린더의 일정을 모두 가져오는 메소드
	@Override
	public List<ScheduleVO> selectScheduleList() {
		List<ScheduleVO> selectScheduleList = sqlsession.selectList("josh.selectScheduleList");
		return selectScheduleList;
	}

	// 특정 하나 켈린더를 가져오는 메소드
	@Override
	public ScheduleVO selectDetailSchedule(String schedule_no) {
		ScheduleVO scvo = sqlsession.selectOne("josh.selectDetailSchedule", schedule_no);
		return scvo;
	}

	// 켈린더에 일정을 수정하는 메소드
	@Override
	public int updateSchedule(ScheduleVO scvo) {
		int n = sqlsession.update("josh.updateSchedule", scvo);
		return n;
	}

	// 캘린더를 삭제하는 메소드
	@Override
	public int deleteSchedule(String schedule_no) {
		int n = sqlsession.delete("josh.deleteSchedule", schedule_no);
		return n;
	}

}
