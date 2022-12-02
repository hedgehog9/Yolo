package com.yolo.hr.jjy.employee.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.yolo.hr.jjy.employee.model.*;

@Service
public class EmployeeService implements InterEmployeeService {

	@Autowired
	private InterEmployeeDAO dao;
	
	// 전체 사원을 조회 해오는 메소드 
	@Override
	public List<Map<String, String>> getEmpList(Map<String, String> empMap) {
		List<Map<String, String>> empList = dao.getEmpList(empMap);
		return empList;
	}

	// 사원 번호를 전달받아 사원 한명의 정보를 조회해오는 메소드
	@Override
	public Map<String, String> getEmpOne(Map<String, String> empnoMap) {
		Map<String, String> employeeMap = dao.getEmpOne(empnoMap);
		return employeeMap;
	}

	// 시작일, 종료일, 사원번호, 메모, 사원번호를 Map 으로 전달받아 휴직테이블에 insert 후 
	// 사원 테이블에 status 컬럼 "휴직" 으로 update 하는 메소드 (트랜잭션)
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int insertLeave(Map<String, String> leaveMap) {
		
		int leaveInsert = 0, leaveUpdate = 0, result =0;
		leaveInsert = dao.insertLeave(leaveMap);
		
		// 현재 날짜와 휴직 시작일 비교, 휴직 시작일이 작은 경우 휴직처리 
        LocalDate now = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String formatedNow = now.format(formatter);
        
        int dateResult = leaveMap.get("startdate").compareTo(formatedNow);
		
        if(dateResult == 0 || dateResult < 0) {// 휴직 신청 날짜가 같은 경우  또는 이후 날짜인 경우 
			if(leaveInsert == 1) {
				leaveUpdate = dao.updateLeave(leaveMap);
			}
        }
        if(leaveUpdate == 1) {result = 1;}
		return result;
	}


}
