<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
</script>
<script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
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
.section1{
	margin: 0 auto;
	width: 1500px;
}
.section2{
	margin: 0 auto;
	width: 1000px;
	padding-left: 200px;
}
.ordering_area {
	margin: 30px 0px;
}

.col-lg-8 {
	margin: 25px 0px;
}

.cart_table_title {
	border-bottom: 1px solid #171717;
}
 	.insert_cate,
 	.insert_req  {
 		width: 80%;
 	}
 	.insert_req * {
 		width: 100%;
 	}
 	.text-primary {
 		font-weight: bold; 
 	}
 	.insert_req textarea{
 		resize: none;
 		height: 25%;
 	}
 	.insert_req .regist {
 		height: 30px;
 		width: 100px;
 	}
</style>

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>

<section class="section1">
<jsp:include page="/WEB-INF/views/template/memberInfoAside.jsp"/>
<div class="ordering_area row justify-content-center">
	<div class="col-lg-8 cart_area">
		<br><br>
		<div class="cart_title">
			<h3>회원 탈퇴 안내</h3>
		</div>
		<div>
			<h3>사용하고 계신 아이디(${memberdelete.member_id})는 탈퇴할 경우 재사용 및 복구가 불가능합니다.
				탈퇴한 아이디는 본인과 타인 모두 재사용 및 복구가 불가하오니 신중하게 선택하시기 바랍니다.
			</h3>
		</div>
		<br><br>
		<div>
			<h3>
				탈퇴 후 회원정보 및 개인형 서비스 이용기록은 모두 삭제됩니다.
				회원정보 및 개인형 서비스 이용기록은 모두 삭제되며, 삭제된 데이터는 복구되지 않습니다.
				삭제되는 내용을 확인하시고 필요한 데이터는 미리 백업을 해주세요.
			</h3>
		</div>
	<div class="insert_req form-group ">
	<form id=frm action="memberdelete" method="post">
		<fieldset>
	    	<div class="form-group">
				<label for="exampleInputId"></label>
				<input type="hidden" name="member_id"  id="exampleInputId" class="form-control" value="${memberdelete.member_id}" maxlength="38" required>
	 			<div class="row-empty-20"></div>
	 			<label for="exampleInputPassword1">비밀번호:</label>
				<input type="password" class="form-control" name="member_pw" placeholder="Password" maxlength="28" required>
				<br>
				<label for="exampleInputPassword1">비밀번호 확인:</label>
				<input type="password" class="form-control" name="member_pwcheck" placeholder="Password Check" maxlength="28" required>
				<div class="row-empty-20"></div>
				<button type="button" class="btn btn-secondary disabled btn-block" onclick="test()">탈퇴</button>
			</div>
	  </fieldset>
	</form>
</div>
</div>
</div>
</section>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>