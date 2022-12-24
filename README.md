
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

## 로그인
- 이메일을 아이디로 사용 
![로그인 화면](https://user-images.githubusercontent.com/100989788/209433886-01b3ebad-4d57-41b5-911d-ae176a3aa6b5.png)


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

## 주요 기능 
## 출퇴근
- 출근하기 버튼 클릭시 자동으로 시간계산
- 퇴근하기 버튼 클릭시 점심시간이 공제된 근무시간 기록 <br>
![출퇴근](https://user-images.githubusercontent.com/65589607/209297538-9eaf95ca-855d-4a28-a6e3-926b2991e1d8.gif)

<br><br>
## 캘린더
- 캘린더 CRUD 기능 
- 사원테이블에 직원들의 생년월일을 캘린더에 자동추가
- 구글캘린더 대한민국 휴무일 api 연동 <br> 
![캘린더](https://user-images.githubusercontent.com/65589607/209296260-b1d27954-492b-40e7-adc9-3552c3414181.gif)




## ERD
<img width="788" alt="erd 최종" src="https://user-images.githubusercontent.com/100989788/209434132-13c6efe9-fbde-47d9-9e2b-da95b88ab2c3.png">

