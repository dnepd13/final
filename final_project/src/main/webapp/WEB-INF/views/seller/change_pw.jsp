<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
     
<jsp:include page="/WEB-INF/views/template/header-seller.jsp"/>     
     
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 


<style>
	.login-area {
		width: 500px;
		margin: 0 auto;
		padding-top: 50px;
	}
	.login input[type=text],
	.login input[type=password],
	.login input[type=submit]{
		width: 100%;
		border: 1px solid lightgray;
		border-radius: 5px;
 	}
 	
</style>



 
<div class="container-fluid">
     <div class="row">
         <div class="offset-md-4 col-md-4 ">
            <div class="row justify-content-center"><h1>비밀번호 변경 페이지</h1></div>
            <br><br><br>
            <form action="change_pw" method="post">
 
				<!--비밀번호 입력창-->
               <div class="form-group">
               	 <label for="pw-input">변경할 비밀번호를 입력 해주세요. </label>
                 <input class="form-control" type="password" id="pw-input1" name="seller_pw" required>
               </div>
                <button type="submit" id="frm" class="btn btn-secondary disabled btn-block">비밀번호 변경하기</button>
             </form>
          </div>
       </div>

</div>
 
<jsp:include page="/WEB-INF/views/template/footer-seller.jsp"/>
 
