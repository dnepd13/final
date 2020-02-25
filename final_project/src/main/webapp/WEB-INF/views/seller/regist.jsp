<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
  </script>
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
});
// 		validate-form이 전송되면 /validate로 비동기 요청을 전송
		$("#check_email_code").click(function(e){
			e.preventDefault();
			
// 			var url = $(this).attr("action"); 
// 			var method = $(this).attr("method");
		var data = $(this).serialize();
			
			$.ajax({
				url:"validate",
				type:"post",
				data:{
					'check_email' :$("input[name='check_email_code']").val()
				},
				success:function(resp){
// 					console.log(resp);
					if(resp == "email_success"){
						alert("인증 완료");
					}
					else{
						alert("인증 실패");
					}
				}
			});
		});


</script>
</head>
<body>

<h1>regist.jsp</h1>
<h1>회원가입 페이지</h1>
<form action="regist" method="post">
<div>
<input type="text" name="seller_id"  id="seller_id" placeholder="판매자 아이디">
  <!--  name = 값 controller에있는파라미터값변수명하고 일치해야함 -->
<input class="test" type="button" id="id_check" value="중복확인" ><br>
</div>
<div>
<input type="text" name="seller_pw" placeholder="판매자 비밀번호"><br><br>
</div>
<div>
 <input type="text" name="seller_name" placeholder="판매자 대표이름"><br><br>
</div>

<div >

	<input type="email" id="email" name="seller_email" placeholder="이메일 입력">
	<input type="button" id="check_email"value="인증번호 보내기">
	<input type="text" name="cert" placeholder="인증번호 입력">
	<input type="button" name="check_email_code" id="check_email_code" value="인증코드확인">

</div>
<div>
<input type="tel" name="seller_phone" placeholder="판매자 대표자 전화번호"><br><br>
</div>
<div>
<input type="number" name="seller_birth" placeholder="판매자 사업자번호/주민번호"><br><br>
</div>
<div>
<input type="text" name="seller_addr_post" placeholder="판매자 사업장 우편번호"><br><br>
</div>
<div>
<input type="text" name="seller_addr_basic" placeholder="판매자 사업장 기본주소"><br><br>
</div>
<div>
<input type="text" name="seller_addr_extra" placeholder="판매자  사업장 상세주소"><br><br>
</div>
<div>
<input type="text" name="seller_store_name" placeholder="판매자 사업장 이름"><br><br>
</div>
<div>
<input type="tel" name="seller_store_phone" placeholder="판매자 사업장 전화번호"><br><br>
</div>
<div>
<input type="number" name="seller_store_fax" placeholder="판매자 사업장 팩스번호"><br><br>
</div>
<div>
</div>
<input type="text" name="seller_bank_code" placeholder="판매자 사업장 은행코드"><br><br>
<div>
 <input type="text" name="seller_bank_account" placeholder="판매자 은행계좌번호"><br><br>
</div>
<div>
<input type="text" name="seller_bank_username" placeholder="판매자 은행 예금주"><br><br>
</div>
<div>
<input type="text" name="seller_bank_birth" placeholder="판매자 사업장 주민등록번호"><br><br>
</div>

<input type="hidden" name="seller_agree_date" value="${param.dTime }">
<div>
<input type="submit" class="buttontest" value="가입하기" onclick="test();">
</div>
</form>