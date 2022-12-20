package com.yolo.hr.jihyunController;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.yolo.hr.common.FileManager;
import com.yolo.hr.jihyunModel.FileVO;
import com.yolo.hr.jihyunModel.MessengerVO;
import com.yolo.hr.jihyunService.InterMessengerService;
import com.yolo.hr.jjy.employee.model.EmployeeVO;

@Controller
public class MessengerController {
	
	@Autowired
	private InterMessengerService service;
	
	
	// === #155. 파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI : Dependency Injection) ===
	@Autowired
	private FileManager fileManager; // bean으로 올라간 애를 쓰겠다
	
	
	// 안 읽은 메신저 개수 알아오기
	@ResponseBody
	@RequestMapping(value = "/messenger/getUnreadMsgCnt.yolo" , produces="text/plain;charset=UTF-8")
	public String getUnreadMsgCnt(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		String n = service.getUnreadMsgCnt(loginuser.getEmpno());
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
		
	}
	
		
	// 보낸 메일함 열기
	@RequestMapping(value = "/messenger/sentMessage.yolo")
	public ModelAndView sentMessage( HttpServletRequest request, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO)session.getAttribute("loginuser");
		
		// === #114. 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 시작 === //
		/*
			페이징 처리를 통한 글 목록을 보여주기는 
			예를 들어 2페이지의 내용을 보고자 한다면 검색을 할 경우는 아래와 같이 
			list.action?searchType=subject&searchWord=java&currentShowPageNo=2 와 같이 해주어야 한다
			
			또는 
			
			검색이 없는 전체를 볼때는 아래와 같이
			list.action  또는
			list.action?searchType=&searchWord=&currentShowPageNo=2 또는
			list.action?searchType=subject&searchWord=&currentShowPageNo=2 또는
			list.action?searchType=name&searchWord=&currentShowPageNo=2 또는
		*/
		
		String searchWord = request.getParameter("searchWord"); 
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		
		if(searchWord==null || "".equals(searchWord.trim())){
			searchWord = "";
		}
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchWord", searchWord);
		paraMap.put("empno", loginuser.getEmpno());
		
		// 먼저 총 게시물 건수 (total Count를 구해와야 한다 )
		// 1. 검색조건이 있을때    2. 검색조건이 없을때
		int totalCount = 0;        // 총 게시물 건수
		int sizePerPage = 10;       // 한 페이지당 보여줄 게시물 건수 
		int currentShowPageNo = 0; // 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0;         // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
      
		int startRno = 0; // 시작 행번호
		int endRno = 0;   // 끝 행번호
		
		// 총 게시물 건수 (total Count) 
		totalCount = service.getTotalCount(paraMap);
		// System.out.println("확인용 totalCount : " + totalCount);
		
		// 만약에 총 게시물 건수(totalCount)가 22라면 총페이지수는 3개가 되어야 한다
		totalPage = (int) Math.ceil( (double)totalCount/sizePerPage );
		// (double)22/10 ==> 2.2 ==> Math.ceil(2.2) == > 3.0 ==> 3
		// (double)30/10 ==> 3.0 ==> Math.ceil(3.0) == > 3.0 ==> 3
		
		
		// 만약에 str_currentShowPageNo이 null 이라면 즉, 게시판에 보여지는 초기화면이라면
		if(str_currentShowPageNo == null) {
			currentShowPageNo =1 ;
		} else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				
				// 또 장난쳐올 경우 ( 숫자인데 없는 페이지 )
				if(currentShowPageNo <1 || currentShowPageNo> totalPage) {
					currentShowPageNo =1 ;
				}
				
			} catch (NumberFormatException e) {
				currentShowPageNo =1 ;
			}
		}
		
		
		// **** 가져올 게시글의 범위를 구한다.(공식임!!!) **** 
		/*
           currentShowPageNo      startRno     endRno
          --------------------------------------------
               1 page        ===>    1           10
               2 page        ===>    11          20
               3 page        ===>    21          30
               4 page        ===>    31          40
               ......                ...         ...
		 */
		
		startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
	    endRno = startRno + sizePerPage - 1;
		
	    paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
	    
		List<Map<String, String>> sentMsgList = service.getSentMsgList(paraMap); // 페이징처리를 한 메신저 가져오기 검색 잇 없 모두 포함
		
		if(!"".equals(searchWord)) {
			mav.addObject("searchWord", searchWord);
		}
		
		// === #121. 페이지바 만들기 === //
		int blockSize = 10;
		// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수이다.
		/*
	                 	  1  2  3  4  5  6  7  8  9 10 [다음][마지막]  -- 1개블럭
	         [맨처음][이전]  11 12 13 14 15 16 17 18 19 20 [다음][마지막]  -- 1개블럭
	         [맨처음][이전]  21 22 23
		 */
		
		int loop = 1;
	     /*
	          loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
	     */
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
	    
	      
		
		// *** !! 공식이다. !! *** //
	   /*
	       1  2  3  4  5  6  7  8  9  10  -- 첫번째 블럭의 페이지번호 시작값(pageNo)은 1 이다.
	       11 12 13 14 15 16 17 18 19 20  -- 두번째 블럭의 페이지번호 시작값(pageNo)은 11 이다.
	       21 22 23 24 25 26 27 28 29 30  -- 세번째 블럭의 페이지번호 시작값(pageNo)은 21 이다.
	       
	       currentShowPageNo         pageNo
	      ----------------------------------
	            1                      1 = ((1 - 1)/10) * 10 + 1
	            2                      1 = ((2 - 1)/10) * 10 + 1
	            3                      1 = ((3 - 1)/10) * 10 + 1
	            4                      1
	            5                      1
	            6                      1
	            7                      1 
	            8                      1
	            9                      1
	            10                     1 = ((10 - 1)/10) * 10 + 1
	           
	            11                    11 = ((11 - 1)/10) * 10 + 1
	            12                    11 = ((12 - 1)/10) * 10 + 1
	            13                    11 = ((13 - 1)/10) * 10 + 1
	            14                    11
	            15                    11
	            16                    11
	            17                    11
	            18                    11 
	            19                    11 
	            20                    11 = ((20 - 1)/10) * 10 + 1
	            
	            21                    21 = ((21 - 1)/10) * 10 + 1
	            22                    21 = ((22 - 1)/10) * 10 + 1
	            23                    21 = ((23 - 1)/10) * 10 + 1
	            ..                    ..
	            29                    21
	            30                    21 = ((30 - 1)/10) * 10 + 1
	   */
		
		String pageBar = "<ul>";
		String url = "sentMessage.yolo";
		
		
		// === [처음][이전] 만들기 === //
		if(pageNo!=1) {
			pageBar += "<a class='last' style='margin-left:auto;' href='"+url+"?searchWord="+searchWord+"&currentShowPageNo=1'><li><<</li></a>";
			pageBar += "<a class='box' href='"+url+"?searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'><li>Previous</li></a>";
		}
		
		
		while( !(loop  > blockSize || totalPage < pageNo) ) {
			
			// 현재 보고있는 페이지와 같은 페이지 번호라면 앵커태그를 줄 필요가 업잔슴
			if(pageNo == currentShowPageNo) { 
				pageBar += "<a class='is-active' href='"+url+"?searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'><li>"+pageNo+"</li></a>";
				
			} else {
				pageBar += "<a href='"+url+"?searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'><li>"+pageNo+"</li></a>";
			}
			
			loop++;
			pageNo++;
		} // end of while
		
		
		// === [다음][마지막] 만들기 === //
		if(pageNo<=totalPage) {
			pageBar += "<a class='box' href='"+url+"?searchWord="+searchWord+"&currentShowPageNo="+(pageNo)+"'><li>Next</li></a>";
			pageBar += "<a class='last' style='margin-right:auto;' href='"+url+"?searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'><li>>></li></a>";
		}
		
		pageBar += "</ul>";
		
		mav.addObject("sentMsgList", sentMsgList);
		mav.addObject("sentMsgCnt", totalCount);
		mav.addObject("pageBar", pageBar);
				
		
		mav.setViewName("jihyun/messenger/sentMessage.admin"); 
		
		return mav;
	}
	
	
	// 받은 메일함 열기
	@RequestMapping(value = "/messenger/receivedMessage.yolo")
	public ModelAndView receivedMessage( HttpServletRequest request, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO)session.getAttribute("loginuser");
		
		// empno 넘어오면 request 영역에 담아줘야 한다
		String empno = request.getParameter("empno"); 
		mav.addObject("empno", empno);
		
		
		// === #114. 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 시작 === //
		/*
			페이징 처리를 통한 글 목록을 보여주기는 
			예를 들어 2페이지의 내용을 보고자 한다면 검색을 할 경우는 아래와 같이 
			list.action?searchType=subject&searchWord=java&currentShowPageNo=2 와 같이 해주어야 한다
			
			또는 
			
			검색이 없는 전체를 볼때는 아래와 같이
			list.action  또는
			list.action?searchType=&searchWord=&currentShowPageNo=2 또는
			list.action?searchType=subject&searchWord=&currentShowPageNo=2 또는
			list.action?searchType=name&searchWord=&currentShowPageNo=2 또는
		*/
		
		String searchWord = request.getParameter("searchWord"); 
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if(searchWord==null || "".equals(searchWord.trim())){
			searchWord = "";
		}
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchWord", searchWord);
		paraMap.put("empno", loginuser.getEmpno());
		
		// 먼저 총 게시물 건수 (total Count를 구해와야 한다 )
		// 1. 검색조건이 있을때    2. 검색조건이 없을때
		int totalCount = 0;        // 총 게시물 건수
		int sizePerPage = 10;       // 한 페이지당 보여줄 게시물 건수 
		int currentShowPageNo = 0; // 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0;         // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
      
		int startRno = 0; // 시작 행번호
		int endRno = 0;   // 끝 행번호
		
		// 총 게시물 건수 (total Count) 
		totalCount = service.getTotalCount2(paraMap);
		// System.out.println("확인용 totalCount : " + totalCount);
		
		// 만약에 총 게시물 건수(totalCount)가 22라면 총페이지수는 3개가 되어야 한다
		totalPage = (int) Math.ceil( (double)totalCount/sizePerPage );
		// (double)22/10 ==> 2.2 ==> Math.ceil(2.2) == > 3.0 ==> 3
		// (double)30/10 ==> 3.0 ==> Math.ceil(3.0) == > 3.0 ==> 3
		
		
		// 만약에 str_currentShowPageNo이 null 이라면 즉, 게시판에 보여지는 초기화면이라면
		if(str_currentShowPageNo == null) {
			currentShowPageNo =1 ;
		} else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				
				// 또 장난쳐올 경우 ( 숫자인데 없는 페이지 )
				if(currentShowPageNo <1 || currentShowPageNo> totalPage) {
					currentShowPageNo =1 ;
				}
				
			} catch (NumberFormatException e) {
				currentShowPageNo =1 ;
			}
		}
		
		
		// **** 가져올 게시글의 범위를 구한다.(공식임!!!) **** 
		/*
           currentShowPageNo      startRno     endRno
          --------------------------------------------
               1 page        ===>    1           10
               2 page        ===>    11          20
               3 page        ===>    21          30
               4 page        ===>    31          40
               ......                ...         ...
		 */
		
		startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
	    endRno = startRno + sizePerPage - 1;
		
	    paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
	    
		List<Map<String, String>> receivedMsgList = service.getReceivedMsgList(paraMap); // 페이징처리를 한 메신저 가져오기 검색 잇 없 모두 포함
		
		if(!"".equals(searchWord)) {
			mav.addObject("searchWord", searchWord);
		}
		
		// === #121. 페이지바 만들기 === //
		int blockSize = 10;
		// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수이다.
		/*
	                 	  1  2  3  4  5  6  7  8  9 10 [다음][마지막]  -- 1개블럭
	         [맨처음][이전]  11 12 13 14 15 16 17 18 19 20 [다음][마지막]  -- 1개블럭
	         [맨처음][이전]  21 22 23
		 */
		
		int loop = 1;
	     /*
	          loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
	     */
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
	    
	      
		
		// *** !! 공식이다. !! *** //
	   /*
	       1  2  3  4  5  6  7  8  9  10  -- 첫번째 블럭의 페이지번호 시작값(pageNo)은 1 이다.
	       11 12 13 14 15 16 17 18 19 20  -- 두번째 블럭의 페이지번호 시작값(pageNo)은 11 이다.
	       21 22 23 24 25 26 27 28 29 30  -- 세번째 블럭의 페이지번호 시작값(pageNo)은 21 이다.
	       
	       currentShowPageNo         pageNo
	      ----------------------------------
	            1                      1 = ((1 - 1)/10) * 10 + 1
	            2                      1 = ((2 - 1)/10) * 10 + 1
	            3                      1 = ((3 - 1)/10) * 10 + 1
	            4                      1
	            5                      1
	            6                      1
	            7                      1 
	            8                      1
	            9                      1
	            10                     1 = ((10 - 1)/10) * 10 + 1
	           
	            11                    11 = ((11 - 1)/10) * 10 + 1
	            12                    11 = ((12 - 1)/10) * 10 + 1
	            13                    11 = ((13 - 1)/10) * 10 + 1
	            14                    11
	            15                    11
	            16                    11
	            17                    11
	            18                    11 
	            19                    11 
	            20                    11 = ((20 - 1)/10) * 10 + 1
	            
	            21                    21 = ((21 - 1)/10) * 10 + 1
	            22                    21 = ((22 - 1)/10) * 10 + 1
	            23                    21 = ((23 - 1)/10) * 10 + 1
	            ..                    ..
	            29                    21
	            30                    21 = ((30 - 1)/10) * 10 + 1
	   */
		
		String pageBar = "<ul>";
		String url = "receivedMessage.yolo";
		
		
		// === [처음][이전] 만들기 === //
		if(pageNo!=1) {
			pageBar += "<a class='last' style='margin-left:auto;' href='"+url+"?searchWord="+searchWord+"&currentShowPageNo=1'><li><<</li></a>";
			pageBar += "<a class='box' href='"+url+"?searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'><li>Previous</li></a>";
		}
		
		
		while( !(loop  > blockSize || totalPage < pageNo) ) {
			
			// 현재 보고있는 페이지와 같은 페이지 번호라면 앵커태그를 줄 필요가 업잔슴
			if(pageNo == currentShowPageNo) { 
				pageBar += "<a class='is-active' href='"+url+"?searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'><li>"+pageNo+"</li></a>";
				
			} else {
				pageBar += "<a href='"+url+"?searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'><li>"+pageNo+"</li></a>";
			}
			
			loop++;
			pageNo++;
		} // end of while
		
		
		// === [다음][마지막] 만들기 === //
		if(pageNo<=totalPage) {
			pageBar += "<a class='box' href='"+url+"?searchWord="+searchWord+"&currentShowPageNo="+(pageNo)+"'><li>Next</li></a>";
			pageBar += "<a class='last' style='margin-right:auto;' href='"+url+"?searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'><li>>></li></a>";
		}
		
		pageBar += "</ul>";
		
		mav.addObject("receivedMsgList", receivedMsgList);
		mav.addObject("pageBar", pageBar);
		
		String n = service.getUnreadMsgCnt(loginuser.getEmpno());
		mav.addObject("n", n);
				
		mav.setViewName("jihyun/messenger/receivedMessage.admin"); 
		return mav;
		
	}
	
	
	// 메일 내용 조회하기 ( 보낸 메일 )
	@ResponseBody
	@RequestMapping(value = "/messenger/getMailContent.yolo",  method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String getMailContent (HttpServletRequest request) {
		
		String msgno = request.getParameter("msgno");
		
		Map<String,String> mailContent = service.getMailContent(msgno);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("name", mailContent.get("name") );
		jsonObj.put("nickname", mailContent.get("nickname") );
		jsonObj.put("deptname", mailContent.get("deptname") );
		jsonObj.put("position", mailContent.get("position") );
		jsonObj.put("profile_color", mailContent.get("profile_color") );
		jsonObj.put("pk_msgno", mailContent.get("pk_msgno") );
		jsonObj.put("empno", mailContent.get("empno") );
		jsonObj.put("origin_msgno", mailContent.get("origin_msgno") );
		jsonObj.put("subject", mailContent.get("subject") );
		jsonObj.put("content", mailContent.get("content") );
		jsonObj.put("writedate", mailContent.get("writedate") );
		jsonObj.put("having_attach", mailContent.get("having_attach") );
		jsonObj.put("group_msgno", mailContent.get("group_msgno") );
			
		return jsonObj.toString() ;
	}
	
	
	// 메일 내용 조회하기 ( 받은 메일 => 조회수 업데이트 포함) 
	@ResponseBody
	@RequestMapping(value = "/messenger/getMailContent2.yolo",  method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String getMailContent2 (HttpServletRequest request) {
		
		String msgno = request.getParameter("msgno");
		
		Map<String,String> mailContent = service.getMailContent2(msgno);
		
		if("0".equals(mailContent.get("view_status"))) {
			service.updateViewStatus(msgno);
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("name", mailContent.get("name") );
		jsonObj.put("nickname", mailContent.get("nickname") );
		jsonObj.put("deptname", mailContent.get("deptname") );
		jsonObj.put("position", mailContent.get("position") );
		jsonObj.put("profile_color", mailContent.get("profile_color") );
		jsonObj.put("pk_msgno", mailContent.get("pk_msgno") );
		jsonObj.put("empno", mailContent.get("empno") );
		jsonObj.put("origin_msgno", mailContent.get("origin_msgno") );
		jsonObj.put("subject", mailContent.get("subject") );
		jsonObj.put("content", mailContent.get("content") );
		jsonObj.put("writedate", mailContent.get("writedate") );
		jsonObj.put("having_attach", mailContent.get("having_attach") );
		jsonObj.put("group_msgno", mailContent.get("group_msgno") );
			
		return jsonObj.toString() ;
	}
	
	
	// 조회한 메신저에 첨부파일이 있다면 조회하기
	@ResponseBody
	@RequestMapping(value = "/messenger/getMailFile.yolo", produces="text/plain;charset=UTF-8" )
	public String getMailFile(HttpServletRequest request) {
		
		String group_msgno = request.getParameter("group_msgno");
		
		List<FileVO> fileList = service.getMsgFileList(group_msgno);
		
		JSONArray jsonArr = new JSONArray();
		
		for(FileVO filevo : fileList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("pk_fileno", filevo.getPk_fileno());
			jsonObj.put("fileName", filevo.getFileName() );
			jsonObj.put("orgFilename", filevo.getOrgFilename() );
			jsonObj.put("fileSize", filevo.getFileSize() );
			
			jsonArr.put(jsonObj);
		}
		
		return jsonArr.toString();
	}
	
	
	// 메신저 첨부파일 다운받기
	@ResponseBody
	@RequestMapping(value = "/messenger/downloadMailFile.yolo", produces="text/plain;charset=UTF-8" )
	public void downloadMailFile(HttpServletRequest request, HttpServletResponse response) {
		String fileName = request.getParameter("fileName");
		String orgFilename = request.getParameter("orgFilename");
		
		// view단 페이지가 없기 때문에 이 자체 내에서 다 해주어야한다 
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = null; // out은 웹브라우저에 기술하는 대상체 라고 생각하자
		
		try {
			
			if(fileName!=null && !"".equals(fileName)) {
				
				String path = "C:\\Users\\sist\\git\\Yolo\\Yolo\\src\\main\\webapp\\files\\massenger\\";
				
				// **** file 다운로드 하기 **** // 
				boolean flag = false ;// file 다운로드 성공/ 실패를 알려주는 용도
				
				flag = fileManager.doFileDownload(fileName, orgFilename, path, response);
				
				if(!flag) {
					out = response.getWriter(); // 그냥 getWrite 해버리면 한글이 다 깨지니까 위에서 setContent 해중거 
					out.println("<script type='text/javascript'>alert('파일 다운로드가 실패되었습니다.'); history.back()</script>");
					return ; // 종료
				}
			}
			
		} catch (IOException e) {
			try {
				// view단 페이지가 없기 때문에 이 자체 내에서 다 해주어야한다 
				out = response.getWriter(); // 그냥 getWrite 해버리면 한글이 다 깨지니까 위에서 setContent 해중거 
				out.println("<script type='text/javascript'>alert('파일다운로드가 불가합니다.'); history.back()</script>");
				
			} catch (IOException e1) {
				e1.printStackTrace();
			} 
		}
	}
	
	
	// 체크된 메신저 읽기 (체크된 메신저 조회수 업데이트)
	@ResponseBody
	@RequestMapping(value = "/messenger/updateCheckedMsg.yolo",  method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public void updateCheckedMsg (HttpServletRequest request) {
		String str_msgno = request.getParameter("str_msgno");
		service.updateViewStatus(str_msgno);
	}
	
	
	// 모든 메신저 읽기 (모든 안읽은 메신저 조회수 업데이트)
	@ResponseBody
	@RequestMapping(value = "/messenger/updateAllMsg.yolo", produces="text/plain;charset=UTF-8")
	public void updateAllMsg (HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		service.updateAllMsgStatus(loginuser.getEmpno());
	}
	
	
	// 부서만 조회해오기
	@ResponseBody
	@RequestMapping(value = "/jihyun/getDept.yolo", produces="text/plain;charset=UTF-8")
	public String getDept( HttpServletRequest request) {
		
		// 부서만 조회해오기
		List<Map<String,String>> deptList = service.getDeptList();
		
		JSONArray jsonArr = new JSONArray();
		
		for(Map<String,String> dept: deptList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("deptname", dept.get("deptname") );
			jsonObj.put("deptno", dept.get("deptno") );
			
			jsonArr.put(jsonObj);
		}
		
		return jsonArr.toString() ;
	}
	
	// 부서 사람들(부서장) 조회해오기
	@ResponseBody
	@RequestMapping(value = "/jihyun/getDeptPerson.yolo", produces="text/plain;charset=UTF-8")
	public String getDeptPerson( HttpServletRequest request) {
		
		
		String deptno = request.getParameter("deptno");
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("deptno", deptno);
		paraMap.put("empno", loginuser.getEmpno());
		
		// 부서사람들 조회하기
		List<Map<String,String>> deptList = service.getDeptPersonList(paraMap);
		
		JSONArray jsonArr = new JSONArray();
		
		for(Map<String,String> dept: deptList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("empno", dept.get("empno") );
			jsonObj.put("name", dept.get("name") );
			
			jsonArr.put(jsonObj);
		}
		return jsonArr.toString() ;
	}
	
	
	// 부서내 팀 사람들(사원들) 조회해오기
	@ResponseBody
	@RequestMapping(value = "/jihyun/getTeamPerson.yolo", produces="text/plain;charset=UTF-8")
	public String getTeamPerson( HttpServletRequest request) {
		
		String deptno = request.getParameter("deptno");
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("deptno", deptno);
		paraMap.put("empno", loginuser.getEmpno());
		
		// 부서사람들 조회하기
		List<Map<String,String>> teamList = service.getTeamPerson(paraMap);
		
		JSONArray jsonArr = new JSONArray();
		
		for(Map<String,String> dept: teamList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("empno", dept.get("empno") );
			jsonObj.put("name", dept.get("name") );
			
			jsonArr.put(jsonObj);
		}
		return jsonArr.toString() ;
	}
	
	
	
	// 해당부서 팀 구해오기
	@ResponseBody
	@RequestMapping(value = "/jihyun/getTeam.yolo", produces="text/plain;charset=UTF-8")
	public String getTeam( HttpServletRequest request) {
		
		String deptno = request.getParameter("deptno");
		
		// 해당부서 팀 구해오기
		List<Map<String,String>> deptList = service.getTeam(deptno);
		
		JSONArray jsonArr = new JSONArray();
		
		for(Map<String,String> dept: deptList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("deptname", dept.get("deptname") );
			jsonObj.put("deptno", dept.get("deptno") );
			
			jsonArr.put(jsonObj);
		}
		return jsonArr.toString() ;
	}
	
	
	// 체크된 유저 목록 가져오기
	@ResponseBody
	@RequestMapping(value = "/messenger/chooseUser.yolo", produces="text/plain;charset=UTF-8")
	public String chooseUser( HttpServletRequest request) {
		
		String str_empno = request.getParameter("str_empno");
		
		// 해당부서 팀 구해오기
		List<Map<String, String>> empList = service.getChooseEmp(str_empno);
		
		JSONArray jsonArr = new JSONArray();
		
		for(Map<String, String> emp: empList) {
			JSONObject jsonObj = new JSONObject();
			
			
			jsonObj.put("name", emp.get("name") );
			jsonObj.put("nickname", emp.get("name").substring(emp.get("name").length()-2) );
			jsonObj.put("position", emp.get("position") );
			jsonObj.put("deptname", emp.get("deptname") );
			jsonObj.put("profile_color", emp.get("profile_color") );
			jsonObj.put("empno", emp.get("empno") );
			
			jsonArr.put(jsonObj);
		}
		return jsonArr.toString() ;
	}
	
	
	// 메신저 보내기
	@ResponseBody
	@RequestMapping(value = "/messenger/sendMessenger.yolo", produces="text/plain;charset=UTF-8",  method= {RequestMethod.POST} )
	public void sendMessenger(MessengerVO msgvo, MultipartHttpServletRequest mrequest) {
		
		Calendar currentDate = Calendar.getInstance();
		SimpleDateFormat dateft = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		
		String time = dateft.format(currentDate.getTime());
		
		HttpSession session = mrequest.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		msgvo.setFk_senderno(loginuser.getEmpno());
		
		// 첨부파일 여부
		String str_attachCount = mrequest.getParameter("attachCount");
		
		if("".equals(str_attachCount)) {
			str_attachCount="0";
		}
		int attachCount = Integer.valueOf(str_attachCount);
		int cntRealAttach = 0;
		
		if(attachCount>0) {
			
			for(int i=0; i<attachCount; i++) {
				
				MultipartFile attach = mrequest.getFile("attach"+i);
				
				// attach(첨부파일)가 비어있지 않다면 (즉 첨부파일이 있는 경우라면 )
				if( !attach.isEmpty()) {
					
					String path = "C:\\Users\\sist\\git\\Yolo\\Yolo\\src\\main\\webapp\\files\\massenger\\";
					
					String newFileName = "";
					// WAS(톰캣)의 디스크에 저장되어질 파일네임 날짜 + 나노시간 + 파일확장자 식으로 저장되어짐
					
					byte[] bytes = null; // 첨부파일의 내용물을 담는 것
					long fileSize = 0; // 첨부파일의 크기 
					
					try {
						bytes = attach.getBytes(); // 첨부파일의 내용물을 읽어오는 것
						
						String originalFilename = attach.getOriginalFilename(); // 첨부파일명의 파일명 (예: 강아지.png)
						// System.out.println("확인 originalFilename : "+ originalFilename);
						// 확인 originalFilename : 즐.png
						
						// 파일을 업로드 시켜주는 클래스를 만들거임
						newFileName = fileManager.doFileUpload(bytes, originalFilename, path); // 첨부되어진 파일을 업로드 하도록 하는 것이당 ㅎㅎ
						
						// System.out.println("확인용 newFileName : "+ newFileName); 
						// 확인용 newFileName : 20221028235426101969758220700.png
						
						/*
							3. BoardVo boardvo 에 fileName, orgFilename, fileSize 를 담아줘야함
						 */
						FileVO filevo = new FileVO();
						
						filevo.setFileName(newFileName); // WAS에 저장된 파일명 // 20221028235426101969758220700.png
						filevo.setOrgFilename(originalFilename); // 강아지.png
						// 게시판 페이지에서 첨부된 파일(강아지.png)을 보여줄 때 사용.
			            // 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.
						fileSize = attach.getSize();
						filevo.setFileSize(String.valueOf(fileSize) ); // 첨부파일의 크기
						
						filevo.setFk_msgno(time); // 허수를 담아준 담에 메일을 발송한 후 update 해줄거임
						
						service.addFile(filevo);
						
						cntRealAttach++;
						
					} catch (Exception e) { // 꺠진 파일을 읽어올 수 도 있으므로 exception 처리 //fileManager에서 pathname 가 잘못되면 오류가 발생하는 오류도 잡아줌
						e.printStackTrace();
					} 
					
				}
			}
			
			msgvo.setHaving_attach(String.valueOf(cntRealAttach));
			
		} else {
			msgvo.setHaving_attach(String.valueOf(cntRealAttach));
		}
		
		String msgno = service.sendMessenger(msgvo);
		
		// 허수를 담아줬던 메신저 파일 그룹 메신저 넘버를 진짜 그룹 번호로 업데이트 해줌
		if(cntRealAttach>0) {
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("msgno", msgno);
			paraMap.put("time", time);
			
			service.updateMsgno(paraMap);
		}
	}// end of  메신저 보내기
	
	
	
	// 메신저 전달하기
	@ResponseBody
	@RequestMapping(value = "/messenger/deleverMessenger.yolo", produces="text/plain;charset=UTF-8",  method= {RequestMethod.POST})
	public void deleverMessenger(MessengerVO msgvo, HttpServletRequest request) {
		
		String msgno = msgvo.getOrigin_msgno();
		MessengerVO deliverMsgvo = service.getDeliverMsg(msgno); // 원본 메신저 조회하기
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		msgvo.setFk_senderno(loginuser.getEmpno());
		
		service.deleverMessenger(deliverMsgvo, msgvo); // 메신저 전달하기
		
	}
	
	
	// 메신저 발송을 위해서 이름 알아오기
	@ResponseBody
	@RequestMapping(value = "/messenger/getEmpName.yolo", produces="text/plain;charset=UTF-8")
	public String getEmpName(HttpServletRequest request) {
		
		String empno = request.getParameter("empno");
		return service.getEmpName(empno); // 메세지 발송을 위해 사람이름 알아오기
		
	}
	
	
	
	/*
	    @ExceptionHandler 에 대해서.....
	    ==> 어떤 컨트롤러내에서 발생하는 익셉션이 있을시 익셉션 처리를 해주려고 한다면
	        @ExceptionHandler 어노테이션을 적용한 메소드를 구현해주면 된다
	         
	       컨트롤러내에서 @ExceptionHandler 어노테이션을 적용한 메소드가 존재하면, 
	       스프링은 익셉션 발생시 @ExceptionHandler 어노테이션을 적용한 메소드가 처리해준다.
	       따라서, 컨트롤러에 발생한 익셉션을 직접 처리하고 싶다면 @ExceptionHandler 어노테이션을 적용한 메소드를 구현해주면 된다.
	*/
	@ExceptionHandler(java.lang.Throwable.class)
	public void handleThrowable(Throwable e, HttpServletRequest request, HttpServletResponse response) {
	    
	   e.printStackTrace(); // 콘솔에 에러메시지 나타내기
	    
	    try {
	       // *** 웹브라우저에 출력하기 시작 *** //
	       
	       // HttpServletResponse response 객체는 넘어온 데이터를 조작해서 결과물을 나타내고자 할때 쓰인다. 
	       response.setContentType("text/html; charset=UTF-8");
	       
	       PrintWriter out = response.getWriter();   // out 은 웹브라우저에 기술하는 대상체라고 생각하자.
	       
	       out.println("<html>");
	       out.println("<head><title>오류메시지 출력하기</title></head>");
	       out.println("<body>");
	       out.println("<h1>오류발생</h1>");
	       
	    //   out.printf("<div><span style='font-weight: bold;'>오류메시지</span><br><span style='color: red;'>%s</span></div>", e.getMessage()); 
	       
	       String ctxPath = request.getContextPath();
	       
	       out.println("<div><img src='"+ctxPath+"/resources/images/error.gif'/></div>");
	       out.printf("<div style='margin: 20px; color: blue; font-weight: bold; font-size: 26pt;'>%s</div>", "장난금지");
	       out.println("<a href='"+ctxPath+"/index.action'>홈페이지로 가기</a>");
	       out.println("</body>");
	       out.println("</html>");
	       
	       // *** 웹브라우저에 출력하기 끝 *** //
	    } catch (IOException e1) {
	       e1.printStackTrace();
	    }
	    
	}
		
}
