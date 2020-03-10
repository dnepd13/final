<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
  </script>
  <script>  
  $(function() {
	  $(".buttontest").attr("disabled", true);
      $("#id_check").click(function() {

            var member_id = $("input[name=member_id]").val();

            	if(member_id.length < 1){
            		alert("아이디를 입력하세요");
            	}
            	else{
            		
                     $.ajax({
                              url : "id_check",
                              type : "get",
                              contetType: "application/x-www-form-urlencoded; charset=UTF-8",
                              data : {
                                 'member_id' : member_id
                              },
                              success : function(resp) { //resp = 위코드가 성공적으로 컨트롤러에 다녀왔을때 가져온 값
									console.log(resp);                              		
                              		if(resp == 0){


                    					
                              			window.alert("사용 가능한 아이디 입니다");
										$(".buttontest").attr("disabled", false);
										//	$(".buttontest").attr("disabled", false);
										$('input[name="idcheck2"]').val("Y");
										
                              		}
                              		else{
                              			window.alert("중복된 아이디 입니다");
                              			$('input[name="idcheck2"]').val("N");
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
			
			var email = $(this).parents().find("input[name=member_email]").val();
			if(email==""){
				alert("이메일을 입력해주세요");
			}
			else if($(this).val()=='인증번호 재발송'){
				$("#check_email").parents(".input_email").next(".send").find(".info").remove();
				
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
							$("#check_email_code").show();
							var send = $("<td class='info'></td><td colspan='2' class='info'><p>해당 이메일로 인증번호 발송이 완료되었습니다.</p></td>");
							$("#check_email").parents(".input_email").next(".send").append(send);
					}
				
				});	
			}
				
			else{
				
// 				$(this).find("input[type=button]").prop("disabled", true);
				$(this).val("인증번호 재발송");
				$("#check_email_code").show();
				
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
							
							var send = $("<td class='info'></td><td colspan='2' class='info'><p>해당 이메일로 인증번호 발송이 완료되었습니다.</p></td>");
							$("#check_email").parents(".input_email").next(".send").append(send);
					}
				
				});				
			}

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
						$("input[value='회원가입']").prop("disabled", false);
						window.alert("인증 완료");
					}
					else{
						window.alert("인증 실패");
						
						$("#check_email").parents(".input_email").next(".send").find(".info").remove();
						
						var send = $("<td class='info'></td><td colspan='2' class='info'><p>인증에 실패했습니다. 인증번호 재발송 후 다시 입력해주세요.</p></td>");
						$("#check_email").parents(".input_email").next(".send").append(send);
					}
				}
			});
		});
});
</script>

<style>
	.regist-area {
		width: 500px;
		margin: 0 auto;
		padding-top: 50px;
	}
	.btn_regist {
		width: 100%;'
	}

 	.card-body table td {
 		heigh: 150px;
 		padding: 10px 0;
 	}
</style>

<div class="row-empty-40"></div>
<div class="row-empty-40"></div>

<div class="regist-area card border-primary mb-3">
	<div class="card-header" style="width:100%;">
		    	회원가입
	</div>
	<div class="card-body">
		<form action="regist" method="post">
			<fieldset>
		    		<table class="form-group">
		    			<colgroup>
		    				<col width="100px;">
		    				<col width="300px;">
		    				<col width="100px;">
		    			</colgroup>
		    			<tbody>
			    			<tr>
			    				<td><label for="member_id">ID</label></td>
			    				<td><input type="text" name="member_id" id="member_id"  class="form-control"placeholder="아이디를 입력하세요" required>
			    						<small id="emailHelp" class="form-text text-muted">영문, 숫자 20자 이내</small>
			    				</td>
			    				<td><input class="test" type="button" id="id_check" value="중복확인" ><br></td>
			    			</tr>
			    			<tr>
			    				<td><label for="exampleInputPassword1">PW</label></td>
			    				<td><input type="password" name="member_pw" class="form-control join" id="exampleInputPassword1" placeholder="Password" required>
			    				</td>
			    				<td></td>
			    			</tr>
			    			<tr>
			    				<td>이름</td>
			    				<td><input type="text" name="member_name" class="form-control" placeholder="이름을 입력하세요" required></td>
			    				<td></td>
			    			</tr>
			    			<tr class="input_email">
			    				<td>이메일</td>
			    				<td>
			    						<input type="email" id="email" name="member_email" placeholder="이메일 주소를 입력하세요" class="form-control" required>
			    						<input type="text" name="cert" class="form-control" placeholder="인증번호 입력" required>
			    				</td>
			    				<td><input type="button" id="check_email" value="인증번호 보내기">
			    						<input type="button" name="check_email_code" id="check_email_code" value="인증코드확인">
			    				</td>
			    			</tr>
			    			<tr class="send">
			    			</tr>
			    			<tr>
			    				<td>연락처</td>
			    				<td><input type="text" name="member_phone" class="form-control" placeholder="휴대폰 번호를 입력하세요( '-'제외)" required></td>
			    				<td></td>
			    			</tr>
			    			<tr>
			    				<td>생년월일</td>
			    				<td><input type="text" name="member_birth" class="form-control" placeholder="생년월일을 입력하세요" required>
			    						<small id="emailHelp" class="form-text text-muted">ex: 19890101</small>
			    				</td>
			    				<td></td>
			    			</tr>
			    			<tr>
			    				<td colspan="3"><input type="submit" value="회원가입" onclick="test();" class="btn_regist btn btn-secondary" disabled/></td>
			    			</tr>
		    			</tbody>
		    		</table>
	  		</fieldset>
		</form>	
	</div>
</div>


<div class="row-empty-40"></div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>

