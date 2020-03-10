<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css"> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<script>
	$(function(){
			var idcomfirm = 0;
			var namecomfirm = 0;
			var emailcomfirm = 0;
		//아이디 검사
		$(".id-form").on("blur", function(){
			var id = $(this).val();
			var idcheck = $("#b");
			var regex = /^[A-Za-z0-9]{5,20}$/;

			if(regex.test($(this).val())){
				//여기다가 아이디 검사도 넣어야함
				$.ajax({
					url:"idcheck",
					type:"post",
					data:{
						"admin_id":id
					},
					success:function(resp){
						if(resp == 1){
							idcomfirm = 1;
							$("#b").css("color", "blue")
							idcheck.text("사용 가능한 아이디 입니다");
						}
						else {
							idcheck.text("이미 존재하는 아이디 입니다");
							$("#b").css("color", "red")
							$(".id-form").focus();
							idcomfirm=0;
						}
					}
					
				});
				
			}	
			else{
				idcomfirm=0;
				$("#b").css("color", "red")
				idcheck.text("아이디는 영어 소문자 및 대문자, 숫자로 작성해야하며 5~20자 사이로 입력해야합니다");
				$(this).focus();
			}
		});
		
		$(".name-form").on("blur", function(){
			var name = $(this).val();
			var nameregex = /^[가-힣]{2,7}$/;
			var namecheck = $("#n");
	
			if(nameregex.test(name)){
				namecomfirm = 1;
				$("#n").css("color", "blue")
				namecheck.text("사용가능합니다")
			}
			else{
				namecomfirm = 0;
				$("#n").css("color", "red")
				namecheck.text("이름은 한글로 2~7자로 작성해야합니다");
				$(this).focus();
			}
			
		});
		
		$(".email-form").on("blur", function(){
			var email = $(this).val();
			var emailregex = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
			var emailcheck = $("#e");
			
			if(emailregex.test(email)){
				emailcomfirm = 1;
				$("#e").css("color", "blue")
				emailcheck.text("사용 가능한 이메일입니다");
			}
			else{
				emailcomfirm = 0;
				$("#e").css("color", "red")
				emailcheck.text("이메일을 다시 입력하세요");
			}
		});
		
		$(".inselt").click(function(){
			if(idcomfirm == 1&&namecomfirm==1&&emailcomfirm==1){
				console.log(idcomfirm);
				console.log(namecomfirm);
				console.log(emailcomfirm);
				window.alert("가입이 완료되었습니다");
				$(".admininsert").submit();		
			}
			else{
				console.log(idcomfirm);
				console.log(namecomfirm);
				console.log(emailcomfirm);
				$("#i").css("color", "red")
				$("#i").text("정보를 다시 입력하세요");
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
                <form class="admininsert" action="" method="post"> 
                <!-- <form class="form-inline">옆으로 오는 입력 형식 -->
                    <!--아이디 입력창-->
                    <div class="form-group">
                        <label for="id-input">ID : </label>
                        <input class="id-form form-control" type="text"  name="admin_id" required>
                        <span id="b">아이디는 영어 소문자, 대문자, 숫자로만 작성가능하며 5~20자 사이로 입력해야합니다</span>
                    </div>
                    
                    <!--비밀번호 입력창-->
                    <div class="form-group">
                        <label for="pw-input">PW : </label>
                        <input class="form-control" type="password"  name="admin_pw" required>
                    </div>
                    
                    <!--이름 입력창-->
                    <div class="form-group">
                        <label for="pw-input">이름 : </label>
                        <input class=" name-form form-control" type="text" name="admin_name" required>
                   		<span id="n">한글 2~7자 까지 입력가능합니다</span>
                    </div>
                    
                    <!--이메일 입력창-->
                    <div class="form-group">
                        <label for="pw-input">이메일 : </label>
                        <input class="email-form form-control" type="text" name="admin_email" required>
                        <span id="e"></span>
                    </div>

                    <button type="insert button" class="btn btn-primary btn-block">관리자가입</button>
                    <span id="i"></span>
                </form>
            </div>
        </div>
    </div>
</article></section>
