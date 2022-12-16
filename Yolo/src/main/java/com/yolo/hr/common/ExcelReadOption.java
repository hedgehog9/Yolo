package com.yolo.hr.common;


import java.util.*;

public class ExcelReadOption {
   //    엑셀파일의 경로
   private String filePath;
   
   //  추출할 컬럼 명  
   private List<String> outputColumns;
   
   //  추출을 시작할 행 번호
   private int startRow;

   public String getFilePath() {
       return filePath;
   }

   public void setFilePath(String filePath) {
       this.filePath = filePath;
   }

   public List<String> getOutputColumns() {

       List<String> temp = new ArrayList<String>();
       temp.addAll(outputColumns);

       return temp;
   }

   public void setOutputColumns(List<String> outputColumns) {

 //    이걸 A,B,C,D 이런 식으로 추가하던데
       List<String> temp = new ArrayList<String>();
       temp.addAll(outputColumns);

       this.outputColumns = temp;
   }

   public void setOutputColumns(String ... outputColumns) {

       if(this.outputColumns == null) {
           this.outputColumns = new ArrayList<String>();
       }

       for(String ouputColumn : outputColumns) {
           this.outputColumns.add(ouputColumn);
       }
   }

   public int getStartRow() {
       return startRow;
   }
   public void setStartRow(int startRow) {
       this.startRow = startRow;
   }
 }
