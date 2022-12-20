package com.yolo.hr.jihyunService;

import java.util.List;
import java.util.Map;

import com.yolo.hr.jihyunModel.AlarmDAO;
import com.yolo.hr.jihyunModel.AlarmVO;

public interface InterAlarmService {

	// AOP 알람추가하기
	void addAlarm(Map<String, String> paraMap);

	// 알람 조회하기
	List<AlarmVO> getAlarmList(String empno);
	
	// 지난 알람 조회하기
	List<AlarmVO> getPastAlarmList(String empno);

	// 알람 읽기
	void readAlarm(String alarmno);

	// 모든 알람 읽기
	void readAllAlarm(String empno);

	// 안 읽은 소식 개수 알아오기
	String getUnreadAlarmCnt(String empno);

}
