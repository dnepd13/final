<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
  </script>
  <script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
  
   <div class="container-fluid">
        <div class="row">
            <div class="offset-md-4 col-md-4 ">
                <div class="row justify-content-center"><h1>회원 아이디 찾기</h1></div>
                <br><br><br>
                <form action="memberfind_id" method="post">  
                <!-- 이름 입력창 -->
			  <div class="form-group">
  				<label class="col-form-label" for="inputDefault">이름 : </label>
  				<input type="text" class="form-control"id="inputDefault"name="member_name"required>
			  </div>
			  <div class="form-group">			 
  				<label class="col-form-label" for="email">이메일 : </label>
  				<input type="email" class="form-control"id="email"name="member_email"placeholder="이메일 입력" required>
  			  </div>
  			   
  			   <button type="submit" class="btn btn-secondary disabled btn-block">아이디 찾기</button>
  			   </form>
  		   </div>
  		</div>
  	</div>
  			  












