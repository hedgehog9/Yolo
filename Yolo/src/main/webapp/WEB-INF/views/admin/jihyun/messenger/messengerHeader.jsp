<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<style>

	div#messengerHeader {
		/* border: 1px solid black; */
		height: 110px;
		width: 100%;
		display: flex;
  		align-items: center;
	}
	
	span.headerTitle {
		font-weight: bold;
		font-size: 22pt;
		margin: auto 15px;
		color: #cccece;
	}
	
	span.headerTitle:hover {
		cursor: pointer;
		color: #494949;
	}
	
	button.headerBtn {
		border-radius: 0.5rem;
		border: 1px solid gray;
		background: linear-gradient( to left ,#5bd3ff, #88eb1e );
		margin-left:60%;
		width: 170px;
		height: 45px;
		border: none;
		color: white;
		font-weight: bold;
	}
	
	button.headerBtn:hover{
		 filter: brightness(90%);
	}
	
	i#icon{
		color: white;
		margin-right: 15px;
	}
	
</style>

<div id="messengerHeader" class="border-bottom">
		<span class="headerTitle ml-5">받은 메신저</span>
		<span class="headerTitle">보낸 메신저</span>
		<button type="button" class="headerBtn" data-toggle="modal" data-target="#sendMail">
			<i class="fas fa-regular fa-paper-plane" id="icon"></i>메신저 보내기
		</button>
</div>


<!-- Modal -->
<!-- Modal 구성 요소는 현재 페이지 상단에 표시되는 대화 상자/팝업 창입니다. -->
<div class="modal fade" id="sendMail">
  <div class="modal-dialog modal-dialog-scrollable">
  <!-- .modal-dialog-scrollable을 .modal-dialog에 추가하여 페이지 자체가 아닌 모달 내부에서만 스크롤할 수 있습니다. -->
    <div class="modal-content">
      
      <!-- Modal body -->
      <div class="modal-body">
        <h3>Some text to enable scrolling..</h3>
              <p>Some text to enable scrolling.. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
              <p>Some text to enable scrolling.. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>

              <p>Some text to enable scrolling.. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
      </div>
      
    </div>
  </div>
</div>