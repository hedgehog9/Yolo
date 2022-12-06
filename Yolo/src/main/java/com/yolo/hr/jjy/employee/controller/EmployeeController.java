package com.yolo.hr.jjy.employee.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;

import org.json.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yolo.hr.jjy.employee.model.EmployeeVO;
import com.yolo.hr.jjy.employee.model.InterEmployeeDAO;
import com.yolo.hr.jjy.employee.service.InterEmployeeService;
import com.yolo.hr.login.service.InterLoginServcie;

@Controller
public class EmployeeController {
	
	@Autowired
	private InterEmployeeService service; 
	
	@Autowired 
	private InterEmployeeDAO dao;

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
		
	    // 총 게시물 건수(totalCount)
	    int totalCount = service.getTotalCount(empMap);
//	    System.out.println("~~~~~~ 확인용 totalCount : " + totalCount);
	    
		// 전체 사원을 조회해오는 메소드 (검색어가 있는 경우 검색어 입력 )
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
				jsonObj.put("totalCount", totalCount); // 조회 결과물 수 
				
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
		
//		System.out.println(arr_position);
//		System.out.println(arr_dept);
//		System.out.println(arr_status);
//		
//		System.out.println("sizePerPage"+sizePerPage);
//		System.out.println("keyword"+keyword);
		
		
		Map<String,Object> pageMap = new HashMap<>();
		pageMap.put("sizePerPage", sizePerPage);
		pageMap.put("keyword", keyword); // 검색어를 입력한 경우 
		pageMap.put("arr_position", arr_position); // 검색어를 입력한 경우 
		pageMap.put("arr_dept", arr_dept); // 검색어를 입력한 경우 
		pageMap.put("arr_status", arr_status); // 검색어를 입력한 경우 
		
		int totalPage = service.getTotalPage(pageMap);
		
		// System.out.println("############## 확인용 ############"+totalPage);

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("totalPage",totalPage); // 1 이상인경우 휴직 신청 불가 
		
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
		
		
		if(currentShowPageNo == null) {
			currentShowPageNo ="1";
		}
		
		int sizePerPage = 10; // 한 페이지당 보여줄 댓글 건수 

		int startRno = ((Integer.parseInt(currentShowPageNo) - 1) * sizePerPage) + 1;
	    int endRno = startRno + sizePerPage - 1;
		
	    pageMap.put("startRno", String.valueOf(startRno));
	    pageMap.put("endRno", String.valueOf(endRno));
	    
	    
//	    System.out.println("currentShowPageNo : "+currentShowPageNo);
//		System.out.println("String.valueOf(startRno) : "+String.valueOf(startRno));
//		System.out.println("String.valueOf(endRno) : "+String.valueOf(endRno));
		
//		List<Map<String,String>> empList = service.empListWithRno(pageMap);
		
		// 페이징 처리한 글목록 가져오기 (검색이 있든지, 검색이 없든지 모두 다 포함한 것)
	    List<Map<String,String>> empListPaging = service.empListSearchWithPaging(pageMap);
		
//		System.out.println("확인용 페이징 empList : "+ empListPaging);
		
		JSONArray jsonArr = new JSONArray();
		
		if(empListPaging.size() != 0) {
			for(Map<String,String> EmpMap: empListPaging) {
				
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
	public String leaveabsence(HttpServletRequest request) {

		String leavetype = request.getParameter("leavetype");
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String memo = request.getParameter("memo");
		String empno = request.getParameter("empno");
		
		Map<String,String> leaveMap = new HashMap<>();
		
		leaveMap.put("leavetype", leavetype);
		leaveMap.put("startdate", startdate);
		leaveMap.put("enddate", enddate);
		leaveMap.put("memo", memo);
		leaveMap.put("empno", empno);
		
		int result = service.insertLeave(leaveMap);
		System.out.println("휴직처리 insert 결과 : "+ result);
		
		return "";
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
	
	
	
	
	
}
