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

	//진행중인 내문서함 리스트 가져오기
	List<Map<String, String>> getdocumentList(Map<String, String> paraMap);

	//로드시 첫번째 문서번호 가져오기
	String getdoc_no(String empno);

	//작성자인지 아닌지
	String checkWriter(Map<String, String> paraMap);

	//문서 자세히 가져오기
	Map<String, String> getDocDetail(Map<String, String> paraMap);
	
	//내 전단계 결제자 결제여부 알아오기
	String getPrestepApp(Map<String, String> paraMap);

	//승인,반려 상태 업데이트 시키기
	int updateApproval(Map<String, String> paraMap);

	//결제라인 이름 가져오기
	String getAppname(String doc_no);
	
	//내 문서함 리스트 가져오기
	List<Map<String, String>> getMydocumentList(Map<String, String> paraMap);

	//총 페이지수 알아오기
	int getTotalPage(Map<String, String> paraMap);

	//파일첨부가 되어진 댓글 1개에서 서버에 업로드 되어진 파일명과 오리지널 파일파일명을 조회해 주는것 
	documentVO getfilename(Map<String, String> paraMap);

	//진행중 총 게시물 수
	int getdocTotalCnt(Map<String, String> paraMap);

	//완료 게시물 수
	int getcomTotalCnt(Map<String, String> paraMap);
	//내 게시물 수
	int getmyTotalCnt(Map<String, String> paraMap);
	

}
