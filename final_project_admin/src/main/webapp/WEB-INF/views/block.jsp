<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css"> 
<div style="padding-top: 50px;">
<jsp:include page="template/header.jsp"></jsp:include>
</div>
<div class="container-fluid">
        <div class="row" style="padding: 50px;">
            <div class="offset-md-1 col-md-10">
<div class="row justify-content-center"  style="padding: 20px;"><h1>회원 차단</h1></div>

<c:choose>
	<c:when test="${param.member_no != null }">
		<form action="block" method="post">
		    <div class="form-group row">
		      <label for="staticEmail1" class="col-sm-2 col-form-label">회원</label>
		      <div class="col-sm-10">
		        <input type="text" readonly="" name="block_group"  class="form-control-plaintext" id="staticEmail1" value="구매자">
		      </div>
		    </div>
		    <div class="form-group row">
		      <label for="staticEmail2" class="col-sm-2 col-form-label">아이디</label>
		      <div class="col-sm-10">
		        <input type="text" readonly="" name="block_id" class="form-control-plaintext" id="staticEmail2" value="${id }">
		      </div>
		    </div>
		    <div class="form-group">
		      <label for="exampleTextarea">차단 사유</label>
		      <textarea class="form-control" name="block_content" id="exampleTextarea" rows="3"></textarea>
		    </div>
		    <input type="hidden" name="member_no" value="${no }">
		    <input type="submit" value="차단하기">
		</form>
	</c:when>
	<c:when test="${param.seller_no != null }">
			<form action="block" method="post">
			    <div class="form-group row">
			      <label for="staticEmail" class="col-sm-2 col-form-label">회원</label>
			      <div class="col-sm-10">
			        <input type="text" name="block_group" readonly="" class="form-control-plaintext" id="staticEmail" value="판매자">
			      </div>
			    </div>
			    <div class="form-group row">
			      <label for="staticEmail2" class="col-sm-2 col-form-label">아이디</label>
			      <div class="col-sm-10">
			        <input type="text" name="block_id" readonly="" class="form-control-plaintext" id="staticEmail2" value="${id }">
			      </div>
			    </div>
			    <div class="form-group">
			      <label for="exampleTextarea">차단 사유</label>
			      <textarea class="form-control" name="block_content" id="exampleTextarea" rows="3"></textarea>
			    </div>
			    <input type="hidden" name="seller_no" value="${no}">
			     <input type="submit" class="offset-md-0 col-md-12" value="차단하기">
			</form>
	</c:when>
</c:choose>

 </div>
        </div>
    </div>