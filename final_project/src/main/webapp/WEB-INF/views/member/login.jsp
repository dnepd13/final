<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>order-링</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head>
<style>
	.container {
		width: 50%;
	}
	.login input[type=text],
	.login input[type=password],
	.login input[type=submit]{
		width: 100%;
		border: 1px solid lightgray;
		border-radius: 5px;
 	}
 	.login .enter {
 		background-color: rgb(234,234,234);
 		outline: none;
 		border: 0;
 	}
 	.login .confirm {
 		background-color: white;
 		outline: none;
 		border: 0;
 	}
 	
</style>
<body>
	<br>
	
	<div class="container" align="center">
		<h2>대략 우리 로고</h2>
		<br>

		
		<div class="content login">
			<div id="member_login" class="container" style="margin:0 0">
				<br>
					<form action="login" method="post">
					<input type="text" name="member_id" placeholder="아이디"><p></p>						
					<input type="password" name="member_pw"placeholder="비밀번호"><p></p>						
					<input type="submit" value="로그인" class="enter">
				</form>
			</div>
	
</div>
</body>
</html>

