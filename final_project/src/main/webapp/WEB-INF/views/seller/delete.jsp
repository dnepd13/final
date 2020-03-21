<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header-seller.jsp"/>    

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>

<div class="container-fluid">
     <div class="row">
         <div class="offset-md-4 col-md-4 ">
            <div class="row justify-content-center"><h1>탈퇴하기</h1></div>
            <br><br><br>
	<form action="delete" method="post">
	    	<div class="form-group">
			
	 			<label for="exampleInputPassword1">현재 비밀번호를 입력해주세요.</label>
				<input type="password" name="seller_pw" class="form-control" id="exampleInputPassword1" placeholder="Password" required>
				</div>
				<input type="submit" value="탈퇴하기" class="enter btn btn-secondary" style="width:100%;">
				</form>
</div>
</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer-seller.jsp"/>

