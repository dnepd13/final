 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 
 <!-- 회원id 찾기 결과창 -->
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>



<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>

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
  
  
   <div class="login-area">
       <form action="find_id_info" method="post"> 
             <fieldset>
                <div class="row justify-content-center" style="padding-top:100px;">
                <br><br><br>
                 
                <div class="form-group">
                <P style="font-size: 18px ">고객님 정보와 일치하는 아이디 입니다.</P>
                 
                <div>
    			<p style="font-size: 24px ">${memberDto.member_id}</p>                
                </div>
                
                 <div class="row-empty-40"></div>
                  <p align="right">
                 	<a href="${pageContext.request.contextPath}/member/login"><button class="btn btn-secondary" type="button" style="width:35%;">로그인</button></a>
 					<a href="${pageContext.request.contextPath}/member/pwfind"><button class="btn btn-secondary" type="button" style="width:35%;">비밀번호찾기</button></a>
                  </p>
                </div>
                </div>
             </fieldset>
       </form>
   </div>

				
	
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>	
         