package com.yolo.hr.jihyunController;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
import com.yolo.hr.jihyunService.InterLeaveService;
import com.yolo.hr.jjy.employee.model.EmployeeVO;

@Controller
public class LeaveController {

	@Autowired
	private InterLeaveService service;

	// === #155. 파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI : Dependency
	// Injection) ===
	@Autowired
	private FileManager fileManager; // bean으로 올라간 애를 쓰겠다

	// 사용자의 권한을 조회해서 넘겨주는 ajax
	@ResponseBody
	@RequestMapping(value = "/leave/checkAuthority.yolo", produces = "text/plain;charset=UTF-8")
	public String checkAuthority(HttpServletRequest request) {

		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");

		List<String> adminEmpnoList = service.getAdminEmpnoList();

		String empno = loginuser.getEmpno();

		if (adminEmpnoList.contains(empno)) {
			return "1";
		} else {
			return "0";
		}
	}

	// 내휴가
	@RequestMapping(value = "/leaveSummary.yolo")
	public ModelAndView leaveSummary(HttpServletRequest request, ModelAndView mav) {

		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");

		Calendar currentDate = Calendar.getInstance();
		SimpleDateFormat dateft = new SimpleDateFormat("yyyy");

		String year = dateft.format(currentDate.getTime());

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("empno", loginuser.getEmpno());
		paraMap.put("year", year);

		List<Map<String, String>> leaveTypeList = service.getLeaveTypeList(paraMap); // 휴가 종류와 남은 일수 구해오기
		mav.addObject("leaveTypeList", leaveTypeList);

		// 관리자 권한 알아보기
		List<String> adminEmpnoList = service.getAdminEmpnoList();
		if (adminEmpnoList.contains(loginuser.getEmpno())) {
			mav.addObject("isAdmin", "1");
		}

		mav.setViewName("jihyun/leave/leaveSummary.admin");

		return mav;
	}

	// 모달을 띄우기 위해서 해당 휴가에 대한 정보를 얻어온다
	@ResponseBody
	@RequestMapping(value = "/leave/getLeaveDate.yolo", produces = "text/plain;charset=UTF-8")
	public String getLeaveDate(HttpServletRequest request) {

		String empno = request.getParameter("empno");
		
		EmployeeVO loginuser;
		
		if(empno != null) {
			loginuser = new EmployeeVO();
			loginuser.setEmpno(empno);
		} else {
			HttpSession session = request.getSession();
			loginuser = (EmployeeVO) session.getAttribute("loginuser");
		}
		

		String pk_leave_type = request.getParameter("pk_leave_type");

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("empno", loginuser.getEmpno());
		paraMap.put("pk_leave_type", pk_leave_type);

		Map<String, String> leaveData = service.getLeaveDate(paraMap);

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("pk_leave_type", leaveData.get("pk_leave_type"));
		jsonObj.put("leave_name", leaveData.get("leave_name"));
		jsonObj.put("limit_info", leaveData.get("limit_info"));
		jsonObj.put("add_file", leaveData.get("add_file"));
		jsonObj.put("emoji", leaveData.get("emoji"));
		jsonObj.put("limit_days", leaveData.get("limit_days"));
		jsonObj.put("remaining_leave", leaveData.get("remaining_leave"));
		jsonObj.put("info1", leaveData.get("info1"));
		jsonObj.put("info2", leaveData.get("info2"));
		jsonObj.put("info3", leaveData.get("info3"));

		return jsonObj.toString();

	}

	// 휴가 신청하기
	@ResponseBody
	@RequestMapping(value = "/leave/requestLeave.yolo", produces = "text/plain;charset=UTF-8", method = {
			RequestMethod.POST })
	public void requestLeave(MultipartHttpServletRequest mrequest) throws ParseException {

		HttpSession session = mrequest.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");

		String pk_leave_type = mrequest.getParameter("pk_leave_type");
		String start_date = mrequest.getParameter("start_date");
		String end_date = mrequest.getParameter("end_date");
		String leave_content = mrequest.getParameter("leave_content");

		Map<String, String> parameterMap = new HashMap<>();

		// === #153. !!! 첨부파일이 있는경우 작업시작 !!! === //
		MultipartFile attach = mrequest.getFile("attach");

		// attach(첨부파일)가 비어있지 않다면 (즉 첨부파일이 있는 경우라면 )
		if (attach != null && !attach.isEmpty()) {

			String path = "C:\\Users\\sist\\git\\Yolo\\Yolo\\src\\main\\webapp\\files\\leave\\";

			/*
			 * 2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기
			 */
			String newFileName = "";
			// WAS(톰캣)의 디스크에 저장되어질 파일네임 날짜 + 나노시간 + 파일확장자 식으로 저장되어짐

			byte[] bytes = null; // 첨부파일의 내용물을 담는 것

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
				 * 3. BoardVo boardvo 에 fileName, orgFilename, fileSize 를 담아줘야함
				 */

				parameterMap.put("fileName", newFileName); // WAS에 저장된 파일명 // 20221028235426101969758220700.png
				parameterMap.put("originalFilename", originalFilename); // 강아지.png

			} catch (Exception e) { // 꺠진 파일을 읽어올 수 도 있으므로 exception 처리 //fileManager에서 pathname 가 잘못되면 오류가 발생하는 오류도
									// 잡아줌
				e.printStackTrace();
			}
		}
		// === !!! 첨부파일이 있는경우 작업끗 !!! === //
		else {
			parameterMap.put("fileName", ""); // WAS에 저장된 파일명 // 20221028235426101969758220700.png
			parameterMap.put("originalFilename", ""); // 강아지.png
		}

		parameterMap.put("empno", loginuser.getEmpno());
		parameterMap.put("pk_leave_type", pk_leave_type);
		parameterMap.put("start_day", start_date);
		parameterMap.put("end_day", end_date);
		parameterMap.put("use_reason", leave_content);

		// System.out.println(loginuser.getEmpno()+pk_leave_type+start_date+end_date+String.valueOf((end.compareTo(start)+1))+leave_content+add_file+parameterMap.get("originalFilename")+parameterMap.get("fileName"));
		service.requestLeave(parameterMap);

	}

	// 휴가 사용 내역 조회하기
	@ResponseBody
	@RequestMapping(value = "/leave/getLeaveRecode.yolo", produces = "text/plain;charset=UTF-8")
	public String getLeaveRecode(HttpServletRequest request) {

		String empno = request.getParameter("empno");
		
		EmployeeVO loginuser;
		
		if(empno != null) {
			loginuser = new EmployeeVO();
			loginuser.setEmpno(empno);
		} else {
			HttpSession session = request.getSession();
			loginuser = (EmployeeVO) session.getAttribute("loginuser");
		}

		String year = request.getParameter("year");

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("empno", loginuser.getEmpno());
		paraMap.put("year", year);

		List<Map<String, String>> leaveRecordList = service.getLeaveRecode(paraMap);

		JSONArray jsonArr = new JSONArray();

		for (Map<String, String> leaveRecord : leaveRecordList) {
			JSONObject jsonObj = new JSONObject();

			jsonObj.put("pk_request_leaveno", leaveRecord.get("pk_request_leaveno"));
			jsonObj.put("fk_leave_type", leaveRecord.get("fk_leave_type"));
			jsonObj.put("start_day", leaveRecord.get("start_day"));
			jsonObj.put("end_day", leaveRecord.get("end_day"));
			jsonObj.put("use_days", leaveRecord.get("use_days"));
			jsonObj.put("start_name", leaveRecord.get("start_name"));
			jsonObj.put("end_name", leaveRecord.get("end_name"));
			jsonObj.put("opproval_status", leaveRecord.get("opproval_status"));
			jsonObj.put("add_file", leaveRecord.get("add_file"));
			jsonObj.put("filename", leaveRecord.get("filename"));
			jsonObj.put("orgfilename", leaveRecord.get("orgfilename"));
			jsonObj.put("emoji", leaveRecord.get("emoji"));
			jsonObj.put("leave_name", leaveRecord.get("leave_name"));

			jsonArr.put(jsonObj);
		}

		return jsonArr.toString();
	}

	// 휴가 예정 내역 조회하기
	@ResponseBody
	@RequestMapping(value = "/leave/getLeavePlan.yolo", produces = "text/plain;charset=UTF-8")
	public String getLeavePlan(HttpServletRequest request) {

		String empno = request.getParameter("empno");
		
		EmployeeVO loginuser;
		
		if(empno != null) {
			loginuser = new EmployeeVO();
			loginuser.setEmpno(empno);
		} else {
			HttpSession session = request.getSession();
			loginuser = (EmployeeVO) session.getAttribute("loginuser");
		}

		String year = request.getParameter("year");

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("empno", loginuser.getEmpno());
		paraMap.put("year", year);

		List<Map<String, String>> leavePlanList = service.getLeavePlan(paraMap);

		JSONArray jsonArr = new JSONArray();

		for (Map<String, String> leaveRecord : leavePlanList) {
			JSONObject jsonObj = new JSONObject();

			jsonObj.put("pk_request_leaveno", leaveRecord.get("pk_request_leaveno"));
			jsonObj.put("fk_leave_type", leaveRecord.get("fk_leave_type"));
			jsonObj.put("start_day", leaveRecord.get("start_day"));
			jsonObj.put("end_day", leaveRecord.get("end_day"));
			jsonObj.put("use_days", leaveRecord.get("use_days"));
			jsonObj.put("start_name", leaveRecord.get("start_name"));
			jsonObj.put("end_name", leaveRecord.get("end_name"));
			jsonObj.put("opproval_status", leaveRecord.get("opproval_status"));
			jsonObj.put("add_file", leaveRecord.get("add_file"));
			jsonObj.put("filename", leaveRecord.get("filename"));
			jsonObj.put("orgfilename", leaveRecord.get("orgfilename"));
			jsonObj.put("emoji", leaveRecord.get("emoji"));
			jsonObj.put("leave_name", leaveRecord.get("leave_name"));

			jsonArr.put(jsonObj);
		}

		return jsonArr.toString();

	}

	
	// 휴가신청 번호로 휴가신청 상세 조회
	@ResponseBody
	@RequestMapping(value = "/leave/getLeaveDetail.yolo", produces = "text/plain;charset=UTF-8")
	public String getLeaveRequestDetail(HttpServletRequest request) {

		String request_leaveno = request.getParameter("request_leaveno");

		Map<String, String> leaveRequestDetail = service.getLeaveRequestDetail(request_leaveno);

		JSONObject jsonObj = new JSONObject();

		jsonObj.put("pk_request_leaveno", leaveRequestDetail.get("pk_request_leaveno"));
		jsonObj.put("fk_leave_type", leaveRequestDetail.get("fk_leave_type"));
		jsonObj.put("fk_empno", leaveRequestDetail.get("fk_empno"));
		jsonObj.put("start_day", leaveRequestDetail.get("start_day"));
		jsonObj.put("end_day", leaveRequestDetail.get("end_day"));
		jsonObj.put("use_days", leaveRequestDetail.get("use_days"));
		jsonObj.put("start_name", leaveRequestDetail.get("start_name"));
		jsonObj.put("end_name", leaveRequestDetail.get("end_name"));
		jsonObj.put("use_reason", leaveRequestDetail.get("use_reason"));
		jsonObj.put("opproval_status", leaveRequestDetail.get("opproval_status"));
		jsonObj.put("add_file", leaveRequestDetail.get("add_file"));
		jsonObj.put("filename", leaveRequestDetail.get("filename"));
		jsonObj.put("orgfilename", leaveRequestDetail.get("orgfilename"));
		jsonObj.put("emoji", leaveRequestDetail.get("emoji"));
		jsonObj.put("leave_name", leaveRequestDetail.get("leave_name"));
		jsonObj.put("name", leaveRequestDetail.get("name"));
		jsonObj.put("nickname", leaveRequestDetail.get("nickname"));
		jsonObj.put("profile_color", leaveRequestDetail.get("profile_color"));
		
		return jsonObj.toString();
	}
	
	
	
	// 휴가신청에 파일 추가 하기
	@ResponseBody
	@RequestMapping(value = "/leave/addLeavFile.yolo", produces = "text/plain;charset=UTF-8")
	public void addLeavFile(MultipartHttpServletRequest mrequest) {

		String pk_request_leaveno = mrequest.getParameter("pk_request_leaveno");
		MultipartFile attach = mrequest.getFile("attach");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("pk_request_leaveno", pk_request_leaveno);
		
		// attach(첨부파일)가 비어있지 않다면 (즉 첨부파일이 있는 경우라면 )
		if (attach != null && !attach.isEmpty()) {

			String path = "C:\\Users\\sist\\git\\Yolo\\Yolo\\src\\main\\webapp\\files\\leave\\";

			/*
			 * 2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기
			 */
			String newFileName = "";
			// WAS(톰캣)의 디스크에 저장되어질 파일네임 날짜 + 나노시간 + 파일확장자 식으로 저장되어짐

			byte[] bytes = null; // 첨부파일의 내용물을 담는 것

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
				 * 3. BoardVo boardvo 에 fileName, orgFilename, fileSize 를 담아줘야함
				 */

				paraMap.put("fileName", newFileName); // WAS에 저장된 파일명 // 20221028235426101969758220700.png
				paraMap.put("originalFilename", originalFilename); // 강아지.png
				
				service.addFileToRequestLeave(paraMap);
				

			} catch (Exception e) { // 꺠진 파일을 읽어올 수 도 있으므로 exception 처리 //fileManager에서 pathname 가 잘못되면 오류가 발생하는 오류도
									// 잡아줌
				e.printStackTrace();
			}
		}
		// === !!! 첨부파일이 있는경우 작업끗 !!! === //
		
	}
	
	
	
	// 휴가신청 삭제하기
	@ResponseBody
	@RequestMapping(value = "/leave/deleteRequestLeave.yolo", produces = "text/plain;charset=UTF-8")
	public void deleteRequestLeave(HttpServletRequest request) {

		String request_leaveno = request.getParameter("request_leaveno");
		Map<String, String> leaveRequestDetail = service.getLeaveRequestDetail(request_leaveno);
		
		// 파일이 올라가 있다면 먼저 지워줘야 한다.
		if(leaveRequestDetail.get("add_file").equals("1") && leaveRequestDetail.get("filename")!=null && !"".equals(leaveRequestDetail.get("filename"))){
			String fileName = leaveRequestDetail.get("filename");
			String path = "C:\\Users\\sist\\git\\Yolo\\Yolo\\src\\main\\webapp\\files\\leave\\";
			fileManager.doFileDelete(fileName,  path);
		} 
		
		service.deleteRequestLeave(leaveRequestDetail); // 휴가신청 삭제하기
		
	}
	
	
	
	// 휴가신청 첨부파일 다운받기
	@ResponseBody
	@RequestMapping(value = "/leave/downloadLeaveFile.yolo", produces="text/plain;charset=UTF-8" )
	public void downloadLeaveFile(HttpServletRequest request, HttpServletResponse response) {
		String fileName = request.getParameter("fileName");
		String orgFilename = request.getParameter("orgFilename");
		
		// view단 페이지가 없기 때문에 이 자체 내에서 다 해주어야한다 
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = null; // out은 웹브라우저에 기술하는 대상체 라고 생각하자
		
		try {
			
			if(fileName!=null && !"".equals(fileName)) {
				
				String path = "C:\\Users\\sist\\git\\Yolo\\Yolo\\src\\main\\webapp\\files\\leave\\";
				
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
	
	
	
	// 승인 / 반려하기 함수 
	@ResponseBody
	@RequestMapping(value = "/leave/approvalRequestLevae.yolo", produces = "text/plain;charset=UTF-8")
	public void addAlarm_approvalRequestLevae(Map<String, String> paraMap, HttpServletRequest request) {

		Map<String, String> leaveRequestDetail = service.getLeaveRequestDetail(request.getParameter("request_leaveno"));
		leaveRequestDetail.put("approval_status", request.getParameter("approval_status"));
		
		service.approvalRequestLevae(leaveRequestDetail); 
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		// 승인일때 소식
		if("1".equals(request.getParameter("approval_status"))) {
			paraMap.put("alarm_content", loginuser.getName()+"님이 휴가를 승인했습니다." );
			paraMap.put("alarm_type", "3" );
			
		} else { // 반려일때 소식
			paraMap.put("alarm_content", loginuser.getName()+"님이 휴가를 반려했습니다." );
			paraMap.put("alarm_type", "2" );
		}
		
		paraMap.put("fk_recipientno", request.getParameter("empno") ); // 받는사람 (여러명일때는 ,으로 구분된 str)
		paraMap.put("url", "/leaveSummary");
		paraMap.put("url2", ".yolo"); // 연결되는 pknum등... (여러개일때는 ,으로 구분된 str)(대신 받는 사람 수랑 같아야됨)
		
		
	}
	
	

	// 관리자 구성원 휴가 보유 현황
	@RequestMapping(value = "/empLeaveStatus.yolo")
	public String empLeaveStatus(HttpServletRequest request) {

		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");

		// 관리자의 부서번호를 통해서 아래부서를 다 알아온다
		List<String> deptnoList = service.getLowerDeptnoList(loginuser.getFk_deptno());

		// 위에서 조회한 부서에 해당하는 사원들의 휴가 사용/잔여 내역을 불러온다
		List<Map<String, String>> leaveStatusList = service.getLeaveStatusList(String.join(",", deptnoList));

		request.setAttribute("leaveStatusList", leaveStatusList);

		// 관리자 권한 알아보기
		List<String> adminEmpnoList = service.getAdminEmpnoList();
		if (adminEmpnoList.contains(loginuser.getEmpno())) {
			request.setAttribute("isAdmin", "1");
		}

		return "jihyun/leave/empLeaveStatus.admin"; // 뷰단 페이지
	}

	
	// 관리자 구성원 휴가 사용 내역
	@RequestMapping(value = "/empLeaveUsingList.yolo")
	public String empLeaveUsingList(HttpServletRequest request) {

		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");

		// 관리자의 부서번호를 통해서 아래부서를 다 알아온다
		List<String> deptnoList = service.getLowerDeptnoList(loginuser.getFk_deptno());
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("empno", loginuser.getEmpno());
		paraMap.put("deptJoin", String.join(",", deptnoList));

		// 위에서 조회한 부서에 해당하는 사원들의 휴가 신청내역을 불러온다
		List<Map<String, String>> requestLeaveList = service.getRequestLeaveList(paraMap);

		request.setAttribute("requestLeaveList", requestLeaveList);

		// 관리자 권한 알아보기
		List<String> adminEmpnoList = service.getAdminEmpnoList();
		if (adminEmpnoList.contains(loginuser.getEmpno())) {
			request.setAttribute("isAdmin", "1");
		}

		return "jihyun/leave/empLeaveUsingList.admin"; // 뷰단 페이지
	}

	// 연차촉진하기
	@ResponseBody
	@RequestMapping(value = "/leave/promoteAnnual.yolo")
	public void addAlarm_promoteAnnual(Map<String, String> paraMap, HttpServletRequest request) {

		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");

		String empno = request.getParameter("empno");

		paraMap.put("fk_recipientno", empno); // 받는사람 (여러명일때는 ,으로 구분된 str)
		paraMap.put("url", "/leaveSummary");
		paraMap.put("url2", ".yolo"); // 연결되는 pknum등... (여러개일때는 ,으로 구분된 str)(대신 받는 사람 수랑 같아야됨)
		paraMap.put("alarm_content", loginuser.getName() + "님이 연차 사용을 요청했습니다.");
		paraMap.put("alarm_type", "1");

	}
	
	
	
	///////////////////////////////////////////////////관리자가 해당 사원 보는 메소드들 //////////////////////////////////////////////////////////////
	// 내휴가
	@RequestMapping(value = "/leave/specificEmpLeave.yolo")
	public ModelAndView specificEmpLeave(HttpServletRequest request, ModelAndView mav) {

		String empno = request.getParameter("empno");
		String name = request.getParameter("name");

		Calendar currentDate = Calendar.getInstance();
		SimpleDateFormat dateft = new SimpleDateFormat("yyyy");

		String year = dateft.format(currentDate.getTime());

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("empno", empno);
		paraMap.put("year", year);

		List<Map<String, String>> leaveTypeList = service.getLeaveTypeList(paraMap); // 휴가 종류와 남은 일수 구해오기
		mav.addObject("leaveTypeList", leaveTypeList);
		
		mav.addObject("empno", empno);
		mav.addObject("name", name);

		mav.setViewName("jihyun/leave/specificEmpLeaveSummary.admin");
		
		return mav;
	}
	
	
	
	

	/*
	 * @ExceptionHandler 에 대해서..... ==> 어떤 컨트롤러내에서 발생하는 익셉션이 있을시 익셉션 처리를 해주려고 한다면
	 * 
	 * @ExceptionHandler 어노테이션을 적용한 메소드를 구현해주면 된다
	 * 
	 * 컨트롤러내에서 @ExceptionHandler 어노테이션을 적용한 메소드가 존재하면, 스프링은 익셉션
	 * 발생시 @ExceptionHandler 어노테이션을 적용한 메소드가 처리해준다. 따라서, 컨트롤러에 발생한 익셉션을 직접 처리하고
	 * 싶다면 @ExceptionHandler 어노테이션을 적용한 메소드를 구현해주면 된다.
	 */
	@ExceptionHandler(java.lang.Throwable.class)
	public void handleThrowable(Throwable e, HttpServletRequest request, HttpServletResponse response) {

		e.printStackTrace(); // 콘솔에 에러메시지 나타내기

		try {
			// *** 웹브라우저에 출력하기 시작 *** //

			// HttpServletResponse response 객체는 넘어온 데이터를 조작해서 결과물을 나타내고자 할때 쓰인다.
			response.setContentType("text/html; charset=UTF-8");

			PrintWriter out = response.getWriter(); // out 은 웹브라우저에 기술하는 대상체라고 생각하자.

			out.println("<html>");
			out.println("<head><title>오류메시지 출력하기</title></head>");
			out.println("<body>");
			out.println("<h1>오류발생</h1>");

			// out.printf("<div><span style='font-weight: bold;'>오류메시지</span><br><span
			// style='color: red;'>%s</span></div>", e.getMessage());

			String ctxPath = request.getContextPath();

			out.println("<div><img src='" + ctxPath + "/resources/images/error.gif'/></div>");
			out.printf("<div style='margin: 20px; color: blue; font-weight: bold; font-size: 26pt;'>%s</div>", "장난금지");
			out.println("<a href='" + ctxPath + "/index.action'>홈페이지로 가기</a>");
			out.println("</body>");
			out.println("</html>");

			// *** 웹브라우저에 출력하기 끝 *** //
		} catch (IOException e1) {
			e1.printStackTrace();
		}

	}
}
