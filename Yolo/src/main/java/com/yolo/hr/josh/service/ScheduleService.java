package com.yolo.hr.josh.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yolo.hr.josh.model.InterScheduleDAO;
import com.yolo.hr.josh.model.MemberVO;
import com.yolo.hr.josh.model.ScheduleVO;

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

	// 켈린더에 일정을 등록하는 메소드
	@Override
	public int insertSchedule(ScheduleVO scvo) {
		int n = dao.insertSchedule(scvo);
		return n;
	}

	// 캘린더의 일정을 모두 가져오는 메소드
	@Override
	public List<ScheduleVO> selectScheduleList() {
		List<ScheduleVO> selectScheduleList = dao.selectScheduleList();
		return selectScheduleList;
	}

	// 특정 하나 켈린더를 가져오는 메소드
	@Override
	public ScheduleVO selectDetailSchedule(String schedule_no) {
		ScheduleVO scvo = dao.selectDetailSchedule(schedule_no);
		return scvo;
	}

	// 켈린더에 일정을 수정하는 메소드
	@Override
	public int updateSchedule(ScheduleVO scvo) {
		int n = dao.updateSchedule(scvo);
		return n;
	}

	// 캘린더를 삭제하는 메소드
	@Override
	public int deleteSchedule(String schedule_no) {
		int n = dao.deleteSchedule(schedule_no);
		return n;
	}

}
