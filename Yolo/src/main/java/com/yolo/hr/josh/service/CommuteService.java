package com.yolo.hr.josh.service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yolo.hr.josh.model.CommuteVO;
import com.yolo.hr.josh.model.InterCommuteDAO;

@Service
public class CommuteService implements InterCommuteService {

	@Autowired
	private InterCommuteDAO dao;

	// 출근 메소드
	@Override
	public int commuteStart(String fk_empno) {
		int n = dao.commuteStart(fk_empno);
		return n;
	}

	// 출근했는지 확인하는 메소드
	@Override
	public CommuteVO checkCommute(String fk_empno) {
		CommuteVO commentvo = dao.checkCommute(fk_empno);
		return commentvo;
	}

	// 퇴근 메소드
	@Override
	public int commuteEnd(Map<String, String> paraMap) {
		int n = dao.commuteEnd(paraMap);
		return n;
	}

	// 특정사원의 일주일 출근기록을 가져오는 메소드
	@Override
	public List<CommuteVO> mycommute(Map<String, String> paraMap) {
		List<CommuteVO> commuteList = dao.mycommute(paraMap);
		return commuteList;
	}

	// 사원들의 근무기록을 가져오는 메소드
	@Override
	public List<HashMap<String, String>> totalCommuteList(Map<String, Object> paraMap) {
		List<HashMap<String, String>> totalCommuteList = dao.totalCommuteList(paraMap);
		return totalCommuteList;
	}

	// 급여정산 후에 리스트 불러오기
	@Override
	public List<Map<String, Object>> getPaymentList(Map<String, Object> paraMap) {
		List<Map<String, Object>> getPaymentList = dao.getPaymentList(paraMap);
		return getPaymentList;
	}

	// 급여정보 보내서 insert 하기
	@Override
	public int checkedPayment(List<Map<String, Object>> paraList) {
		int n = dao.checkedPayment(paraList);
		return n;
	}

	// 급여명세서 불러오는 메소드
	@Override
	public List<Map<String, String>> getPayStubList(Map<String, Object> paraMap) {
		List<Map<String, String>> payStubList = dao.getPayStubList(paraMap);
		return payStubList;
	}

	
	// 퇴직금을 받을 수 있는 회원명단을 가져오는 메소드
	@Override
	public List<Map<String, String>> getSeverancePayList(Map<String, Object> pageMap) {
		
		String pattern = "^[0-9]*$"; // 숫자만 등장하는지
		String str = (String) pageMap.get("keyword"); 
		
		boolean result = Pattern.matches(pattern, str);
		
		String searchType = "";
		if(str != "") {
			if(result) {
				searchType = "empno";
			}
			if(!result){
				searchType = "name";
			}
		}
		pageMap.put("searchType", searchType);
		List<Map<String, String>> getSeverancePayList = dao.getSeverancePayList(pageMap);
		
		return getSeverancePayList;
	}

	// 퇴직금 총 페이지수 가져오는 메소드
	@Override
	public int getTotalPage(Map<String, Object> pageMap) {
		String pattern = "^[0-9]*$"; // 숫자만 등장하는지
		String str = (String) pageMap.get("keyword"); 
		
		boolean result = Pattern.matches(pattern, str);
		
		String searchType = "";
		if(str != "") {
			if(result) {
				searchType = "empno";
			}
			if(!result){
				searchType = "name";
			}
		}
		pageMap.put("searchType", searchType);
		
		int totalPage = dao.getTotalPage(pageMap);
		return totalPage;
	}

	@Override
	public int severancePayment(List<Map<String, Object>> paraList) {
		int n = dao.severancePayment(paraList);
		return n;
	}

	@Override
	public List<Map<String, Object>> sumWorktimeByDept() {
		List<Map<String, Object>> sumWorktimeByDeptList = dao.sumWorktimeByDept();
		return sumWorktimeByDeptList;
	}
	
}
