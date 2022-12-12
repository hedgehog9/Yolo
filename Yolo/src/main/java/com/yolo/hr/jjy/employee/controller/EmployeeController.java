package com.yolo.hr.jjy.employee.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.yolo.hr.common.FileManager;
import com.yolo.hr.jihyunModel.FileVO;
import com.yolo.hr.jjy.employee.model.EmployeeVO;
import com.yolo.hr.jjy.employee.model.InterEmployeeDAO;
import com.yolo.hr.jjy.employee.service.InterEmployeeService;

@Controller
public class EmployeeController {
	
	@Autowired
	private InterEmployeeService service; 
	
	@Autowired 
	private InterEmployeeDAO dao;
	
	// === #155. 파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI : Dependency Injection) ===
	@Autowired
	private FileManager fileManager; // bean으로 올라간 애를 쓰겠다

	// 구성원 메인 페이지
	@RequestMapping(value = "/people.yolo")
	public String people() {
		return "jangjy/people_admin.admin";
	}
	
	@ResponseBody 
	@RequestMapping(value = "/getEmpList.yolo", produces="text/plain;charset=UTF-8")
	public String getEmpList( HttpServletRequest request ) {
		
		String keyword = request.getParameter("keyword");
		Map<String,String> empMap = new HashMap<>();
		
		if(keyword == null) {
			keyword="";
		}
		empMap.put("keyword", keyword);
	    
		List<Map<String,String>> empList = service.getEmpList(empMap);
		
	    
		JSONArray jsonArr = new JSONArray();
		
		if(empList.size() != 0) {
			for(Map<String,String> EmpMap: empList) {
				
				JSONObject jsonObj = new JSONObject();
				
				jsonObj.put("empno",EmpMap.get("empno")); // 사번
				jsonObj.put("profile_color",EmpMap.get("profile_color")); // 프로필 아이콘 색상
				jsonObj.put("profileName", EmpMap.get("name").substring(1)); // 프로필이름 
				jsonObj.put("name", EmpMap.get("name")); // 이름 
				jsonObj.put("status", EmpMap.get("status")); // 재직상태
				jsonObj.put("hireDate", EmpMap.get("hiredate")); // 입사일
				jsonObj.put("retireDate", EmpMap.get("retiredate")); // 퇴사일
				jsonObj.put("continuousServiceMonth", EmpMap.get("continuousServiceMonth")); // 근속기간
				jsonObj.put("workingDays",EmpMap.get("workingDays")); // 근무일수
				jsonObj.put("dept", EmpMap.get("dept")); // 부서
				jsonObj.put("position", EmpMap.get("position")); // 직위
				jsonObj.put("email", EmpMap.get("email")); // 이메일
				jsonObj.put("gender", EmpMap.get("gender")); // 성별
				jsonObj.put("mobile", EmpMap.get("mobile")); // 핸드폰번호
				jsonObj.put("deptname", EmpMap.get("deptname")); // 부서명
//				jsonObj.put("totalCount", totalCount); // 조회 결과물 수 
				
				jsonArr.put(jsonObj);
				
			}
		}
		
		return jsonArr.toString();
	}

	
	// 페이징 처리를 위한 페이지수 구해오기 
	@ResponseBody
	@RequestMapping(value = "/getTotalPage.yolo", produces = "text/plain;charset=UTF-8")
	public String getTotalPage(HttpServletRequest request,@RequestParam(name = "arr_position[]", required = false) List<String> arr_position,
														  @RequestParam(name = "arr_dept[]", required = false) List<String> arr_dept ,
														  @RequestParam(name = "arr_status[]", required = false) List<String> arr_status) {
		
		String sizePerPage = request.getParameter("sizePerPage");
		String keyword = request.getParameter("keyword");
		
		Map<String,Object> pageMap = new HashMap<>();
		pageMap.put("sizePerPage", sizePerPage);
		pageMap.put("keyword", keyword); // 검색어를 입력한 경우 
		pageMap.put("arr_position", arr_position); // 검색어를 입력한 경우 
		pageMap.put("arr_dept", arr_dept); // 검색어를 입력한 경우 
		pageMap.put("arr_status", arr_status); // 검색어를 입력한 경우 
		
		int totalPage = service.getTotalPage(pageMap);
		
		// System.out.println("############## 확인용 ############"+totalPage);

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("totalPage",totalPage); 
		
		return jsonObj.toString();
	}
	
	// 페이징 처리를 위한 페이지수 구해오기 
	@ResponseBody
	@RequestMapping(value = "/empListPaging.yolo", produces = "text/plain;charset=UTF-8")
	public String empListPaging(HttpServletRequest request, @RequestParam(name = "arr_position[]", required = false) List<String> arr_position,
															@RequestParam(name = "arr_dept[]", required = false) List<String> arr_dept ,
															@RequestParam(name = "arr_status[]", required = false) List<String> arr_status) {
		
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		String keyword = request.getParameter("keyword");
		
		Map<String,Object> pageMap = new HashMap<>();
		pageMap.put("currentShowPageNo", currentShowPageNo);
		pageMap.put("keyword", keyword);
		pageMap.put("arr_position", arr_position);
		pageMap.put("arr_dept", arr_dept);
		pageMap.put("arr_status", arr_status);
		
		// 총 페이지수 구해오기 
		int totalCount = service.getTotalCount(pageMap); 
		
		if(currentShowPageNo == null) {
			currentShowPageNo ="1";
		}
		
		int sizePerPage = 10; // 한 페이지당 보여줄 댓글 건수 

		int startRno = ((Integer.parseInt(currentShowPageNo) - 1) * sizePerPage) + 1;
	    int endRno = startRno + sizePerPage - 1;
		
	    pageMap.put("startRno", String.valueOf(startRno));
	    pageMap.put("endRno", String.valueOf(endRno));
	    
		// 페이징 처리한 글목록 가져오기 (검색이 있든지, 검색이 없든지 모두 다 포함한 것)
	    List<Map<String,String>> empListPaging = service.empListSearchWithPaging(pageMap);
		
		JSONArray jsonArr = new JSONArray();
		
		if(empListPaging.size() != 0) {
			for(Map<String,String> empMap: empListPaging) {
				
				JSONObject jsonObj = new JSONObject();
				
				jsonObj.put("empno",empMap.get("empno")); // 사번
				jsonObj.put("profile_color",empMap.get("profile_color")); // 프로필 아이콘 색상
				jsonObj.put("profileName", empMap.get("name").substring(1)); // 프로필이름 
				jsonObj.put("name", empMap.get("name")); // 이름 
				jsonObj.put("status", empMap.get("status")); // 재직상태
				jsonObj.put("hireDate", empMap.get("hiredate")); // 입사일
				jsonObj.put("retireDate", empMap.get("retiredate")); // 퇴사일
				jsonObj.put("continuousServiceMonth", empMap.get("continuousServiceMonth")); // 근속기간
				jsonObj.put("workingDays",empMap.get("workingDays")); // 근무일수
				jsonObj.put("dept", empMap.get("dept")); // 부서
				jsonObj.put("position", empMap.get("position")); // 직위
				jsonObj.put("email", empMap.get("email")); // 이메일
				if(empMap.get("rrn") != null) { jsonObj.put("gender", empMap.get("gender")); }
				jsonObj.put("mobile", empMap.get("mobile")); // 핸드폰번호
				jsonObj.put("deptname", empMap.get("deptname")); // 부서명
				jsonObj.put("totalCount", totalCount); // 총 결과물 수 
				
				jsonArr.put(jsonObj);
				
			}
		}
		return jsonArr.toString();
	}

	// 인사 발령 내역 조회
	@RequestMapping(value = "/change_history.yolo")
	public String change_history() {

		return "jangjy/change_history.admin";
	}

	// 사용자 한명 상세 정보 (admin)
	@RequestMapping(value = "/userDetail.yolo")
	public String user_detail(HttpServletRequest request) {
		
		String empno = request.getParameter("empno");
		Map<String,String> empnoMap = new HashMap<>();
		empnoMap.put("empno", empno);
		
		Map<String,String> employeeMap = service.getEmpOne(empnoMap);
//		System.out.println("확인용 employeeMap + "+employeeMap);
		
		request.setAttribute("employeeMap",employeeMap);
		
		return "jangjy/user_detail.admin";
	}
	
	
	// 휴직 처리하기 전 날짜 조회
	@ResponseBody
	@RequestMapping(value = "/checkLeave.yolo", produces = "text/plain;charset=UTF-8")
	public String checkLeave(HttpServletRequest request) {

		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String empno = request.getParameter("empno");

		Map<String, String> leaveCheckMap = new HashMap<>();

		leaveCheckMap.put("startdate", startdate);
		leaveCheckMap.put("enddate", enddate);
		leaveCheckMap.put("empno", empno);
		
		// 등록하려는 날짜가 이미 등록된 날짜와 포함된다면 경고창 출력

		int result = dao.checkLeave(leaveCheckMap);
//		System.out.println("휴직가능 여부 조회  결과 : " + result);

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result",result); // 1 이상인경우 휴직 신청 불가 
		
		return jsonObj.toString();
	}
	
	
	// 휴직 처리 
	@ResponseBody
	@RequestMapping(value = "/leaveAbsence.yolo", produces = "text/plain;charset=UTF-8")
	public String addAlarm_leaveabsence(Map<String, String> paraMap, HttpServletRequest request) {
		
		String leavetype = request.getParameter("leavetype");
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String memo = request.getParameter("memo");
		String empno = request.getParameter("empno");
		
		System.out.println("확인용 휴직처리할 사원번호 "+empno);
		
		Map<String,String> leaveMap = new HashMap<>();
		
		leaveMap.put("leavetype", leavetype);
		leaveMap.put("startdate", startdate);
		leaveMap.put("enddate", enddate);
		leaveMap.put("memo", memo);
		leaveMap.put("empno", empno);
		
		int result = service.insertLeave(leaveMap);
		System.out.println("휴직처리 insert 결과 : "+ result);
		
		if(result == 1) {
			System.out.println("alarm 용 Map");
			paraMap.put("fk_recipientno", empno ); // 받는사람 (여러명일때는 ,으로 구분된 str)
			paraMap.put("url", "/userDetail.yolo?empno=" );
			paraMap.put("url2", " " ); // 연결되는 pknum등...  (여러개일때는 ,으로 구분된 str)(대신 받는 사람 수랑 같아야됨)
			paraMap.put("alarm_content", "휴직 처리되었습니다." );
			paraMap.put("alarm_type","4" );
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", result);
		
		return jsonObj.toString();
	}
	
	// 부서 이름 조회 
	@ResponseBody
	@RequestMapping(value = "/getDeptList.yolo", produces = "text/plain;charset=UTF-8")
	public String getDeptList(HttpServletRequest request) {

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
	
	
	// 해당부서 팀 구해오기
	@ResponseBody
	@RequestMapping(value = "/getTeamList.yolo", produces="text/plain;charset=UTF-8")
	public String getTeam(HttpServletRequest request) {
		
		String deptno = request.getParameter("deptno");
		
		Map<String, String> deptMap = new HashMap<>();
		deptMap.put("deptno", deptno);
		
		// 해당부서 팀 구해오기
		List<Map<String,String>> deptList = service.getTeam(deptMap);
		JSONArray jsonArr = new JSONArray();
		
		for(Map<String,String> dept: deptList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("deptname", dept.get("deptname") );
			jsonObj.put("deptno", dept.get("deptno") );
			
			jsonArr.put(jsonObj);
		}
		return jsonArr.toString() ;
	}
	
	// 사원 등록 
	@ResponseBody
	@RequestMapping(value = "/registEmployee.yolo", produces="text/plain;charset=UTF-8")
	public String registEmployee(@RequestParam Map<String,Object>paraMap) {
		
		System.out.println("사원 등록 Map" + paraMap);
		JSONObject jsonObj = new JSONObject();
		
		// 회원가입시 이메일 중복 여부 확인 
		int duplicateEmail = dao.checkDuplicateEmail(paraMap);
		
		jsonObj.put("duplicateEmail", duplicateEmail );
//		System.out.println("확인용 이메일 중복 여부 "+ duplicateEmail);
		
		if(duplicateEmail != 1) { // 중복이 아닌 경우 
			int registResult = service.registEployee(paraMap);
			jsonObj.put("registResult", registResult);
//			System.out.println("신규사원 등록 여부 "+registResult);
		}
		
		return jsonObj.toString() ;
	}
	
	
	// 사원 근무시간 구해오기 
	@ResponseBody
	@RequestMapping(value = "/getWorkTime.yolo", produces="text/plain;charset=UTF-8")
	public String getWorkTime( @RequestParam Map<String,Object>workTimeMap) {
		
		String time = dao.getWorkTime(workTimeMap);

//		System.out.println("근무시간 Map" + workTimeMap);
//		System.out.println("확인용 time" + time);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("time", time);
		
		return jsonObj.toString() ;
	}
	
	// 부서에 부서장 또는 팀장이 있는지 조회 
	@ResponseBody
	@RequestMapping(value = "/checkManager.yolo", produces="text/plain;charset=UTF-8")
	public String checkManager( @RequestParam Map<String,Object>paraMap) {
		
		int manager_yn = service.checkManager(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("manager_yn", manager_yn);
		
		return jsonObj.toString() ;
	}
	
	
	// 인사발령 (트랜잭션)
	@RequestMapping(value = "/personnelAppointment.yolo", produces="text/plain;charset=UTF-8")
//	public String addAlarm_personnelAppointment(Map<String, String> paraMap, HttpServletRequest request , @RequestParam Map<String,Object> psaMap) {
	public String personnelAppointment(Map<String, String> paraMap, HttpServletRequest request , @RequestParam Map<String,Object> psaMap) {
		System.out.println("psaMap"+psaMap);
//		paraMap{empno=1111, before_deptno=100, before_position=관리자, psa_date=2022-12-09, changeType=직무 변경, deptno=25, teamno=108, position=, memo=}

		int result = service.personnelAppointment(psaMap);
		
		if(result == 1) {
			paraMap.put("fk_recipientno",(String)psaMap.get("empno")); // 받는사람 (여러명일때는 ,으로 구분된 str)
			// 나중에 인사발령 조회 페이지로 이동시키기 
			paraMap.put("url", "/userDetail.yolo?empno=" );
			paraMap.put("url2", (String)psaMap.get("empno")); // 연결되는 pknum등...  (여러개일때는 ,으로 구분된 str)(대신 받는 사람 수랑 같아야됨)
			paraMap.put("alarm_content", "인사발령!" );
			paraMap.put("alarm_type", "5");
		}
		
		return "redirect:userDetail.yolo?empno="+psaMap.get("empno");
	}
	
	// 사원번호를 전달받아 인사발령 기록 조회 해오기 
	@ResponseBody
	@RequestMapping(value = "/getPsaHistory.yolo", produces="text/plain;charset=UTF-8")
	public String getPsaHistory( @RequestParam Map<String,Object>paraMap ) {
		
		
		List<Map<String,String>> psaHistoryList = dao.getPsaHistory(paraMap);
		
		
		JSONArray jsonArr = new JSONArray();
		for(Map<String,String> historyMap : psaHistoryList) {
			JSONObject jsonObj = new JSONObject();
			
			jsonObj.put("fk_empno",historyMap.get("fk_empno") );
			jsonObj.put("fk_before_deptno", historyMap.get("fk_before_deptno"));
			jsonObj.put("fk_after_deptno", historyMap.get("fk_after_deptno"));
			jsonObj.put("before_position", historyMap.get("before_position"));
			jsonObj.put("after_position", historyMap.get("after_position"));
			jsonObj.put("memo", historyMap.get("memo"));
			jsonObj.put("psa_date", historyMap.get("psa_date"));
			jsonObj.put("psa_label", historyMap.get("psa_label"));
			jsonObj.put("after_deptname", historyMap.get("after_deptname"));
			jsonObj.put("before_deptname", historyMap.get("before_deptname"));
			
			jsonArr.put(jsonObj);
		}
		
		return jsonArr.toString() ;
	}
	
	// 사원번호를 전달받아 휴직 기록 조회 해오기 
	@ResponseBody
	@RequestMapping(value = "/getLeaveAbsence.yolo", produces="text/plain;charset=UTF-8")
	public String getLeaveAbsence( @RequestParam Map<String,Object>paraMap ) {
		
		List<Map<String,String>> leaveAbsenceList = dao.getLeaveAbsence(paraMap);
		
		JSONArray jsonArr = new JSONArray();
		for(Map<String,String> leaveAbsenceMap : leaveAbsenceList) {
			JSONObject jsonObj = new JSONObject();
			
			jsonObj.put("fk_empno",leaveAbsenceMap.get("fk_empno") );
			jsonObj.put("leavetype", leaveAbsenceMap.get("leavetype"));
			jsonObj.put("startdate", leaveAbsenceMap.get("startdate"));
			jsonObj.put("enddate", leaveAbsenceMap.get("enddate"));
			jsonObj.put("memo", leaveAbsenceMap.get("memo"));
			
			jsonArr.put(jsonObj);
		}
		
		return jsonArr.toString() ;
	}
	
	@RequestMapping(value = "/changePsInfo.yolo", produces="text/plain;charset=UTF-8" , method= {RequestMethod.POST} )
	public String changePsInfo( MultipartHttpServletRequest mrequest, @RequestParam Map<String,Object>psInfoMap ) {
		
		
		
		System.out.println("확인용 psInfoMap : "+ psInfoMap);
		int result = service.changePsInfo(psInfoMap);
		
		
		Calendar currentDate = Calendar.getInstance();
		SimpleDateFormat dateft = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		
		String time = dateft.format(currentDate.getTime());
		
		// 첨부파일 여부
		HttpSession session = mrequest.getSession();
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
					
					// System.out.println("root 확인 :" + root);
					// root 확인 :C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\
					
					String path = root + "resources"+File.separator+"files";
//					System.out.println("확인용 path : "+ path);
					// C:\NCS\workspace(final)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Yolo\resources\files
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
						
						String org_filename = attach.getOriginalFilename(); // 첨부파일명의 파일명 (예: 강아지.png)
						// System.out.println("확인 originalFilename : "+ originalFilename);
						// 확인 originalFilename : 즐.png
						
						// 파일을 업로드 시켜주는 클래스를 만들거임
						newFileName = fileManager.doFileUpload(bytes, org_filename, path); // 첨부되어진 파일을 업로드 하도록 하는 것이당 ㅎㅎ
						
						// System.out.println("확인용 newFileName : "+ newFileName); 
						// 확인용 newFileName : 20221028235426101969758220700.png
						
						/*
							3. BoardVo boardvo 에 fileName, orgFilename, fileSize 를 담아줘야함
						 */
//						FileVO filevo = new FileVO();
						Map<String,Object> fileMap = new HashMap<>();
						
						fileMap.put("fk_empno", psInfoMap.get("empno"));
						fileMap.put("filename", newFileName); // WAS에 저장된 파일명 // 20221028235426101969758220700.png
						fileMap.put("org_filename", org_filename); // WAS에 저장된 파일명 // 20221028235426101969758220700.png
						// 게시판 페이지에서 첨부된 파일(강아지.png)을 보여줄 때 사용.
			            // 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.
						fileSize = attach.getSize();
						fileMap.put("fileSize", fileSize);
//						filevo.setFileSize(String.valueOf(fileSize) ); // 첨부파일의 크기
						
//						filevo.setFk_msgno(time); // 허수를 담아준 담에 메일을 발송한 후 update 해줄거임
						
						dao.addFile(fileMap);
						
						cntRealAttach++;
						
					} catch (Exception e) { // 꺠진 파일을 읽어올 수 도 있으므로 exception 처리 //fileManager에서 pathname 가 잘못되면 오류가 발생하는 오류도 잡아줌
						e.printStackTrace();
					} 
				}
			}
			
		} 
		return "redirect:userDetail.yolo?empno="+psInfoMap.get("empno");
	}
	
	
	// 인사발령 내역 조회 /////////////////////////////////////////////////////////////////////////
	
	// 페이징 처리를 위한 페이지수 구해오기 
	@ResponseBody
	@RequestMapping(value = "/getTotalPsaPage.yolo", produces = "text/plain;charset=UTF-8")
	public String getTotalPsaPage(HttpServletRequest request,@RequestParam(name = "arr_position[]", required = false) List<String> arr_position,
														  @RequestParam(name = "arr_dept[]", required = false) List<String> arr_dept ,
														  @RequestParam(name = "arr_status[]", required = false) List<String> arr_status) {
		
		String sizePerPage = request.getParameter("sizePerPage");
		String keyword = request.getParameter("keyword");
		
		Map<String,Object> pageMap = new HashMap<>();
		pageMap.put("sizePerPage", sizePerPage);
		pageMap.put("keyword", keyword); // 검색어를 입력한 경우 
		pageMap.put("arr_position", arr_position); // 검색어를 입력한 경우 
		pageMap.put("arr_dept", arr_dept); // 검색어를 입력한 경우 
		pageMap.put("arr_status", arr_status); // 검색어를 입력한 경우 
		
		int totalPage = service.getTotalPsaPage(pageMap);
		
		System.out.println("############## 확인용 ############"+totalPage);

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("totalPage",totalPage); 
		
		return jsonObj.toString();
	}
	
	
	
	// 페이징 처리를 위한 목록 구해오기 
	@ResponseBody
	@RequestMapping(value = "/psaListPaging.yolo", produces = "text/plain;charset=UTF-8")
	public String psaListPaging(HttpServletRequest request, @RequestParam(name = "arr_position[]", required = false) List<String> arr_position,
															@RequestParam(name = "arr_dept[]", required = false) List<String> arr_dept ,
															@RequestParam(name = "arr_status[]", required = false) List<String> arr_status) {
		
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		String keyword = request.getParameter("keyword");
		
		Map<String,Object> pageMap = new HashMap<>();
		pageMap.put("currentShowPageNo", currentShowPageNo);
		pageMap.put("keyword", keyword);
		pageMap.put("arr_position", arr_position);
		pageMap.put("arr_dept", arr_dept);
		pageMap.put("arr_status", arr_status);
		
		// 총 페이지수 구해오기 
		int totalCount = service.getTotalPsaPage(pageMap); 
		
		if(currentShowPageNo == null) {
			currentShowPageNo ="1";
		}
		
		int sizePerPage = 10; // 한 페이지당 보여줄 댓글 건수 

		int startRno = ((Integer.parseInt(currentShowPageNo) - 1) * sizePerPage) + 1;
	    int endRno = startRno + sizePerPage - 1;
		
	    pageMap.put("startRno", String.valueOf(startRno));
	    pageMap.put("endRno", String.valueOf(endRno));
	    
		// 페이징 처리한 글목록 가져오기 (검색이 있든지, 검색이 없든지 모두 다 포함한 것)
	    List<Map<String,String>> psaListPaging = service.psaListSearchWithPaging(pageMap);
	    
//	    System.out.println("확인용 psaListPaging : "+psaListPaging);
		
		JSONArray jsonArr = new JSONArray();
		
		if(psaListPaging.size() != 0) {
			for(Map<String,String> psaMap: psaListPaging) {
				
				JSONObject jsonObj = new JSONObject();
				
				jsonObj.put("after_deptname",psaMap.get("after_deptname")); // 발령 후 부서명 
				jsonObj.put("before_deptname",psaMap.get("before_deptname")); // 발령 후 부서명 
				jsonObj.put("before_position",psaMap.get("before_position")); // 프로필 아이콘 색상
				jsonObj.put("after_position", psaMap.get("after_position")); // 이름 
				jsonObj.put("psa_date", psaMap.get("psa_date")); // 재직상태
				jsonObj.put("psa_label", psaMap.get("psa_label")); // 입사일
				jsonObj.put("memo", psaMap.get("memo")); // 퇴사일
				jsonObj.put("name", psaMap.get("name")); // 퇴사일
				jsonObj.put("totalCount", totalCount);
				
				jsonArr.put(jsonObj);
				
			}
		}
		return jsonArr.toString();
	}

	
	
	
	
	
	
	
	
}
