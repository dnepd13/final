 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
  </script>
  <script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
  <jsp:include page="/WEB-INF/views/template/header.jsp"/>
 <jsp:include page="/WEB-INF/views/template/menu.jsp"/>                  
  
   <div class="container-fluid">
        <div class="row">
            <div class="offset-md-4 col-md-4 ">
                <div class="row justify-content-center"><h1>판매자 아이디 찾기</h1></div>
                <br><br><br>
                <P style="font-size: 18px ">고객님 정보와 일치하는 아이디 입니다.</P>
                <form action="find_id_info" method="post">  
                <div>
                <p>${sellerDto.seller_id}</p>                
                </div>
         		<button type="submit" class="btn btn-secondary disabled">로그인 하기</button>
         		</form>
         		<button type="submit" class="btn btn-secondary disabled" onclick="location.href = '#' ">비밀번 찾기</button>
			</div>
		 </div>

	</div>
	<!-- <h1>판매자 아이디는</h1>
    <form action="find_id_info" method="post">
<h3>판매자 아이디 :${sellerDto.seller_id}</h3>

   <input   type="submit" value="로그인하기"> 
         </form>  -->	

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>         

