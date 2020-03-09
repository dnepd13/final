<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css"> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<script>
	$(function(){
		$("#b").hide();
		$(".id-form").on("blur", function(){
			var id = $(this).val().length;
			var idcheck = $("#b");
			console.log(idcheck);
			var comfirm = 0;
			if(id>=5 && id<21){
				$("#b").hide();
				console.log(comfirm);
				//여기다가 아이디 검사도 넣어야함
				comfirm += 1;
			}
			else{
				$("#b").show();
				$("#b").css("color", "red")
				idcheck.text("아이디를 5~21자 사이로 입력하세요");
				$(this).focus();
			}
		});
	});
</script>

<aside>
<div>
<jsp:include page="template/header.jsp"></jsp:include>
</div>
</aside>

<section class="admin" style="padding-left: 250px;">
	<article>


<div class="container-fluid">
        <div class="row" style="padding: 50px;">
            <div class="offset-md-4 col-md-4 ">
                <div class="row justify-content-center" style="padding: 20px;"><h1>관리자 등록</h1></div>
                <br><br><br>
                <form action="" method="post"> 
                <!-- <form class="form-inline">옆으로 오는 입력 형식 -->
                    <!--아이디 입력창-->
                    <div class="form-group">
                        <label for="id-input">ID : </label>
                        <input class="id-form form-control" type="text"  name="admin_id" required>
                        <span id="b"></span>
                    </div>
                    
                    <!--비밀번호 입력창-->
                    <div class="form-group">
                        <label for="pw-input">PW : </label>
                        <input class="form-control" type="password"  name="admin_pw" required>
                    </div>
                    
                    <!--이름 입력창-->
                    <div class="form-group">
                        <label for="pw-input">이름 : </label>
                        <input class="form-control" type="text" name="admin_name" required>
                    </div>
                    
                    <!--이메일 입력창-->
                    <div class="form-group">
                        <label for="pw-input">이메일 : </label>
                        <input class="form-control" type="text" name="admin_email" required>
                    </div>

                    <button type="button" class="btn btn-primary btn-block">관리자가입</button>
                </form>
            </div>
        </div>
    </div>
</article></section>
