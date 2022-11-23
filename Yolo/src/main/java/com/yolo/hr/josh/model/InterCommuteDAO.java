package com.yolo.hr.josh.model;


public interface InterCommuteDAO {

	// 출근 메소드
	int commuteStart(String fk_empno);

	// 출근했는지 확인하는 메소드
	CommuteVO checkCommute(String fk_empno);

}
