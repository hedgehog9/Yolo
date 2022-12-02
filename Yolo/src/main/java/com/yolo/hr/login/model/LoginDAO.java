package com.yolo.hr.login.model;

import java.util.*;

import javax.annotation.Resource;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.yolo.hr.jjy.employee.model.EmployeeVO;

@Repository
public class LoginDAO implements InterLoginDAO {

	@Resource
	private SqlSessionTemplate sqlsession; 
	
	
	// 아이디와 비밀번호를 입력 받아 vo를 반환
	@Override
	public EmployeeVO checkLogin(Map<String, String> loginMap) {
		
		EmployeeVO loginuser = sqlsession.selectOne("jangjy.checkLogin",loginMap);
		return loginuser;
	}// end of public boolean checkLogin(Map<String, String> loginMap) {}---------------------


	// 휴직중인 사원의 목록을 조회하는 메소드 
	@Override
	public List<Map<String, String>> getLeaveEmpList() {
		List<Map<String, String>> leaveEmpList = sqlsession.selectList("jangjy.getLeaveEmpList");
		return leaveEmpList;
	}


	// 휴직이 끝난 사원 리스트를 전달받아 재직 처리하는 메소드
	@Override
	public void updateLeaveEmp(Map<String, String[]> paraMap) {
		sqlsession.selectList("jangjy.updateLeaveEmp",paraMap);
		
	}

}
