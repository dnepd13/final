<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>

<span><a href="${pageContext.request.contextPath }/member/login">회원로그인</a></span>
<span> &#124; </span>
<span><a href="${pageContext.request.contextPath }/seller/login">판매자로그인</a></span>
<span> &#124; </span>
<span><a href="${pageContext.request.contextPath }/goods/getList">상품List</a></span>
</body>
</html>
