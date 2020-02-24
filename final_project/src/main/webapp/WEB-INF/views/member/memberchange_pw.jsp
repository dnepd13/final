<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
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


<h1>비밀번호 변경</h1>

<form action="memberchange_pw" method="get">
<label>새비밀번호</label> <input type="password" name="member_pw" id="password1" required /> <br> 
<label>비민번호 재 확인페이지</label> <input type="password"    id="password2"  required /> <br>
<div class="alert alert-success" id="alert-success">비밀번호가 일치합니다.</div>
 <div class="alert alert-danger" id="alert-danger">비밀번호가 일치하지 않습니다.</div>
<input type="submit" id="submit" value="변경하기">
</form> 