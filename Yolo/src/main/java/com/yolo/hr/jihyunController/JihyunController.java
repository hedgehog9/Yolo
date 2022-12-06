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
public class JihyunController {
	
	@Autowired
	private InterMessengerService service;
	
	
	// === #155. 파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI : Dependency Injection) ===
	@Autowired
	private FileManager fileManager; // bean으로 올라간 애를 쓰겠다
	
	
	// 보낸 메일함 열기
	@RequestMapping(value = "/messenger/sentMessage.yolo")
	public ModelAndView sentMessage( HttpServletRequest request, ModelAndView mav) {
		
		// 가라 세션
		EmployeeVO loginuser = new EmployeeVO();
		loginuser.setEmpno("1050");
		// loginuser.setEmpno("1001");
		HttpSession session = request.getSession();
		session.setAttribute("loginuser", loginuser);
		// 가라세션 끝
		
		List<Map<String, String>> sentMsgList = service.getSentMsgList(loginuser.getEmpno());
		
		mav.addObject("sentMsgList", sentMsgList);
		mav.addObject("sentMsgCnt", sentMsgList.size());
		
		mav.setViewName("jihyun/messenger/sentMessage.admin"); 
		
		return mav;
	}
	
	
	// 받은 메일함 열기
	@RequestMapping(value = "/messenger/receivedMessage.yolo")
	public ModelAndView receivedMessage( HttpServletRequest request, ModelAndView mav) {
		
		// 가라 세션
		EmployeeVO loginuser = new EmployeeVO();
		// loginuser.setEmpno("1001");
		loginuser.setEmpno("1050");
		HttpSession session = request.getSession();
		session.setAttribute("loginuser", loginuser);
		// 가라세션 끝
		
		List<Map<String, String>> receivedMsgList = service.getReceivedMsgList(loginuser.getEmpno());
		
		mav.addObject("receivedMsgList", receivedMsgList);
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
				HttpSession session = request.getSession();
				String root = session.getServletContext().getRealPath("/"); // 이만큼이 webapp 
				
				// System.out.println("root 확인 :" + root);
				// root 확인 :C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\
				
				String path = root + "resources"+File.separator+"files"+File.separator+"massenger";
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
		
		// 부서사람들 조회하기
		List<Map<String,String>> deptList = service.getDeptPersonList(deptno);
		
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
		
		// 부서사람들 조회하기
		List<Map<String,String>> teamList = service.getTeamPerson(deptno);
		
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
					/*
			            1. 사용자가 보낸 첨부파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다. 
			           >>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
			                                 우리는 WAS의 webapp/resources/files 라는 폴더로 지정해준다.
			                                 조심할 것은  Package Explorer 에서  files 라는 폴더를 만드는 것이 아니다.       
			       */
					// WAS의 webapp 절대경로를 알아와야한다. 
					String root = session.getServletContext().getRealPath("/"); // 이만큼이 webapp 
					
					System.out.println("root 확인 :" + root);
					// root 확인 :C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\
					
					String path = root + "resources"+File.separator+"files"+File.separator+"massenger";
					/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
				            운영체제가 Windows 이라면 File.separator 는  "\" 이고,
				            운영체제가 UNIX, Linux, 매킨토시(맥) 이라면  File.separator 는 "/" 이다. 
				    */
					
					// path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
					// System.out.println("확인용 path : "+ path); 
					// 확인용 path : C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files
					
					/*
					 	2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기
					*/
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
	
	
	
	// 관리자 내휴가 휴가 개요
	@RequestMapping(value="/leaveSummary.yolo") 
    public String leaveSummary() {
		
        return "jihyun/leave/leaveSummary.admin"; // 뷰단 페이지
        // /WEB-INF/views/admin/{1}/{2}.jsp
    }
	

	// 관리자 구성원 휴가 보유 현황
	@RequestMapping(value="/empLeaveStatus.yolo") 
    public String empLeaveStatus() {
		
        return "jihyun/leave/empLeaveStatus.admin"; // 뷰단 페이지
    }
	
	// 관리자 구성원 휴가 사용 내역
	@RequestMapping(value="/empLeaveUsingList.yolo") 
    public String empLeaveUsingList() {
		
        return "jihyun/leave/empLeaveUsingList.admin"; // 뷰단 페이지
    }
		
}
