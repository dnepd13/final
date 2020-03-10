<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

<style>
	* {box-sizing: border-box;}
	.myInfo_wrap {
		width: 1200px;
		height: 800px;
		margin: 0 auto;
	}
	.pwChange_wrap {
		float: left;
		margin-left: 60px;
		padding-top: 100px;
		width: 900px;
	}
	.pwChange_wrap::after{content:""; display: block; clear:both;}
	.pwChange_main {
		margin: 0 auto;
		width: 90%;
		height: 50px;
		border-bottom: 2px solid #F3F5F8;
	}
	.pwChange_mainBox1 {
		width: 200px;
		height: auto;
		padding-top: 10px;
		margin-left: 30px;
		float: left;
		font-size: large; 
	}
	.pwChange_list {
		margin: 30px auto;
		width: 90%;
	}
	form {
		margin: 0 auto;
		width: 50%;
	}
	
</style>

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

<div class="myInfo_wrap">
<jsp:include page="/WEB-INF/views/template/memberInfoAside.jsp"/>
	<div class="pwChange_wrap">
		<div class="pwChange_main">
			<div class="pwChange_mainBox1">
				비밀번호 변경
			</div>
		</div>
		<div class="pwChange_list form-group">
			<form action="memberchange_pw" method="get">
				<label>새비밀번호</label> <input type="password" name="member_pw" id="password1" class="form-control" required /> <br> 
				<label>비민번호 재 확인페이지</label> <input type="password" id="password2" class="form-control" required /> <br>
				<div class="alert alert-success" id="alert-success">비밀번호가 일치합니다.</div>
				 <div class="alert alert-danger" id="alert-danger">비밀번호가 일치하지 않습니다.</div>
				<input type="submit" id="submit" class="btn btn-primary" value="변경하기" style="width:100%;">
			</form> 
		</div>
	</div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"/>