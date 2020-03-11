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
				<div class = "card border-secondary mb-3"style = "max-width : 500rem;">
  				<div class = "card-header">
  				  <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"size="4";>회원정보 수정 </font></font>
  				</div>
  				<div class = "card-body">
  				
				 <form action="editmember" method="post">
				  <%-- <h5 class = "card-title"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> ${sellerDto.seller_id}님의 정보입니다 </font> </font> </h5> --%>
    			   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 아이디 :${memberDto.member_id} </font></font></p>
    			   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 이름 :${memberDto.member_name} </font></font></p>
    			   <div class="form-group">
   				   	<p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 
   				   	   이메일 : <input style="width:15rem;" class="form-control form-control-sm" type="text" name="member_email" value="${memberDto.member_email}"> </font></font></p>
    			   </div>
    			    <div class="form-group">
        			   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 
    			   	   연락처 : <input class="form-control form-control-sm" type="text" name="member_phone" value="${memberDto.member_phone}"> </font></font></p>
    			      </div> 
    			    <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 생년월일 :${memberDto.member_birth} </font></font></p> 
        			<p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 등급 :${memberDto.member_grade} </font></font></p>  		  
    			   <button type="submit" class="btn btn-secondary disabled btn-block">수정하기</button>
    			 </form>
  				</div>
 			 </div>
 		  </div>
 		</div> 
 	</div>	 
