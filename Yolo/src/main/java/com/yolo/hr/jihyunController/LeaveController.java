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

import com.google.gson.JsonArray;
import com.yolo.hr.common.FileManager;
import com.yolo.hr.jihyunService.InterLeaveService;
import com.yolo.hr.jjy.employee.model.EmployeeVO;

@Controller
public class LeaveController {
	
	@Autowired
	private InterLeaveService service;
	
	// === #155. 파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI : Dependency Injection) ===
	@Autowired
	private FileManager fileManager; // bean으로 올라간 애를 쓰겠다

	// 내휴가 
	@RequestMapping(value="/leaveSummary.yolo") 
    public ModelAndView leaveSummary(HttpServletRequest request, ModelAndView mav) {
		
		// 가라 사원
		EmployeeVO loginuser = new EmployeeVO();
		loginuser.setEmpno("1050");
		// 가라 사원 끝
		
		Calendar currentDate = Calendar.getInstance();
		SimpleDateFormat dateft = new SimpleDateFormat("yyyy");
		
		String year = dateft.format(currentDate.getTime());
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("empno", loginuser.getEmpno());
		paraMap.put("year", year);
		
		List<Map<String, String>> leaveTypeList = service.getLeaveTypeList(paraMap); // 휴가 종류와 남은 일수 구해오기
		mav.addObject("leaveTypeList", leaveTypeList);
		
		
		mav.setViewName("jihyun/leave/leaveSummary.admin");
		
        return mav;
    }
	
	
	// 모달을 띄우기 위해서 해당 휴가에 대한 정보를 얻어온다
	@ResponseBody
	@RequestMapping(value = "/leave/getLeaveDate.yolo" , produces="text/plain;charset=UTF-8")
	public String getLeaveDate(HttpServletRequest request) {
		
		// 가라 사원
		EmployeeVO loginuser = new EmployeeVO();
		loginuser.setEmpno("1050");
		// 가라 사원 끝
		
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
	@RequestMapping(value = "/leave/requestLeave.yolo" , produces="text/plain;charset=UTF-8", method = {RequestMethod.POST})
	public void requestLeave(MultipartHttpServletRequest mrequest) throws ParseException {
		
		// 가라 사원
		EmployeeVO loginuser = new EmployeeVO();
		loginuser.setEmpno("1050");
		// 가라 사원 끝
		
		String pk_leave_type = mrequest.getParameter("pk_leave_type");
		String start_date = mrequest.getParameter("start_date");
		String end_date = mrequest.getParameter("end_date");
		String leave_content = mrequest.getParameter("leave_content");
		String add_file = mrequest.getParameter("add_file");
		
		
		Map<String, String> parameterMap = new HashMap<>();
		
		// === #153. !!! 첨부파일이 있는경우 작업시작 !!! === // 
		MultipartFile attach = mrequest.getFile("attach");
		
		// attach(첨부파일)가 비어있지 않다면 (즉 첨부파일이 있는 경우라면 )
		if( attach!=null && !attach.isEmpty()) {
			
			String path = "C:\\Users\\sist\\git\\Yolo\\Yolo\\src\\main\\webapp\\files\\leave\\";
	
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
				
				parameterMap.put("fileName", newFileName); // WAS에 저장된 파일명 // 20221028235426101969758220700.png
				parameterMap.put("originalFilename", originalFilename); // 강아지.png
				
			} catch (Exception e) { // 꺠진 파일을 읽어올 수 도 있으므로 exception 처리 //fileManager에서 pathname 가 잘못되면 오류가 발생하는 오류도 잡아줌
				e.printStackTrace();
			} 
		}
		// === !!! 첨부파일이 있는경우 작업끗 !!! === // 
		else {
			parameterMap.put("fileName", ""); // WAS에 저장된 파일명 // 20221028235426101969758220700.png
			parameterMap.put("originalFilename", ""); // 강아지.png
		}
		
		// 시작날짜 끝날짜 차이
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date start = sdf.parse(start_date);
		Date end = sdf.parse(end_date);
		// System.out.println(end.compareTo(start)+1);
		
		
		parameterMap.put("empno", loginuser.getEmpno());
		parameterMap.put("pk_leave_type", pk_leave_type);
		parameterMap.put("start_day", start_date);
		parameterMap.put("end_day", end_date);
		parameterMap.put("use_days", String.valueOf((end.compareTo(start)+1)));
		parameterMap.put("use_reason", leave_content);
		parameterMap.put("add_file", add_file);
		
		// System.out.println(loginuser.getEmpno()+pk_leave_type+start_date+end_date+String.valueOf((end.compareTo(start)+1))+leave_content+add_file+parameterMap.get("originalFilename")+parameterMap.get("fileName"));
		service.requestLeave(parameterMap);
		
	}
	
	
	// 휴가 사용 내역 조회하기
	@ResponseBody
	@RequestMapping(value = "/leave/getLeaveRecode.yolo" , produces="text/plain;charset=UTF-8")
	public String getLeaveRecode(HttpServletRequest request) {
		
		// 가라 사원
		EmployeeVO loginuser = new EmployeeVO();
		loginuser.setEmpno("1050");
		// 가라 사원 끝
		
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
	@RequestMapping(value = "/leave/getLeavePlan.yolo" , produces="text/plain;charset=UTF-8")
	public String getLeavePlan(HttpServletRequest request) {
		
		// 가라 사원
		EmployeeVO loginuser = new EmployeeVO();
		loginuser.setEmpno("1050");
		// 가라 사원 끝
		
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
