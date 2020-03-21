<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<style>
.ordering_area {
	margin: 30px 0px;
}
.cart_table {
	border-top: 2px solid #171717;
	border-bottom: 1px solid #171717;
}
.col-lg-8 {
	margin: 25px 0px;
}
.cart_table_title {
	border-bottom: 1px solid #171717;
}
.items_area {
	border-bottom: 1px solid #171717;
}
.cart_area {
	margin: 15px 0px;
}
.section1{
	margin: 0 auto;
	width: 1500px;
}
h4{
	color:red;
	padding-bottom:50px;
}
</style>

<section class="section1">
<div class="ordering_area row justify-content-center">
	<div class="col-lg-8 cart_area">
		<div class="cart_title">
			<h3>신고 게시판 상세보기</h3>
		</div>

<table class="table table-hover cart_table">
<tbody>
	<tr>
		<th width="121px">제목</th>
		<td width="600px" style="word-break:break-all;"> ${ReportGetOne.admin_qna_title}</td>
	</tr>
	<tr>
		<th width="121px">작성자구분</th>
		<td width="600px">${ReportGetOne.admin_qna_usertype}</td>
	</tr>
	<tr>
		<th width="121px">작성자</th>
		<td width="600px">${ReportGetOne.admin_qna_writer}</td>
	</tr>
	<tr>
		<th width="121px">작성일</th>
		<td width="600px">${ReportGetOne.admin_qna_date}</td>
	</tr>
	<tr>
		<th width="121px" >내용</th>
		<td width="600px">
		<textarea readonly="readonly" required rows="15" cols="100" style="resize:none;" class="form-control">${ReportGetOne.admin_qna_content}</textarea>
		</th>
	</tr>
</tbody>

</table>
<p align="right">
			<c:choose>
				<c:when test="${qnaone.admin_no >0}">	
					<h4>관리자의 답변입니다.</h4>
				</c:when>
			<c:otherwise>
			<div class="btn-group-vertical"  style="float:right;">
				<a href="${pageContext.request.contextPath}/board/editreport?admin_qna_no=${ReportGetOne.admin_qna_no}">
					<button type="button" class="btn btn-primary">수정하기</button>&nbsp;&nbsp;
				</a>
					</div> 
			</c:otherwise>
			</c:choose>
			<div class="btn-group-vertical"  style="float:right;">
				<a href="${pageContext.request.contextPath}/board/memberreport"><button class="btn btn-primary regist" type="button">목록으로</button></a>
			</div>
	</p>
<p align="right"></p>
</div> 
</div>
</section>
<div class="row-empty-40"></div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>>

