
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!--판매자 비밀번호 찾기의 비밀번호 변경 페이지>-->


<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>





 
<div class="container-fluid"style="margin-top: 5%;">
     <div class="row">
         <div class="offset-md-4 col-md-4 ">
            <div class="row justify-content-center"><h1> 판매자 비밀번호 변경 페이지</h1></div>
            <br><br><br>
            <form action="emailpwchange" method="post">
 
				<!--비밀번호 입력창-->
               <div class="form-group">
               	 <label for="pw-input">비밀번호 입력 </label>
                 <input class="form-control" type="password" id="pw-input1" name="seller_pw" required>
               </div>
               
                <button type="submit" class="btn btn-secondary disabled btn-block" id="frm">비밀번호 변경하기</button>
             </form>
          </div>
       </div>
</div>




 <jsp:include page="/WEB-INF/views/template/footer.jsp"/>

 
