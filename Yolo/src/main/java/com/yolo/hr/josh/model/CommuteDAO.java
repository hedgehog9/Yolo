package com.yolo.hr.josh.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class CommuteDAO implements InterCommuteDAO {

	@Resource
	private SqlSessionTemplate sqlsession;

	// 출근 메소드
	@Override
	public int commuteStart(String fk_empno) {
		int n = sqlsession.insert("josh.commuteStart",fk_empno);
		return n;
	}

	// 출근했는지 확인하는 메소드
	@Override
	public CommuteVO checkCommute(String fk_empno) {
		CommuteVO commentvo = sqlsession.selectOne("josh.checkCommute",fk_empno);
		return commentvo;
	}

	// 퇴근 메소드
	@Override
	public int commuteEnd(Map<String, String> paraMap) {
		int n = sqlsession.update("josh.commuteEnd",paraMap);
		return n;
	}

	// 특정사원의 일주일 출근기록을 가져오는 메소드
	@Override
	public List<CommuteVO> mycommute(Map<String, String> paraMap) {
		List<CommuteVO> commuteList = sqlsession.selectList("josh.mycommute",paraMap);
		return commuteList;
	}

	
	@Override
	public List<HashMap<String, String>> selectDeptList() {
		List<HashMap<String, String>> deptList = sqlsession.selectList("josh.selectDept");
		return deptList;
	}

	// 사원들의 근무기록을 가져오는 메소드
	@Override
	public List<HashMap<String, String>> totalCommuteList(Map<String, Object> paraMap) {
		List<HashMap<String, String>> totalCommuteList = sqlsession.selectList("josh.totalCommuteList",paraMap);
		return totalCommuteList;
	}

	// 토탈페이지를 가져오는 메소드
	@Override
	public int commuteTotalPage(Map<String, Object> paraMap) {
		int totalPage = sqlsession.selectOne("josh.commuteTotalPage", paraMap);
		return totalPage;
	}

	// 급여정산 후에 리스트 불러오기
	@Override
	public List<Map<String, Object>> getPaymentList(Map<String, Object> paraMap) {
		List<Map<String, Object>> getPaymentList = sqlsession.selectList("josh.getPaymentList",paraMap);
		return getPaymentList;
	}

	// 급여정산 totalPage
	@Override
	public int paymentListTotalPage(Map<String, Object> paraMap) {
		int totalPage = sqlsession.selectOne("josh.paymentListTotalPage", paraMap);
		return totalPage;
	}

	// 급여정보 보내서 insert 하기
	@Override
	public int checkedPayment(List<Map<String, Object>> paraList) {
		int n = sqlsession.insert("josh.checkedPayment", paraList);
		return n;
	}

	// 급여 명세서를 가져오는 메소드
	@Override
	public List<Map<String, String>> getPayStubList(Map<String, Object> paraMap) {
		List<Map<String, String>> payStubList = sqlsession.selectList("josh.getPayStubList", paraMap);
		return payStubList;
	}

	// 퇴직금을 받을 수 있는 회원명단을 가져오는 메소드
	@Override
	public List<Map<String, String>> getSeverancePayList(Map<String, Object> pageMap) {
		List<Map<String, String>> getSeverancePayList = sqlsession.selectList("josh.getSeverancePayList", pageMap);
		return getSeverancePayList;
	}

	// 퇴직금 총 페이지수 가져오는 메소드
	@Override
	public int getTotalPage(Map<String, Object> pageMap) {
		int totalPage = sqlsession.selectOne("josh.getSeverancePayListTotalPage",pageMap);
		return totalPage;
	}

	// 퇴직금 테이블에 insert
	@Override
	public int severancePayment(List<Map<String, Object>> paraList) {
		int n = sqlsession.insert("josh.severancePayment", paraList);
		return n;
	}
	
}
