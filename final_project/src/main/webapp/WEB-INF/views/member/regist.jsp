<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
  </script>
  <script>  
  $(function() {
	  $(".buttontest").attr("disabled", true);
      $(".test").click(function() {
    		console.log("되는건가");
            var member_id = $("input[name=member_id]").val();
            console.log(member_id);
            	if(member_id.length < 1){
            		alert("아이디를 입력하세요");
            	}
            	else{
            		
                     $.ajax({
                              url : "id_check",
                              type : "get",
                              data : {
                                 'member_id' : member_id
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
				data:{'member_email' :data
					
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



<h1>회원가입</h1>

    <form action="regist" method="post">
	    
	    <input type="text" name="member_id" id="member_id" placeholder="아이디를 입력하세요">
	    <input class="test" type="button" id="id_check" value="중복확인" ><br>
    	<input type="password" class=join name="member_pw"  placeholder="비밀번호를 입력">
    	<br><br>

    	<input type="text" name="member_name" placeholder="이름을 입력하세요">
    	<br><br>
 <div >   	
    	<input type="email" id="email" name="member_email" placeholder="이메일 주소를 입력하세요" class="form-control">
    	<input type="button" id="check_email" value="인증번호 보내기">
	<input type="text" name="cert" placeholder="인증번호 입력">
	<input type="button" name="check_email_code" id="check_email_code" value="인증코드확인">
</div>
    	<br><br>
		<input type="text" name="member_phone" placeholder="휴대폰 번호를 입력하세요(-는빼고 11자리를 입력하시면 됩니다)">
		<br><br>
    	<input type="text" name="member_birth" placeholder="생년월일을 입력하세요 (ex: 19890101)">
    	<br><br><br><br>
    	<input type="submit" value="회원가입" onclick="test();"/>
    </form>
    
    
    
    
    
    
    
    
    
    
    


