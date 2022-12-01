package com.yolo.hr.jjy.employee.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;

import org.json.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yolo.hr.jjy.employee.model.EmployeeVO;
import com.yolo.hr.jjy.employee.service.InterEmployeeService;
import com.yolo.hr.login.service.InterLoginServcie;

@Controller
public class EmployeeController {
	
	@Autowired
	private InterEmployeeService service; 

	// 구성원 메인 페이지
	@RequestMapping(value = "/people.yolo")
	public String people() {
		return "jangjy/people_admin.admin";
	}
	
	
	@ResponseBody // return 되어지는 값 그 자체를 웹브라우저에 바로 직접 쓰여지게 하는 것이다. 일반적으로 JSON 값을 Return 할때 많이 사용된다.
	@RequestMapping(value = "/getEmpList.yolo", produces="text/plain;charset=UTF-8")
	public String getEmpList( HttpServletRequest request ) {
		
		Map<String,String> empMap = new HashMap<>();
		
		// 전체 사원을 조회해오는 메소드 
		List<EmployeeVO> empList = service.getEmpList(empMap);
		System.out.println("확인용 empList = " + empList);
		
		JSONArray jsonArr = new JSONArray();
		
		if(empList.size() != 0) {
			for(EmployeeVO evo: empList) {
				
				JSONObject jsonObj = new JSONObject();
				
				jsonObj.put("name", evo.getName()); // 이름 
				jsonObj.put("status", evo.getStatus()); // 재직상태
				jsonObj.put("empno", evo.getEmpno()); // 사번
				jsonObj.put("hireDate", evo.getHiredate()); // 입사일
				jsonObj.put("retireDate", evo.getRetiredate()); // 퇴사일
				jsonObj.put("date", "근속기간"); // 근속기간
				jsonObj.put("date2", "근무일수"); // 근무일수
				jsonObj.put("dept", evo.getFk_deptno()); // 부서
				jsonObj.put("position", evo.getPosition() ); // 직위
				jsonObj.put("email", evo.getEmail()); // 이메일
				jsonObj.put("gender", evo.getGender()); // 성별
				jsonObj.put("mobile", evo.getMobile()); // 연락처
				
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

	// 조직도
	@RequestMapping(value = "/organization_chart.yolo")
	public String organization_chart() {

		return "jangjy/organization_chart.admin";
	}

	// 사용자 한명 상세 정보 (admin)
	@RequestMapping(value = "/user_detail.yolo")
	public String user_detail() {

		return "jangjy/user_detail.admin";
	}

}
