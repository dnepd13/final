<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
<script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>


<form action="check_pw" method="post">
현재비밀번호<input type="password" name="member_pw">
<input type="submit" value="확인">
</form> 