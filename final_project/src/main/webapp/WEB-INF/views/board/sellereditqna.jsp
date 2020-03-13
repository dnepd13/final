<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    


<!-- 판매자 문의 수정페이지 -->

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">   

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>
<jsp:include page="/WEB-INF/views/template/memberInfoAside.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 


<div align="center" class="btn-group-vertical">

<h1>문의 게시판 상세보기</h1>
<h2><a href="http://localhost:8001/ordering/board/memberqna">목록으로</a></h2>

<form action="sellereditqna" method="post">
	<input type="hidden" name="admin_qna_no" value="${sellerupdateget.admin_qna_no }">

	<div class="btn-group-vertical">
	<a><button class="btn btn-primary" value="수정">수정 확인</button></a>
	</div>
<table class="table table-hover" >

<tbody class="col-lg-4 col-md-6">

	<tr>
		<td width="100px">제목</td>
		<th><input type="text" name="admin_qna_title" value="${sellerupdateget.admin_qna_title}" maxlength="68" required></th>
	</tr>

	<tr>
		<td width="100px">	<textarea name="admin_qna_content" rquired rows="15" cols="100" style="resize:none;">
		${sellerupdateget.admin_qna_content}</textarea>
	</td>

</tbody>

	

</table>
</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>