<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">   

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>
<jsp:include page="/WEB-INF/views/template/memberInfoAside.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<div align="center" class="btn-group-vertical">

<h1>문의 게시판 상세보기</h1>
<h2><a href="http://localhost:8001/ordering/board/memberqna">목록으로</a></h2>


<c:choose>
<c:when test="${admin_qna_writer == admin}">	
	<div class="btn-group-vertical">
	<a href="${pageContext.request.contextPath}/board/sellereditqna?admin_qna_no=${sellerQnaGetOne.admin_qna_no}">
		<button type="button" class="btn btn-primary">수정</button>
	</a>
</div> 
</c:when>
<c:otherwise>
	<h1>관리자의 답변입니다.</h1>

</c:otherwise>
</c:choose>
<table class="table table-hover">
<tbody>
	<tr>
		<th width="121px">제목</th>
		<td width="600px">${sellerQnaGetOne.admin_qna_title}</td>
	</tr>
		<tr>
		<th width="121px">작성자구분</th>
		<td width="600px">${sellerQnaGetOne.admin_qna_usertype}</td>
	</tr>
		<tr>
		<th width="121px">작성자</th>
		<td width="600px">${sellerQnaGetOne.admin_qna_writer}</td>
	</tr>
		<tr>
		<th width="121px">작성일</th>
		<td width="600px">${sellerQnaGetOne.admin_qna_date}</td>
	</tr>
	
	
	<tr>
		<th></th>
		<td width="600px" align="left">${sellerQnaGetOne.admin_qna_content}</td>
	</tr>
</tbody>

	

</table>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>