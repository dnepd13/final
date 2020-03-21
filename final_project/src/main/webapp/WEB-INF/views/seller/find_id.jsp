<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<style>
	.findId-area {
		width: 500px;
		margin: 0 auto;
		padding-top: 50px;
	}
	.findId input[type=text],
	.findId input[type=password],
	.findId input[type=submit]{
		width: 100%;
		border: 1px solid lightgray;
		border-radius: 5px;
 	}
 	
</style>

<div class="findId-area">
	<div><h4 align="center">아이디 찾기</h4></div>
	<form action="find_id_info" method="post">
		<fieldset>
	    	<div class="form-group">
				<label for="exampleInputId">이름</label>
				<input type="text" name="seller_name" id="exampleInputId" class="form-control" placeholder="name" required>
	 			<div class="row-empty-20"></div>
	 			<label for="exampleInputPassword1">이메일:</label>
	 			<input type="text" name="seller_email" class="form-control" id="exampleInputEmail" placeholder="email" required>
				<div class="row-empty-20"></div>
				<input type="submit" value="아이디찾기" class="enter btn btn-secondary" style="width:100%;">
			</div>
	  </fieldset>
	</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>