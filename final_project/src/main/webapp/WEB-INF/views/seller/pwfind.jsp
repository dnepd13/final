<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
  </script>

  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
   

     
   <script>  
  $(function() {
	 // $(".buttontest").attr("disabled", true);
      $("#id_check").click(function() {
    		//console.log("되는건가");
            var seller_id = $("input[name=seller_id]").val();
           // console.log(seller_id);
            //	if(seller_id.length < 1){
            //		alert("아이디를 입력하세요");
            	//}
            	//else{
            		
                     $.ajax({
                              url : "id_check",
                              type : "get",
                              contetType: "application/x-www-form-urlencoded; charset=UTF-8",
                              data : {
                                 'seller_id' : seller_id
                              },
                              success : function(resp) { //resp = 위코드가 성공적으로 컨트롤러에 다녀왔을때 가져온 값
									console.log(resp);                              		
                              		if(resp == 0){
                              			window.alert("정확하지 않은 아이디 입니다")
                              
                              			console.log($('input[name="idcheck2"]').val());
									//	$(".buttontest").attr("disabled", false);
										$('input[name="idcheck2"]').val("Y");
                              		}
                              		else{
                              			window.alert("정확한 아이디 입니다")
                              			$('input[name="idcheck2"]').val("N");
                              			
                              		}
                                 }
                                 
                        
                              });
            	//}
    });
   });
// 		.validate-form은 처음에 숨기고 이메일 전송시만 표시
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
					'seller_id' : $("input[name='seller_id']").val(),
					'seller_email' : $("input[name='seller_email']").val()				
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
						console.log($('input[name="check_email_code2"]').val());
						window.alert("인증 완료");
						$('input[name="checkemailcode2"]').val("Y");
						
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
	if ($('input[name="seller_id"]').val() == "") {
		window.alert("아이디를 입력해주세요");
		return false;
	}
	var idcheck2 =$('input[name="idcheck2"]').val(); 
	if(idcheck2 != 'Y'){
		alert("아이디 중복체크를 해주세요.");
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

</head> 

<body>
<div class="continer-fluid">
	<div class="row"  style="padding:50px;">
		<div class="offset-md-4 col-md-4 ">
	 	 <div class="row justify-content-center" style="padding: 20px;"><h1>비밀번호 찾기</h1></div>
         <br><br><br>
		 <form id=frm action="pwfind" method="post">
		 <!-- <form class="form-inline">옆으로 오는 입력 형식 -->
              <!--아이디 입력창-->
			  <div class="form-group">
  				<label class="col-form-label">ID : </label>
  				<input type="text" class="form-control" name="seller_id"required>
			  	 <!--  name = 값 controller에있는파라미터값변수명하고 일치해야함 -->
			  	<input type="button"class="btn btn-secondary disabled" id="id_check" value="중복확인" ><br>
			  	 <input type="hidden"name="idcheck2" value="N">
			  </div>
			  			   <!-- 이메일 입력창 -->
			  <div class="form-group">			 
  				<label class="col-form-label" for="email">이메일 : </label>
  				<input type="email" class="form-control"id="email"name="seller_email"placeholder="이메일 입력" required>
			  	<input type="button" class="btn btn-secondary disabled" id="check_email" value="인증번호 보내기">
				<input type="text" name="cert" placeholder="인증번호 입력" style="display: none;">
				<input type="button" class="btn btn-secondary disabled" name="check_email_code" id="check_email_code" value="인증번호확인"style="display: none;">
				<input type="hidden"name="checkemailcode2" value="N">	
				<!-- <p id="msg">이메일 인증에 실패하였습니다</p> -->
			  </div>
			  			   <!--버튼 창 -->
			  <div class="form-group">
			   	<button type="button" class="btn btn-secondary disabled btn-block" onclick="test()">비밀번호 찾기</button>
			  </div>
			 </form>
		   </div>
		</div>
   </div>
 </body>