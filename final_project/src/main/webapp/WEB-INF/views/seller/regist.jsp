<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
  </script>
  <script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
  
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
// 		.validate-form은 처음에 숨기고 이메일 전송시만 표시
$(function() {
		$("#check_email_code").hide();
		
// 		.email-form이 전송되면 send 주소로 비동기 신호를 전송(ajax)
		$("#check_email").click(function(e){
			e.preventDefault();
			
			$(this).find("input[type=button]").prop("disabled", true);
			$(this).find("input[type=button]").val("인증번호 발송중...");
			
			var url = $(this).attr("action"); 
			var method = $(this).attr("method");
			var data = $("#email").val();
			console.log(data)
			$.ajax({
				url: "send",
				type:"post",
				data:{'seller_email' :data
					
				},
				success:function(resp){
					//console.log(resp);
					if(resp == "success"){
						$("#check_email_code").show();
						
					}
				}
			
			});
		});
// 		validate-form이 전송되면 /validate로 비동기 요청을 전송
		$("#check_email_code").click(function(e){
			e.preventDefault();
			console.log("string");
// 			var url = $(this).attr("action"); 
// 			var method = $(this).attr("method");
		var data = $(this).serialize();
			
			$.ajax({
				url:"validate",
				type:"post",
				data:{
					'cert' :$("input[name='cert']").val()
				},
				success:function(resp){
// 					console.log(resp);
					if(resp == "success"){
						window.alert("인증 완료");
					}
					else{
						window.alert("인증 실패");
					}
				}
			});
		});

});

</script>
</head>
<body>
<div class="continer-fluid">
	<div class="row"  style="padding:50px;">
		<div class="offset-md-4 col-md-4 ">
	 	 <div class="row justify-content-center" style="padding: 20px;"><h1>판매자 회원가입</h1></div>
         <br><br><br>
		 <form action="regist" method="post">
		 <!-- <form class="form-inline">옆으로 오는 입력 형식 -->
              <!--아이디 입력창-->
			  <div class="form-group">
  				<label class="col-form-label" for="inputDefault">ID : </label>
  				<input type="text" class="form-control" name="seller_id"required>
			  	 <!--  name = 값 controller에있는파라미터값변수명하고 일치해야함 -->
			  	<input class="test" type="button" id="id_check" value="중복확인" ><br>
			  </div>
              <!-- 비밀번호 입력창 -->
               <div class="form-group">
  				<label class="col-form-label" for="inputDefault">PW : </label>
  				<input type="password" class="form-control"id="inputDefault"name="seller_pw"required>
			  </div>
			  <!-- 이름 입력창 -->
			  <div class="form-group">
  				<label class="col-form-label" for="inputDefault">이름 : </label>
  				<input type="text" class="form-control"id="inputDefault"name="seller_name"required>
			  </div>
			   <!-- 이메 입력창 -->
			  <div class="form-group">			 
  				<label class="col-form-label" for="email">이메일 : </label>
  				<input type="email" class="form-control"id="email"name="seller_email"placeholder="이메일 입력" required>
			  	<input type="button" id="check_email"value="인증번호 보내기">
				<input type="text" name="cert" placeholder="인증번호 입력">
				<input type="button" name="check_email_code" id="check_email_code" value="인증코드확인">	
			  </div>
			  <!-- 전화번호 입력창 -->
			  <div class="form-group">
  				<label class="col-form-label" for="inputDefault">전화번호 : </label>
  				<input type="tel" class="form-control"id="inputDefault"name="seller_phone"required>
			  </div>
			  <!--주민등록번호/사업자번호 입력창 -->
			  <div class="form-group">
  				<label class="col-form-label" for="inputDefault">주민등록번호 또는 사업자번호 : </label>
  				<input type="number" class="form-control"id="inputDefault"name="seller_birth"required>
			  </div>
			  <!--사업장 우편번호 입력창 -->
			  <div class="form-group">
  				<label class="col-form-label" for="inputDefault">사업장 우편번호 : </label>
  				<input type="text" class="form-control"id="inputDefault"name="seller_addr_post"required>
			  </div>
			  <!--사업장 기본주소 입력창 -->
			  <div class="form-group">
  				<label class="col-form-label" for="inputDefault">사업장 기본주소 : </label>
  				<input type="text" class="form-control"id="inputDefault"name="seller_addr_basic"required>
			  </div>
			  <!--사업장 상세주소 입력창 -->
			  <div class="form-group">
  				<label class="col-form-label" for="inputDefault">사업장 상세주소 : </label>
  				<input type="text" class="form-control"id="inputDefault"name="seller_addr_extra"required>
			  </div>
			  <!--사업장 이름 입력창 -->
			  <div class="form-group">
  				<label class="col-form-label" for="inputDefault">사업장 이름 : </label>
  				<input type="text" class="form-control"id="inputDefault"name="seller_store_name"required>
			  </div>
			  <!--사업장 전화번호 입력창 -->
			  <div class="form-group">
  				<label class="col-form-label" for="inputDefault">사업장 전화번호 : </label>
  				<input type="tel" class="form-control"id="inputDefault"name="seller_store_phone"required>
			  </div>
			  <!--사업장 팩스번호 입력창 -->
			  <div class="form-group">
  				<label class="col-form-label" for="inputDefault">사업장 팩번호 : </label>
  				<input type="number" class="form-control"id="inputDefault"name="seller_store_"required>
			  </div>
			  <!--사업장 은행명 (코드)입력창 -->
			  <div class="form-group">
  				<label class="col-form-label" for="inputDefault">사업장 은행 : </label>
  				<input type="text" class="form-control"id="inputDefault"name="seller_bank_code"required>
			  </div>
			  <!--사업장 은행계좌번호 입력창 -->
			  <div class="form-group">
  				<label class="col-form-label" for="inputDefault">사업장 은행 계좌번호 : </label>
  				<input type="text" class="form-control"id="inputDefault"name="seller_bank_account"required>
			  </div>
			 
			  <!--사업장 은행 예금주 입력창 -->
			  <div class="form-group">
  				<label class="col-form-label" for="inputDefault">사업장 은행 예금주 : </label>
  				<input type="text" class="form-control"id="inputDefault"name="seller_bank_username"required>
			  </div>
			   <!--사업장 은행 주민등록번호 입력창 -->
			  <div class="form-group">
  				<label class="col-form-label" for="inputDefault">사업장 은행 주민등록번 : </label>
  				<input type="text" class="form-control"id="inputDefault"name="seller_bank_birth"required>
			  </div>
			   <!--가입일 숨겨서 온다-->
			  <input type="hidden" name="seller_agree_date" value="${param.dTime }">
			   <!--버튼 창 -->
			   <button type="button" class="btn btn-secondary disabled" onclick="test();">가입하기</button>
			  </form>
			 </div>
		</div>
    </div>
			  
			  
<!-- <div>
판매자 아이디 <input type="text" name="seller_id"  id="seller_id" >
   name = 값 controller에있는파라미터값변수명하고 일치해야함
                     <input class="test" type="button" id="id_check" value="중복확인" ><br>
</div>
<div>
판매자 비밀번호 <input type="text" name="seller_pw"><br><br>
</div>
<div>
판매자 대표자 이름 <input type="text" name="seller_name"><br><br>
</div>

<div >
	<input type="email" id="email" name="seller_email" placeholder="이메일 입력">
	<input type="button" id="check_email"value="인증번호 보내기">
	<input type="text" name="cert" placeholder="인증번호 입력">
	<input type="button" name="check_email_code" id="check_email_code" value="인증코드확인">
</div>
<div>
판매자 대표자 전화번호 <input type="tel" name="seller_phone"><br><br>
</div>
<div>
판매자 주민등록번호/사업자번호 <input type="number" name="seller_birth"><br><br>
</div>
<div>
판매자 사업장 우편번호 <input type="text" name="seller_addr_post"><br><br>
</div>
<div>
판매자 사업장 기본주소 <input type="text" name="seller_addr_basic"><br><br>
</div>
<div>
판매자 사업장 상세주소 <input type="text" name="seller_addr_extra"><br><br>
</div>
<div>
판매자 사업장 이름 <input type="text" name="seller_store_name"><br><br>
</div>
<div>
판매자 사업장 전화번호 <input type="tel" name="seller_store_phone"><br><br>
</div> 
<div>
판매자 사업장 팩스번호 <input type="number" name="seller_store_fax"><br><br>
</div>
<div>
</div>
판매자 사업장 은행명(코드) <input type="text" name="seller_bank_code"><br><br>
<div>
판매자 사업장 은행계좌번호 <input type="text" name="seller_bank_account"><br><br>
</div>
<div>
판매자 사업장 은행예금주 <input type="text" name="seller_bank_username"><br><br>
</div>
<div>
판매자 사업장 은행 주민 등록번호 <input type="text" name="seller_bank_birth"><br><br>
</div>

<input type="hidden" name="seller_agree_date" value="${param.dTime }">
<div>

<input type="submit" class="buttontest" value="가입하기" onclick="test();">
</div>
</form>-->
