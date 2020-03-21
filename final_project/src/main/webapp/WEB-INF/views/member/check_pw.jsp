<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">

<div class="container-fluid">
     <div class="row">
         <div class="offset-md-4 col-md-4 ">
            <div class="row justify-content-center"><h2>현재 비밀번호를 입력해주세요</h2></div>
            <br><br><br>
    		<form action="check_pw" method="post">
    		   <!--비밀번호 입력창-->
               <div class="form-group">
               	 <label for="pw-input">현재 비밀번호 </label>
                 <input class="form-control" type="password" id="pw-input" name="member_pw" maxlength="38" required>
               </div>
               <button type="submit" class="btn btn-secondary disabled btn-block">다음</button>
           </form>
          </div>
      </div>
</div>             
            
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>
