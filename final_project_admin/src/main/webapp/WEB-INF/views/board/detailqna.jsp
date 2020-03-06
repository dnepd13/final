<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css"> 
<aside>
<div>
<jsp:include page="../template/header.jsp"></jsp:include>
</div>
</aside>

<section class="admin" style="padding-left: 250px;">
	<article>
<div class="container-fluid">
        <div class="row" style="padding-top: 50px;">
            <div class="offset-md-1 col-md-10" >
<div class="row justify-content-center" style="padding: 20px;"><h1>관리문의 게시판 목록</h1></div>
<hr>
<h1>${one.admin_qna_title}</h1>
<h3>${one.admin_qna_usertype} ${one.admin_qna_writer} ${one.admin_qna_date}</h3>
<hr>
<h3>${one.admin_qna_content}</h3>
<hr>
<div class="offset-md-4 col-md-4">

<div class="btn-group-vertical">
	<a href="${pageContext.request.contextPath}/board/write?admin_qna_no1=${one.admin_qna_no}&member_no=${one.member_no}&seller_no=${one.seller_no}"><button type="button" class="btn btn-primary">답글쓰기</button></a>
</div>
<c:if test="${one.admin_qna_writer == admin_id }">
<div class="btn-group-vertical">
	<a href="${pageContext.request.contextPath}/board/editqna?admin_qna_no1=${one.admin_qna_no}"><button type="button" class="btn btn-primary">수정</button></a>
</div>
</c:if>
<c:if test="${admin_grade=='총괄관리자' or one.admin_qna_writer == admin_id }">
<div class="btn-group-vertical">
	<a href="${pageContext.request.contextPath}/board/delete?admin_qna_no1=${one.admin_qna_no}"><button type="button" class="btn btn-primary">삭제</button></a>
</div>
</c:if>
</div>

</div>
        </div>
    </div>
</article></section>
