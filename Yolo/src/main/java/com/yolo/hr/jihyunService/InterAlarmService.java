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

}
