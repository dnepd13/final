<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

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

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>

<section class="section1">
<div class="ordering_area row justify-content-center">
	<div class="col-lg-8 cart_area">
		<div class="cart_title" style="padding-bottom:50px;">
			<h3>문의게시판 글 등록</h3>
		</div>
<div class="insert_req form-group ">
	<form action="qnaregist" method="post">
			<input type="text" name="admin_qna_title" value="" required class="form-control" placeholder="제목" width=1000px;>
			<div class="row-empty-20"></div>
		<textarea name="admin_qna_content" required rows="15" cols="140" style="resize:none;" class="form-control" placeholder="내용"></textarea>
			<div class="row-empty-20"></div>
		<p align="right">
			<button class="btn btn-primary regist" value="등록 ">등록</button>&nbsp;&nbsp;
			<a href="${pageContext.request.contextPath}/board/memberqna"><button class="btn btn-primary regist" type="button">목록으로</button></a>
		</p>
	</form>
	</div>
</div>
</div>
</section>

<div class="row-empty-40"></div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>

