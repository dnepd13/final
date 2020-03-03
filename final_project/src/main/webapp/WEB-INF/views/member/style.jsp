<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>order-링</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
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
	input[type="text"]{
	margin: 0.5m 0;
	border: 1px solid #ccc;
	padding:0.75em;
	width: 20%;
	font-size:16px;
	color:#999;
	border-radius:6px;
	}
	input[type="password"]{
	margin: 0.5m 0;
	border: 1px solid #ccc;
	padding:0.75em;
	width: 50%;
	font-size:16px;
	color:#999;
	border-radius:6px;
	}
	input[type="tel"]{
	margin: 0.5m 0;
	border: 1px solid #ccc;
	padding:0.75em;
	width: 100%;
	font-size:16px;
	color:#999;
	border-radius:6px;
	}
	input[type="number"]{
	margin: 0.5m 0;
	border: 1px solid #ccc;
	padding:0.75em;
	width: 100%;
	font-size:16px;
	color:#999;
	border-radius:6px;
	}
	input[type="email"]{
	margin: 0.5m 0;
	border: 1px solid #ccc;
	padding:0.75em;
	width: 100%;
	font-size:16px;
	color:#999;
	border-radius:6px;
	}
	
	
	.container {
		width: 60%;
		height:420px;
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


<script>  
  $(function() {
	  $(".buttontest").attr("disabled", true);
      $(".test").click(function() {
    		console.log("되는건가");
            var seller_id = $("input[name=seller_id]").val();
            console.log(seller_id);
            	if(seller_id.length < 1){
            		alert("아이디를 입력하세요");
            	}
            	else{
            		
                     $.ajax({
                              url : "id_check",
                              type : "get",
                              data : {
                                 'seller_id' : seller_id
                              },
                              success : function(resp) { //resp = 위코드가 성공적으로 컨트롤러에 다녀왔을때 가져온 값
									console.log(resp);                              		
                              		if(resp == 0){
                              			window.alert("사용 가능한 아이디 입니다");
										$(".buttontest").attr("disabled", false);
                              		}
                              		else{
                              			window.alert("중복된 아이디 입니다");
                              			
                              		}
                                 }
                                 
                        
                              });
            	}
    });
   });


</script>


<body>
	<br>
	
	<div class="container" align="center">
		<h2>대략 우리 로고</h2>
		<br>
		<!-- Nav tabs -->
		<ul class="nav nav-tabs">
			<li class="nav-item"><a class="nav-link active"
				data-toggle="tab" href="#home">일반 회원가입</a></li>
			<li class="nav-item"><a class="nav-link" data-toggle="tab"
				href="#menu1">판매자 회원가입</a></li>
		</ul>

		<!-- Tab panes -->
		<div class="tab-content login">
			<div id="home" class="container tab-pane active" style="margin:15 0">
				<br>
					<form action="${pageContext.request.contextPath }/member/regist" method="post">						
					<input type="text" name="member_id" placeholder="아이디를 입력하세요"><p></p>
	  				<input type="password" class=join name="member_pw"  placeholder="비밀번호를 입력"><p></p>
    				<input type="text" name="member_name" placeholder="이름을 입력하세요"><p></p>
    				<input type="text" name="member_email" placeholder="이메일 주소를 입력하세요"><p></p>
	    			<input type="text" name="member_phone" placeholder="휴대폰 번호를 입력하세요(-는빼고 11자리를 입력하시면 됩니다)"><p></p>
					<input type="text" name="member_birth" placeholder="생년월일을 입력하세요 (ex: 19890101)"><p></p>
					<input type="submit" value="가입" class="enter">
				</form>
			</div>
<div id="menu1" class="container tab-pane fade" style="margin:0 0">
			<br>
<form action="${pageContext.request.contextPath }/seller/regist" method="post">
<input type="text" name="seller_id"  id="seller_id" placeholder="판매자 아이디">
<input class="test" type="button" id="id_check"value="중복확인">
<br>
<input type="text" name="seller_pw" placeholder="판매자 비밀번호"><br><br>
<input type="text" name="seller_name" placeholder="판매자 대표이름"><br><br>
<input type="email" id="email" name="seller_email" placeholder="이메일 입력">
<input type="button" id="check_email"value="인증번호 보내기">
<br>
<input type="text" name="cert" placeholder="인증번호 입력">
<input type="button" name="check_email_code" id="check_email_code" value="인증코드확인">
<br>
<input type="tel" name="seller_phone" placeholder="판매자 대표자 전화번호"><br><br>
<input type="number" name="seller_birth" placeholder="판매자 사업자번호/주민번호"><br><br>
<input type="text" name="seller_addr_post" placeholder="판매자 사업장 우편번호"><br><br>
<input type="text" name="seller_addr_basic" placeholder="판매자 사업장 기본주소"><br><br>
<input type="text" name="seller_addr_extra" placeholder="판매자  사업장 상세주소"><br><br>
<input type="text" name="seller_store_name" placeholder="판매자 사업장 이름"><br><br>

<input type="tel" name="seller_store_phone" placeholder="판매자 사업장 전화번호"><br><br>

<input type="number" name="seller_store_fax" placeholder="판매자 사업장 팩스번호"><br><br>

<input type="text" name="seller_bank_code" placeholder="판매자 사업장 은행코드"><br><br>

 <input type="text" name="seller_bank_account" placeholder="판매자 은행계좌번호"><br><br>

<input type="text" name="seller_bank_username" placeholder="판매자 은행 예금주"><br><br>

<input type="text" name="seller_bank_birth" placeholder="판매자 사업장 주민등록번호"><br><br>

<input type="hidden" name="seller_agree_date" value="${param.dTime }">
<div>
<input type="submit" value="가입" class="enter">
</form>
				<p></p>
				<form action="${pageContext.request.contextPath }/seller/find" method="get">
					<input type="submit" value="아이디" class="confirm"><p></p><input type="submit" value="비밀번호 찾기" class="confirm">
				</form>
		</div>
	</div>
	
</div>
</body>
</html>

    
    
    
    
    
    
    
    
    
    





