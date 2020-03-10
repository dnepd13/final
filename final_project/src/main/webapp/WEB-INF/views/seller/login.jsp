<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
  
  <div class="container-fluid">
        <div class="row" style="padding: 50px;">
            <div class="offset-md-1 col-md-10">
            
            
   <div class="container-fluid">
        <div class="row" >
            <div class="offset-md-3 col-md-6 ">
            
                <div class="row justify-content-center" style="padding-top:20px;">
                <img style="padding-left:20px;" src="${pageContext.request.contextPath}/resources/img/logo-ordering.png" width=400px; height=200px;>
                <h1>판매자 로그인</h1>
                </div>
                <br><br><br>
                <form action="login" method="post"> 
               	   <!--아이디 입력창-->
			  		<div class="form-group">
  						<label class="col-form-label" for="inputDefault">ID : </label>
  						<input type="text" class="form-control" name="seller_id" placeholder="ID"required>
			  	 	<!--  name = 값 controller에있는파라미터값변수명하고 일치해야함 -->			  	
			  		</div>
              		<!-- 비밀번호 입력창 -->
               		<div class="form-group">
  						<label class="col-form-label" for="inputDefault">PW : </label>
  						<input type="password" class="form-control"id="inputDefault"name="seller_pw"  placeholder="Password" required>
			 	   </div>
			  
			    	<button type="submit" class="btn btn-secondary disabled btn-block">로그인</button>
			    </form>
			    <button type="button" class="btn btn-secondary disabled btn-block" onclick="location.href = 'find_id' ">아이디찾기</button>
			    <button type="button" class="btn btn-secondary disabled btn-block"onclick="location.href = '#' ">비밀번호 찾기</button>
			    
			   <div class="fail row justify-content-center">
                	<c:if test="${param.error != null }">
                		<h4>정보를 다시 입력하세요</h4>
                	</c:if>
                </div> 
              </div>
          </div>
       </div>
</div>
        </div>
  </div>
