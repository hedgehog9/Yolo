package com.yolo.hr.jihee.workflowController;



import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.print.DocFlavor.STRING;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.formula.functions.Vlookup;
import org.json.JSONArray;
import org.json.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.yolo.hr.common.FileManager;
import com.yolo.hr.jihee.workflow.model.documentVO;
import com.yolo.hr.jihee.workflow.service.InterWorkflowService;
import com.yolo.hr.jjy.employee.model.EmployeeVO;



@Controller
public class WorkflowController {
	
	//service 주입
	@Autowired
	private InterWorkflowService service;
	
	//파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI : Dependency Injection) ===  
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value = "/workflow.yolo")
	public String viewWorkflow(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		//페이지 로드 첫번째 문서번호 알아오기(최신순)
		String empno = loginuser.getEmpno();	
		String doc_no = service.getdoc_no(empno);
		String no = "10";
		
		HashMap<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("emp_no", empno);
		
		request.setAttribute("empno", empno);
		if(!(doc_no == null)) {
			request.setAttribute("doc_no", doc_no);
		}
		
		else {
			request.setAttribute("doc_no", no);		
		}
		
		// empno 넘어오면 request 영역에 담아줘야 한다
				String alarmDocno = request.getParameter("doc_no"); 
	//			System.out.println("alarmDocno:" + alarmDocno);
				request.setAttribute("alarmDocno", alarmDocno);
				
		//진행중 게시물 총수
		int docTotalCnt = service.getdocTotalCnt(paraMap);		
		request.setAttribute("waitingTotalCnt", docTotalCnt);
		
		//완료 게시물 총수
		int comTotalCnt = service.getcomTotalCnt(paraMap);		
		request.setAttribute("completeTotalCnt", comTotalCnt );
		
		//내 문서한 게물 총수
		int myTotalCnt = service.getmyTotalCnt(paraMap);		
		request.setAttribute("myTotalCnt", myTotalCnt );
						
				
		return "jihee/content/document.workadmin";
	}
	
	@RequestMapping(value = "/cpworkflow.yolo")
	public String viewCpWorkflow(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		//페이지 로드 첫번째 문서번호 알아오기(최신순)
		String empno = loginuser.getEmpno();	
		String doc_no = service.getdoc_no(empno);
		String no = "10";
		
		HashMap<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("emp_no", empno);
		
		request.setAttribute("empno", empno);
		if(!(doc_no == null)) {
			request.setAttribute("doc_no", doc_no);
		}
		
		else {
			request.setAttribute("doc_no", no);		
		}
		
		// empno 넘어오면 request 영역에 담아줘야 한다
				String alarmDocno = request.getParameter("doc_no"); 
	//			System.out.println("alarmDocno:" + alarmDocno);
				request.setAttribute("alarmDocno", alarmDocno);
				
		//진행중 게시물 총수
		int docTotalCnt = service.getdocTotalCnt(paraMap);		
		request.setAttribute("waitingTotalCnt", docTotalCnt);
		
		//완료 게시물 총수
		int comTotalCnt = service.getcomTotalCnt(paraMap);		
		request.setAttribute("completeTotalCnt", comTotalCnt );
		
		//내 문서한 게물 총수
		int myTotalCnt = service.getmyTotalCnt(paraMap);		
		request.setAttribute("myTotalCnt", myTotalCnt );
						
				
		return "jihee/content/cpDocument.workadmin";
	}
	
	//문서 자세히 보기 ajax
	@ResponseBody
	@RequestMapping(value = "/workflow/documentDetail.yolo")
	public String documentDetail(HttpServletRequest request) {
		
		String empno = request.getParameter("emp_no");
		String doc_no = request.getParameter("doc_no");
		String nodoc = "10";
		
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("empno",empno);

		if(doc_no==null) {
			paraMap.put("doc_no", nodoc);
		}
		else {
			paraMap.put("doc_no", doc_no);
		}

		//작성자 인지 아닌지 구분하기
		String writer = service.checkWriter(paraMap);
		
		
		paraMap.put("writer",writer);
		JSONObject jsonObj = new JSONObject();
		
		//System.out.println("writer : " + writer);
		//문서 자세히 가져오기(작성자 or 작성자 아닐때 xml에서 처리)
		Map<String,String> docDetailMap = service.getDocDetail(paraMap);
		
		
		
		//결제라인 이름만 문자열로 가져오기
		String appName = service.getAppname(doc_no);
		
		/*
		 * String[] appNameList = appName.split(","); int finalCnt = appNameList.length;
		 */
		int finalCnt = 0;			
		if(appName != null) {
			jsonObj.put("appName", appName);
			String[] appNameList = appName.split(",");
			finalCnt = appNameList.length;
		
		}
	
//		System.out.println("doc_no:" + doc_no );
//		System.out.println("writer: " + writer);
//		System.out.println("map확인 : " +docDetailMap.get("doc_contents"));
//		System.out.println("map확인 : " +docDetailMap.get("doc_subject"));
		
		
		if(docDetailMap != null) { 
			
			
			//null 일떄 처리해주기
			String deptno = docDetailMap.get("fk_deptno");
		
			jsonObj.put("fk_writer_empno",docDetailMap.get("fk_writer_empno"));
			jsonObj.put("doc_no",docDetailMap.get("doc_no"));
			jsonObj.put("doc_subject",docDetailMap.get("doc_subject"));
			jsonObj.put("doc_contents",docDetailMap.get("doc_contents"));
			jsonObj.put("writeday",docDetailMap.get("writeday"));
			jsonObj.put("modificationday",docDetailMap.get("modificationday"));
			jsonObj.put("filename",docDetailMap.get("filename"));
			jsonObj.put("orgfilename",docDetailMap.get("orgfilename"));
			jsonObj.put("filesize",docDetailMap.get("filesize"));
			jsonObj.put("d_day",docDetailMap.get("d_day"));
			jsonObj.put("icon",docDetailMap.get("icon"));
			jsonObj.put("name",docDetailMap.get("name"));
			jsonObj.put("position",docDetailMap.get("position"));
			jsonObj.put("profile_color", docDetailMap.get("profile_color"));
			jsonObj.put("end_doc",docDetailMap.get("end_doc"));
			
			paraMap.put("deptno", docDetailMap.get("fk_deptno")); 
			int levelno = 1;
			
			
			String prestepApp = "0"; // 팀장인경우 (작성자도아니고 이전 결제자도 없는경우)
			if(writer==null) { // 작성자가 아닐 경우
				
				//내 결제단계에서 -1 이전사람 결제단계 알아오기 	
				levelno	= Integer.parseInt(docDetailMap.get("levelno"));
				int prelevelno = levelno -1;
				
				
				if(finalCnt < levelno) {
					levelno = levelno - 1;				
				}
				
				jsonObj.put("approval", docDetailMap.get("approval"));
				
				paraMap.put("prelevelno",Integer.toString(prelevelno));
				paraMap.put("deptno",deptno);
				
				
				//이전단계 반려 하나라도 있는경우 최종결재권자에게 결재권한 주기 
				List<Map<String,String>> appList = service.appList(paraMap);
				
			
				int approvalCnt = appList.size();
				boolean deny = false;
				
			
				if(finalCnt == Integer.parseInt(docDetailMap.get("levelno"))) {
					for(int i=0; i<approvalCnt; i++) {
						String approval = appList.get(i).get("approval");
						System.out.println("approval :" +approval);
						if(approval.equals("2")) {
							deny = true;
						}
					}
					
					jsonObj.put("deny", deny);
				}
				
				
			
				//System.out.println("approval :" + docDetailMap.get("approval"));
				
					//1단계 결제자가 아닐경우
					if(prelevelno != 0) {
					//내 전단계 결제자 결제여부 알아오기
					prestepApp =service.getPrestepApp(paraMap);
					//System.out.println("prestepApp : "+prestepApp);
						if(prestepApp == null ) {
							prestepApp = "1";
						}
					
					}
			}	
				
			else { //작성자 일 경우
				levelno = 1;

				
				prestepApp= "0";
			}
			
			
			//지금 몇단계 승인예정인지 알아오기
			String nowApprovalStep = service.getApprovalSetp(docDetailMap.get("doc_no"));
		
			
			
			///////////////////////// 단계 표시해주기//////////
			if (nowApprovalStep !=null) {
				
				//마지막 level 알아오기
				
				int lastLevelno = service.getlastLevelno(docDetailMap.get("doc_no"));
				
				
				int n = Integer.parseInt(nowApprovalStep);
				if(!(nowApprovalStep.equals(String.valueOf(lastLevelno)) ) ) {
					
					n= n+1;
					nowApprovalStep = String.valueOf(n);
				}
				
				if(finalCnt < n) {
					n = Integer.parseInt(nowApprovalStep);
					n= n-1;
					nowApprovalStep = String.valueOf(n);
					
				}
			
				
				
			}
			
			
			else {
				
				nowApprovalStep = "1";
			}
			
			
			jsonObj.put("nowApprovalStep", nowApprovalStep);
			jsonObj.put("levelno",levelno);
			jsonObj.put("prestepApp", prestepApp);
			//System.out.println("prestepApp : " +prestepApp);
			
			request.setAttribute("json", jsonObj.toString());
			
		
		}
		
		else {
			
			jsonObj.put("doc_no", doc_no);
			System.out.println("doc_no :" + doc_no);
		}
		
		//히스토리 가져오기 
		List<Map<String,String>> historyList = service.getHistory(docDetailMap.get("doc_no"));
		
		boolean historyFlag = false;
		if(historyList != null) {
			
			historyFlag = true;
			jsonObj.put("historyList", historyList);
			jsonObj.put("historyFlag", historyFlag);
			
		}
		
		
		
		return jsonObj.toString(); //"{n:1}"
	}
	
	//결제라인 알아오는 modal(모달)
	@ResponseBody
	@RequestMapping(value = "/workflow/modalApproval.yolo")
	public String getApprovalModal(HttpServletRequest request) {
		
		
		String empno = request.getParameter("emp_no");
		String doc_no = request.getParameter("doc_no");
		String nodoc = "10";
	//	System.out.println("emp_no :" +empno);
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("empno",empno);
		
		if(doc_no==null) {
			paraMap.put("doc_no", nodoc);
		}
		else {
			paraMap.put("doc_no", doc_no);
		}
		
		//작성자 인지 아닌지 구분하기
		String writer = service.checkWriter(paraMap);
		if(writer==null) {
			writer = "";		
		}
		paraMap.put("writer",writer);
		JSONArray jsonArr = new JSONArray();

		//문서 자세히 가져오기(작성자 or 아닐때 나뉨 xml에서 처리)
		Map<String,String> docDetailMap = service.getDocDetail(paraMap);
		int levelno = 5;

		if(docDetailMap != null) { 
			//null 일떄 처리해주기
			String deptno = docDetailMap.get("fk_deptno");
			paraMap.put("deptno", deptno);

			//참조 대상자들 알아오기
			List<Map<String,String>> appList = service.appList(paraMap);
			
			JSONObject jsonObj2 = new JSONObject();
			jsonObj2.put("end_doc", docDetailMap.get("end_doc"));
			
			if(appList !=null) {
				
			
				//지금 몇단계 승인예정인지 알아오기/////////////////////////
				String nowApprovalStep = service.getApprovalSetp(docDetailMap.get("doc_no"));
				
				if (nowApprovalStep !=null) {
					
					int lastLevelno = service.getlastLevelno(docDetailMap.get("doc_no"));
					
					
					int n = Integer.parseInt(nowApprovalStep);
					if(!(nowApprovalStep.equals(String.valueOf(lastLevelno)) ) ) {
						
						n= n+1;
						nowApprovalStep = String.valueOf(n);
					}
					
					if(appList.size() < n) {
						n = Integer.parseInt(nowApprovalStep);
						n= n-1;
						nowApprovalStep = String.valueOf(n);
						
					}	
					
					//JSONObject jsonObj3 = new JSONObject();
					
					
					
					
					
				}
				else {
					
					nowApprovalStep = "1";
				}
				
				/*
				 * for(Object json : jsonArr) {
				 * 
				 * System.out.println("jsonArr1 : " + json); }
				 */
				
				jsonObj2.put("nowApprovalStep", nowApprovalStep);
				jsonArr.put(jsonObj2);
				////////////////////////////////////////////
				
				
				for(Map<String,String> approvalModal: appList) {
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("levelno", approvalModal.get("levelno"));
					jsonObj.put("name", approvalModal.get("name"));
					jsonObj.put("position", approvalModal.get("position"));
					jsonObj.put("profile_color", approvalModal.get("profile_color"));
					jsonObj.put("deptname", approvalModal.get("deptname"));
					jsonObj.put("approval", approvalModal.get("approval"));
					if(approvalModal.get("approval_day")==null) {
						jsonObj.put("approval_day", "12345678910123445");
					    
					}
					else {
					jsonObj.put("approval_day", approvalModal.get("approval_day"));
					}
					jsonObj.put("approval_no", approvalModal.get("approval_no"));
					jsonArr.put(jsonObj);	
					
					
					//System.out.println("jsonArr2 : " + jsonArr);
				}	
				
				
			}
		}
		
		return jsonArr.toString(); //"{n:1}"
	}
	
	//문서 승인,반려 ajax
	@ResponseBody
	@RequestMapping(value = "/workflow/approval.yolo")
	public String approvalDu(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO)session.getAttribute("loginuser");
		
		String approvalNo = request.getParameter("approval");
		String doc_no = request.getParameter("doc_no");
		String levelno = request.getParameter("levelno");
		String empno = loginuser.getEmpno();
		String deptno = loginuser.getFk_deptno();
		
	//	System.out.println("leveno : " +levelno);
		
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("approvalNo", approvalNo);
		paraMap.put("doc_no", doc_no);
		paraMap.put("empno", empno);
		paraMap.put("deptno", deptno);
		paraMap.put("levelno",levelno);
		
		System.out.println( "deptno : " +empno);
		//승인,반려 상태 업데이트 시키기
		int n = service.updateApproval(paraMap);
		//System.out.println("n :" + n);
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("doc_no", doc_no);
		jsonObj.put("empno", empno);
		jsonObj.put("n", n);
		
		
		//System.out.println("approval : " + approval);
		//System.out.println("doc_no :" + doc_no);
		
		
		
		
		
		return jsonObj.toString();
	}
	
	
	@RequestMapping(value = "/cpWorkflow.yolo")
	public String viewCpWorkflow() {
		
		return "jihee/content/cpDocument.admin";
	}
	
	@RequestMapping(value = "/workflow/selectWrite.yolo")
	public String selectWriteWorkflow() {
		
		
		return "jihee/content/selectWrite.admin";
	}
	
	//글 작성하기 폼페이지 요청
	@RequestMapping(value = "/workflow/write.yolo")
	public String writeWorkflow( HttpServletRequest request) {
		
		String subject = request.getParameter("subject");
		String icon = request.getParameter("icon");
		String information = request.getParameter("information");
		String guide_form = request.getParameter("guide_form");
		
		//System.out.println(guide_form);
		request.setAttribute("subject", subject);
		request.setAttribute("icon", icon);
		request.setAttribute("information", information);
		request.setAttribute("guide_form", guide_form);
		
		//세션 값 받아오기 
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		//null 일떄 처리해주기
		String deptno = loginuser.getFk_deptno();
		String empno = loginuser.getEmpno();
		
		if(!(deptno == null)) {
		//System.out.println("emono :" + deptno);
		Map<String,String> paraMap = new HashMap<>();		
		paraMap.put("deptno", deptno);
		paraMap.put("empno", empno);
		String doc_no = null;
		paraMap.put("doc_no", doc_no);
		
		//참조 대상자들 알아오기
		List<Map<String,String>> appList = service.appList(paraMap);
		
		request.setAttribute("appList", appList);
		request.setAttribute("empno", empno);
		request.setAttribute("deptno", deptno);
		
		
		
		//list안의 map 출력
		
//		  for(int i = 0; i < appList.size(); i++){ //arraylist 사이즈 만큼 for문을 실행합니다.
//		  System.out.println("list 순서 " + i + "번쨰"); for( Entry<String, String> map :
//		  appList.get(i).entrySet() ){ // list 각각 hashmap받아서 출력합니다. 
//	      System.out.println(String.format("키 : %s, 값 : %s", map.getKey(), map.getValue()) ); } }
		
//		  for(int i = 0; i < appList.size(); i++){ //arraylist 사이즈 만큼 for문을 실행합니다.
//			 
//				System.out.println( "levelno :" + appList.get(i).get("levelno"));
//			  }

		
		}

		return "jihee/content/write.admin";
	}
	
	// 글작성하기 완료 요청
	@RequestMapping(value = "workflow/writeEnd.yolo", method= {RequestMethod.POST})
	public ModelAndView addAlarm_writeEnd(Map<String, String> paraMap, ModelAndView mav, MultipartHttpServletRequest mrequest, documentVO docvo) {
	/*
	    form 태그의 name 명과  BoardVO 의 필드명이 같다라면 
	    request.getParameter("form 태그의 name명"); 을 사용하지 않더라도
	        자동적으로 documentVO docVO 에 set 되어진다.
	*/	
		
	/*
	      웹페이지에 요청 form이 enctype="multipart/form-data" 으로 되어있어서 Multipart 요청(파일처리 요청)이 들어올때 
	      컨트롤러에서는 HttpServletRequest 대신 MultipartHttpServletRequest 인터페이스를 사용해야 한다.
	   MultipartHttpServletRequest 인터페이스는 HttpServletRequest 인터페이스와  MultipartRequest 인터페이스를 상속받고있다.
           즉, 웹 요청 정보를 얻기 위한 getParameter()와 같은 메소드와 Multipart(파일처리) 관련 메소드를 모두 사용가능하다.  	
	 */		
		
		/* 데이터확인
	  String doc_dontents= docvo.getDoc_contents();
	  System.out.println("doc_dontents : " + doc_dontents); 
	  String doc_date= docvo.getD_day(); 
	  System.out.println("date : " + doc_date);
	  String doc_subject= docvo.getDoc_subject(); 
	  System.out.println("doc_subject : " + doc_subject);
	 */ 
	

	 
	// === #153. !!! 첨부파일이 있는 경우 작업 시작 !!! === //
		MultipartFile attach = docvo.getAttach();
		HttpSession session = mrequest.getSession();
		if( !attach.isEmpty() ) {
			// attach(첨부파일)가 비어 있지 않으면(즉, 첨부파일이 있는 경우라면)
			
			/*
			   1. 사용자가 보낸 첨부파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다. 
			   >>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
			              우리는 WAS의 webapp/resources/files 라는 폴더로 지정해준다.
			              조심할 것은  Package Explorer 에서  files 라는 폴더를 만드는 것이 아니다.       
			*/
			// WAS 의 webapp 의 절대경로를 알아와야 한다.
			
			String root = session.getServletContext().getRealPath("/");
			
	//		System.out.println("~~~~ 확인용 webapp 의 절대경로 => " + root);
	//		~~~~ 확인용 webapp 의 절대경로 => C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\
 
			String path =  "C:\\Users\\sist\\git\\Yolo\\Yolo\\src\\main\\webapp\\files"+File.separator+"workflow";
			/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
		              운영체제가 Windows 이라면 File.separator 는  "\" 이고,
		              운영체제가 UNIX, Linux, 매킨토시(맥) 이라면  File.separator 는 "/" 이다. 
		    */
			
			
			// path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
	//		System.out.println("~~~~ 확인용 path => " + path);
			// ~~~~ 확인용 path => C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files  
			
			
			/*
			   2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기
			*/
			String newFileName = "";
			// WAS(톰캣)의 디스크에 저장될 파일명 
			
			byte[] bytes = null;
			// 첨부파일의 내용물을 담는 것
			
			long fileSize = 0;
			// 첨부파일의 크기 
			
			try {
				bytes = attach.getBytes();
				// 첨부파일의 내용물을 읽어오는 것
				
				String originalFilename = attach.getOriginalFilename();
				// attach.getOriginalFilename() 이 첨부파일명의 파일명(예: 강아지.png) 이다. 
			//	System.out.println("~~~~ 확인용 originalFilename => " + originalFilename); 
			//	~~~~ 확인용 originalFilename => LG_싸이킹청소기_사용설명서.pdf
				
				
				newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
				//첨부되어진 파일을 업로드 하도록 하는 것이다.
				
				
			//	System.out.println("~~~~ 확인용 newFilename => " + newFileName); 
				// ~~~~ 확인용 newFilename => 20221028152541761482360123200.pdf
				
				/*
				 3. BoardVO boardvo 에   fileName 값과 orgFilename 값과 fileSize 값을 넣어주기	  
				 */
				
				docvo.setFileName(newFileName);
				// WAS(톰캣)에 저장된 파일명(20221028152541761482360123200.pdf)
				
				docvo.setOrgFilename(originalFilename);
				// 게시판 페이지에서 첨부된 파일(강아지.png)을 보여줄 때 사용.
	            // 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.
				//  LG_싸이킹청소기_사용설명서.pdf
				
				fileSize = attach.getSize();// 첨부파일의 크기(단위는 byte임) 만들어져있는 메소드인듯
				docvo.setFileSize(String.valueOf(fileSize));
				
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		// === !!! 첨부파일이 있는 경우 작업 끝 !!! === //
		
		int n = 0;
		
		
		paraMap.put("deptno", String.valueOf(docvo.getDeptno()));
		paraMap.put("empno", docvo.getFk_writer_empno());
		
		//줄바꿈 적용시키기
		String doc_contents = docvo.getDoc_contents();
		doc_contents=doc_contents.replace("\r\n","<br>");
		docvo.setDoc_contents(doc_contents);
				
		
		if(attach.isEmpty() ) {
			//파일첨부가 없는 글쓰기인 경우		
			paraMap.put("attach", "no");
		}
		else {
			//파일첨부가 있는 글쓰기인 경우
			//n = service.add_withFile(docvo, paraMap);
			paraMap.put("attach", "yes");
		}
		
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		String name = loginuser.getName();
		docvo.setName(name);
		
		//글 작성하기
		int doc_no = service.add(docvo,paraMap);
		
		
		if( !(Integer.toString(doc_no)==null) ) {
			mav.setViewName("redirect:/workflow.yolo");
		}
		
		List<String> alarmList = new ArrayList<String>();
		
		//참조 대상자들 알아오기
		List<Map<String,String>> appList = service.appList(paraMap);
		
		for(int i=0; i<appList.size(); i++) {
			
			 String alaramMap = appList.get(i).get("FK_EMPNO");
			 alarmList.add(alaramMap);
					 
		}
		  String fk_empno = String.join(",", alarmList);
		  
		
	
		
		
		// === AOP After Advice를 사용하기 === //
		paraMap.put("fk_recipientno", fk_empno ); // 받는사람 (여러명일때는 ,으로 구분된 str)
		paraMap.put("url", "/workflow.yolo?doc_no=");
		paraMap.put("url2", Integer.toString(doc_no) ); // 연결되는 pknum등...  (여러개일때는 ,으로 구분된 str)(대신 받는 사람 수랑 같아야됨)
		paraMap.put("alarm_content", loginuser.getName()+"님이 기안문서를 작성하였습니다." );
		paraMap.put("alarm_type", "3" );
		
		
		return mav;
	}
	
	// 수정하기
	@RequestMapping(value = "/workflow/modify.yolo")
	public String modifyWorkflow(HttpServletRequest request, documentVO docvo) {

		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		String deptno = loginuser.getFk_deptno();
		String empno = loginuser.getEmpno();
		
		String writer_empno = request.getParameter("fk_writer_empno");
		String doc_no = request.getParameter("doc_no");
	
		
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("empno",empno);
		paraMap.put("doc_no", doc_no);
		paraMap.put("deptno", deptno);
	

		//참조 대상자들 알아오기
		List<Map<String,String>> appList = service.appList(paraMap);
		
		boolean flag = true;
		for(int i=0; i<appList.size(); i++) {
			
			 String approval = appList.get(i).get("approval"); 
			 if(approval.equals("1") || approval.equals("2")) {
				 flag = false;
			 }			 
		//	 System.out.println("approval : " +approval);
		//	 System.out.println("flag : "  +flag);
		}
		
		if(empno.equals(writer_empno) && flag ){
			//System.out.println("if empno :" +empno +"writer_empno :" +writer_empno );
			paraMap.put("writer","do");
		
			//문서 알아오기
			Map<String,String> docDetailMap = service.getDocDetail(paraMap);
			String subject = docDetailMap.get("doc_subject");
			String contents = docDetailMap.get("doc_contents");
			String icon = docDetailMap.get("icon");
			String orgfilename = docDetailMap.get("orgfilename");
			String d_day = docDetailMap.get("d_day");
			String name = docDetailMap.get("name");
			
			
			docvo.setDoc_no(Integer.parseInt(docDetailMap.get("doc_no")));
			
			paraMap.put("contents", contents );
			
			
			//줄바꿈 적용시키기
			contents=contents.replace("<br>","\r\n");
			
			request.setAttribute("appList", appList);
			request.setAttribute("subject", subject);
			request.setAttribute("icon", icon);
			request.setAttribute("orgfilename", orgfilename);
			request.setAttribute("d_day", d_day);
			request.setAttribute("contents", contents);
			request.setAttribute("doc_no", doc_no);
			request.setAttribute("name", name);
			
			
			return "jihee/content/modify.admin";
		
		}
		
		else if(!(empno.equals(writer_empno))) {
			
			String message = "본인이 쓴 글이 아니면 수정이 불가합니다 ";
			String loc = request.getContextPath() + "/workflow.yolo";
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			return "/msg";
		}
		
		else {
			String message = "이미 결재가 시작되어 수정이 불가합니다.";
			String loc = request.getContextPath() + "/workflow.yolo";
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			return "/msg";
			
		}
		
		


	}
	
	// 수정하기 종료
		@RequestMapping(value = "/workflow/modifyEnd.yolo")
		public String modifyWorkflowEnd(HttpServletRequest request, documentVO docvo) {
			
			//수정하기
			int n = service.upateDoc(docvo);
			
			if( n == 1 ) {
				return "redirect:/workflow.yolo";
			}
			else {
				String message = "수정 실패했습니다.";
				String loc = request.getContextPath() + "/workflow.yolo";
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				return "/msg";
			}
			
			
		}
	
	//내문서함 글 목록 보여주기 (ajax)
	@ResponseBody
	@RequestMapping(value = "/workflow/myDocument_dm.yolo", method = {RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	public String myDcument_dm(HttpServletRequest request ) {
		

		
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		
		//세션값 가져오기
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		String empno = loginuser.getEmpno();
		//System.out.println("empno:" +empno);
		
		
		if(currentShowPageNo == null) { //초기값은 1이다
			currentShowPageNo = "1";
		}
		
		int sizePerPage = 10; // 한페이지당 보여줄 게시물 건수
		
		/*
	     currentShowPageNo      startRno     endRno
	    --------------------------------------------
	         1 page        ===>    1           10
	         2 page        ===>    11          20
	         3 page        ===>    21          30
	         4 page        ===>    31          40
	         ......                ...         ...
	 */
		
		int startRno = ((Integer.parseInt(currentShowPageNo) - 1) ) *sizePerPage +1;
		int endRno = startRno + sizePerPage - 1 ;
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
		paraMap.put("emp_no", empno);
		
		List<Map<String,String>> myDocumentList = service.getMydocumentList(paraMap);
		
		JSONArray jsonArr = new JSONArray(); // []
		// 리스트 개수 알아오기
		int listSize = myDocumentList.size();
		request.setAttribute("mylistSize", listSize);
		JSONObject jsonObj2 = new JSONObject();
		jsonObj2.put("mylistSize", listSize);
		jsonArr.put(jsonObj2);
					
				
//		 for(int i = 0; i < documentList.size(); i++){ //arraylist 사이즈 만큼 for문을 실행합니다.
//			 
//				System.out.println( "documentList :" + documentList.get(i));
//			  }
		
		
		
		
		if(myDocumentList !=null) {
			
			for(Map<String,String> docListmap: myDocumentList) {
				JSONObject jsonObj = new JSONObject();
				String doc_contents = docListmap.get("doc_contents");
				// 엔터값 처리해주기
				int index = doc_contents.indexOf("<br>");
	
				if(index != -1) {
					doc_contents = doc_contents.substring(0,doc_contents.indexOf("<br>"));		
				}
				
				jsonObj.put("doc_subject", docListmap.get("doc_subject"));
				jsonObj.put("doc_contents", docListmap.get("doc_contents"));
				jsonObj.put("writeday", docListmap.get("writeday"));
				//jsonObj.put("modificationday", docListmap.get("modificationday"));
				
				jsonObj.put("filename", docListmap.get("filename"));
				jsonObj.put("orgfilename", docListmap.get("orgfilename"));
				jsonObj.put("filesize", docListmap.get("filesize"));
				
				jsonObj.put("d_day", docListmap.get("d_day"));
				//jsonObj.put("approval_day", docListmap.get("approval_day"));
				//jsonObj.put("approval", docListmap.get("approval"));
				jsonObj.put("name", docListmap.get("name"));
				jsonObj.put("doc_no", docListmap.get("doc_no"));
				jsonObj.put("emp_no", empno);
				jsonObj.put("end_Doc", docListmap.get("end_doc"));
				
				//System.out.println("endDOC : "+docListmap.get("end_doc"));
				
				jsonArr.put(jsonObj);
			}// end of for----------------------
			
			
		}
		
		else {
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("doc_no", "10");
			jsonObj.put("emp_no", "1");
			jsonArr.put(jsonObj);
		}
		
		return jsonArr.toString(); // "[]" 또는 "[{},}{],{}]"
	
	}
		
	//진행중인 문서함 글 목록 보여주기 (ajax)
	@ResponseBody
	@RequestMapping(value = "/workflow/watingDm.yolo")
	public String watingDm(HttpServletRequest request, EmployeeVO empvo) {
		

		String currentShowPageNo = request.getParameter("currentShowPageNo");
		
		//세션값 가져오기
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		String empno = loginuser.getEmpno();
		//System.out.println("empno:" +empno);
		
		
		if(currentShowPageNo == null) { //초기값은 1이다
			currentShowPageNo = "1";
		}
		
		int sizePerPage = 10; // 한페이지당 보여줄 게시물 건수
		
		/*
	     currentShowPageNo      startRno     endRno
	    --------------------------------------------
	         1 page        ===>    1           10
	         2 page        ===>    11          20
	         3 page        ===>    21          30
	         4 page        ===>    31          40
	         ......                ...         ...
	 */
		
		int startRno = ((Integer.parseInt(currentShowPageNo) - 1) ) *sizePerPage +1;
		int endRno = startRno + sizePerPage - 1 ;
		
		
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
		paraMap.put("emp_no", empno);
		paraMap.put("end_doc", "0");
		
		// 진행중인  ,완료 구분법 : 문서 리스트뽑을때 마지막 level이 3이 아니면 아래거 실행 
		
		List<Map<String,String>> documentList = service.getdocumentList(paraMap);
		
		JSONArray jsonArr = new JSONArray(); // []
		
		// 리스트 개수 알아오기
		int listSize = documentList.size();

		request.setAttribute("waitinglistSize", listSize);
		JSONObject jsonObj2 = new JSONObject();
		jsonObj2.put("waitinglistSize", listSize);
		jsonArr.put(jsonObj2);
		

		//내가 마지막 레벨이면 approval = 0 인것만, 완료문서함에서는 approval =1인것만 뽑기

//		 for(int i = 0; i < documentList.size(); i++){ //arraylist 사이즈 만큼 for문을 실행합니다.
//			 
//				System.out.println( "documentList :" + documentList.get(i));
//			  }
		

		if(documentList !=null) {
			

			String prestepApp = "0"; // 팀장인경우 (작성자도아니고 이전 결제자도 없는경우)
			
			for(Map<String,String> docListmap: documentList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("doc_subject", docListmap.get("doc_subject"));
				
				String doc_contents = docListmap.get("doc_contents");
				
				// 엔터값 처리해주기
				int index = doc_contents.indexOf("<br>");
	
				if(index != -1) {
					doc_contents = doc_contents.substring(0,doc_contents.indexOf("<br>"));		
				}
				
				//System.out.println("doc_contents :" + doc_contents);
				
				jsonObj.put("doc_contents", doc_contents);
				jsonObj.put("writeday", docListmap.get("writeday"));
				jsonObj.put("modificationday", docListmap.get("modificationday"));
				
				jsonObj.put("filename", docListmap.get("filename"));
				jsonObj.put("orgfilename", docListmap.get("orgfilename"));
				jsonObj.put("filesize", docListmap.get("filesize"));
				
				jsonObj.put("d_day", docListmap.get("d_day"));
				jsonObj.put("approval_day", docListmap.get("approval_day"));
				jsonObj.put("approval", "0");
				jsonObj.put("levelno", "0");
				jsonObj.put("name", docListmap.get("name"));
				jsonObj.put("doc_no", docListmap.get("doc_no"));
				jsonObj.put("emp_no", empno);
				
				paraMap.put("empno", empno);
				paraMap.put("doc_no", docListmap.get("doc_no"));
				//작성자 인지 아닌지 구분하기
				String writer = service.checkWriter(paraMap);				
				
				paraMap.put("writer",writer);
				paraMap.put("doc_no", docListmap.get("doc_no"));
				Map<String,String> docDetailMap = service.getDocDetail(paraMap);
				
				paraMap.put("deptno",docListmap.get("fk_deptno"));
				
				//이전단계 반려 하나라도 있는경우 최종결재권자에게 결재권한 주기 ///////////////////////////
				List<Map<String,String>> appList = service.appList(paraMap);
				int approvalCnt = appList.size();
				boolean deny = false;
				
				
			
				
				
				if(writer==null) { // 작성자가 아닐 경우
				//내 결제단계에서 -1 이전사람 결제단계 알아오기 	
				int levelno	= Integer.parseInt(docDetailMap.get("levelno"));
				int prelevelno = levelno -1;
				jsonObj.put("levelno",levelno);
				jsonObj.put("approval", docDetailMap.get("approval"));
				
	
				paraMap.put("prelevelno",Integer.toString(prelevelno));
				//paraMap.put("deptno",docListmap.get("fk_deptno"));
				
				//결제라인 이름만 문자열로 가져오기
				String appName = service.getAppname(docListmap.get("doc_no"));
				
				//String[] appNameList = appName.split(",");
				int finalCnt =0;
							
				if(appName != null) {
					jsonObj.put("appName", appName);
					String[] appNameList = appName.split(",");
					finalCnt = appNameList.length;
				}
				
				if(finalCnt == Integer.parseInt(docDetailMap.get("levelno"))) {
					for(int i=0; i<approvalCnt; i++) {
						String approval = appList.get(i).get("approval");
						if(approval.equals("2")) {
							deny = true;
						}
					}
					
					jsonObj.put("deny", deny);
				}
				///////////////////////////////////////////////////////////////
				
					//1단계 결제자가 아닐경우
					if(prelevelno != 0 ) {
					//내 전단계 결제자 결제여부 알아오기
					prestepApp =service.getPrestepApp(paraMap);
					
					//System.out.println("name : " + docListmap.get("name"));
					//System.out.println("prestepApp : " +prestepApp);
						if(prestepApp == null ) {
							prestepApp = "1";
						}
					
					}
				}
				
				jsonObj.put("prestepApp",prestepApp);
				jsonArr.put(jsonObj);
			}// end of for----------------------
			
			
		}
		
		else {
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("doc_no", "10");
			jsonObj.put("emp_no", "1");
			jsonArr.put(jsonObj);
			
		}
		
		return jsonArr.toString(); // "[]" 또는 "[{},}{],{}]"
	
	}
	
	//완료된 문서함 글 목록 보여주기 (ajax)
	@ResponseBody
	@RequestMapping(value = "/workflow/completeDm.yolo")
	public String completeDm(HttpServletRequest request, EmployeeVO empvo) {
		

		String currentShowPageNo = request.getParameter("currentShowPageNo");
		
		//세션값 가져오기
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		String empno = loginuser.getEmpno();
		//System.out.println("empno:" +empno);
		
		
		if(currentShowPageNo == null) { //초기값은 1이다
			currentShowPageNo = "1";
		}
		
		int sizePerPage = 10; // 한페이지당 보여줄 게시물 건수
		
		/*
	     currentShowPageNo      startRno     endRno
	    --------------------------------------------
	         1 page        ===>    1           10
	         2 page        ===>    11          20
	         3 page        ===>    21          30
	         4 page        ===>    31          40
	         ......                ...         ...
	 */
		
		int startRno = ((Integer.parseInt(currentShowPageNo) - 1) ) *sizePerPage +1;
		int endRno = startRno + sizePerPage - 1 ;
		
		
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
		paraMap.put("emp_no", empno);
		paraMap.put("end_doc", "1");
		
		List<Map<String,String>> documentList = service.getdocumentList(paraMap);
		

		JSONArray jsonArr = new JSONArray(); // []
		// 리스트 개수 알아오기
		int listSize = documentList.size();
		request.setAttribute("completelistSize", listSize);
		JSONObject jsonObj2 = new JSONObject();
		jsonObj2.put("completelistSize", listSize);
		jsonArr.put(jsonObj2);
		
		if(documentList !=null) {
			

			String prestepApp = "0"; // 팀장인경우 (작성자도아니고 이전 결제자도 없는경우)
			
			for(Map<String,String> docListmap: documentList) {
				JSONObject jsonObj = new JSONObject();
				
				String doc_contents = docListmap.get("doc_contents");
				// 엔터값 처리해주기
				int index = doc_contents.indexOf("<br>");
	
				if(index != -1) {
					doc_contents = doc_contents.substring(0,doc_contents.indexOf("<br>"));		
				}
				jsonObj.put("doc_subject", docListmap.get("doc_subject"));
				jsonObj.put("doc_contents", docListmap.get("doc_contents"));
				jsonObj.put("writeday", docListmap.get("writeday"));
				jsonObj.put("modificationday", docListmap.get("modificationday"));
				
				jsonObj.put("filename", docListmap.get("filename"));
				jsonObj.put("orgfilename", docListmap.get("orgfilename"));
				jsonObj.put("filesize", docListmap.get("filesize"));
				
				jsonObj.put("d_day", docListmap.get("d_day"));
				jsonObj.put("approval_day", docListmap.get("approval_day"));
				jsonObj.put("approval", docListmap.get("approval"));
				jsonObj.put("name", docListmap.get("name"));
				jsonObj.put("doc_no", docListmap.get("doc_no"));
				jsonObj.put("emp_no", empno);
				
				paraMap.put("empno", empno);
				paraMap.put("doc_no", docListmap.get("doc_no"));
				//작성자 인지 아닌지 구분하기
				String writer = service.checkWriter(paraMap);				
				
				paraMap.put("writer",writer);
				paraMap.put("doc_no", docListmap.get("doc_no"));
				Map<String,String> docDetailMap = service.getDocDetail(paraMap);
				
				if(writer==null) { // 작성자가 아닐 경우
				//내 결제단계에서 -1 이전사람 결제단계 알아오기 	
				int levelno	= Integer.parseInt(docDetailMap.get("levelno"));
				int prelevelno = levelno -1;
				jsonObj.put("levelno",levelno);
				jsonObj.put("approval", docDetailMap.get("approval"));
				
				paraMap.put("prelevelno",Integer.toString(prelevelno));
				paraMap.put("deptno",docListmap.get("fk_deptno"));
				
					//1단계 결제자가 아닐경우
					if(prelevelno != 0 ) {
					//내 전단계 결제자 결제여부 알아오기
					prestepApp =service.getPrestepApp(paraMap);
					
					//System.out.println("name : " + docListmap.get("name"));
					//System.out.println("prestepApp : " +prestepApp);
						if(prestepApp == null ) {
							prestepApp = "1";
						}
					
					}
				}	
				
				jsonObj.put("prestepApp",prestepApp);
			
				jsonArr.put(jsonObj);
			}// end of for----------------------
			
			
		}
		
		else {
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("doc_no", "10");
			jsonObj.put("emp_no", "1");
			jsonArr.put(jsonObj);
		}
		
		return jsonArr.toString(); // "[]" 또는 "[{},}{],{}]"
	
	}
	
	
	// === #132. totalPage 수를 알아오기(Ajax 처리)=== //
		@ResponseBody
		@RequestMapping(value = "/getTotalPage.yolo", method = {RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
		public String getTotalPage(HttpServletRequest request) {
			
		
			
			String sizePerPage = request.getParameter("sizePerPage");
			

			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("sizePerPage", sizePerPage);
			paraMap.put("end_doc","0");
			
			//세션값 가져오기
			HttpSession session = request.getSession();
			EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
			String empno = loginuser.getEmpno();
			paraMap.put("empno",empno);
			
			// 원글 글번호(parentSeq)에 해당하는 댓글의 totalPage 수 알아오기
			int totalPage = service.getTotalPage(paraMap);
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("totalPage", totalPage); // {"totalPAge":3}
			
			
			return jsonObj.toString();
		}
		
// === #132. totalPage 수를 알아오기(Ajax 처리)=== //
		@ResponseBody
		@RequestMapping(value = "/getTotalPageCom.yolo", method = {RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
		public String getTotalPagecom(HttpServletRequest request) {
			
			String sizePerPage = request.getParameter("sizePerPage");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("sizePerPage", sizePerPage);
			paraMap.put("end_doc","1");
			
			//세션값 가져오기
			HttpSession session = request.getSession();
			EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
			String empno = loginuser.getEmpno();
			paraMap.put("empno",empno);
			
			// 원글 글번호(parentSeq)에 해당하는 댓글의 totalPage 수 알아오기
			int totalPage = service.getTotalPage(paraMap);
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("totalPage", totalPage); // {"totalPAge":3}
			
			
			return jsonObj.toString();
		}
		
		// === #132. totalPage 수를 알아오기(Ajax 처리)=== //
		@ResponseBody
		@RequestMapping(value = "/getTotalPagemy.yolo", method = {RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
		public String getTotalPagemy(HttpServletRequest request) {
			
			int sizePerPage =Integer.parseInt(request.getParameter("sizePerPage"));
			
			Map<String, String> paraMap = new HashMap<>();
			//paraMap.put("sizePerPage", sizePerPage);
			
			//세션값 가져오기
			HttpSession session = request.getSession();
			EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
			String emp_no = loginuser.getEmpno();
			paraMap.put("emp_no",emp_no);
		
			
			// 원글 글번호(parentSeq)에 해당하는 댓글의 totalPage 수 알아오기 (
			
			double totalP = (double) service.getmyTotalCnt(paraMap);
			double page = totalP/sizePerPage;
			int totalPage = (int) Math.ceil(page);
			
			if(totalPage == 0 ) {
				totalPage =1;
			}
			
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("totalPage", totalPage); // {"totalPAge":3}
			
			
			return jsonObj.toString();
		}
				
				
		// === #163. 첨부파일 다운로드  === //	
		@RequestMapping(value = "/download.yolo")
		public void requiredLogin_download(HttpServletRequest request, HttpServletResponse response) {
			
			String doc_no= request.getParameter("doc_no");
			//첨부파일이 있는 글번호 
			
			/* 
			  	첨부파일이 있는 글번호를 가지고
			  	tbl_board filename 컬럼의 값과 orgfilename 컬럼의 값을 가져와야 한다.
			  	filename 컬럼의 값은 2022103109271535243254235235234.jpf 와 같은 것이고
			  	orgfilename 컬럼의 값은 berkelekle심플라운드01.jsp 와 같은 것이다.
			  
			 */
			
			// 글조회 수 증가는 없고 단순히 글1개를 조회 해주는 것
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("doc_no", doc_no);
			
			
			response.setContentType("text/html; charset=UTF-8"); //자바이지만  웹페이지처럼 뭔가를 찍어주겠다
			PrintWriter out = null;
			//out 은 웹브라우저에 기술하는 대상체라고 생각하자.
			
			
			try {  //유저가 장난쳐오면 막으려고
				Integer.parseInt(doc_no);
				documentVO docvo = service.getfilename(paraMap);
		
				if(docvo == null || (docvo != null && docvo.getFileName() == null ) ) {
					out = response.getWriter();
					// out은 웹브라우저에 기술하는 대상체라고 생각하자.
					
					out.println("<script type='text/javascript'>alert('존재하지 않는 글번호 이거나 첨부파일이 없으므로 파일다운로드가 불가합니다'); history.back();</script>");
					return; //종료
					
				}
				else {
					// 정상적으로 다운로드를 할 경우
					String fileName = docvo.getFileName();
					// 20221028160823764043978919400 이것이 바로 (WAS)톰캣 서버의 디스크에 저장된 파일이름이다.
					request.setAttribute("fileName", fileName);
					
					String OrgFilename = docvo.getOrgFilename();
					// LG_싸이킹청소기_사용설명서.pdf  이것은 다운로드시 보여줄 파일명이다.
					
					// 첨부파일이 저장되어 있는 WAS(톰캣)서버의 디스크 경로명을 알아와야만 다운로드를 해줄 수 있다.
					// 이 결로는 우리가 파일첨부를 위해서 /addEnd.action 에서 설정해두었던 경로와 똑같아야 한다.
					
					// WAS 의 webapp 의 절대경로를 알아와야 한다.
					HttpSession session = request.getSession();
					String root = session.getServletContext().getRealPath("/");
					
					//System.out.println("~~~~ 확인용 webapp 의 절대경로 => " + root);
					//~~~~ 확인용 webapp 의 절대경로 => C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\
					
					String path =  "C:\\Users\\sist\\git\\Yolo\\Yolo\\src\\main\\webapp\\files"+File.separator+"workflow";
					request.setAttribute("path", path );
					/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
				              운영체제가 Windows 이라면 File.separator 는  "\" 이고,
				              운영체제가 UNIX, Linux, 매킨토시(맥) 이라면  File.separator 는 "/" 이다. 
				    */
					
					// path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
					//	System.out.println("~~~~ 확인용 path => " + path);
				    // ~~~~ 확인용 path => C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files  
						
					// *** file 다운로드 하기 *** //
					boolean flag = false; // file 다운로드 성공, 실패를 알려주는 용도
					flag = fileManager.doFileDownload(fileName, OrgFilename, path, response);
					// file 다운로드 성공시 falge 는 true,
					// file 다운로드 실패시 falge 는 flase 를 가진다.
					
					if(!flag) {
						//다운로드가 실패할 경우 메시지를 띄워준다.
						out = response.getWriter();
						// out은 웹브라우저에 기술하는 대상체라고 생각하자.
						
						out.println("<script type='text/javascript'>alert('존재하지 않는 글번호 이거나 첨부파일이 없으므로 파일다운로드가 불가합니다'); history.back();</script>");

					}
					
				}
			
			} catch(NumberFormatException | IOException e) {
				try {
					out = response.getWriter();
					// out은 웹브라우저에 기술하는 대상체라고 생각하자.
					
					out.println("<script type='text/javascript'>alert( '파일다운로드가 불가합니다'); history.back();</script>");

				} catch (IOException e1) {
					e1.printStackTrace();
				}
				
			}
		
		}// end of requiredLogin_download
		

		
		
}
