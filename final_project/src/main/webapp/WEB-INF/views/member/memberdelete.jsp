<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
</script>
<script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>


<!-- 배송지 기본 목록 게시판 -->  

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<script type="text/javascript">
function test() {
	if ($('input[name="member_pw"]').val() == "") {
		alert("비밀번호를 입력해주세요.");
		return false;
	}
	if ($('input[name="member_pwcheck"]').val() == "") {
		alert("비밀번호 확인을 해주세요.");
		return false;
	}
	if ($('input[name="member_pwcheck"]').val() != $('input[name="member_pw"]').val()) {
		alert("비밀번호가 일치하지 않습니다.");
		return false;
	}
	$("#frm").submit();
}
</script>

<style>
	.myInfo_wrap {
		width: 1200px;
		height: 800px;
		margin: 0 auto;
	}
	.addr_wrap {
		float: left;
		margin-left: 60px;
		padding-top: 100px;
		width: 900px;
	}
	.addr_wrap::after{content:""; display: block; clear:both;}
	.addr_main {
		margin: 0 auto;
		width: 90%;
		height: 50px;
		border-bottom: 2px solid #F3F5F8;
	}
	.addr_mainBox1 {
		width: 200px;
		height: auto;
		padding-top: 10px;
		margin-left: 30px;
		float: left;
		font-size: large; 
	}
	.addr_mainBox3 {
		width: 307px;
		height: 100%;
		padding-top: 35px;
		padding-left: 25px;
		margin-left: 500px;
		font-size: x-large; 
/* 		background: #F3F5F8; */
	}
	.addr_mainBox3 ::after {
		content="";
		display: block;
		clear: both;	
	}
	.addr_list {
		margin: 30px auto;
		width: 90%;
	}
	
	table thead {background: #F3F5F8; }
	table thead tr {
		border-top: 2px solid gray;
		text-align: center;
	}
	table tbody td{
		text-align: left;
	}
	
	.btn_area {
		margin: 0 auto;
		width: 90%;
	}
	
 /* modal 전체 스타일 */
 	.modal {
 		display: none;
 		z-index: 1;
 		top: 0;
 		bottom: 0;
 		letf: 0;
 		right: 0;
 		background-color: rgba(0,0,0,0.3);
 	}
 	
 /* modal 내부 컨텐츠 스타일 */
 	#sample6_postcode {
 		float: left;
 	}
 	.btn_findPost {
		position: relative;
		border-radius: 2px;
		margin-left: 10px;
		margin-top: 3px;
	}
	.btn_findPost::after {
		content: "";
		display: block;
		clear: both;
	}
</style>


<div class="myInfo_wrap">
<jsp:include page="/WEB-INF/views/template/memberInfoAside.jsp"/>
	<div class="addr_wrap">
		<div class="addr_main">
			<div class="addr_mainBox1">
				회원 탈퇴 안내
			</div>
	
			<div>
				<h3>
				<br><br>
				사용하고 계신 아이디는 탈퇴할 경우 재사용 및 복구가 불가능합니다.
				<br>
				탈퇴한 아이디는 본인과 타인 모두 재사용 및 복구가 불가하오니 신중하게 선택하시기 바랍니다.
				</h3>
			</div>
		<br><br>
			<div>
				<h3>
				탈퇴 후 회원정보 및 개인형 서비스 이용기록은 모두 삭제됩니다.
				<br>
				회원정보 및 개인형 서비스 이용기록은 모두 삭제되며, 삭제된 데이터는 복구되지 않습니다.
				<br>
				삭제되는 내용을 확인하시고 필요한 데이터는 미리 백업을 해주세요.
				</h3>
			</div>
	<div class="insert_req form-group ">
	<form id=frm action="memberdelete" method="post">
		
	    		<div class="row-empty-20"></div>
				<label for="exampleInputId"></label>
				<input type="hidden" name="member_id"  id="exampleInputId" class="form-control" value="${memberdelete.member_id}" maxlength="38" required>
	 			
	 			<div class="row-empty-20"></div>
	 			<label for="exampleInputPassword1">비밀번호:</label>
				<input type="password" class="form-control" name="member_pw" placeholder="Password" maxlength="28" required>
				
				<div class="row-empty-20"></div>
				<label for="exampleInputPassword1">비밀번호 확인:</label>
				<input type="password" class="form-control" name="member_pwcheck" placeholder="Password Check" maxlength="28" required>
				
				<div class="row-empty-20"></div>
			
				 <p align="right">
					<button type="button" class="btn btn-secondary" onclick="test()" style="width:25%;">탈퇴</button>
				 	 <a href="${pageContext.request.contextPath}/member/membermyinfo"><button class="btn btn-secondary" type="button" style="width:25%;">마이페이지</button></a>
				</p>
	</form>
</div>
</div>
</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>