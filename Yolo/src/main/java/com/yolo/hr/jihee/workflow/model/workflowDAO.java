package com.yolo.hr.jihee.workflow.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;


@Repository
public class workflowDAO implements InterWorkflowDAO {

	
	@Resource
	private SqlSessionTemplate sqlsession; // 로컬 DB final_orauser2 에 연결
	// Type (클래스) 및 빈이름이 동일한 것을 찾아서 주입시켜준다

	@Override
	public List<Map<String, String>> appList(Map<String, String> paraMap) {
		List<Map<String,String>> appList = sqlsession.selectList("choijh.appList", paraMap);
		return appList;
	}
}
