package com.yolo.hr.jihee.workflow.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yolo.hr.common.AES256;
import com.yolo.hr.common.FileManager;
import com.yolo.hr.jihee.workflow.model.InterWorkflowDAO;

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

	@Override
	public List<Map<String, String>> appList(Map<String, String> paraMap) {
		List<Map<String,String>> appList = dao.appList(paraMap);
		return appList;
	}
	
}



