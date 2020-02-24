<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">       

<h1>문의 게시판 상세보기</h1>
<h1><a href="${pageContext.request.contextPath}/home">홈으로</a></h1>

<hr>
<h1>제목:${qnaone.admin_qna_title}</h1>
<h1>회원등급:${qnaone.admin_qna_usertype}</h1>
<h1>작성자:${qnaone.admin_qna_writer}</h1>
<h1>작성일:${qnaone.admin_qna_date}</h1>
<hr>
<hr>
<h3>내용:${qnaone.admin_qna_content}</h3>
<hr>
<div class="btn-group-vertical">
	<a href="${pageContext.request.contextPath}/board/editqna?admin_qna_no=${qnaone.admin_qna_no}">
		<button></button>
	</a>
</div> 