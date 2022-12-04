package com.yolo.hr.jihyunModel;

import java.util.List;
import java.util.Map;

public interface InterAlarmDAO {

	// AOP 알람추가하기
	void addAlarm(String sql);

	// 알람 조회하기
	List<AlarmVO> getAlarmList(String empno);

}
