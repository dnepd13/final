<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css"> 
<h1>문의게시판 상세보기</h1>
<h1><a href="${pageContext.request.contextPath}/home">홈으로</a></h1>
<hr>
<h1>${one.admin_qna_title}</h1>
<h3>${one.admin_qna_usertype} ${one.admin_qna_writer} ${one.admin_qna_date}</h3>
<hr>
<h3>${one.admin_qna_content}</h3>
<hr>
<div class="btn-group-vertical">
	<a href="${pageContext.request.contextPath}/board/write?admin_qna_no=${one.admin_qna_no}"><button type="button" class="btn btn-primary">답글쓰기</button></a>
</div>




