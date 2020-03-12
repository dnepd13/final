<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<<<<<<< HEAD
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
</script>
<script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>


  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
  

=======
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
  </script>
  <script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
  
>>>>>>> refs/remotes/origin/lyrak_master
  <script>  
  $(function() {
<<<<<<< HEAD
		 // $(".buttontest").attr("disabled", true);
	      $("#id_check").click(function() {
	    		//console.log("되는건가");
	            var member_id = $("input[name=member_id]").val();
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
	                                 'member_id' : member_id
	                              },
	                              success : function(resp) { //resp = 위코드가 성공적으로 컨트롤러에 다녀왔을때 가져온 값
										console.log(resp);                              		
	                              		if(resp == 0){
	                              			window.alert("사용 가능한 아이디 입니다")
	                              			console.log($('input[name="idcheck2"]').val());
										//	$(".buttontest").attr("disabled", false);
											$('input[name="idcheck2"]').val("Y");
	                              		}
	                              		else{
	                              			window.alert("중복된 아이디 입니다")
	                              			$('input[name="idcheck2"]').val("N");
	                              			
	                              		}
	                                 }
	                                 
	                        
	                              });
	            	//}
	    });
	   });
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
//	 		.validate-form은 처음에 숨기고 이메일 전송시만 표시
	$(function() {
		//	$("#check_email_code").hide();
=======
	  $(".buttontest").attr("disabled", true);
      $(".test").click(function() {
    		console.log("확인용");
            var member_id = $("input[name=member_id]").val();
            console.log(seller_id);
            	if(member_id.length < 1){
            		alert("확인을 위해 아이디를 입력하세요");
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
>>>>>>> refs/remotes/origin/lyrak_master
			
//	 		.email-form이 전송되면 send 주소로 비동기 신호를 전송(ajax)
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
//	 		validate-form이 전송되면 /validate로 비동기 요청을 전송
			$("#check_email_code").click(function(){
			//	e.preventDefault();
			//	console.log("string");
//	 			var url = $(this).attr("action"); 
//	 			var method = $(this).attr("method");
		//	var data = $(this).serialize();
				
				$.ajax({
					url:"validate",
					type:"post",
					data:{
						'cert' :$("input[name='cert']").val()
					},
					success:function(data){
//	 					console.log(resp);
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
<<<<<<< HEAD
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
		if ($('input[name="member_pw"]').val() == "") {
			alert("비밀번호를 입력해주세요.");
			return false;
		}
		if ($('input[name="member_name"]').val() == "") {
			alert("이름을 입력해주세요.");
			return false;
		}
		var checkemailcode2 = $('input[name="checkemailcode2"]').val();
		console.log($('input[name="checkemailcode2"]').val());
		if(checkemailcode2 != 'Y'){
			alert("이메일 인증이 필요합니다.");
			return false;
			}
		if ($('input[name="member_phone"]').val() == "") {
			alert("연락처를 입력해주세요.");
			return false;
		}
		if ($('input[name="member_birth"]').val() == "") {
			alert("생년 월일을 입력해주세요.");
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
=======
		});
});

>>>>>>> refs/remotes/origin/lyrak_master
</script>

<<<<<<< HEAD
<body>
<div class="continer-fluid">
	<div class="row"  style="padding:50px;">
		<div class="offset-md-4 col-md-4 ">
	 	 <div class="row justify-content-center" style="padding: 20px;"><h1>회원가입</h1></div>
         <br><br><br>
		 <form id=frm action="regist" method="post">
		 <!-- <form class="form-inline">옆으로 오는 입력 형식 -->
              <!--아이디 입력창-->
			  <div class="form-group">
  				<label class="col-form-label">ID : </label>
  				<input type="text" class="form-control" name="member_id"required>
			  	 <!--  name = 값 controller에있는파라미터값변수명하고 일치해야함 -->
			  	<input type="button"class="btn btn-secondary disabled" id="id_check" value="중복확인" ><br>
			  	 <input type="hidden"name="idcheck2" value="N">
			  </div>
              <!-- 비밀번호 입력창 -->
               <div class="form-group">
  				<label class="col-form-label" >PW : </label>
  				<input type="password" class="form-control" name="member_pw"required>
			  </div>
			  <!-- 이름 입력창 -->
			  <div class="form-group">
  				<label class="col-form-label">이름 : </label>
  				<input type="text" class="form-control"name="member_name"required>
			  </div>
			   <!-- 이메일 입력창 -->
			  <div class="form-group">			 
  				<label class="col-form-label" for="email">이메일 : </label>
  				<input type="email" class="form-control"id="email"name="member_email"placeholder="이메일 입력" required>
			  	<input type="button" class="btn btn-secondary disabled" id="check_email" value="인증번호 보내기">
				<input type="text" name="cert" placeholder="인증번호 입력" style="">
				<input type="button" class="btn btn-secondary disabled" name="check_email_code" id="check_email_code" value="인증번호확인"style="">
				<input type="hidden"name="checkemailcode2" value="N">	
				<!-- <p id="msg">이메일 인증에 실패하였습니다</p> -->
			  </div>
			  <!-- 전화번호 입력창 -->
			  <div class="form-group">
  				<label class="col-form-label">전화번호 : </label>
  				<input type="tel" class="form-control" name="member_phone"required>
  					  <div class="form-group">
  				<label class="col-form-label">회원 생년월일 : </label>
  				<input type="text" class="form-control" name="member_birth"required>
			 			   <!--가입일 숨겨서 온다-->
			  <div class="form-group">
			  	<input type="hidden" name="member_agree_date" value="${param.dTime }">
			  </div>
			   <!--버튼 창 -->
			  <div class="form-group">
			   	<button type="button" class="btn btn-secondary disabled btn-block" onclick="test()">가입하기</button>
			  </div>
			  </div>
			  </form>
		   </div>
		</div>
   </div>
 </body>
 
=======

</head>
<body>
<div class="continer-fluid">
	<div class="row"  style="padding:50px;">
			<div class="offset-md-4 col-md-4 ">
	 	 <div class="row justify-content-center" style="padding: 20px;"><h1>회원가입</h1></div>
         <br><br>
         
    <form action="regist" method="post">
   
    <!-- id -->
     <div class="form-group">
  		<label class="col-form-label" for="inputDefault">ID : </label>
	    <input type="text" name="member_id" placeholder="ID를 입력하세요" required>
	    <input class="test" type="button" id="id_check" value="중복확인" ><br>
	</div>
	   
	 <!-- pw -->
	 <div class="form-group">
  		<label class="col-form-label" for="inputDefault">PW : </label>
    	<input type="password" class="form-control" id="inputDefault" name="member_pw"  placeholder="비밀번호를 입력하세요" required>
    </div>
    
    <!-- name -->
     <div class="form-group">
  		<label class="col-form-label" for="inputDefault">이름 : </label>
    	<input type="text" class="form-control" id="inputDefault" name="member_name" placeholder="이름을 입력하세요" required>
    </div>
    
 	<!-- 이메일 입력창 -->
	<div class="form-group"> 	
    			<input type="email" class="form-control"id="email" name="member_email" placeholder="이메일 입력하세요" required>
   				<input type="button" class="btn btn-secondary disabled" id="check_email" value="인증번호 보내기">
				<input type="text" name="cert" placeholder="인증번호를 입력하세요">
				<input type="button" class="btn btn-secondary disabled" name="check_email_code" id="check_email_code" value="인증코드확인">	
	</div>
	
   <!-- 전화번호 입력창 -->
	<div class="form-group">
		<label class="col-form-label" for="inputDefault">전화번호 : </label>
		<input type="tel" class="form-control"id="inputDefault" name="member_phone" placeholder="휴대폰 번호를 입력하세요(-는빼고 숫자만 입력)" required>
	</div>
	
	  <!--주민등록번호/사업자번호 입력창 -->
	<div class="form-group">
  		<label class="col-form-label" for="inputDefault">주민등록번호 : </label>
    	<input type="number" class="form-control"id="inputDefault" name="member_birth" placeholder="생년월일을 입력하세요 (ex: 19890101)" required>
    </div>
    <!--가입일 입력구문-->
		<input type="hidden" name="member_agree_date" value="${param.dTime }">
    	<input type="submit" class="btn btn-secondary disabled btn-block" onclick="test();">회원 가입하기</button>
    </form>
    
</div>
</div>
</div>  
 
    
    
    
    
    
    
    
    
    
>>>>>>> refs/remotes/origin/lyrak_master


