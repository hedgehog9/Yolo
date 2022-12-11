package com.yolo.hr.jihyunModel;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class LeaveDAO implements InterLeaveDAO {
	
	@Resource
	private SqlSessionTemplate sqlsession;

	// 휴가 종류와 남은 일수 구해오기
	@Override
	public List<Map<String, String>> getLeaveTypeList(Map<String, String> paraMap) {
		List<Map<String, String>> leaveTypeList = sqlsession.selectList("kimjh.selectLeaveType",paraMap);
		return leaveTypeList;
	}

}
