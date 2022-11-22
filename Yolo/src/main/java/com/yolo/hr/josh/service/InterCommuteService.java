package com.yolo.hr.josh.service;

import com.yolo.hr.josh.model.CommuteVO;

public interface InterCommuteService {

	// 출근 메소드
	int commuteStart(String fk_empno);

	// 출근했는지 확인하는 메소드
	CommuteVO checkCommute(String fk_empno);

}
