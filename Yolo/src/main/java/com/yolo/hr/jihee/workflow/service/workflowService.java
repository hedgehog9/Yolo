package com.yolo.hr.jihee.workflow.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yolo.hr.common.AES256;
import com.yolo.hr.common.FileManager;
import com.yolo.hr.jihee.workflow.model.InterWorkflowDAO;
import com.yolo.hr.jihee.workflow.model.approvalVO;
import com.yolo.hr.jihee.workflow.model.documentVO;

@Service
public class workflowService implements InterWorkflowService {

	// === #34. 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired // Type에 따라 알아서 Bean을 주입해준다.
	private InterWorkflowDAO dao;
	// Type 에 따라 Spring 컨테이너가 알아서 bean 으로 등록된 com.spring.board.model.BoardDAO 의 bean 을  dao 에 주입시켜준다. 
    // 그러므로 dao 는 null 이 아니다.
	
	// === #45. 양방향 암호화 알고리즘인 AES256 를 사용하여 복호화 하기 위한 클래스 의존객체 주입하기(DI: Dependency Injection) ===
   @Autowired
   private AES256 aes;
   // Type 에 따라 Spring 컨테이너가 알아서 bean 으로 등록된 com.spring.board.common.AES256 의 bean 을  aes 에 주입시켜준다. 
    // 그러므로 aes 는 null 이 아니다.
   // com.spring.board.common.AES256 의 bean 은 /webapp/WEB-INF/spring/appServlet/servlet-context.xml 파일에서 bean 으로 등록시켜주었음. 
	
	@Autowired
	private FileManager fileManager;

	// 결제라인 뽑아오기(승인,참조 대상자들)
	@Override
	public List<Map<String, String>> appList(Map<String, String> paraMap) {
		List<Map<String,String>> appList = dao.appList(paraMap);
		return appList;
	}

	//파일첨부 없는 경우 글쓰기(결제 상신까지)
	@Override
	public int add(documentVO docvo, Map<String, String> paraMap) {
		int result = 0; // 리턴값
		int n =0;
		
		//기안 번호 채굴
		int doc_no = dao.docno();
		docvo.setDoc_no(doc_no);
		
		//System.out.println("doc_co" + doc_no);
		
		if ("no".equals(paraMap.get("attach"))){
		//document 테이블에 기안문서 작성
			n = dao.add(docvo);	
		}
		
		else {
			n = dao.add__withFile(docvo);	
			
		}
		
		//approvla 테이블에  결제라인 수 많큼 insert 해주기
		if(n==1) {
			//알람 테이블 메소드 만들기
			
			// 결제할 사람 알아오기 
			List<Map<String,String>> appList = dao.appList(paraMap);
			int approval_cnt = appList.size(); 
			int m = 0;

			for(Map<String, String> appParamap : appList) {
				
				//문서번호 넣어주기
				appParamap.put("doc_no",String.valueOf(doc_no)); 
				
				//결재번호 채굴
				int approval_no = dao.appno();
				appParamap.put("app_no",String.valueOf(approval_no));
				//System.out.println("appno :" + approval_no);
				
				//결재 상신하기
				
				
					m += dao.addApproval(appParamap);

			
			}// end of for-------------
			
			if(m == approval_cnt) {
				result=1;
			}	
		}// end of if 
		
		return result;

	}

	//내문서함 리스트 가져오기
	@Override
	public List<Map<String, String>> getdocumentList(Map<String, String> paraMap) {
		List<Map<String,String>> documentList = dao.getdocumentList(paraMap);		
		return documentList;
	}

	//로드시 첫번째 문서번호 가져오기
	@Override
	public String getdoc_no(String empno) {
		String doc_no = dao.getdoc_no(empno);
		return doc_no;
	}

	//작성자인지 아닌지
	@Override
	public String checkWriter(Map<String, String> paraMap) {
		String writer = dao.checkWriter(paraMap);
		return writer;
	}

	//문서 자세히 가져오기
	@Override
	public Map<String, String> getDocDetail(Map<String, String> paraMap) {
		Map<String,String> docDetail = dao.getDocDetail(paraMap);
		return docDetail;
	}


	

	
	
}



