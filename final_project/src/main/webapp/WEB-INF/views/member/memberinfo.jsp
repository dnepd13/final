<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
  </script>
  <script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
 <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>

   <div class="container-fluid" style="padding-top:100px;">
        <div class="row">
            <div class="offset-md-4 col-md-4 ">
				<div class = "card border-secondary mb-3"style = "max-width : 500rem;" >
  				<div class = "card-header" >
  				   <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"size="4"; >멤버 회원정보 </font></font>
  				</div>
  				<div class = "card-body">
  				  <form action="memberinfo" method="post">
               <!--     <h4 class = "card-title"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> Seller Information </font> </font> </h4> -->
    			   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 아이디 : ${memberDto.member_id} </font></font></p>
    			   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 이름 : ${memberDto.member_name} </font></font></p>
   				   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 이메일 : ${memberDto.member_email} </font></font></p>
    			   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 연락처 : ${memberDto.member_phone} </font></font></p>
    			   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 생년월일 : ${memberDto.member_birth} </font></font></p>
    			   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 등급 : ${memberDto.member_grade} </font></font></p>
    			   <button type="submit" class="btn btn-secondary disabled btn-block">정보 수정하기</button>
    			 </form>
  				</div>
 			 </div>
 		  </div>
 		</div> 
 	</div>	 
 
 
 <jsp:include page="/WEB-INF/views/template/footer.jsp"/>

