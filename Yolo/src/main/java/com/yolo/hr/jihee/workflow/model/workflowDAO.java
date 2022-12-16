package com.yolo.hr.jihee.workflow.model;

import java.util.HashMap;
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

	//진행중인 내문서함 리스트 가져오기
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
	

	//내 전단계 결제자 결제여부 알아오기
	@Override
	public String getPrestep(Map<String, String> paraMap) {
		String prestepApp = sqlsession.selectOne("choijh.getPrestep",paraMap);
		return prestepApp;
	}

	//승인,반려 상태 업데이트 시키기
	@Override
	public int updateApproval(Map<String, String> paraMap) {
		int n = sqlsession.update("choijh.updateApproval",paraMap);
		return n;
	}
	
	//승인,반려 상태 업데이트 시키기(마지막 승인자)
	@Override
	public int updateAprroval_last(Map<String, String> appParamap) {
		int n = sqlsession.update("choijh.updateApproval_last",appParamap);
	return n;
	}
	
	// 마지막 결제 단계 알아오기
	@Override
	public int getLastlevelno(String doc_no) {
		int lastLevelno = sqlsession.selectOne("choijh.lastLevelno",doc_no);
		return lastLevelno;
	}

	//결제라인 이름 가져오기
	@Override
	public String getAppname(String doc_no) {
		String appName = sqlsession.selectOne("choijh.getAppname",doc_no);
		return appName;
	}

	//내 문서함 가져오기
	@Override
	public List<Map<String, String>> getMydocumentList(Map<String, String> paraMap) {
		List<Map<String,String>> mydocumentList = sqlsession.selectList("choijh.MydocumentList", paraMap);
		return mydocumentList;
	}

	//총 페이지수 알아오기
	@Override
	public int getTotalPage(Map<String, String> paraMap) {
		int totalPage = sqlsession.selectOne("choijh.getTotalPage", paraMap);
		return totalPage;
	}

	//파일첨부가 되어진 댓글 1개에서 서버에 업로드 되어진 파일명과 오리지널 파일파일명을 조회해 주는것 
	@Override
	public documentVO getfilename(Map<String, String> paraMap) {
		documentVO docvo = sqlsession.selectOne("choijh.getfilename", paraMap);
		return docvo;
	}
	
	// 총 게시물 수
	@Override
	public int getdocTotalCnt(Map<String, String> paraMap) {
		int documentList = sqlsession.selectOne("choijh.getdocTotalCnt", paraMap);
		return documentList;
	}

	// 완료 총 게시물 수
	@Override
	public int getcomTotalCnt(Map<String, String> paraMap) {
		int documentList = sqlsession.selectOne("choijh.getcomTotalCnt", paraMap);
		return documentList;
	}
	
	// 내 총 게시물 수
		@Override
		public int getmyTotalCnt(Map<String, String> paraMap) {
			int documentList = sqlsession.selectOne("choijh.getmyTotalCnt", paraMap);
			return documentList;
		}
	
	// 수정하기 
	@Override
	public int update(documentVO docvo) {
		int n = sqlsession.update("choijh.updateDoc",docvo);
		return n;
	}
	

	
	
	
}
