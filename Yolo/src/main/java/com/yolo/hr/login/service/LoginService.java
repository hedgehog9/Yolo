package com.yolo.hr.login.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yolo.hr.jjy.employee.model.EmployeeVO;
import com.yolo.hr.login.model.InterLoginDAO;

@Service
public class LoginService implements InterLoginServcie {
	
	@Autowired
	private InterLoginDAO dao; 

	// 아이디와 비밀번호를 입력 받아 vo를 반환
	@Override
	public EmployeeVO checkLogin(Map<String, String> loginMap) {
		EmployeeVO loginuser = dao.checkLogin(loginMap);
		return loginuser;
	}

	// 휴직중인 사원 목록을 조회하는 메소드 
	@Override
	public List<Map<String, String>> getLeaveEmpList() {
		List<Map<String, String>> leaveEmpList = dao.getLeaveEmpList();
		return leaveEmpList;

	}
	// 휴직중인 사원의 목록을 전달받아 배열로 변환 후 update 하는 메소드
	@Override
	public void updateLeaveEmp(List<Map<String, String>> empList) {
		// update where 절에 in 을 사용하기 위해 list 를 배열로 변환
		if(empList != null && empList.size() > 0) {
	    	String[] arr_leaveEmp = new String[empList.size()];
	    	
	    	for(int i=0; i<empList.size(); i++) {
	    		arr_leaveEmp[i] = empList.get(i).get("empno");
	    	}
	    	
	    	Map<String,String[]> paraMap = new HashMap<>();
	    	paraMap.put("arr_leaveEmp", arr_leaveEmp);
	    	
	    	dao.updateLeaveEmp(paraMap);
		}
	}

	// 로그인시 휴직 처리할 사원의 목록을 가져와 현재 날짜와 비교해 휴직 시작인 경우 휴직 상태로 변경
	@Override
	public List<Map<String, String>> getLeaveStartEmpList() {
		List<Map<String, String>> leaveStartEmpList = dao.getLeaveStartEmpList();
		return leaveStartEmpList;
	}

	// 휴직중인 사원의 목록을 전달받아 배열로 변환 후 update 하는 메소드 
	@Override
	public void updateLeaveStartEmp(List<Map<String, String>> leaveStartEmpList) {
		// update where 절에 in 을 사용하기 위해 list 를 배열로 변환
		if(leaveStartEmpList != null && leaveStartEmpList.size() > 0) {
	    	String[] arr_leaveStartEmp = new String[leaveStartEmpList.size()];
	    	
	    	for(int i=0; i<leaveStartEmpList.size(); i++) {
	    		arr_leaveStartEmp[i] = leaveStartEmpList.get(i).get("empno");
	    	}
	    	
	    	Map<String,String[]> paraMap = new HashMap<>();
	    	paraMap.put("arr_leaveStartEmp", arr_leaveStartEmp);
	    	
	    	dao.updateLeaveStartEmp(paraMap);
		}
		
	}
	
	
	
	
	
}
