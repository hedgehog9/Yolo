package com.yolo.hr.jihee.workflow.service;

import java.util.List;
import java.util.Map;

public interface InterWorkflowService {
	
	//참조할 사람 목록 알아오기
	List<Map<String, String>> appList(Map<String, String> paraMap);
	

}
