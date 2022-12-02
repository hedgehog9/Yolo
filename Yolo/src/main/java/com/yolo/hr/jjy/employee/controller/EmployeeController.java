package com.yolo.hr.jjy.employee.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;

import org.json.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
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
		
		Map<String,String> empMap = new HashMap<>();
		
		// 전체 사원을 조회해오는 메소드 
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
		System.out.println("휴직가능 여부 조회  결과 : " + result);

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
		
		// 등록하려는 날짜가 이미 등록된 날짜와 포함된다면 경고창 출력 
		int result = service.insertLeave(leaveMap);
		System.out.println("휴직처리 insert 결과 : "+ result);
		
		return "";
	}
	
	

	
	
	
	
	
}
