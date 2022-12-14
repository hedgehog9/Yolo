package com.yolo.hr.josh.model;

import java.util.List;
import java.util.Map;

public interface InterScheduleDAO {

	// 공유자 검색시 자동검색이 되는 기능
	List<MemberVO> searchJoinUserList(String joinuser);

	// 켈린더에 일정을 등록하는 메소드
	int insertSchedule(ScheduleVO scvo);

	// 캘린더의 일정을 모두 가져오는 메소드
	List<ScheduleVO> selectScheduleList();

	// 특정 하나 켈린더를 가져오는 메소드
	ScheduleVO selectDetailSchedule(String schedule_no);

	// 켈린더에 일정을 수정하는 메소드
	int updateSchedule(ScheduleVO scvo);

	// 캘린더를 삭제하는 메소드
	int deleteSchedule(String schedule_no);

	// 시퀀스 넘버를 가져오는 메소드
	String getSequenceNo();

	// 휴가신청후 스케줄테이블에 등록하는 메소드
	void insertVactionSchedule(Map<String, String> paraMap);

}
