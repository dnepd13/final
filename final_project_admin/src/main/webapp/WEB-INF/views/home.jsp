<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%-- ${pageContext.request.contextPath} 절대경로--%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<jsp:include page="${pageContext.request.contextPath}/template/header.jsp"></jsp:include>

<div><h1>회원 ${memberCount } 명   판매자 ${sellerCount } 명  오늘 가입자 ${todayRegist } 명  </h1></div>


