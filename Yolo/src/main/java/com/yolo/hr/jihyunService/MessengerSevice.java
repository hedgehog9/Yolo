package com.yolo.hr.jihyunService;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yolo.hr.jihyunModel.InterMessengerDAO;

@Service
public class MessengerSevice implements InterMessengerService {

	@Autowired
	private InterMessengerDAO mdao;

	
	// 전체 부서 조회하기
	@Override
	public List<Map<String, String>> getDeptList() {
		List<Map<String, String>> deptList = mdao.getDeptList();
		return deptList;
	}

	// 부서사람들 조회하기
	@Override
	public List<Map<String, String>> getDeptPersonList(String deptno) {
		List<Map<String, String>> deptPersonList = mdao.getDeptPersonList(deptno);
		return deptPersonList;
	}

	// 해당부서 팀 구해오기
	@Override
	public List<Map<String, String>> getTeam(String deptno) {
		List<Map<String, String>> teamList = mdao.getTeam(deptno);
		return teamList;
	}

	// 팀 사람들 구해오기
	@Override
	public List<Map<String, String>> getTeamPerson(String deptno) {
		List<Map<String, String>> teamPersonList = mdao.getTeamPerson(deptno);
		return teamPersonList;
	}
}
