<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">   

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<style>
.section1{
	margin: 0 auto;
	width: 1500px;
}
.section2{
	margin: 0 auto;
	width: 1000px;
	padding-left: 200px;
}
.ordering_area {
	margin: 30px 0px;
}

.col-lg-8 {
	margin: 25px 0px;
}

.cart_table_title {
	border-bottom: 1px solid #171717;
}
 	.insert_cate,
 	.insert_req  {
 		width: 80%;
 	}
 	.insert_req * {
 		width: 100%;
 	}
 	.text-primary {
 		font-weight: bold; 
 	}
 	.insert_req textarea{
 		resize: none;
 		height: 25%;
 	}
 	.insert_req .regist {
 		height: 30px;
 		width: 100px;
 	}
</style>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>
<section class="section1">
<div class="ordering_area row justify-content-center">
	<div class="col-lg-8 cart_area">
		<div class="cart_title">
			<h3>문의 게시판 상세보기 ${seller_id }</h3>
		</div>
	</div>
</div>
<table class="table table-borderless cart_table">
			<tr class="cart_table_title">
			
				<th scope="col" class="align-middle text-center" style="width: 800px">제목</th>
				<td width="600px">${sellerQnaGetOne.admin_qna_title}</td>
				<th scope="col" class="align-middle text-center" style="width: 150px">작성자</th>
				<td width="600px">${sellerQnaGetOne.admin_qna_writer}</td>
				<th scope="col" class="align-middle text-center" style="width: 150px">구분</th>
				<td width="600px">${sellerQnaGetOne.admin_qna_usertype}</td>
				<th scope="col" class="align-middle text-center" style="width: 300px">작성시간</th>
				<td width="600px">${sellerQnaGetOne.admin_qna_date}</td>
			</tr>
</section>
<section class="section2">
<div class="insert_req form-group">
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