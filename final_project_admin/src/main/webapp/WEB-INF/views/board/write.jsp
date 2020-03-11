<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">

<style>
	.arti{
		overflow: hidden;
	}
</style>

<aside>
<div>
<jsp:include page="../template/header.jsp"></jsp:include>
</div>
</aside>

<section class="admin" style="padding-left: 250px;">
	<article class="arti">
<div class="container-fluid">
        <div class="row" style="padding: 50px;"><br>
            <div class="offset-md-3 col-md-6">

	<div class="row justify-content-center"><h1>관리문의글작성</h1></div>

<form action="" method="post">
  <fieldset>
    <div class="form-group">
      <label for="exampleSelect1">말머리</label>
      <select class="form-control" name="admin_qna_head" id="exampleSelect1">
      	<option>공지</option>
        <option>답변</option>
      </select>
    </div>
    <div class="form-group row">
      <label for="staticEmail" class="col-sm-2 col-form-label">글제목</label>
      <div class="col-sm-10">
        <input type="text" name="admin_qna_title" class="form-control-plaintext" id="staticEmail" placeholder="글 제목을 입력하세요" required="required">
      </div>
    </div>
    <div class="form-group row">
      <label for="staticEmail" class="col-sm-2 col-form-label">작성자</label>
      <div class="col-sm-10">
        <input type="text" name="admin_qna_writer" class="form-control-plaintext" id="staticEmail" placeholder="${admin_id }" value="${admin_id }" required="required">
      </div>
    </div>
    <div class="form-group">
      <label for="exampleTextarea">Example textarea</label>
      <textarea name="admin_qna_content" class="form-control" id="exampleTextarea" rows="5" required="required"></textarea>
    </div>
    <c:if test="${param.member_no != null or param.seller_no != null }">
    <input type="hidden" name="admin_qna_no1" value="${param.admin_qna_no }">
    <input type="hidden" name="member_no" value="${param.member_no }">
    <input type="hidden" name="seller_no" value="${param.seller_no }">
    </c:if>
    <div class="btn-group-vertical offset-md-4 col-md-4">
  		<button type="submit" class="btn btn-primary">등록</button>
	</div>
  </fieldset>
</form>

   </div>
        </div>
    </div>
    </article></section>