package com.yolo.hr.jinji.notice.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import javax.servlet.http.*;

import org.json.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.yolo.hr.common.FileManager;
import com.yolo.hr.jinji.notice.model.CommentVO;
import com.yolo.hr.jinji.notice.model.InterNoticeDAO;
import com.yolo.hr.jinji.notice.model.*;
import com.yolo.hr.jinji.notice.service.InterNoticeService;
import com.yolo.hr.jjy.employee.model.EmployeeVO;


@Controller
public class NoticeController {

	@Autowired
	private InterNoticeService service;
	
	@Autowired
	private InterNoticeDAO dao;

	
	// 파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI : Dependency Injection) ===  
    @Autowired // Type에 따라 알아서 bean을 주입시켜준다. 
    private FileManager fileManager; // 빈으로 올라가게 하고 그것을 사용하다. @Autowired 넣어준다.
    
    // 1050 이메일 ptucker@yolo.com
	
    // 부서만 조회해오기
 	@ResponseBody
 	@RequestMapping(value = "/notice/getDept.yolo", produces="text/plain;charset=UTF-8")
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
 	
 	
 	// 체크된 부서 유저 목록 가져오기
 	@ResponseBody
 	@RequestMapping(value = "/notice/chooseUser.yolo", produces="text/plain;charset=UTF-8")
 	public String chooseUser( HttpServletRequest request) {
 		
 		String str_empno = request.getParameter("str_empno");
 		
 		// 해당부서 팀 구해오기
 		List<Map<String, String>> empList = service.getChooseDept(str_empno);
 		
 		JSONArray jsonArr = new JSONArray();
 		
 		for(Map<String, String> emp: empList) {
 			JSONObject jsonObj = new JSONObject();
 			
 			jsonObj.put("name", emp.get("name") );
 			jsonObj.put("nickname", emp.get("nickname") );
 			jsonObj.put("position", emp.get("position") );
 			jsonObj.put("deptname", emp.get("deptname") );
 			jsonObj.put("profile_color", emp.get("profile_color") );
 			jsonObj.put("empno", emp.get("empno") );
 			
 			jsonArr.put(jsonObj);
 		}
 		return jsonArr.toString() ;
 	}
 	
 	
 	// 공지글 작성 (공지 작성시 aop 알림 설정 + 파일 첨부)
 	@ResponseBody
 	@RequestMapping(value = "/notice/sendNotice.yolo", produces="text/plain;charset=UTF-8")
 	public void addAlarm_sendNotice(Map<String, String> paraMap, NoticeVO noticevo, MultipartHttpServletRequest mrequest) {
 		
 		
 		// !! 첨부파일 업로드 하기 시작 !! //
        // addEnd 카피
        MultipartFile attach = noticevo.getAttach();
        HttpSession session = mrequest.getSession();
      
        if(!attach.isEmpty()) {
          // attach가 첨부파일이다. 이것이 비어있지 않다면(첨부파일 존재하면)
          /*
          1. 사용자가 보낸 첨부파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다. 
          >>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
                     우리는 WAS의 webapp/resources/files 라는 폴더로 지정해준다.
                     조심할 것은  Package Explorer 에서  files 라는 폴더를 만드는 것이 아니다.  
             resources 폴더에 만들어도 되지만 그렇게 하지 않고.
                     실제로는 .meta data에 올라간다.
          */
          // WAS의 webapp 절대경로(실제경로) 알아와야 한다. 
         
          String root = session.getServletContext().getRealPath("/"); // 요만큼이 webapp다.
//        System.out.println("확인용  webapp 절대경로(실제경로)  : " + root);
          // C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\
          // 실제로는 .meta data에 올라간다.
          String path = "C:\\Users\\sist\\git\\Yolo\\Yolo\\src\\main\\webapp\\files"+File.separator+"notice";
          /* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
                    운영체제가 Windows 이라면 File.separator 는  "\" 이고,
                    운영체제가 UNIX, Linux, 메킨토시라면  File.separator 는 "/" 이다. 
          */
          
          // path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
          // System.out.println("확인용 path: " + path);
          // C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files
          
          // 2. 파일첨부를 위한 변수 설정 및 값 초기화 한 후 파일 올리기
          String newFileName = "";
          // WAS(톰캣) 디스크에 저장될 파일명 // WAS(톰캣)에 저장될 파일명(2022103109271535243254235235234.png) : 실제 디스크 파일명 
          // 사진 파일명이 강아지.jsp일때 // WAS(톰캣)에 저장될 파일명(2022103109271535243254235235234.png) : 실제 디스크 파일명 
          
          byte[] bytes = null; // 최대파일 사이즈 10메가로 설정해뒀다, 서블릿컨텍스트xml에
          // 첨부파일 내용물 담는 것
          
          long fileSize = 0; // 초기화
          // 첨부파일 크기 
          
          // 파일 첨부 다 되면 boardvo에 다 담긴다. getAttach 해와서 파일 비어있는지 아닌지 알 수 있다.
          try {
              bytes = attach.getBytes(); // bytes 여기에 저장 // 익셉션 처리 
              // 첨부파일 내용물 읽어오는 것
              String originalFilename = attach.getOriginalFilename();
              // attach.getOriginalFilename() 이 첨부파일의 파일명(ex: 강아지 : png)다.
              // System.out.println("확인용 originalFilename"+ originalFilename);
              // 확인용 originalFilename => LG_싸이킹청소기_사용설명서.pdf
              
              newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
              // 첨부되어진 파일을 업로드 하도록 하는 것이다.
              System.out.println("확인용 newFileName " + newFileName);
              // 확인용 newFileName => 202210281521341200152368627000.pdf
              /*
               * 3. COmmentVO commentvo 에 fileName 과 orgFileName 값과 fileSize 값 넣어주기
              */
                noticevo.setFileName(newFileName);
                // WAS(톰캣)에 저장된 파일명(202210281521341200152368627000.pdf)
               
                noticevo.setOrgFilename(originalFilename);
                // 게시판 페이지에서 첨부된 파일(강아지.png)을 보여줄 때 사용.
                // 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.
               // LG_싸이킹청소기_사용설명서.pdf
               
               fileSize = attach.getSize(); // 첨부파일 크기 (단위는 byte)
               noticevo.setFileSize(String.valueOf(fileSize));
               
          } catch (Exception e) {
            e.printStackTrace();
          } 
        }
        // ===  첨부파일 있는 경우 작업 끝 !!! === //

    	EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
 		noticevo.setFk_senderno(loginuser.getEmpno()); // 작성 -> vo 인서트
 		
 		
        
    	if(attach.isEmpty() ) {
			//파일첨부가 없는 글쓰기인 경우		
    		service.sendNotice_noFile(noticevo);
			
		}
		else {
			//파일첨부가 있는 글쓰기인 경우
			service.sendMotice_withFile(noticevo);
		}
        
 	
 		// 첨부 파일 없는 글쓰기
 		// service.sendNotice(noticevo);
 		
 		List<String> empnoList = new ArrayList<String>();
 		 
 		if("1".equals( noticevo.getFk_deptno())) {
 			
 		}
 		else {
 			
 			empnoList = service.getEmpnoList(noticevo.getFk_deptno());
 		}
 		
 		// 해당 사원 번호 알아오기
 		String ste_empnoList = String.join(",", empnoList );
 		
 		// System.out.println(noticevo.getSubject());	
 		// System.out.println(noticevo.getFk_deptno());	
 		// System.out.println(noticevo.getContent());	
 		
 		// seq최신 공지번호 알아오기 (noticevo는 입력한 것을 가져오는)
 		String notino = service.getSeqNotino(loginuser.getEmpno());
//		System.out.println(notino);
 		
// 		System.out.println(empnoList);
 		
 		// === AOP After Advice를 사용하기 === //
 		paraMap.put("fk_recipientno", ste_empnoList); // 받는사람 (여러명일때는 ,,으로 구분된 str)
 		paraMap.put("url", "/notice/noticeList.yolo?alarm_noticeno=" );
 		paraMap.put("url2", notino ); // 연결되는 pknum등...  (여러개일때는 ,,으로 구분된 str)(대신 받는 사람 수랑 같아야됨)
 		paraMap.put("alarm_content", loginuser.getName() + "님이 공지를 작성하셨습니다. 확인해 주세요." );
 		paraMap.put("alarm_type", "5" );
 		
 	}
 
 	
 	
 	
 	
 	/////////////////////////////////////////////////// 전체 공지 시작 /////////////////////////////////
	// 전체 공지 리스트
	@RequestMapping(value = "/notice/noticeList.yolo")
	public ModelAndView noticeList(HttpServletRequest request, ModelAndView mav) {
		
		// 가라 세션
		/*
	    EmployeeVO loginuser = new EmployeeVO();
	    loginuser.setEmpno("1050");
	      
	      
	    loginuser.setFk_deptno("106"); // 사원번호
	      
	    HttpSession session = request.getSession();
	    session.setAttribute("loginuser", loginuser);
	    */
	    // 가라세션 끝
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		String empno = loginuser.getEmpno();
		request.setAttribute("empno", empno);
		
		
		
		// === 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 시작 === //
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
		int sizePerPage = 5;       // 한 페이지당 보여줄 게시물 건수 
		int currentShowPageNo = 0; // 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0;         // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
      
		int startRno = 0; // 시작 행번호
		int endRno = 0;   // 끝 행번호
		
		// 총 게시물 건수 (total Count) 
		totalCount = service.getTotalCount(paraMap); 
		// System.out.println("확인용 totalCount : " + totalCount); 확인용 totalCount : 6
		
		// 만약에 총 게시물 건수(totalCount)가 22라면 총페이지수는 3개가 되어야 한다
		totalPage = (int) Math.ceil( (double)totalCount/sizePerPage );
		// (double)22/10 ==> 2.2 ==> Math.ceil(2.2) == > 3.0 ==> 3
		// (double)30/10 ==> 3.0 ==> Math.ceil(3.0) == > 3.0 ==> 3
		// System.out.println(totalPage);
		
		// 만약에 str_currentShowPageNo이 null 이라면 즉, 게시판에 보여지는 초기화면이라면
		if(str_currentShowPageNo == null) {
			currentShowPageNo =1 ;
		} else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				
				// 또 장난쳐올 경우 ( 숫자인데 없는 페이지 )
				if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {// 유저가 페이지수 장난칠 수도 있다 겟방식이라서
		              currentShowPageNo = 1;
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
	    
		
		// 공지 알림으로 뜬 공지 사항 누르면 해당 공지 내용 띄우기
		String alarm_noticeno = request.getParameter("alarm_noticeno");
		
		
		// 페이징 처리 안한 전체 공지 리스트
		// List<Map<String, String>> showAllNoticeList = service.showAllNoticeList(loginuser.getFk_deptno());
		// 검색어 없는 전체 공지 리스트 페이징 처리
		
		// 페이징 처리 된 검색어 가능한 리스트
		List<Map<String, String>> showAllNoticeList = service.showAllNoticeList(paraMap);
		
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
		String url = "noticeList.yolo";
		
		
		// === [처음][이전] 만들기 === //
		if(pageNo!=1) {
			pageBar += "<a class='last' style='margin-left:auto;' href='"+url+"?searchWord="+searchWord+"&currentShowPageNo=1'><li><<</li></a>";
			pageBar += "<a class='box' href='"+url+"?searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'><li>Previous</li></a>";
		}
		
		
		while( !(loop  > blockSize || totalPage < pageNo) ) {
			
			// 현재 보고있는 페이지와 같은 페이지 번호라면 앵커태그를 줄 필요 없음.
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
		

		////////////////////////////////////////////////////////////
		
		
		
		/*
		for(Map<String, String> map:showAllNoticeList) {
			map.get("cmtCount");
		//	System.out.println(map.get("cmtCount"));
		}
		*/
		
		mav.addObject("alarm_noticeno", alarm_noticeno);
		
		mav.addObject("showAllNoticeList", showAllNoticeList);
		mav.addObject("totalCount", totalCount);
		mav.addObject("pageBar", pageBar);
		
		
		mav.setViewName("jinji/notice/noticeList.admin"); 
		
		return mav;
		
	}
	
	
	
	// 전체 공지리스트 공지 1개 내용 조회하기(ajax)
	@ResponseBody
	@RequestMapping(value="/notice/getNoticeContent.yolo", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
    public String noticeContent( HttpServletRequest request) {
    
		// 해당 공지글을 읽기 위해 필요한 공지번호를 가져오기
		String notino = request.getParameter("notino");		
		// System.out.println(notino);

		
		// map 으로 넣기( 해당 글의 공지번호를 통해 글 하나만 가져오기)
	    Map<String, String> notice = service.showNoticeContent(notino);

	    // ajax
        JSONObject jsonObj = new JSONObject(); 
        jsonObj.put("notino", notice.get("notino"));
        jsonObj.put("fk_senderno", notice.get("fk_senderno"));
        jsonObj.put("subject", notice.get("subject"));
        jsonObj.put("content", notice.get("content"));
        jsonObj.put("writedate", notice.get("writedate"));
        jsonObj.put("profile_color", notice.get("profile_color"));
        jsonObj.put("deptname", notice.get("deptname"));
        jsonObj.put("name", notice.get("name"));
        jsonObj.put("nickname", notice.get("nickname"));
        jsonObj.put("position", notice.get("position"));
        jsonObj.put("showDept", notice.get("showDept"));
        
        jsonObj.put("fileName", notice.get("fileName"));
		jsonObj.put("orgFilename", notice.get("orgFilename"));
		jsonObj.put("fileSize", notice.get("fileSize"));
        
	//	System.out.println(jsonObj);
		
        return jsonObj.toString(); // string 타입으로 변한다.  '[{}, {}, {} ]' 또는 "[ ]"  => select 된 것이 없을 때
    }
    
	
	// 첨부파일 조회하기
	@ResponseBody
	@RequestMapping(value = "/notice/getFile.yolo", produces="text/plain;charset=UTF-8" )
	public String getFile(HttpServletRequest request) {
		
		String notino = request.getParameter("notino");
		
	//	System.out.println(notino);
		
		List<NoticeVO> fileList = service.getFileList(notino);
		
		JSONArray jsonArr = new JSONArray();
		
		for(NoticeVO filevo : fileList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("notino", filevo.getNotino());
			jsonObj.put("fileName", filevo.getFileName());
			jsonObj.put("orgFilename", filevo.getOrgFilename() );
			jsonObj.put("fileSize", filevo.getFileSize() );
			
			jsonArr.put(jsonObj);
		
	//		System.out.println(jsonObj);
		}
		
		return jsonArr.toString();
	}
	
	
	// 해당 첨부파일 다운받기
	@ResponseBody
	@RequestMapping(value = "/notice/downloadNoticeFile.yolo", produces="text/plain;charset=UTF-8" )
	public void downloadNoticeFile(HttpServletRequest request, HttpServletResponse response, NoticeVO noticevo) {
		
		
		String fileName = request.getParameter("fileName");
		String orgFilename = request.getParameter("orgFilename");
		
		
		
		// view단 페이지가 없기 때문에 이 자체 내에서 다 해주어야한다 
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = null; // out은 웹브라우저에 기술하는 대상체 라고 생각하자
		
		try {
			
	
			if(noticevo.getFileName()!=null && !"".equals(noticevo.getFileName())) {
				HttpSession session = request.getSession();
				String root = session.getServletContext().getRealPath("/"); // 이만큼이 webapp 
				
				 System.out.println("root 확인 :" + root);
				// root 확인 :C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\
				
				String path =  "C:\\Users\\sist\\git\\Yolo\\Yolo\\src\\main\\webapp\\files"+File.separator+"notice";
								// root + "resources"+File.separator+"files"+File.separator+"massenger";
				/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
			            운영체제가 Windows 이라면 File.separator 는  "\" 이고,
			            운영체제가 UNIX, Linux, 매킨토시(맥) 이라면  File.separator 는 "/" 이다. 
			    */
				
				// path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
				 System.out.println("확인용 path : "+ path); 
				// 확인용 path : C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files
				
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
	

	
	// 전체 공지글 수정하기 (fk_serderno 만 가능하도록 하기)
	@ResponseBody
	@RequestMapping(value = "/notice/getEditNotice.yolo", produces="text/plain;charset=UTF-8",  method= {RequestMethod.POST})
	public String editNotice(NoticeVO noticevo, HttpServletRequest request) {
		
		String notino = noticevo.getNotino();
//		NoticeVO editNoticevo = service.getEditNotice(notino);
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		noticevo.setFk_senderno(loginuser.getEmpno());
		
		// map 으로 넣기( 공지 수정을 위해 해당 공지번호 글 하나만 가져오기)
	    Map<String, String> editNotice = service.showEditNoticeContent(notino);
		
//		service.editNotice(editNoticevo, noticevo); // 공지글 수정하기
		
		
		// ajax
        JSONObject jsonObj = new JSONObject();
//	   jsonObj.put("editNoticevo", editNoticevo);
        jsonObj.put("notino", editNotice.get("notino"));
        jsonObj.put("subject", editNotice.get("subject"));
        jsonObj.put("content", editNotice.get("content"));
        
        
        return jsonObj.toString(); 
	}
	
	
	// 공지글 수정 완료 폼 요청
	@RequestMapping(value = "/notice/editNoticeFrm.yolo", produces="text/plain;charset=UTF-8",  method= {RequestMethod.POST})
	public ModelAndView editNoticeEnd(ModelAndView mav, NoticeVO noticevo, HttpServletRequest request) {
		
		int result = service.editNotice(noticevo);
		
		/*
		 * System.out.println(result); System.out.println(noticevo.getSubject());
		 * System.out.println(noticevo.getContent());
		 * System.out.println(noticevo.getNotino());
		 */
		 
	   if(result==0) {
           mav.addObject("message", "공지 수정이 완료되지 못했습니다.");
           mav.setViewName("jinji/notice/noticeList.admin"); 
       }
       else { // n == 1 이라면 성공된 경우다 
           mav.addObject("message", "공지 수정이 완료 되었습니다.");
           mav.setViewName("redirect:/notice/noticeList.yolo"); // 페이지만 변경시 redirect(데이터 보내는 곳과 띄우는 곳 다를 때)
       }
      
      return mav;
	}

	

	// 공지글 삭제  요청
   @ResponseBody
   @RequestMapping(value = "/notice/deleteNoticeEnd.yolo",produces="text/plain;charset=UTF-8", method = {RequestMethod.POST })
   public String deleteNoticeEnd(HttpServletRequest request, HttpServletResponse response) {
      
      // 삭제하고자 하는 글의 번호 가져오기
      String notino = request.getParameter("notino"); // notino (jsp에 name or ajax로 데이터 넘겨줘야)
      String fk_senderno = request.getParameter("fk_senderno");
      
      // System.out.println("글삭제번호 :" + notino);
      
      Map<String, String> paraMap = new HashMap<>();
      paraMap.put("notino", notino);
      paraMap.put("fk_senderno", fk_senderno);
      
      HttpSession session = request.getSession();
	  EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
	  
	  String empno = loginuser.getEmpno();
	  request.setAttribute("empno", empno);
	  
	  paraMap.put("empno", empno);
	  
	  // System.out.println(paraMap);
	  
	  String message = "";

	  int result = 0;
	  
	  JSONObject jsonObj = new JSONObject();
//		  System.out.println("fk_send : " +fk_senderno);
//		  System.out.println("empno : " +empno);
	  
	  if( !(empno.equals(fk_senderno) )) {
		  message = "글작성자만 삭제 가능합니다.";
	  }
	  else {
		  result = service.delNoticeEnd(paraMap);	
		  message = "글이 삭제되었습니다.";
	  }

	  jsonObj.put("result", result); 
	  jsonObj.put("message", message); 

	  return jsonObj.toString();

	  
   }

   
   // 공지 댓글 작성하기
   @ResponseBody
   @RequestMapping(value="/notice/addComment.yolo", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
   public String addComment(CommentVO commentvo) {
   // ajax는 결과물 그대로 찍어줘야 하니까 String이 리턴타입이다//modelandview가 아니다.
      
       int n  = 0;
       
       n = service.addComment(commentvo);
       // 댓글쓰기(insert) 및 원게시물(tbl_board 테이블)에 댓글의 개수 증가(update 1씩 증가)하기 
       // 이어서 회원의 포인트를 50점을 증가하도록 한다. (tbl_member 테이블에 point 컬럼의 값을 50 증가하도록 update 한다.)
     
       JSONObject jsonObj = new JSONObject();
       jsonObj.put("n", n); // 위의 n 때문에 쓸 수 없으니 전역변수로 
       jsonObj.put("fk_notino", commentvo.getFk_notino());
       jsonObj.put("fk_empno", commentvo.getFk_empno());
       jsonObj.put("content", commentvo.getContent());
       
       System.out.println("json 확인용 :" + jsonObj);

       return jsonObj.toString();
   }

   
   
   // 원공지글에 해당하는 댓글 조회하기
   @ResponseBody
   @RequestMapping(value="/notice/readComment.yolo", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
   public String readComment(HttpServletRequest request) {
       
       String fk_notino = request.getParameter("fk_notino");
       
       // System.out.println("fk_notino :"+fk_notino);
       
       List<Map<String,String>> commentList = service.getCommentList(fk_notino); 
    
       // 어떤 글은 댓글 아예 없을 수도 있다.
       
       JSONArray jsonArr = new JSONArray();
       // DB에서 읽어온 것 네임,컨텐트, 작성일자를 put 해준다.
     
		for(Map<String,String> comment: commentList) { // 뷰단에 뿌려줄 값들 모두 넣기
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("commentno", comment.get("commentno"));
			jsonObj.put("name", comment.get("name"));
			jsonObj.put("fk_notino", comment.get("fk_notino"));
			jsonObj.put("fk_empno", comment.get("fk_empno"));
			jsonObj.put("content", comment.get("content"));
			jsonObj.put("writedate", comment.get("writedate"));
			jsonObj.put("profile_color", comment.get("profile_color") );
			jsonObj.put("nickname", comment.get("nickname"));
			jsonObj.put("deptname", comment.get("deptname"));
			jsonObj.put("position", comment.get("position"));
			
			jsonArr.put(jsonObj);
		}
	//	System.out.println(jsonArr);  
	// 	원공지글에 대한 댓글 여러개일 수 있음 => 뷰단 ajax로 for문 돌리기((  $.each(data,function(index, item)  ))
		return jsonArr.toString() ;

   }
   
   
	// 원 공지글에 대한 댓글 수정하기
	@ResponseBody
	@RequestMapping(value = "/notice/editComment.yolo", produces="text/plain;charset=UTF-8",  method= {RequestMethod.POST})
	public String editComment(CommentVO commentvo, HttpServletRequest request) {
		
		String content = request.getParameter("content");
		String cmtno = request.getParameter("cmtno");
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		commentvo.setFk_empno(loginuser.getEmpno());
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("content", content);
		paraMap.put("cmtno", cmtno);
		
		// map 으로 넣기( 공지 수정을 위해 해당 공지번호 글 하나만 가져오기)
	    int result = service.showEditComment(paraMap);
		
	    // service.editNotice(editNoticevo, noticevo); // 공지글 수정하기
		
	   // ajax
	   JSONObject jsonObj = new JSONObject();
	   // jsonObj.put("editNoticevo", editNoticevo);
	   jsonObj.put("result",result);
	   
	   
	   return jsonObj.toString(); 
	}
	   
	
	// 댓글 삭제
	@ResponseBody
	@RequestMapping(value = "/notice/delComment.yolo", produces="text/plain;charset=UTF-8",  method= {RequestMethod.POST})
	public String delComment(CommentVO commentvo, HttpServletRequest request) {
		
		String commentno = request.getParameter("commentno");
		String notino = request.getParameter("notino");
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		commentvo.setFk_empno(loginuser.getEmpno());
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("commentno", commentno);
		paraMap.put("notino", notino);
		
		// map 으로 넣기( 공지 수정을 위해 해당 공지번호 글 하나만 가져오기)
	    int result = service.delComment(paraMap);
	    
		dao.delCmtCount(paraMap);
	    // service.editNotice(editNoticevo, noticevo); // 공지글 수정하기
		
	   // ajax
	   JSONObject jsonObj = new JSONObject();
	   // jsonObj.put("editNoticevo", editNoticevo);
	   jsonObj.put("result",result);
	   
	   
	   return jsonObj.toString(); 
	}
	   
	
	
	
	
   /////////////////////////////////////////////////// 전체 공지 끝 /////////////////////////////////
   
   
   
   
   
   
   
    /////////////////////////////////////////////////// 부서 공지 시작 /////////////////////////////////
	// 부서 공지 리스트 
	@RequestMapping(value = "/notice/depNoticeList.yolo")
	public ModelAndView depNoticeList(HttpServletRequest request, ModelAndView mav, NoticeVO noticevo) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
	
		String empno = loginuser.getEmpno();
		request.setAttribute("empno", empno);
		
		String deptno = loginuser.getFk_deptno();
		request.setAttribute("deptno", deptno);
		
		deptno.equals(noticevo.getFk_deptno());
		empno.equals(noticevo.getFk_senderno());
		
		// === 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 시작 === //
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
		paraMap.put("empno", empno);
		paraMap.put("deptno", deptno);
		
		
		// 먼저 총 게시물 건수 (total Count를 구해와야 한다 )
		// 1. 검색조건이 있을때    2. 검색조건이 없을때
		int totalCount = 0;        // 총 게시물 건수
		int sizePerPage = 5;       // 한 페이지당 보여줄 게시물 건수 
		int currentShowPageNo = 0; // 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0;         // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
      
		int startRno = 0; // 시작 행번호
		int endRno = 0;   // 끝 행번호
		
		// 총 게시물 건수 (total Count) 
		totalCount = service.getDepTotalCount(paraMap); 
		// System.out.println("확인용 부서 totalCount : " + totalCount);
		
		// 만약에 총 게시물 건수(totalCount)가 22라면 총페이지수는 3개가 되어야 한다
		totalPage = (int) Math.ceil( (double)totalCount/sizePerPage );
		// (double)22/10 ==> 2.2 ==> Math.ceil(2.2) == > 3.0 ==> 3
		// (double)30/10 ==> 3.0 ==> Math.ceil(3.0) == > 3.0 ==> 3
		// System.out.println(totalPage);
		
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
//		paraMap.put("fk_deptno", noticevo.getFk_deptno());
//		paraMap.put("fk_senderno", noticevo.getFk_senderno());
		paraMap.put("empno", empno);
		paraMap.put("deptno", deptno);

		
		// 페이징 처리 안한 전체 공지 리스트
		// List<Map<String, String>> showAllNoticeList = service.showAllNoticeList(loginuser.getFk_deptno());
		// 검색어 없는 전체 공지 리스트 페이징 처리
		List<Map<String, String>> depNoticeList = service.depNoticeList(paraMap);
		
		
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
		String url = "depNoticeList.yolo";
		
		
		// === [처음][이전] 만들기 === //
		if(pageNo!=1) {
			pageBar += "<a class='last' style='margin-left:auto;' href='"+url+"?searchWord="+searchWord+"&currentShowPageNo=1'><li><<</li></a>";
			pageBar += "<a class='box' href='"+url+"?searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'><li>Previous</li></a>";
		}
		
		
		while( !(loop  > blockSize || totalPage < pageNo) ) {
			
			// 현재 보고있는 페이지와 같은 페이지 번호라면 앵커태그를 줄 필요 없음.
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
		

		////////////////////////////////////////////////////////////
		
		
		/*
		for(Map<String, String> map:showAllNoticeList) {
			map.get("cmtCount");
		//	System.out.println(map.get("cmtCount"));
		}
		*/
		
		// 페이징 처리 안한 공지리스트
		// List<Map<String, String>> depNoticeList = service.depNoticeList(loginuser.getFk_deptno());
		
		
		mav.addObject("depNoticeList", depNoticeList);
		mav.addObject("pageBar", pageBar);
		mav.addObject("totalCount", totalCount);
		
//		System.out.println(showAllNoticeList);
		mav.setViewName("jinji/notice/depNoticeList.admin");
		
		return mav;
	}
	
	
	// 부서 공지리스트 공지 1개 내용 조회하기(ajax)
	@ResponseBody
	@RequestMapping(value="/notice/deptOneNoticeContent.yolo", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
    public String deptOneNoticeContent(HttpServletRequest request) {
    
		// 해당 공지글을 읽이 위해 필요한 공지번호를 가져오기
		String notino = request.getParameter("notino");
//		System.out.println(notino);

			
		// map 으로 넣기( 해당 글의 공지번호를 통해 글 하나만 가져오기)
	    Map<String, String> deptNotice = service.showDeptNoticeContent(notino);
	    
	    // ajax
        JSONObject jsonObj = new JSONObject(); 
        jsonObj.put("notino", deptNotice.get("notino"));
        jsonObj.put("fk_senderno", deptNotice.get("fk_senderno"));
        jsonObj.put("subject", deptNotice.get("subject"));
        jsonObj.put("content", deptNotice.get("content"));
        jsonObj.put("writedate", deptNotice.get("writedate"));
        jsonObj.put("profile_color", deptNotice.get("profile_color"));
        jsonObj.put("deptname", deptNotice.get("deptname"));
        jsonObj.put("name", deptNotice.get("name"));
        jsonObj.put("nickname", deptNotice.get("nickname"));
        jsonObj.put("position", deptNotice.get("position"));
        jsonObj.put("showDept", deptNotice.get("showDept"));
        
        jsonObj.put("fileName", deptNotice.get("fileName"));
		jsonObj.put("orgFilename", deptNotice.get("orgFilename"));
		jsonObj.put("fileSize", deptNotice.get("fileSize"));
		
        return jsonObj.toString(); // string 타입으로 변한다.  '[{}, {}, {} ]' 또는 "[ ]"  => select 된 것이 없을 때
    }
	
	
	// 부서 공지글 수정하기 (fk_serderno 만 가능하도록 하기)
	@ResponseBody
	@RequestMapping(value = "/notice/getDepNoticeContent.yolo", produces="text/plain;charset=UTF-8",  method= {RequestMethod.POST})
	public String editDepNotice(NoticeVO noticevo, HttpServletRequest request ) {
		
		String notino = noticevo.getNotino();
		
//		System.out.println("부서수정번호 : "+ notino);
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		noticevo.setFk_senderno(loginuser.getEmpno());
		
		// map 으로 넣기( 공지 수정을 위해 해당 공지번호 글 하나만 가져오기) (맵에 담으면 맵으로 받음/VO는 NoticeVO로)
		
				
		noticevo =  service.showEditDepNoticeContent(notino);
//		service.editNotice(editNoticevo, noticevo); // 공지글 수정하기
		
		// ajax
        JSONObject jsonObj = new JSONObject();
		
        jsonObj.put("notino", noticevo.getNotino());
        jsonObj.put("subject", noticevo.getSubject());
        jsonObj.put("content", noticevo.getContent());
        
//      System.out.println("부서수정공지 맵 :" +jsonObj);
        return jsonObj.toString(); 
	}
	
	
	// 부서 공지글 1개 삭제  요청
   @ResponseBody
   @RequestMapping(value = "/notice/deleteDepNoticeEnd.yolo",produces="text/plain;charset=UTF-8", method = {RequestMethod.POST })
   public String deleteDepNoticeEnd(HttpServletRequest request, HttpServletResponse response) {
      
      // 삭제하고자 하는 글의 번호 가져오기
      String notino = request.getParameter("notino"); // notino (jsp에 name or ajax로 데이터 넘겨줘야)
      // 공지 작성자의 번호 가져오기
      String fk_senderno = request.getParameter("fk_senderno");
      
      // System.out.println("글삭제번호 :" + notino);
      
      // 글 한 개 삭제(삭제글 정보 1개 맵에 담기)
      Map<String, String> paraMap = new HashMap<>();
      paraMap.put("notino", notino);
      paraMap.put("fk_senderno", fk_senderno);
      
      HttpSession session = request.getSession();
	  EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
	  
	  String empno = loginuser.getEmpno();
	  request.setAttribute("empno", empno);
	  
	  paraMap.put("empno", empno);
	  
	  // System.out.println(paraMap);
	  
	  String message = "";

	  int result = 0;
	  
	  JSONObject jsonObj = new JSONObject();
//	  System.out.println("fk_send : " +fk_senderno);
//    System.out.println("empno : " +empno);
	  
	  if( !(empno.equals(fk_senderno) )) {
		  message = "글작성자만 삭제 가능합니다.";
	  }
	  else {
		  result = service.delDepNoticeEnd(paraMap);	
		  message = "글이 삭제되었습니다.";
	  }

	  jsonObj.put("result", result); 
	  jsonObj.put("message", message); 

	  return jsonObj.toString();

   }	  
	
   
   // 부서 공지 댓글 작성하기
   @ResponseBody
   @RequestMapping(value="/notice/addDepComment.yolo", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
   public String addDepComment(CommentVO commentvo) {
   // ajax는 결과물 그대로 찍어줘야 하니까 String이 리턴타입이다//modelandview가 아니다.
      
       int n  = 0;
       
       n = service.addDepComment(commentvo);
       // 댓글쓰기(insert) 및 원게시물(tbl_board 테이블)에 댓글의 개수 증가(update 1씩 증가)하기 
       // 이어서 회원의 포인트를 50점을 증가하도록 한다. (tbl_member 테이블에 point 컬럼의 값을 50 증가하도록 update 한다.)
     
       JSONObject jsonObj = new JSONObject();
       jsonObj.put("n", n); // 위의 n 때문에 쓸 수 없으니 전역변수로 
       jsonObj.put("fk_notino", commentvo.getFk_notino());
       jsonObj.put("fk_empno", commentvo.getFk_empno());
       jsonObj.put("content", commentvo.getContent());
       
       System.out.println("json 확인용 :" + jsonObj);

       return jsonObj.toString();
   }
   
   
   // 원공지글에 해당하는 댓글 조회하기
   @ResponseBody
   @RequestMapping(value="/notice/readDepComment.yolo", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
   public String readDepComment(HttpServletRequest request) {
       
       String fk_notino = request.getParameter("fk_notino");
       
       // System.out.println("fk_notino :"+fk_notino);
       
       List<Map<String,String>> commentList = service.getDepCommentList(fk_notino); 
    
       // 어떤 글은 댓글 아예 없을 수도 있다.
       
       JSONArray jsonArr = new JSONArray();
       // DB에서 읽어온 것 네임,컨텐트, 작성일자를 put 해준다.
     
		for(Map<String,String> comment: commentList) { // 뷰단에 뿌려줄 값들 모두 넣기
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("commentno", comment.get("commentno"));
			jsonObj.put("name", comment.get("name"));
			jsonObj.put("fk_notino", comment.get("fk_notino"));
			jsonObj.put("fk_empno", comment.get("fk_empno"));
			jsonObj.put("content", comment.get("content"));
			jsonObj.put("writedate", comment.get("writedate"));
			jsonObj.put("profile_color", comment.get("profile_color") );
			jsonObj.put("nickname", comment.get("nickname"));
			jsonObj.put("deptname", comment.get("deptname"));
			jsonObj.put("position", comment.get("position"));
			
			jsonArr.put(jsonObj);
		}
	//	System.out.println(jsonArr);  
	// 	원공지글에 대한 댓글 여러개일 수 있음 => 뷰단 ajax로 for문 돌리기((  $.each(data,function(index, item)  ))
		return jsonArr.toString() ;

   }
   
   
   
	// 부서 공지 댓글 수정하기(업뎁 => int)
	@ResponseBody
	@RequestMapping(value = "/notice/editDepComment.yolo", produces="text/plain;charset=UTF-8",  method= {RequestMethod.POST})
	public String editDepComment(CommentVO commentvo, HttpServletRequest request) {
		
		String content = request.getParameter("content");
		String cmtno = request.getParameter("cmtno");
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		commentvo.setFk_empno(loginuser.getEmpno());
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("content", content);
		paraMap.put("cmtno", cmtno);
		
	    int result = service.showEditDepComment(paraMap);
		
	   // ajax
	   JSONObject jsonObj = new JSONObject();
	   // jsonObj.put("editNoticevo", editNoticevo);
	   jsonObj.put("result",result);
	   
	   
	   return jsonObj.toString(); 
	}
  
   
	// 댓글 삭제
	@ResponseBody
	@RequestMapping(value = "/notice/delDepComment.yolo", produces="text/plain;charset=UTF-8",  method= {RequestMethod.POST})
	public String delDepComment(CommentVO commentvo, HttpServletRequest request) {
		
		String commentno = request.getParameter("commentno");
		String notino = request.getParameter("notino");
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		commentvo.setFk_empno(loginuser.getEmpno());
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("commentno", commentno);
		paraMap.put("notino", notino);
		
		// map 으로 넣기
	    int result = service.delDepComment(paraMap);
		
	    // service.editNotice(editNoticevo, noticevo); 
		
	   // ajax
	   JSONObject jsonObj = new JSONObject();
	   // jsonObj.put("editNoticevo", editNoticevo);
	   jsonObj.put("result",result);
	   
	   
	   return jsonObj.toString(); 
	}
	
   
   
	
	// 첨부파일 조회하기
	@ResponseBody
	@RequestMapping(value = "/notice/getDepFile.yolo", produces="text/plain;charset=UTF-8" )
	public String getDepFile(HttpServletRequest request) {
		
		String notino = request.getParameter("notino");
		
	//	System.out.println(notino);
		
		List<NoticeVO> fileList = service.getDepFile(notino);
		
		JSONArray jsonArr = new JSONArray();
		
		for(NoticeVO filevo : fileList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("notino", filevo.getNotino());
			jsonObj.put("fileName", filevo.getFileName());
			jsonObj.put("orgFilename", filevo.getOrgFilename() );
			jsonObj.put("fileSize", filevo.getFileSize() );
			
			jsonArr.put(jsonObj);
		
	//		System.out.println(jsonObj);
		}
		
		return jsonArr.toString();
	}
	
	
	// 해당 첨부파일 다운받기
	@ResponseBody
	@RequestMapping(value = "/notice/downloadDepFile.yolo", produces="text/plain;charset=UTF-8" )
	public void downloadDepFile(HttpServletRequest request, HttpServletResponse response, NoticeVO noticevo) {
		
		
		String fileName = request.getParameter("fileName");
		String orgFilename = request.getParameter("orgFilename");
		
		
		
		// view단 페이지가 없기 때문에 이 자체 내에서 다 해주어야한다 
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = null; // out은 웹브라우저에 기술하는 대상체 라고 생각하자
		
		try {
			
	
			if(noticevo.getFileName()!=null && !"".equals(noticevo.getFileName())) {
				HttpSession session = request.getSession();
				String root = session.getServletContext().getRealPath("/"); // 이만큼이 webapp 
				
				 System.out.println("root 확인 :" + root);
				// root 확인 :C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\
				
				String path =  "C:\\Users\\sist\\git\\Yolo\\Yolo\\src\\main\\webapp\\files"+File.separator+"notice";
								// root + "resources"+File.separator+"files"+File.separator+"massenger";
				/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
			            운영체제가 Windows 이라면 File.separator 는  "\" 이고,
			            운영체제가 UNIX, Linux, 매킨토시(맥) 이라면  File.separator 는 "/" 이다. 
			    */
				
				// path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
				 System.out.println("확인용 path : "+ path); 
				// 확인용 path : C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files
				
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
		
	
	
	
	
	
	
   
	
	/////////////////////////////////////////////////// 부서 공지 끝 /////////////////////////////////
	
	
	
	
	
	
	
	
	/////////////////////////////////////////////////// 내가 쓴 공지 시작 /////////////////////////////////
	// 내가 쓴 공지 리스트 
	@RequestMapping(value = "/notice/myNoticeList.yolo")
	public ModelAndView myNoticeList(HttpServletRequest request, ModelAndView mav, NoticeVO noticevo) {
		
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		String empno = loginuser.getEmpno();
		request.setAttribute("empno", empno);
		
	 // noticevo.setFk_senderno(loginuser.getEmpno());
		empno.equals(noticevo.getFk_senderno());
		
		
		// === 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 시작 === //
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
		int sizePerPage = 5;       // 한 페이지당 보여줄 게시물 건수 
		int currentShowPageNo = 0; // 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0;         // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
      
		int startRno = 0; // 시작 행번호
		int endRno = 0;   // 끝 행번호
		
		// 총 게시물 건수 (total Count) 
		totalCount = service.getMyTotalCount(paraMap); 
		// System.out.println("확인용 내공지 totalCount : " + totalCount); 
		
		// 만약에 총 게시물 건수(totalCount)가 22라면 총페이지수는 3개가 되어야 한다
		totalPage = (int) Math.ceil( (double)totalCount/sizePerPage );
		// (double)22/10 ==> 2.2 ==> Math.ceil(2.2) == > 3.0 ==> 3
		// (double)30/10 ==> 3.0 ==> Math.ceil(3.0) == > 3.0 ==> 3
		// System.out.println("내공지 totalpage :" + totalPage);
		 
		
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
	    paraMap.put("fk_deptno", noticevo.getFk_deptno());
		paraMap.put("fk_senderno", noticevo.getFk_senderno());
		
		
		// 페이징 처리 안한 전체 공지 리스트
		// List<Map<String, String>> showAllNoticeList = service.showAllNoticeList(loginuser.getFk_deptno());
		// 검색어 없는 전체 공지 리스트 페이징 처리
		// List<Map<String, String>> depNoticeList = service.depNoticeList(paraMap);
		List<Map<String, String>> myNoticeList = service.getMyNoticeList(paraMap);
		
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
		String url = "myNoticeList.yolo";
		
		
		// === [처음][이전] 만들기 === //
		if(pageNo!=1) {
			pageBar += "<a class='last' style='margin-left:auto;' href='"+url+"?searchWord="+searchWord+"&currentShowPageNo=1'><li><<</li></a>";
			pageBar += "<a class='box' href='"+url+"?searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'><li>Previous</li></a>";
		}
		
		
		while( !(loop  > blockSize || totalPage < pageNo) ) {
			
			// 현재 보고있는 페이지와 같은 페이지 번호라면 앵커태그를 줄 필요 없음.
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
		

		////////////////////////////////////////////////////////////

		// 페이징 처리 안한 것
		// List<Map<String, String>> myNoticeList = service.getMyNoticeList(empno);
		
		/*
		for(Map<String, String> map : myNoticeList) {
			map.get("fk_senderno");
			System.out.println(map.get("fk_senderno"));
		}
		*/
		mav.addObject("myNoticeList", myNoticeList);
		mav.addObject("totalCount", totalCount);
		mav.addObject("pageBar", pageBar);
		
		
		mav.setViewName("jinji/notice/myNoticeList.admin"); 
		
		return mav;
		
	}

	
	// 내가 쓴 공지리스트 공지 1개 내용 조회하기(ajax)
	@ResponseBody
	@RequestMapping(value="/notice/getMyOneNoticeContent.yolo", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
    public String MyOneNoticeContent(HttpServletRequest request) {
    
		// 해당 공지글을 읽이 위해 필요한 공지번호를 가져오기
		String notino = request.getParameter("notino");
		// System.out.println(notino);

			
		// map 으로 넣기( 해당 글의 공지번호를 통해 글 하나만 가져오기)
	    Map<String, String> myNotice = service.showMyNoticeContent(notino);

	    // ajax
        JSONObject jsonObj = new JSONObject();
        jsonObj.put("notino", myNotice.get("notino"));
        jsonObj.put("fk_senderno", myNotice.get("fk_senderno"));
        jsonObj.put("subject", myNotice.get("subject"));
        jsonObj.put("content", myNotice.get("content"));
        jsonObj.put("writedate", myNotice.get("writedate"));
        jsonObj.put("profile_color", myNotice.get("profile_color"));
        jsonObj.put("deptname", myNotice.get("deptname"));
        jsonObj.put("name", myNotice.get("name"));
        jsonObj.put("nickname", myNotice.get("nickname"));
        jsonObj.put("position", myNotice.get("position"));
        jsonObj.put("showDept", myNotice.get("showDept"));
        
        jsonObj.put("fileName", myNotice.get("fileName"));
		jsonObj.put("orgFilename", myNotice.get("orgFilename"));
		jsonObj.put("fileSize", myNotice.get("fileSize"));
        
        return jsonObj.toString(); // string 타입으로 변한다.  '[{}, {}, {} ]' 또는 "[ ]"  => select 된 것이 없을 때
    }
	
	
	
	// 내가 쓴 공지리스트 수정
	@ResponseBody
	@RequestMapping(value = "/notice/getMyNoticeContent.yolo", produces="text/plain;charset=UTF-8",  method= {RequestMethod.POST})
	public String editMyNotice(NoticeVO noticevo, HttpServletRequest request ) {
		
		String notino = noticevo.getNotino();
		
//		System.out.println("수정번호 : "+ notino);
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		noticevo.setFk_senderno(loginuser.getEmpno());
		
		// map 으로 넣기( 공지 수정을 위해 해당 공지번호 글 하나만 가져오기) (맵에 담으면 맵으로 받음/VO는 NoticeVO로)
		
				
		noticevo =  service.showEditMyNoticeContent(notino);
//			service.editNotice(editNoticevo, noticevo); // 공지글 수정하기
		
		// ajax
        JSONObject jsonObj = new JSONObject();
		
        jsonObj.put("notino", noticevo.getNotino());
        jsonObj.put("subject", noticevo.getSubject());
        jsonObj.put("content", noticevo.getContent());
        
//	      System.out.println("부서수정공지 맵 :" +jsonObj);
        return jsonObj.toString(); 
	}
	
	
	// 내가 쓴 공지글 1개 삭제  요청
   @ResponseBody
   @RequestMapping(value = "/notice/deleteMyNoticeEnd.yolo",produces="text/plain;charset=UTF-8", method = {RequestMethod.POST })
   public String deleteMyNoticeEnd(HttpServletRequest request, HttpServletResponse response) {
      
      // 삭제하고자 하는 글의 번호 가져오기
      String notino = request.getParameter("notino"); // notino (jsp에 name or ajax로 데이터 넘겨줘야)
      // 공지 작성자의 번호 가져오기
      String fk_senderno = request.getParameter("fk_senderno");
      // System.out.println(fk_senderno);
      // System.out.println("글삭제번호 :" + notino);
      
      
      // 글 한 개 삭제(삭제글 정보 1개 맵에 담기)
      Map<String, String> paraMap = new HashMap<>();
      paraMap.put("notino", notino);
      paraMap.put("fk_senderno", fk_senderno);
      
      HttpSession session = request.getSession();
	  EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
	  
	  String empno = loginuser.getEmpno();
	  request.setAttribute("empno", empno);
	  
	  paraMap.put("empno", empno);
	  
	  String message = "";

	  int result = 0;
	  
	  JSONObject jsonObj = new JSONObject();
	  System.out.println("내가쓴공지:"+paraMap);
	  
	  if( !(empno.equals(fk_senderno) )) {
		  message = "글작성자만 삭제 가능합니다.";
	  }
	  else {
		  result = service.delMyNoticeEnd(paraMap);	
		  message = "글이 삭제되었습니다.";
	  }

	  jsonObj.put("result", result); 
	  jsonObj.put("message", message); 

	  return jsonObj.toString();

   }	  
	
   
   // 내가 쓴 공지 댓글 작성하기
   @ResponseBody
   @RequestMapping(value="/notice/addMyComment.yolo", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
   public String addMyComment(CommentVO commentvo) {
   // ajax는 결과물 그대로 찍어줘야 하니까 String이 리턴타입이다//modelandview가 아니다.
      
       int n  = 0;
       
       n = service.addMyComment(commentvo);
       // 댓글쓰기(insert) 및 원게시물(tbl_board 테이블)에 댓글의 개수 증가(update 1씩 증가)하기 
       // 이어서 회원의 포인트를 50점을 증가하도록 한다. (tbl_member 테이블에 point 컬럼의 값을 50 증가하도록 update 한다.)
     
       JSONObject jsonObj = new JSONObject();
       jsonObj.put("n", n); // 위의 n 때문에 쓸 수 없으니 전역변수로 
       jsonObj.put("fk_notino", commentvo.getFk_notino());
       jsonObj.put("fk_empno", commentvo.getFk_empno());
       jsonObj.put("content", commentvo.getContent());
       
       System.out.println("json 확인용 :" + jsonObj);

       return jsonObj.toString();
   }
   
   
   // 원공지글에 해당하는 댓글 조회하기
   @ResponseBody
   @RequestMapping(value="/notice/readMyComment.yolo", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
   public String readMyComment(HttpServletRequest request) {
       
       String fk_notino = request.getParameter("fk_notino");
       
       // System.out.println("fk_notino :"+fk_notino);
       
       List<Map<String,String>> commentList = service.getMyCommentList(fk_notino); 
    
       // 어떤 글은 댓글 아예 없을 수도 있다.
       
       JSONArray jsonArr = new JSONArray();
       // DB에서 읽어온 것 네임,컨텐트, 작성일자를 put 해준다.
     
		for(Map<String,String> comment: commentList) { // 뷰단에 뿌려줄 값들 모두 넣기
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("commentno", comment.get("commentno"));
			jsonObj.put("name", comment.get("name"));
			jsonObj.put("fk_notino", comment.get("fk_notino"));
			jsonObj.put("fk_empno", comment.get("fk_empno"));
			jsonObj.put("content", comment.get("content"));
			jsonObj.put("writedate", comment.get("writedate"));
			jsonObj.put("profile_color", comment.get("profile_color") );
			jsonObj.put("nickname", comment.get("nickname"));
			jsonObj.put("deptname", comment.get("deptname"));
			jsonObj.put("position", comment.get("position"));
			
			jsonArr.put(jsonObj);
		}
	//	System.out.println(jsonArr);  
	// 	원공지글에 대한 댓글 여러개일 수 있음 => 뷰단 ajax로 for문 돌리기((  $.each(data,function(index, item)  ))
		return jsonArr.toString() ;

   }
   
	// 공지 댓글 수정하기(업뎁 => int)
	@ResponseBody
	@RequestMapping(value = "/notice/editMyComment.yolo", produces="text/plain;charset=UTF-8",  method= {RequestMethod.POST})
	public String editMyComment(CommentVO commentvo, HttpServletRequest request) {
		
		String content = request.getParameter("content");
		String cmtno = request.getParameter("cmtno");
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		commentvo.setFk_empno(loginuser.getEmpno());
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("content", content);
		paraMap.put("cmtno", cmtno);
		
	    int result = service.showEditMyComment(paraMap);
		
	   // ajax
	   JSONObject jsonObj = new JSONObject();
	   // jsonObj.put("editNoticevo", editNoticevo);
	   jsonObj.put("result",result);
	   
	   
	   return jsonObj.toString(); 
	}
 
  
	// 댓글 삭제
	@ResponseBody
	@RequestMapping(value = "/notice/delMyComment.yolo", produces="text/plain;charset=UTF-8",  method= {RequestMethod.POST})
	public String delMyComment(CommentVO commentvo, HttpServletRequest request) {
		
		String commentno = request.getParameter("commentno");
		String notino = request.getParameter("notino");
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		commentvo.setFk_empno(loginuser.getEmpno());
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("commentno", commentno);
		paraMap.put("notino", notino);
		
		// map 으로 넣기
	    int result = service.delMyComment(paraMap);
		
	    // service.editNotice(editNoticevo, noticevo); 
		
	   // ajax
	   JSONObject jsonObj = new JSONObject();
	   // jsonObj.put("editNoticevo", editNoticevo);
	   jsonObj.put("result",result);
	   
	   
	   return jsonObj.toString(); 
	}
	
  
	// 첨부파일 조회하기
	@ResponseBody
	@RequestMapping(value = "/notice/getMyFile.yolo", produces="text/plain;charset=UTF-8" )
	public String getMyFile(HttpServletRequest request) {
		
		String notino = request.getParameter("notino");
		
	//	System.out.println(notino);
		
		List<NoticeVO> fileList = service.getMyFile(notino);
		
		JSONArray jsonArr = new JSONArray();
		
		for(NoticeVO filevo : fileList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("notino", filevo.getNotino());
			jsonObj.put("fileName", filevo.getFileName());
			jsonObj.put("orgFilename", filevo.getOrgFilename() );
			jsonObj.put("fileSize", filevo.getFileSize() );
			
			jsonArr.put(jsonObj);
		
	//		System.out.println(jsonObj);
		}
		
		return jsonArr.toString();
	}
	
	
	// 해당 첨부파일 다운받기
	@ResponseBody
	@RequestMapping(value = "/notice/downloadMyFile.yolo", produces="text/plain;charset=UTF-8" )
	public void downloadMyFile(HttpServletRequest request, HttpServletResponse response, NoticeVO noticevo) {
		
		
		String fileName = request.getParameter("fileName");
		String orgFilename = request.getParameter("orgFilename");
		
		
		
		// view단 페이지가 없기 때문에 이 자체 내에서 다 해주어야한다 
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = null; // out은 웹브라우저에 기술하는 대상체 라고 생각하자
		
		try {
			
	
			if(noticevo.getFileName()!=null && !"".equals(noticevo.getFileName())) {
				HttpSession session = request.getSession();
				String root = session.getServletContext().getRealPath("/"); // 이만큼이 webapp 
				
				// System.out.println("root 확인 :" + root);
				// root 확인 :C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\
				
				String path =  "C:\\Users\\sist\\git\\Yolo\\Yolo\\src\\main\\webapp\\files"+File.separator+"notice";
								// root + "resources"+File.separator+"files"+File.separator+"massenger";
				/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
			            운영체제가 Windows 이라면 File.separator 는  "\" 이고,
			            운영체제가 UNIX, Linux, 매킨토시(맥) 이라면  File.separator 는 "/" 이다. 
			    */
				
				// path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
				// System.out.println("확인용 path : "+ path); 
				// 확인용 path : C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files
				
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
		

	
	/////////////////////////////////////////////////// 내가 쓴 공지 끝 /////////////////////////////////
   
	
	
	
}
