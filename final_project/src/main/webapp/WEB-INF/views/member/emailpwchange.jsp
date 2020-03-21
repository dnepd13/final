<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
</script>
<script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 



<!-- 회원 비밀번호 변경창 -->
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>


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

	.login-area {
		width: 500px;
		margin: 0 auto;
		padding-top: 50px;
	}
	.login input[type=text],
	.login input[type=password],
	.login input[type=submit]{
		width: 100%;
		border: 1px solid lightgray;
		border-radius: 5px;
 	}
 	

</style>

<c:if test="${member_id != null}">
<aside>
	<div>
 	</div>
</aside>
</c:if>



<div class="container-fluid">
     <div class="row">
         <div class="offset-md-4 col-md-4 ">
            <div class="row justify-content-center" style="padding-top:100px;"><h1>비밀번호 변경</h1></div>
            <br><br><br>
            <form id=frm action="pwchange" method="post">
            
	    	<div class="form-group">
	 			<div class="row-empty-20"></div>
	 			<label for="pw-input">비밀번호:</label>
				<input type="password" class="form-control" name="member_pw" placeholder="Password" maxlength="28" required>
				<br>
				<label for="pw-input">비밀번호 확인:</label>
				<input type="password" class="form-control" name="member_pwcheck" placeholder="Password Check" maxlength="28" required>
				<div class="row-empty-20"></div>
				<button type="button" class="btn btn-secondary  btn-block" onclick="test()">등록</button>
			</div>

			</form>
		</div>
	</div>
</div>


 
 
 <jsp:include page="/WEB-INF/views/template/footer.jsp"/>

 