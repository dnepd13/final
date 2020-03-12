<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

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
}
</style>

<section class="section1">
<div class="ordering_area row justify-content-center">
	<div class="col-lg-8 cart_area">
		<div class="cart_title">
<h3>신고 작성하기</h3>
</div>
<div>
	<h4>허위 신고로 적발될 경우 불이익을 받을 수 있습니다.</h4>
</div>

<form action="reportregist" method="post">
	<div class="btn-group-vertical" style="float:right;">
	<a><button class="btn btn-primary">등록</button></a>
	</div>
</div>
</section>
<section class="section2">
<div class="insert_req form-group">
	<form action="reportregist" method="post">

			<input type="text" name="admin_qna_title" value="" required class="form-control" placeholder="제목">
			<div class="row-empty-20"></div>
		<textarea name="admin_qna_content" required rows="15" cols="100" style="resize:none;" class="form-control" placeholder="내용"></textarea>
			<div class="row-empty-20"></div>
		<p align="right">
			<button class="btn btn-primary regist" value="등록 ">등록</button>&nbsp;&nbsp;
			<a href="${pageContext.request.contextPath}/board/memberreport"><button class="btn btn-primary regist" type="button">목록으로</button></a>
		</p>
	</form>
	<p align="right"></p>
</div>
</section>

	<tr>
		<th><input type="text" name="admin_qna_title" placeholder="제목을 입력하세요 ex)판매자 xxx를 신고합니다" required style="width:900px;"></th>
	</tr>
	<tr>
		<td >	
		<textarea name="admin_qna_content" rows="15" cols="125.5" style="resize:none;">내용을 입력하세요</textarea>
		</td>
	</tr>
</table>
</form>
</div>
</div>
</section>
<div class="row-empty-40"></div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"/>
