<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">   

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
</style>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>
<jsp:include page="/WEB-INF/views/template/memberInfoAside.jsp"/>


<section class="section1">
<div class="ordering_area row justify-content-center">
	<div class="col-lg-8 cart_area">
		<div class="cart_title">
			<h3>신고게시판 상세보기</h3>
		</div>
<h2><a href="http://localhost:8001/ordering/board/memberreport">목록으로</a></h2>


<c:choose>
<c:when test="${param.admin_qna_no >0}">	
	<h1>수정 할 수 없는 게시글 입니다.</h1>
</c:when>
<c:otherwise>
	<div class="btn-group-vertical">
	<a href="${pageContext.request.contextPath}/board/editreport?admin_qna_no=${ReportGetOne.admin_qna_no}">
		<button type="button" class="btn btn-primary">수정</button>
	</a>
</div> 

</c:otherwise>
</c:choose>
<table class="table table-hover cart_table">
<tbody>
	<tr>
		<th width="121px">제목</th>
		<td width="600px">${ReportGetOne.admin_qna_title}</td>
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
			<th class="row-empty-20"></th>
	<th><textarea name="admin_qna_content" required rows="15" cols="100" style="resize:none;" class="form-control" placeholder="내용">${ReportGetOne.admin_qna_content}</textarea></th>
		<th class="row-empty-20"></th>
<%-- 				<td width="600px" align="left">${ReportGetOne.admin_qna_content}</td> --%>
	</tr>
</tbody>

	

</table>
	<p align="right">
			<button class="btn btn-primary regist" value="updateqna">수정하기 </button>&nbsp;&nbsp;
			<a href="${pageContext.request.contextPath}/board/memberqna"><button class="btn btn-primary regist" type="button">목록으로</button></a>
		</p>
	<p align="right"></p>
</div>
</section>
<div class="row-empty-40"></div>
<div class="row-empty-40"></div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>>



<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" --%>
<%--     pageEncoding="UTF-8"%> --%>
<%-- <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>     --%>
<%-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">    --%>

<%-- <jsp:include page="/WEB-INF/views/template/header.jsp"/> --%>
<%-- <jsp:include page="/WEB-INF/views/template/menu.jsp"/> --%>
<%-- <jsp:include page="/WEB-INF/views/template/memberInfoAside.jsp"/> --%>

<%-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">  --%>
<%-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css">  --%>

<!-- <div align="center" class="btn-group-vertical"> -->

<!-- <h1>신고 게시판 상세보기</h1> -->
<!-- <h2><a href="http://localhost:8001/ordering/board/memberreport">목록으로</a></h2> -->


<%-- <c:choose> --%>
<%-- <c:when test="${param.admin_qna_no >0}">	 --%>
<!-- 	<h1>수정 할 수 없는 게시글 입니다.</h1> -->
<%-- </c:when> --%>
<%-- <c:otherwise> --%>
<!-- 	<div class="btn-group-vertical"> -->
<%-- 	<a href="${pageContext.request.contextPath}/board/editreport?admin_qna_no=${ReportGetOne.admin_qna_no}"> --%>
<!-- 		<button type="button" class="btn btn-primary">수정</button> -->
<!-- 	</a> -->
<!-- </div>  -->

<%-- </c:otherwise> --%>
<%-- </c:choose> --%>
<!-- <table class="table table-hover"> -->
<!-- <tbody> -->
<!-- 	<tr> -->
<!-- 		<th width="121px">제목</th> -->
<%-- 		<td width="600px">${ReportGetOne.admin_qna_title}</td> --%>
<!-- 	</tr> -->
<!-- 		<tr> -->
<!-- 		<th width="121px">작성자구분</th> -->
<%-- 		<td width="600px">${ReportGetOne.admin_qna_usertype}</td> --%>
<!-- 	</tr> -->
<!-- 		<tr> -->
<!-- 		<th width="121px">작성자</th> -->
<%-- 		<td width="600px">${ReportGetOne.admin_qna_writer}</td> --%>
<!-- 	</tr> -->
<!-- 		<tr> -->
<!-- 		<th width="121px">작성일</th> -->
<%-- 		<td width="600px">${ReportGetOne.admin_qna_date}</td> --%>
<!-- 	</tr> -->
	
	
<!-- 	<tr> -->
<!-- 		<th></th> -->
<%-- 				<td width="600px" align="left">${ReportGetOne.admin_qna_content}</td> --%>
<!-- 	</tr> -->
<!-- </tbody> -->

	

<!-- </table> -->
<!-- </div> -->

<%-- <jsp:include page="/WEB-INF/views/template/footer.jsp"/> --%>