package com.yolo.hr.jihee.workflow.model;

import org.springframework.web.multipart.MultipartFile;

public class documentVO {
	
	
	private int doc_no; 				// 문서번호                 
	private String fk_writer_empno; 		// 문서작성 사운번호       
	private String doc_subject;         //문서제목
	private String doc_contents;        // 문서내용
	private String writeday;              //  작성일자
	private String modificationday;       // 최근 수정 날짜
	private String icon;                  // 아이콘
	private String fileName;   			// WAS(톰캣)에 저장될 파일명(2022042911123035243254235235234.png) 
	private String orgFilename; 		// 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명
	private String fileSize; 		// 파일크기 
	private String D_day;        //희망 마감날짜
	
	private String deptno; // 부서 번호
	
	/*
	=== #152. 파일을 첨부하도록 VO 수정하기
             먼저, 오라클에서 tbl_board 테이블에 3개 컬럼(fileName, orgFilename, fileSize)을 추가한 다음에 아래의 작업을 한다. 
	 */
	 private MultipartFile attach;
	 /* form 태그에서 type="file" 인 파일을 받아서 저장되는 필드이다. 
	       진짜파일 ==> WAS(톰캣) 디스크에 저장됨.
	           조심할것은 MultipartFile attach 는 오라클 데이터베이스 tbl_board 테이블의 컬럼이 아니다.   
	    /Board/src/main/webapp/WEB-INF/views/tiles1/board/add.jsp 파일에서 input type="file" 인 name 의 이름(attach)과  
	      동일해야만 파일첨부가 가능해진다.!!!!
	*/
	
	
	public int getDoc_no() {
		return doc_no;
	}
	public void setDoc_no(int doc_no) {
		this.doc_no = doc_no;
	}
	public String getFk_writer_empno() {
		return fk_writer_empno;
	}
	public void setFk_writer_empno(String fk_writer_empno) {
		this.fk_writer_empno = fk_writer_empno;
	}
	public String getDoc_subject() {
		return doc_subject;
	}
	public void setDoc_subject(String doc_subject) {
		this.doc_subject = doc_subject;
	}
	public String getDoc_contents() {
		return doc_contents;
	}
	public void setDoc_contents(String doc_contents) {
		this.doc_contents = doc_contents;
	}
	public String getWriteday() {
		return writeday;
	}
	public void setWriteday(String writeday) {
		this.writeday = writeday;
	}
	public String getModificationday() {
		return modificationday;
	}
	public void setModificationday(String modificationday) {
		this.modificationday = modificationday;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getOrgFilename() {
		return orgFilename;
	}
	public void setOrgFilename(String orgFilename) {
		this.orgFilename = orgFilename;
	}
	public String getFileSize() {
		return fileSize;
	}
	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}
	public String getD_day() {
		return D_day;
	}
	public void setD_day(String d_day) {
		D_day = d_day;
	}
	public MultipartFile getAttach() {
		return attach;
	}
	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
	public String getDeptno() {
		return deptno;
	}
	public void setDeptno(String deptno) {
		this.deptno = deptno;
	}
	
	
	
	
	
	
	
	

}
