<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- 비밀번호 찾기 이메일 인증창 -->
    
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>


<script>  
$(function() {
	 // $(".buttontest").attr("disabled", true);
     $("#id_check").click(function() {
   		//console.log("되는건가");
           var member_id = $("input[name=member_id]").val();
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
               			window.alert("아이디를 찾을 수 없습니다.")
               			console.log($('input[name="idcheck2"]').val());
						//	$(".buttontest").attr("disabled", false);
							$('input[name="idcheck2"]').val("N");
							console.log($('input[name="idcheck2"]'));
               		}
               		else{
               			window.alert("확인 가능한 아이디 입니다")
               			$('input[name="idcheck2"]').val("Y");
               			console.log($('input[name="idcheck2"]').val());
               			
               		}
                  }
                  
         
               });
	
     });
});


//	.validate-form은 처음에 숨기고 이메일 전송시만 표시
$(function() {
	//	$("#check_email_code").hide();
		
// 		.email-form이 전송되면 send 주소로 비동기 신호를 전송(ajax)
		$("#check_email").click(function(){
		//	e.preventDefault();
			
		//	$(this).find("input[type=button]").prop("disabled", true);
		//	$(this).find("input[type=button]").val("인증번호 발송중...");
			
		//	var url = $(this).attr("action"); 
		//	var method = $(this).attr("method");
		//	var data = $("#email").val();
		//	console.log(data)
			$.ajax({
				url: "send",
				type:"post",
				data: {
					'member_id' : $("input[name='member_id']").val(),
					'member_email' : $("input[name='member_email']").val()				
				},
				success:function(data){
					//console.log(resp);
					if(data == "success"){
						$("#check_email").hide();
						$("input[name='cert").show();
						$("#check_email_code").show();
						
					}
				}
			
			});
		});
// 		validate-form이 전송되면 /validate로 비동기 요청을 전송
		$("#check_email_code").click(function(){
		//	e.preventDefault();
		//	console.log("string");
// 			var url = $(this).attr("action"); 
// 			var method = $(this).attr("method");
	//	var data = $(this).serialize();
			
			$.ajax({
				url:"validate",
				type:"post",
				data:{
					'cert' :$("input[name='cert']").val()
				},
				success:function(data){
// 					console.log(resp);
					if(data == "success"){
						$("#check_email").hide();
						$("input[name='cert").hide();
						$("#check_email_code").hide();
						
						$('input[name="checkemailcode2"]').val("Y");
						console.log($('input[name="check_email_code2"]').val());
						window.alert("인증 완료");
						
						
					}
					else{
						$("#check_email").show();
						$("input[name='cert").hide();
						$("#check_email_code").hide();
						window.alert("인증 실패");
						$('input[name="checkemailcode2"]').val("N");
					}
				}
			});
		});
});

function test() {
	if ($('input[name="member_id"]').val() == "") {
		window.alert("아이디를 입력해주세요");
		return false;
	}
	var idcheck2 =$('input[name="idcheck2"]').val(); 
	if(idcheck2 != 'Y'){
		alert("아이디 중복체크를 해주세요.");
		return false;
	}
	
	var checkemailcode2 = $('input[name="checkemailcode2"]').val();
	console.log($('input[name="checkemailcode2"]').val());
	if(checkemailcode2 != 'Y'){
		alert("이메일 인증이 필요합니다.");
		return false;
	}
	$("#frm").submit();
}

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
	<div class="" style="width:100%;" align="center">
		    	<h2>이메일 확인</h2>
	</div>
	<div class="card-body">
		<form action="pwfind" method="post">
			<fieldset>
		    		<table class="form-group">
		    			<colgroup>
		    				<col width="100px;">
		    				<col width="300px;">
		    				<col width="100px;">
		    			</colgroup>
		    			<tbody>
			    			<tr class="form-group">
			    				<td><label class="col-form-label">ID:</label></td>
			    				<td><input type="text" class="form-control" name="member_id" placeholder="아이디를 입력하세요" maxlength="28" required>
			    						
			    				</td>
			    				<td><input class="btn btn-secondary" type="button" id="id_check" value="ID 확인" ><br></td>
			    				<td><input type="hidden" name="idcheck2" value="N"></td>
			    			</tr>
			    			<tr class="input_email">
			    				<td>이메일</td>
			    				<td>
			    						<input type="email" id="email" name="member_email" placeholder="이메일 주소를 입력하세요" maxlength="48" class="form-control" required>
			    						<input type="text" name="cert" class="form-control" placeholder="인증번호 입력" maxlength="7" required>
			    						<input type="hidden" name="checkemailcode2">
			    				</td>
			    				<td><input class="btn btn-secondary" type="button" id="check_email" value="인증번호 보내기">
			    						<input class="btn btn-secondary" type="button" name="check_email_code" id="check_email_code" value="인증코드확인">
			    				</td>
			    			</tr>
			    			<tr>
			    				<td colspan="3"><input type="button" id="frm" value="확인" onclick="test();" class="btn_regist btn btn-secondary btn-block" />
			    			</tr>
		    			</tbody>
		    		</table>
	  		</fieldset>
		</form>	
	</div>
</div>


<div class="row-empty-40"></div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>


