package com.yolo.hr.jjy.employee.controller;

import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonObject;
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
	
	@RequestMapping(value = "/insight.yolo")
	public String insight() {
		return "jangjy/insight.admin";
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
	@RequestMapping(value = "/getTotalEmpPage.yolo", produces = "text/plain;charset=UTF-8")
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
//	public String addAlarm_leaveabsence(Map<String, String> paraMap,  @RequestParam Map<String,String> leaveMap) {
	public String leaveabsence(Map<String, String> paraMap, @RequestParam Map<String,String> leaveMap) {
		
		System.out.println(leaveMap.get("leavetype"));
		System.out.println(leaveMap.get("startdate"));
		System.out.println(leaveMap.get("enddate"));
		System.out.println(leaveMap.get("memo"));
		System.out.println(leaveMap.get("empno"));
		System.out.println(leaveMap.get("leaveno"));
		
		
		int result = 0;
		if("".equals(leaveMap.get("leaveno"))) {
			result = service.insertLeave(leaveMap);
		}
		else {
			result = service.updateLeave(leaveMap);
		}
		System.out.println("휴직처리 insert 결과 : "+ result);
		
		if(result == 1) {
			System.out.println("alarm 용 Map");
			paraMap.put("fk_recipientno", leaveMap.get("empno") ); // 받는사람 (여러명일때는 ,으로 구분된 str)
			paraMap.put("url", "/userDetail.yolo?empno=" );
			paraMap.put("url2", leaveMap.get("empno") ); // 연결되는 pknum등...  (여러개일때는 ,으로 구분된 str)(대신 받는 사람 수랑 같아야됨)
			paraMap.put("alarm_content", "휴직 처리되었습니다." );
			paraMap.put("alarm_type","4" );
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", result);
		
		return jsonObj.toString();
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/getLeaveInfo.yolo", produces = "text/plain;charset=UTF-8")
//	public String addAlarm_leaveabsence(Map<String, String> paraMap,  @RequestParam Map<String,String> leaveMap) {
	public String getLeaveInfo(Map<String, String> paraMap, @RequestParam Map<String,String> leaveMap) {
		
		System.out.println(leaveMap.get("empno"));
		
		Map<String,String> leaveInfoMap = dao.getLeaveInfo(leaveMap);
//		System.out.println("leaveInfoMap :"+leaveInfoMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("leaveInfoMap", leaveInfoMap);
		
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
//		사원 등록 Map{name=짙은, email=zitt@yolo.com, hire_date=2022-12-17, salary=9800, department=1234, team=, position=부서장}
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
		
//		System.out.println("확인용 psInfoMap : "+ psInfoMap);
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
					
//					String path = root + "resources"+File.separator+"files";
					String path = "C:\\Users\\sist\\git\\Yolo\\Yolo\\src\\main\\webapp\\image"+"resources"+File.separator+"files";
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
		
//		System.out.println("############## 확인용 ############"+totalPage);

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
				jsonObj.put("pk_psano", psaMap.get("pk_psano")); // 퇴사일
				jsonObj.put("totalCount", totalCount);
				
				jsonArr.put(jsonObj);
				
			}
		}
		return jsonArr.toString();
	}
	
	
	
	// 사원번호 전달받아 첨부파일 가져오기 
	@ResponseBody
	@RequestMapping(value = "/getFile.yolo", produces="text/plain;charset=UTF-8")
	public String getFile( @RequestParam Map<String,Object>paraMap ) {
		
//		System.out.println(paraMap);
		
		List<Map<String,String>> fileList = dao.getFile(paraMap);
		
//		System.out.println("확인용 list : "+ fileList);
		
		JSONArray jsonArr = new JSONArray();
		for(Map<String,String> fileMap : fileList) {
			JSONObject jsonObj = new JSONObject();
			
			jsonObj.put("fileno",fileMap.get("fileno") );
			jsonObj.put("fk_empno", fileMap.get("fk_empno"));
			jsonObj.put("org_filename", fileMap.get("org_filename"));
			jsonObj.put("fileSize", fileMap.get("fileSize"));
			jsonObj.put("filename", fileMap.get("filename"));
			
			jsonArr.put(jsonObj);
		}
		
		return jsonArr.toString() ;
	}

	
	// 사원 개인 첨부파일 다운 
	@ResponseBody
	@RequestMapping(value = "/downloadFile.yolo", produces="text/plain;charset=UTF-8" )
	public void downloadMailFile(HttpServletRequest request, HttpServletResponse response) {
		String filename = request.getParameter("filename");
		String org_filename = request.getParameter("org_filename");
		
//		System.out.println("filename : "+ filename);
//		System.out.println("org_filename : "+ org_filename);
		
		// view단 페이지가 없기 때문에 이 자체 내에서 다 해주어야한다 
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = null; // out은 웹브라우저에 기술하는 대상체 라고 생각하자
		
		try {
			
			if(filename!=null && !"".equals(filename)) {
				HttpSession session = request.getSession();
				String root = session.getServletContext().getRealPath("/"); // 이만큼이 webapp 
				
				// System.out.println("root 확인 :" + root);
				// root 확인 :C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\
				
//				String path = root + "resources"+File.separator+"files";
				String path = "C:\\Users\\sist\\git\\Yolo\\Yolo\\src\\main\\webapp\\files\\empFile";
//				String path = "C:\\Users\\sist\\git\\Yolo\\Yolo\\src\\main\\webapp\\files";
				
				/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
			            운영체제가 Windows 이라면 File.separator 는  "\" 이고,
			            운영체제가 UNIX, Linux, 매킨토시(맥) 이라면  File.separator 는 "/" 이다. 
			    */
				
				// path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
				// System.out.println("확인용 path : "+ path); 
				// 확인용 path : C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files
				
				// **** file 다운로드 하기 **** // 
				boolean flag = false ;// file 다운로드 성공/ 실패를 알려주는 용도
				
				flag = fileManager.doFileDownload(filename, org_filename, path, response);
				
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

	
	
	@RequestMapping(value="/downloadExcelFile.yolo", method = {RequestMethod.POST}) // 파일 다운로드이기때문에 POST방식
	public String downloadExcelFile( HttpServletRequest request, Model model ,@RequestParam Map<String,Object>searchMap ) {
		
//		List<String> list_position = new ArrayList<>();
//		List<String> list_dept = new ArrayList<>();
//		List<String> list_status = new ArrayList<>();
		
		String str_arr_position = (String) searchMap.get("arr_position");
		String str_arr_dept = (String) searchMap.get("arr_dept");
		String str_arr_status = (String) searchMap.get("arr_status");
		
		String arr_position [] = null;
		String arr_dept []= null;
		String arr_status []= null;
		
		if( str_arr_position != null && !"".equals(str_arr_position) ) {
			arr_position = str_arr_position.split("\\,");
			System.out.println(arr_position);
		}

		if( str_arr_dept != null && !"".equals(str_arr_dept) ) {
			arr_dept = str_arr_dept.split("\\,");
			System.out.println(arr_dept);
		}
		
		if( str_arr_status != null && !"".equals(str_arr_status) ) {
			arr_status = str_arr_status.split("\\,");
			System.out.println(arr_status);
		}
		searchMap.put("arr_position", arr_position);
		searchMap.put("arr_dept", arr_dept);
		searchMap.put("arr_status", arr_status);
		
		List<Map<String, String>> empList = service.empListDownloadExcel(searchMap);
		
//		System.out.println("searchMap : "+ searchMap);
//		System.out.println("empList" + empList);
		
		SXSSFWorkbook workbook = new SXSSFWorkbook();
		SXSSFSheet sheet = workbook.createSheet("사원정보");
		
		// 시트 열 너비 설정
		sheet.setColumnWidth(0, 2000); // 사번
		sheet.setColumnWidth(1, 2000); // 이름 
		sheet.setColumnWidth(2, 2000); // 상태 
		sheet.setColumnWidth(3, 3000); // 입사일
		sheet.setColumnWidth(4, 3000); // 퇴직일 
		sheet.setColumnWidth(5, 2000); // 근속기간 
		sheet.setColumnWidth(6, 2000); // 근무일수 
		sheet.setColumnWidth(7, 2500); // 부서
		sheet.setColumnWidth(8, 1500); // 직위
		sheet.setColumnWidth(9, 4500); // 이메일
		sheet.setColumnWidth(10, 1500); // 성별
		sheet.setColumnWidth(11, 4000); // 휴대전화
		
		// 행의 위치를 나타내는 변수 (반복문을 사용해서 값을 넣는다.)
		int rowLocation = 0;
		
		// CellStyle 정렬하기(Alignment)
		// CellStyle 객체를 생성하여 Alignment 세팅하는 메소드를 호출해서 인자값을 넣어준다.
		// 아래는 HorizontalAlignment(가로)와 VerticalAlignment(세로)를 모두 가운데 정렬 시켰다.
		
		// 우리회사 정보 문구 셀 병합, 가운데 정렬 
		CellStyle mergeRowStyle = workbook.createCellStyle();         // 셀 병합
		mergeRowStyle.setAlignment(HorizontalAlignment.CENTER);       // 수평 가운데 정렬 
		mergeRowStyle.setVerticalAlignment(VerticalAlignment.CENTER); // 수직 가운데 정렬
		// import org.apache.poi.ss.usermodel.VerticalAlignment 으로 해야함.
		
//		 컬럼 제목에 해당하는 셀 가운데 정렬 
		CellStyle headerStyle = workbook.createCellStyle();
		headerStyle.setAlignment(HorizontalAlignment.CENTER);
		headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		
//		 CellStyle 배경색(ForegroundColor)만들기
      // setFillForegroundColor 메소드에 IndexedColors Enum인자를 사용한다.
      // setFillPattern은 해당 색을 어떤 패턴으로 입힐지를 정한다.
	    mergeRowStyle.setFillForegroundColor(IndexedColors.DARK_BLUE.getIndex());  // IndexedColors.DARK_BLUE.getIndex() 는 색상(남색)의 인덱스값을 리턴시켜준다. 
	    mergeRowStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND); // 테두리 실선 
	    
	    headerStyle.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.getIndex()); // IndexedColors.LIGHT_YELLOW.getIndex() 는 연한노랑의 인덱스값을 리턴시켜준다. 
	    headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND); // 테두리 실선 
		
	    // CellStyle 천단위 쉼표, 금액
      CellStyle moneyStyle = workbook.createCellStyle();
      moneyStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));
      
      // Cell 폰트(Font) 설정하기
      // 폰트 적용을 위해 POI 라이브러리의 Font 객체를 생성해준다.
      // 해당 객체의 세터를 사용해 폰트를 설정해준다. 대표적으로 글씨체, 크기, 색상, 굵기만 설정한다.
      // 이후 CellStyle의 setFont 메소드를 사용해 인자로 폰트를 넣어준다.
	    Font mergeRowFont = workbook.createFont(); // import org.apache.poi.ss.usermodel.Font; 으로 한다.
	    mergeRowFont.setFontName("나눔고딕");
	    mergeRowFont.setFontHeight((short)500);
	    mergeRowFont.setColor(IndexedColors.WHITE.getIndex()); // 글자색상 
	    mergeRowFont.setBold(true);
      
	    mergeRowStyle.setFont(mergeRowFont);
	    
		// CellStyle 테두리 Border
		// 테두리는 각 셀마다 상하좌우 모두 설정해준다.
		// setBorderTop, Bottom, Left, Right 메소드와 인자로 POI라이브러리의 BorderStyle 인자를 넣어서 적용한다.
		headerStyle.setBorderTop(BorderStyle.THICK);    // 실선- 두껍게
		headerStyle.setBorderBottom(BorderStyle.THICK); // 실선- 두껍게
		headerStyle.setBorderLeft(BorderStyle.THIN);    // 실선- 얇게
		headerStyle.setBorderRight(BorderStyle.THIN);   // 실선- 얇게
		
		
		
		
		// Cell Merge 셀 병합시키기
      /* 셀병합은 시트의 addMergeRegion 메소드에 CellRangeAddress 객체를 인자로 하여 병합시킨다.
         CellRangeAddress 생성자의 인자로(시작 행, 끝 행, 시작 열, 끝 열) 순서대로 넣어서 병합시킬 범위를 정한다. 배열처럼 시작은 0부터이다.  
      */
		// 병합할 행 만들기
		Row mergeRow = sheet.createRow(rowLocation); // 엑셀에서 행의 시작은 0 부터 시작한다.
		
		// 병합할 행에 "우리회사 사원정보" 로 셀을 만들어 셀에 스타일을 주기
		// 0 번째 행에 총 8번의 셀을 만든다. 
      for(int i=0; i<11; i++) {
         Cell cell = mergeRow.createCell(i);
         cell.setCellStyle(mergeRowStyle);
         cell.setCellValue("사원정보");
      }// end of for-------------------------
      
  /*
   	---------------------------------------------------------------------------------------------------------------------
  	|우리회사 사원정보 | 우리회사 사원정보 | 우리회사 사원정보 | 우리회사 사원정보 | 우리회사 사원정보 | 우리회사 사원정보 | 우리회사 사원정보 | 우리회사 사원정보|
  	--------------------------------------------------------------------------------------------------------------------- 
  */
      
      
      // 셀 병합하기
      sheet.addMergedRegion(new CellRangeAddress(rowLocation, rowLocation, 0, 11)); // 시작 행, 끝 행, 시작 열, 끝 열 
      ////////////////////////////////////////////////////////////////////////////////////////////////
	    
  /*
   	---------------------------------------------------------------------------------------------------------------------
  	|                                                  우리회사 사원정보    												    |
  	--------------------------------------------------------------------------------------------------------------------- 
  */
      
      
      // 헤더 행 생성 (컬럼별 제목 )
      Row headerRow = sheet.createRow(++rowLocation); // 엑셀에서 행의 시작은 0 부터 시작한다.
                                                      // ++rowLocation는 전위연산자임. 
      
      
      // 해당 행의 첫번째 열 셀 생성
      Cell headerCell = headerRow.createCell(0); // 엑셀에서 열의 시작은 0 부터 시작한다.
      headerCell.setCellValue("사번");
      headerCell.setCellStyle(headerStyle);
      
      // 해당 행의 두번째 열 셀 생성
      headerCell = headerRow.createCell(1);
      headerCell.setCellValue("이름");
      headerCell.setCellStyle(headerStyle);
      
      // 해당 행의 세번째 열 셀 생성
      headerCell = headerRow.createCell(2);
      headerCell.setCellValue("상태");
      headerCell.setCellStyle(headerStyle);
      
      // 해당 행의 네번째 열 셀 생성
      headerCell = headerRow.createCell(3);
      headerCell.setCellValue("입사일자");
      headerCell.setCellStyle(headerStyle);
      
      // 해당 행의 다섯번째 열 셀 생성
      headerCell = headerRow.createCell(4);
      headerCell.setCellValue("퇴직일");
      headerCell.setCellStyle(headerStyle);
      
      // 해당 행의 여섯번째 열 셀 생성
      headerCell = headerRow.createCell(5);
      headerCell.setCellValue("근속기간");
      headerCell.setCellStyle(headerStyle);
      
      // 해당 행의 일곱번째 열 셀 생성
      headerCell = headerRow.createCell(6);
      headerCell.setCellValue("근무일수");
      headerCell.setCellStyle(headerStyle);
      
      // 해당 행의 여덟번째 열 셀 생성
      headerCell = headerRow.createCell(7);
      headerCell.setCellValue("부서");
      headerCell.setCellStyle(headerStyle);
      
      headerCell = headerRow.createCell(8);
      headerCell.setCellValue("직위");
      headerCell.setCellStyle(headerStyle);
      
      headerCell = headerRow.createCell(9);
      headerCell.setCellValue("이메일");
      headerCell.setCellStyle(headerStyle);
      
      headerCell = headerRow.createCell(10);
      headerCell.setCellValue("성별");
      headerCell.setCellStyle(headerStyle);
      
      headerCell = headerRow.createCell(11);
      headerCell.setCellValue("휴대전화");
      headerCell.setCellStyle(headerStyle);
      
      
		// ==== HR사원정보 내용에 해당하는 행 및 셀 생성하기 ==== //
		Row bodyRow = null;
		Cell bodyCell = null;

		for (int i = 0; i < empList.size(); i++) { // 행의 개수 , List 의 크기만큼 반복해서 만든다 

			Map<String, String> empMap = empList.get(i);

			// 행생성
			bodyRow = sheet.createRow(i + (rowLocation + 1));
			
			// 데이터 부서번호 표시
			bodyCell = bodyRow.createCell(0);
			bodyCell.setCellValue(empMap.get("empno"));

			// 데이터 부서명 표시
			bodyCell = bodyRow.createCell(1);
			bodyCell.setCellValue(empMap.get("name"));

			// 데이터 사원번호 표시
			bodyCell = bodyRow.createCell(2);
			bodyCell.setCellValue(empMap.get("status"));

			// 데이터 사원명 표시
			bodyCell = bodyRow.createCell(3);
			bodyCell.setCellValue(empMap.get("hiredate"));

			// 데이터 입사일자 표시
			bodyCell = bodyRow.createCell(4);
			bodyCell.setCellValue(empMap.get("retiredate"));

			// 데이터 월급 표시
			bodyCell = bodyRow.createCell(5);
			bodyCell.setCellValue(empMap.get("continuousServiceMonth"));

			// 데이터 성별 표시
			bodyCell = bodyRow.createCell(6);
			bodyCell.setCellValue(empMap.get("workingDays"));

			// 데이터 나이 표시
			bodyCell = bodyRow.createCell(7);
			bodyCell.setCellValue(empMap.get("deptname")); // 나중에 엑셀에서 나이로 평균을 구하거나 합을 구하는 경우를 위해 int 타입으로 변환

			bodyCell = bodyRow.createCell(8);
			bodyCell.setCellValue(empMap.get("position"));

			bodyCell = bodyRow.createCell(9);
			bodyCell.setCellValue(empMap.get("email"));

			bodyCell = bodyRow.createCell(10);
			bodyCell.setCellValue(empMap.get("gender"));

			bodyCell = bodyRow.createCell(11);
			bodyCell.setCellValue(empMap.get("mobile"));

		} // end of for------------------------------
		
		// request 대신 model 이 필요하다.
		model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "사원정보"); // 파일명
		
		return "excelDownloadView";
		//  "excelDownloadView" 은 
	    //  /webapp/WEB-INF/spring/appServlet/servlet-context.xml 파일에서
	    //  기술된 bean 의 id 값이다. 
		
	}
	
	@ResponseBody
    @RequestMapping(value = "/excelUploadAjax.yolo", method = RequestMethod.POST)
        public ModelAndView excelUploadAjax(MultipartFile testFile, MultipartHttpServletRequest request) throws  Exception{
        
        System.out.println("업로드 진행");
        
        MultipartFile excelFile = request.getFile("excelFile");
        
        if(excelFile == null || excelFile.isEmpty()) {
            throw new RuntimeException("엑셀파일을 선택해 주세요");
        }
        
        HttpSession session = request.getSession();
        String root = session.getServletContext().getRealPath("/"); // 이만큼이 webapp 
//        String path = root + "resources"+File.separator+"files"+File.separator+"excel";
        String path = "C:\\Users\\sist\\git\\Yolo\\Yolo\\src\\main\\webapp\\files\\empFile\\";
        
        File destFile = new File(path+excelFile.getOriginalFilename());
//        File destFile = new File("C:\\upload\\"+excelFile.getOriginalFilename());
        try {
            //내가 설정한 위치에 내가 올린 파일을 만들고 
            excelFile.transferTo(destFile);
        }catch(Exception e) {
            throw new RuntimeException(e.getMessage(),e);
        }
        
        //업로드를 진행하고 다시 지우기
        service.excelUpload(destFile);
        
        destFile.delete();
//      System.out.println("확인용 destFile "+destFile);
//      확인용 destFile C:\Users\sist\git\Yolo\Yolo\src\main\webapp\files\empFile\DBinsert 양식.xlsx
        
        ModelAndView view = new ModelAndView();
        view.setViewName("redirect:/people.yolo");
        
        return view;
    }
	
	
	
	@RequestMapping(value = "/changePsaMemo.yolo", produces="text/plain;charset=UTF-8")
//	public String addAlarm_personnelAppointment(Map<String, String> paraMap, HttpServletRequest request , @RequestParam Map<String,Object> psaMap) {
	public String changePsaMemo(@RequestParam Map<String,Object> psaMap) {

		System.out.println("확인용 :psaMap " + psaMap);
		
		dao.changePsaMemo(psaMap);
		
		return "redirect:change_history.yolo";
	}

	
	// 휴직 취소 
	@ResponseBody
	@RequestMapping(value = "/cancelLeave.yolo", produces="text/plain;charset=UTF-8")
	public String cancelLeave(@RequestParam Map<String,Object>paraMap ) {
		
		System.out.println("paraMap :"+paraMap);
		
		int result = service.cancelLeave(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", result );
		
		return jsonObj.toString();
	}

	// 퇴직 처리 전 결재 문서 검사
	@ResponseBody
	@RequestMapping(value = "/checkApproval.yolo", produces="text/plain;charset=UTF-8")
	public String checkApproval(@RequestParam Map<String,Object>paraMap ) {
		
//		System.out.println("결재문서 검사 paraMap :"+paraMap);
		
		int result = dao.checkApproval(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", result );
		
		return jsonObj.toString();
	}
	
	
	// 퇴직 처리 
	@RequestMapping(value = "/retirement.yolo", produces="text/plain;charset=UTF-8")
	public String updateRetirement(@RequestParam Map<String,Object>paraMap ) {
		
//		System.out.println("퇴직 처리 paraMap :"+paraMap);
		
		int result = dao.updateRetirement(paraMap) ;
		
//		return "redirect:userDetail.yolo?empno="+paraMap.get("empno");
		return "jangjy/people_admin.admin";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/registCheckManager.yolo", produces="text/plain;charset=UTF-8")
	public String registCheckManager( @RequestParam Map<String,Object>paraMap) {
		
		System.out.println(paraMap);
//		{name=, email=, hire_date=2022-12-17, salary=, department=10, team=, position=}
		
		int manager_yn = service.registCheckManager(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("manager_yn", manager_yn);
		
		System.out.println("manager_yn"+manager_yn);
		
		return jsonObj.toString() ;
	}
	
	
	
	

	
	
	
	
	
	
}
