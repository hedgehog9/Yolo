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
	
	//결제라인 뽑아오기(승인,참조) 
	@Override
	public List<Map<String, String>> appList(Map<String, String> paraMap) {
		List<Map<String,String>> appList = sqlsession.selectList("choijh.appList", paraMap);
		return appList;
	}

	//파일첨부 없는 경우 글쓰기
	@Override
	public int add(documentVO docvo) {
		int n = sqlsession.insert("choijh.add", docvo);
		return n;
	}
	
	//기안번호 채굴하기
	@Override
	public int docno() {
		int docno = sqlsession.selectOne("choijh.docno");
		return docno;
	}

	//결재번호 채굴하기
	@Override
	public int appno() {
		int appno = sqlsession.selectOne("choijh.appno");
		return appno;
	}

	//결재 라인에 기안문서 넣어주기(결재 상신하기)
	@Override
	public int addApproval(Map<String, String> appParamap) {
		int addApproval = sqlsession.insert("choijh.addApproval", appParamap);
		return addApproval;
	}

	//파일첨부 있는 경우 글쓰기
	@Override
	public int add__withFile(documentVO docvo) {
		int n = sqlsession.insert("choijh.add_withFile", docvo);
		return n;
	}

	//내문서함 리스트 가져오기
	@Override
	public List<Map<String, String>> getdocumentList(Map<String, String> paraMap) {
		List<Map<String,String>> documentList = sqlsession.selectList("choijh.documentList", paraMap);
		return documentList;
	}

	//로드시 첫번째 문서번호 가져오기
	@Override
	public String getdoc_no(String empno) {
		String doc_no = sqlsession.selectOne("choijh.getdoc_no", empno);
		return doc_no;
	}

	//작성자인지 아닌지
	@Override
	public String checkWriter(Map<String, String> paraMap) {
		String writer = sqlsession.selectOne("choijh.checkWriter",paraMap);
		return writer;
	}

	//문서 자세히 가져오기
	@Override
	public Map<String, String> getDocDetail(Map<String, String> paraMap) {
		Map<String,String> docDetail = sqlsession.selectOne("choijh.getDocDetail",paraMap);
		return docDetail;
	}
	
	
	
	
}
