
# "Yolo"
>  Spring 으로 구현한 인사관리 시스템

<Br>

## 프로젝트 진행 기간
>  2022.11.4 ~ 2022.12.20
![프로젝트 일정](https://user-images.githubusercontent.com/100989788/209290095-53f1ec11-fd7a-48b0-afc9-cba1d3ce5cea.png)

<Br>
<h3>🍀프로젝트 소개 🍀</h3>
HTML, CSS, JAVASCRIPT, JAVA, OARCLE 등 언어들을 활용하여 Spring Framework 의 MVC 패턴 기법을 적용한 인사프로그램을 웹사이트로 구현
사용자 친화적인 UI 와 기본에 충실한 그룹웨어로 조직 구성원들이 의사 소통, 업무 전달, 정보 공유 및 의사 결정들의 업무 활동을 원활하게 수행하고 지원.
<br>


## 🌈개발환경

- OS : Windows 10 , windows 11 <br>
- FW : Spring Framework <br>
- WAS : Apache Tomcat 9.0.65
- Front-end : HTML5 / CSS / javascript / jQuery / AJAX / JSON
- Back-end : JDK 1.8 / JSP / JSTL
- Developer Tools : STS 3.9.12 / eXERD / SqlDeveloper 
- GitHub

<br>

### ⚡Tech Stack⚡

**Front-end**
<br><br>
<img src="https://img.shields.io/badge/HTML5-00599C?style=flat-square&logo=HTML5&logoColor=white"/>
<img src="https://img.shields.io/badge/CSS-A8B9CC?style=flat-square&logo=C&logoColor=white"/>
<img src="https://img.shields.io/badge/javascript-F6C915?style=flat-square&logo=javascript&logoColor=white"/>
<img src="https://img.shields.io/badge/Java-006D5C?style=flat-square&logo=Java&logoColor=white"/>
<img src="https://img.shields.io/badge/jQuery-red?style=flat-square&logo=jQuery&logoColor=white"/>
<img src="https://img.shields.io/badge/AJAX -black?style=flat-square&logo=AJAX &logoColor=white"/>

	 

**Back-end** 
<br><br>
<img src="https://img.shields.io/badge/JDK 1.8-important?style=flat-square&logo=JDK &logoColor=white"/>
<img src="https://img.shields.io/badge/JSP-yellowgreen?style=flat-square&logo=JSP&logoColor=white"/>
<img src="https://img.shields.io/badge/JSTL-blue?style=flat-square&logo=JSTL&logoColor=white"/>


<br>

### 🛠️ TOOL🛠️
<br><br>
<img src="https://img.shields.io/badge/STS 3.9.12-purple?style=flat-square&logo=STS&logoColor=white"/>
<img src="https://img.shields.io/badge/eXERD-brightgreen?style=flat-square&logo=eXERD&logoColor=white"/>
<img src="https://img.shields.io/badge/SqlDeveloper-9cf?style=flat-square&logo=SqlDeveloper &logoColor=white"/>
<img src="https://img.shields.io/badge/gitHub-blueviolet?style=flat-square&logo=gitHub&logoColor=white"/>


<br>

## 주요 기능 

```sh
- 사원 관리 
- 근태 관리 
- 급여 관리
- 사내 일정 관리 
- 휴가 관리
- 전자 결재 
- 메신저 
- 공지사항
```
<br>


## 사용한 API 

* kakao 우편번호 서비스
* fullcalendar-5.6.0


<Br>

## 🧑‍🚀 팀원
```
장진영 - 사원 등록, 관리
진민지 - 공지사항
최지희 - 전자 결재
조상운 - 급여관리, 근태관리, 사내 일정관리
김지현 - 새로운 소식, 메신저, 휴가 관리
```
<br>
## 주요 기능 

## 로그인
- 이메일을 아이디로 사용 
![로그인 화면](https://user-images.githubusercontent.com/100989788/209433886-01b3ebad-4d57-41b5-911d-ae176a3aa6b5.png)


## 메신저
- 보낸 메신저와 받은 메신저 페이지로 구성
- 보낸 메신저의 경우 전달하기 기능, 받은 메신저의 경우 전달하기, 답장하기 기능 구현
- 메신저는 부서로 정렬된 사원을 다중선택하여 보낼 수 있음
- 답장이 있는 메신저의 경우 원글 보기 버튼을 클릭하여 원글을 볼 수 있음
- 메신저 첨부파일은 다중선택 가능
- 사원명, 메신저 제목, 메신저 내용으로 검색가능
- 페이징 구현
- 메신저 열람시 읽은 메신저로 바뀜 <br>
![image](https://user-images.githubusercontent.com/103317169/209462970-03f8033c-5fc5-4dab-aa3f-fcc7d2573fe5.png)
![image](https://user-images.githubusercontent.com/103317169/209462869-e05779db-2c8d-4e5f-8d20-45e325ac20aa.png)
<br><br>

## 새로운 소식
- 새로운 소식 열람하지 않은 알림, 지난 소식은 열람한 알람들 중 7일 안에 온 알람이 보인다. 
- 새로운 소식에 추가되는 경우
	 * 전체공지 / 사원이 속한 부서의 공지가 올라올때
	 * 해당 사원이 결재해야하는 기안 문서가 작성됐을때
	 * 해당 사원이 쓴 기안 문서가 결재가 승인/반려/결재완료 되었을때
	 * 해당 사원이 인사이동이 있을때
	 * 해당 달의 급여가 지급 되었을 때
	 * 휴가가 승인/ 반려 되었을때
	 * 상위 결재자가 연차 사용을 권장하였을 때<br>
![image](https://user-images.githubusercontent.com/103317169/209463263-3dfde7a2-7399-46c5-ab55-6988724e2764.png)
<br><br>


## 구성원 조회 
- 검색창에 숫자 입력 시 사번으로 검색, 한글 입력시 이름으로 검색하도록 구현
- 직위, 부서, 재직 상태로 다중 필터를 적용하여 검색 가능하도록 구현 
- 구성원 정보 다운로드 시 현재 보고있는 구성원 리스트를 엑셀 파일로 저장
- 페이징 처리 <br>
![구성원 메인 페이지](https://user-images.githubusercontent.com/100989788/209433776-8d6c866f-67e9-4481-ad53-6b91eb193e4f.png)

<br><br>
## 구성원 관리
- 휴직, 퇴직 처리가 가능
- 구성원 본인, 관리자의 경우 개인정보수정, 첨부파일 첨부, 다운로드 가능
- 인사발령의 경우 관리자만 발령 가능  
- 구성원 한명의 정보 입력 후 한명씩 등록하거나, 엑셀 파일로 여러명의 구성원 일괄 등록 기능 구현 <br> 
![구성원 상세](https://user-images.githubusercontent.com/100989788/209433788-5ffbc218-1835-4a27-8fb8-92951238cde7.png)


## 출퇴근
- 출근하기 버튼 클릭시 자동으로 시간계산
- 퇴근하기 버튼 클릭시 점심시간이 공제된 근무시간 기록 <br>
![출퇴근](https://user-images.githubusercontent.com/65589607/209297538-9eaf95ca-855d-4a28-a6e3-926b2991e1d8.gif)
<br><br>
	
## 워크플로우(전자결재)
- 진행 중인 문서함(진행중,승인필요) / 내가 쓴 문서함(진행중,완료) / 완료 문서함(완료) 리스트 조회 
  <br><문서함별로 페이징>
- 진행중인 문서함에서 본인 승인 차례가 되면 문서함 리스트에 승인필요 표시, 문서 내용에 반려,승인버튼 활성화
- 첨부파일 첨부, 다운로드 기능
- 문서를 작성, 수정하는 경우 히스토리 내역
- 문서 수정은 본인이 쓴 글만 가능하나 이미 승인이 1단계라도 시작된 경우 수정 불가
![워크플로우 메인2](https://user-images.githubusercontent.com/110098108/209600107-7db59bbf-a281-410c-9b06-82b73439598f.jpg)
	

### 작성하기
- 항목별로 작성하기 폼이 달라진다.
- 글 작성시 결재라인이 자동으로 불러와진다. (사원은 팀장-부서장,사장 / 팀장은 부서장-사원 식으로)
- 결재라인은 부서로 계층을 형성하여, 부서 테이블과 부서 맵핑테이블로 관리하기 때문에 사원들의 인사발령이 
  <br> 있어도 결재라인의 계층이 깨지지 않고 유지 된다.
![작성하기](https://user-images.githubusercontent.com/110098108/209600747-d6d5240a-cdab-48da-9618-15e8e7d898cb.png)
	

### 승인 형황
- 최종 결재권자를 제외한 결재자들은 본인 전단계 사원이 결재를 완료한 경우 승인,반려 가능
 <br>(문서 조회는 결재권과 상관없이 가능)
- 결재 단계중 반려된 단계가 있다면 최종 결재권자에게 이전 결재단계 승인여부와 관계없이 결재권 부여
- 최종결재권자 승인,반려시 문서는 최종완료 처리되며 이전 결재권자들에게 결재권한 박탈
![승인현황](https://user-images.githubusercontent.com/110098108/209600884-e4c06550-8940-4b4c-b9d3-f10b24d91129.png)

<br><br>
	
## 휴가
### 내 휴가
- 일반 사원의 경우 내 휴가 페이지만 보이며, 해당 기간에 남은 휴가를 조회하고 신청할 수 있다.
- 당일을 기준으로 해당년도의 휴가 사용기록과 예정 휴가로 나뉘어 보여진다 
- 예정 휴가의 경우 휴가 신청 취소가 가능하다 (취소시 캘린더의 휴가일정도 같이 삭제된다 )<br>
![image](https://user-images.githubusercontent.com/103317169/209463586-1e3de5de-d207-4ce4-9415-da1351416c61.png) <br>

- 휴가를 누르면 해당 휴가의 정보와 사용 가능한 일수 등의 설명이 뜨며, 날짜를 선택하여 휴가를 신청 할 수 있다.
- 사용기한이 남아있는 휴가의 경우 남은 기간만큼만 사용할수 있고, 조의/결혼/긴급 등은 선택한 사항에 따라 일수가 제한된다.
- 첨부파일이 필요한 휴가는 신청시에 첨부하여도 되고, 휴가 신청 리스트에서 휴가 상세에서 추가할 수도 있다.
- 휴가 신청시 사내 캘린더 해당 사원의 휴가가 추가된다.<br>
![image](https://user-images.githubusercontent.com/103317169/209463731-8103da33-c733-48e0-a33a-3ef06159ca4f.png)<br>

### 휴가 신청내역
- 팀장, 부서장, 사장, 관리자로 로그인 시 해당 팀, 부서, 전체사원의 휴가 신청 내역을 볼 수 있다.
- 휴가를 승인/ 반려 할 수 있다. (반려시 사내 스케줄에서도 삭제됨)<br>
![image](https://user-images.githubusercontent.com/103317169/209465296-65cab0db-4b46-4961-8111-c52d1ac833d6.png)<br>

### 휴가 보유/ 사용 내역
- 팀장, 부서장, 사장, 관리자로 로그인 시 해당 년도의 해당 팀, 부서, 전체사원의 휴가 보유/ 사용 내역을 볼 수 있다.	
- 사원의 이름을 클릭하면 해당 사원의 휴가 페이지로 이동한다
- 잔여 연차를 클릭하면 해당 사용에게 휴가 사용을 권고하는 소식 알람이 간다.
![image](https://user-images.githubusercontent.com/103317169/209465436-a0191602-d9c9-4d4b-b15b-8499a384bb77.png)
<br><br>
	
## 캘린더
- 캘린더 CRUD 기능 
- 사원테이블에 직원들의 생년월일을 캘린더에 자동추가
- 구글캘린더 대한민국 휴무일 api 연동 <br> 
![캘린더](https://user-images.githubusercontent.com/65589607/209296260-b1d27954-492b-40e7-adc9-3552c3414181.gif)




## ERD
<img width="788" alt="erd 최종" src="https://user-images.githubusercontent.com/100989788/209434132-13c6efe9-fbde-47d9-9e2b-da95b88ab2c3.png">

