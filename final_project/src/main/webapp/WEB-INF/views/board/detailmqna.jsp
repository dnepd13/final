<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">   


<!-- 회원 문의 상세 페이지 -->


<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>
<jsp:include page="/WEB-INF/views/template/memberInfoAside.jsp"/>


<section class="section1">
<div class="ordering_area row justify-content-center">
	<div class="col-lg-8 cart_area">
		<div class="cart_title">
			<h3>문의 게시판 상세보기</h3>
		</div>


<table class="table table-hover cart_table">
<tbody>
	<tr>
		<th width="121px">제목</th>
		<td width="600px" style="word-break:break-all;">${qnaoneGetOne.admin_qna_title}</td>
	</tr>
		<tr>
		<th width="121px">작성자구분</th>
		<td width="600px">${qnaoneGetOne.admin_qna_usertype}</td>
	</tr>
		<tr>
		<th width="121px">작성자</th>
		<td width="600px">${qnaoneGetOne.admin_qna_writer}</td>
	</tr>
		<tr>
		<th width="121px">작성일</th>
		<td width="600px">${qnaoneGetOne.admin_qna_date}</td>
	</tr>
		<tr>
		<th width="121px">내용</th>
		<td width="600px" style="word-break:break-all;">${qnaoneGetOne.admin_qna_content}</td>
	</tr>
	</tbody>
	</table>
		<p align="right">
			<c:choose>
				<c:when test="${qnaone.admin_no >0}">	
					<h1>관리자의 답변입니다.</h1>
				</c:when>
			<c:otherwise>
			<div class="btn-group-vertical" >
				<a href="${pageContext.request.contextPath}/board/updateqna?admin_qna_no=${qnaone.admin_qna_no}">
					<button type="button" class="btn btn-primary">수정하기</button>
				</a>
					</div> 
			</c:otherwise>
			</c:choose>
			<a href="${pageContext.request.contextPath}/board/memberqna"><button class="btn btn-primary regist" type="button">목록으로</button></a>
		</p>
	<p align="right"></p>
</div>
</div>
</section>
<div class="row-empty-40"></div>
<div class="row-empty-40"></div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>


