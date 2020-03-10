<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
<script>
$(function(){
	 $(".btn").click(function(){
		 	var nowid = $(".nowid").val();
		 	var id = $(".newpw").val();
			var checkid = $(".newpwcheck").val();
			if(nowid != id){
				if(id != checkid){
					alert("변경 비밀번호가 같지 않습니다");
				}
				else {
					$(".form").submit();
				}
			}
			else alert("기존 비밀번호와 같은 비밀번호로 변경하실 수 없습니다");
	 });
});


</script>

<style>
	.arti{
		overflow: hidden;
	}
</style>

<aside>
<div>
<jsp:include page="../template/header.jsp"></jsp:include>
</div>
</aside>

<section class="admin" style="padding-left: 250px;">
	<article class="arti">

<div class="container-fluid">
     <div class="row" style="padding: 50px;">
         <div class="offset-md-1 col-md-10">

		<div class="row justify-content-center"  style="padding: 20px;"><h1>비밀번호 수정</h1></div>
			
                    <div class="offset-md-4 col-md-4">
			<form action="" method="post"  class="form" > 
                <!-- <form class="form-inline">옆으로 오는 입력 형식 -->
                    <!--비밀번호 입력창-->
                    <div class="form-group">
                        <label for="pw-input">현재 PW : </label>
                        <input class="form-control nowid" type="password"  name="admin_pw" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="pw-input">새 PW : </label>
                        <input class="form-control newpw" type="password" name="new_admin_pw" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="pw-input">새 PW 확인 : </label>
                        <input class="form-control newpwcheck" type="password"   required>
                    </div>
                    
                    <input type="hidden" name="admin_no" value="${param.admin_no }">
					<button class="btn btn-primary" type="button">변경하기</button>
					</form>
					</div>
		</div>
	</div>
</div>
</article>
</section>