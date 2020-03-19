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
display:flex;
align-items:center;
 	aside { 
 		float : left; 
 		padding: 60px 0px;
		width: 150px;
 	}
 	aside div {
 		border-radius: 5px;
 	}	 
 	aside ul { 
 		list-style: none; 
 		padding : 0; 
 	}
	
	.aside-title {
		border: 2px solid #BFC9D9;
		margin: 5px;
		padding: 10px;
	}
	.aside-grade {
		border: 2px solid #BFC9D9;
		margin: 5px;
		padding: 10px;
	}
	.aside-content {
		border: 2px solid #BFC9D9;
		margin: 5px;
		padding: 10px;
	}
	
	aside::after {
		content: "";
		display: block;
		clear: both;
	}





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

<c:if test="${member_id != null}">
<aside>
	<div>
 	</div>
</aside>
</c:if>



<section class="section1">
<div class="logo-area" align="center">
<div style="width: 80%; float:none; margin:0 auto" >
<div class="ordering_area row justify-content-center">
	<div class="col-lg-8 cart_area">
	<br><br><br><br><br>
		<div class="cart_title">
			<h3>비밀번호 찾기</h3>
		</div>
		
	<div class="insert_req form-group ">
            <form id=frm action="pwchange" method="post">
		<fieldset>
	    	<div class="form-group">
	 			<div class="row-empty-20"></div>
	 			<label for="exampleInputPassword1">비밀번호:</label>
				<input type="password" class="form-control" name="member_pw" placeholder="Password" maxlength="28" required>
				<br>
				<label for="exampleInputPassword1">비밀번호 확인:</label>
				<input type="password" class="form-control" name="member_pwcheck" placeholder="Password Check" maxlength="28" required>
				<div class="row-empty-20"></div>
				<button type="button" class="btn btn-secondary disabled btn-block" onclick="test()">등록</button>
			</div>
	  </fieldset>
	</form>
</div>
</div>
</div>
</div>
</div>
</section>

 
 
 <jsp:include page="/WEB-INF/views/template/footer.jsp"/>

 