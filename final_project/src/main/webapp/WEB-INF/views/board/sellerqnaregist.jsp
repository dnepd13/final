<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!-- 판매자 문의 작성 페이지 -->


<jsp:include page="/WEB-INF/views/template/header-seller.jsp"/>

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

<section class="section1">
<div class="ordering_area row justify-content-center">
	<div class="col-lg-8 cart_area">
		<div class="cart_title">
			<h3>문의게시판 글 등록 ${seller_id }</h3>
		</div>
	</div>
</div>
</section>

<section class="section2">
<div class="insert_req form-group">
	<form action="sellerqnaregist" method="post">

			<input type="text" name="admin_qna_title" value="" required class="form-control" maxlength="68" placeholder="제목">
			<div class="row-empty-20"></div>
		<textarea name="admin_qna_content" required rows="15" cols="100" style="resize:none;" class="form-control" placeholder="내용"></textarea>
			<div class="row-empty-20"></div>
		<p align="right">
			<button class="btn btn-secondary regist" value="등록 ">등록</button>&nbsp;&nbsp;
			<a href="${pageContext.request.contextPath}/board/sellerqna"><button class="btn btn-secondary regist" type="button">목록으로</button></a>
		</p>
	</form>
     <p align="right"></p>
</div>
</section>

<div class="row-empty-40"></div>
<div class="row-empty-40"></div>

<jsp:include page="/WEB-INF/views/template/footer-seller.jsp"/>

<!-- <div align="center" class="btn-group-vertical"> -->



<!-- <h1>문의 게시판 상세보기</h1> -->
<!-- <h2><a href="http://localhost:8001/ordering/board/sellerqna">목록으로</a></h2> -->

<!-- <form action="sellerqnaregist" method="post"> -->
<!-- 	<div class="btn-group-vertical"> -->
<!-- 	<a><button class="btn btn-primary" value="등록 ">등록</button></a> -->
<!-- 	</div> -->
<!-- <table class="table table-hover" > -->

<!-- <tbody> -->

<!-- 	<tr> -->
<!-- 		<td class="">제목</td> -->
<!-- 		<th><input type="text" name="admin_qna_title" value="" required></th> -->
<!-- 	</tr> -->

<!-- 	<tr> -->
<!-- 		<td width="100px">	<textarea name="admin_qna_content" rquired rows="15" cols="100" style="resize:none;"> -->
<!-- 		</textarea> -->
<!-- 	</td> -->

<!-- </tbody> -->

	

<!-- </table> -->
<!-- </form> -->
<!-- </div> -->

<%-- <jsp:include page="/WEB-INF/views/template/footer.jsp"/> --%>