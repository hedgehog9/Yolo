package com.yolo.hr.jihee.workflow.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yolo.hr.jihee.workflow.model.documentVO;

public interface InterWorkflowService {
	
	//참조할 사람 목록 알아오기
	List<Map<String, String>> appList(Map<String, String> paraMap);

	//파일첨부 없는 경우 글쓰기
	int add(documentVO docvo, Map<String, String> paraMap);

	//내문서함 리스트 가져오기
	List<Map<String, String>> getdocumentList(Map<String, String> paraMap);

	//로드시 첫번째 문서번호 가져오기
	String getdoc_no(String empno);

	//작성자인지 아닌지
	String checkWriter(Map<String, String> paraMap);

	//문서 자세히 가져오기
	Map<String, String> getDocDetail(Map<String, String> paraMap);

	

}
