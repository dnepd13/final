<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
  </script>
    <script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
     <script type="text/javascript"> 
      $(function(){
    	$("#submit").attr("disabled", true); 
    	$("#alert-success").hide(); 
    	$("#alert-danger").hide();
		$("input").keyup(function(){ 
				var password1=$("#password1").val(); 
				var password2=$("#password2").val();
				if(password1 != "" || password2 != ""){ 
					if(password1 == password2){ 
					$("#alert-success").show();
					$("#alert-danger").hide(); 
					$("#submit").attr("disabled", false); 
				}else{
					$("#alert-success").hide();
					$("#alert-danger").show(); 
					$("#submit").attr("disabled", true); 
				} 
			} 
		});
	}); 

  </script>
<div class="container-fluid">
     <div class="row">
         <div class="offset-md-4 col-md-4 ">
            <div class="row justify-content-center"><h1>판매자 비밀번호 변경 페이지</h1></div>
            <br><br><br>
            <form action="change_pw" method="post">
 
				<!--비밀번호 입력창-->
               <div class="form-group">
               	 <label for="pw-input">비밀번호 입력 </label>
                 <input class="form-control" type="password" id="pw-input1" name="seller_pw" required>
               </div>
                 <!--비밀번호 재 입력창-->
               <div class="form-group">
                  <label for="pw-input">비밀번호 재입력 </label>
                  <input class="form-control" type="password" id="pw-input2" name="seller_pw" required>
               </div>
               <div class="alert alert-success" id="alert-success">비밀번호가 일치합니다.</div>
 <div class="alert alert-danger" id="alert-danger">비밀번호가 일치하지 않습니다.</div>
                <button type="submit" class="btn btn-secondary disabled btn-block">비밀번호 변경하기</button>
             </form>
          </div>
       </div>
</div>

<!-- <h1>판매자 비밀번호 변경 페이지</h1>

<form action="change_pw" method="get">
<label>새비밀번호</label> <input type="password" name="seller_pw" id="password1" required /> <br> 
<label>비민번호 재 확인</label> <input type="password"    id="password2"  required /> <br>
<div class="alert alert-success" id="alert-success">비밀번호가 일치합니다.</div>
 <div class="alert alert-danger" id="alert-danger">비밀번호가 일치하지 않습니다.</div>
<input type="submit" id="submit" value="변경하기">
</form> -->