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
                <P style="font-size: 18px ">고객님 정보와 일치하는 아이디 입니다.</P>
                <form action="find_id_info" method="post">  
                <div>
                <p>${memberDto.member_id}</p>                
                </div>
         		<button type="submit" class="btn btn-secondary disabled">로그인 하기</button>
         		</form>
         		<button type="submit" class="btn btn-secondary disabled" onclick="location.href = 'pwfind' ">비밀번호 찾기</button>
			</div>
		 </div>
	</div>
	
         