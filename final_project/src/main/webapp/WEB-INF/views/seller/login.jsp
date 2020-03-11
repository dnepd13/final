<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
  
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
  
  <div class="login-area">
          <form action="login" method="post"> 
          	<fieldset>
               	   	<div class="form-group">
				<label for="exampleInputId">ID:</label>
				<input type="text" name="seller_id"  id="exampleInputId" class="form-control"placeholder="ID" required>
	 			<div class="row-empty-20"></div>
	 			<label for="exampleInputPassword1">PW:</label>
				<input type="password" name="seller_pw" class="form-control" id="exampleInputPassword1" placeholder="Password" required>
				<div class="row-empty-20"></div>
				<input type="submit" value="로그인" class="enter btn btn-secondary" style="width:100%;">
			</div>
	  </fieldset>
	</form>
	<a href="${pageContext.request.contextPath }/seller/find_id">
		<button class="btn btn-secondary" style="width:48%;">아이디찾기</button>
	</a>
	<a href="${pageContext.request.contextPath }/seller/pwfind">
	<button class="btn btn-secondary" style="width:48%; float:right;">비밀번호찾기</button>
	</a>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>