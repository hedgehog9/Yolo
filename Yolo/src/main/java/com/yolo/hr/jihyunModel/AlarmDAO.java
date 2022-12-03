package com.yolo.hr.jihyunModel;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class AlarmDAO implements InterAlarmDAO {

	@Resource
	private SqlSessionTemplate sqlsession;

	// AOP 알람추가하기
	@Override
	public void addAlarm(String sql) {
		sqlsession.insert("kimjh.insertAlarm", sql);
	}

	// 알람 조회하기
	@Override
	public List<AlarmVO> getAlarmList(String empno) {
		List<AlarmVO> alarmList = sqlsession.selectList("kimjh.selectAlarm", empno);
		return alarmList;
	}
	
	// 알람 조회하기
	@Override
	public List<AlarmVO> getPastAlarmList(String empno) {
		List<AlarmVO> alarmList = sqlsession.selectList("kimjh.selectPastAlarm", empno);
		return alarmList;
	}

	// 알람 읽기
	@Override
	public void readAlarm(String alarmno) {
		sqlsession.update("kimjh.updateAlarm", alarmno);
	}
	
	// 모든 알람 읽기
	@Override
	public void readAllAlarm(String empno) {
		sqlsession.update("kimjh.updateAllAlarm", empno);
		
	}

}
