package com.yolo.hr.jihee.workflow.model;

import java.util.List;
import java.util.Map;

public interface InterWorkflowDAO {

	//참조할 사람 목록 알아오기
	List<Map<String, String>> appList(Map<String, String> paraMap);

}
