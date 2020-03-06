<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">

<aside>
<div>
<jsp:include page="../template/header.jsp"></jsp:include>
</div>
</aside>

<section class="admin" style="padding-left: 250px;">
	<article>

<div class="container-fluid">
        <div class="row" style="padding: 50px;">
            <div class="offset-md-1 col-md-10">
<div class="row justify-content-center"  style="padding: 20px;"><h1>관리문의 글 수정</h1></div>


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
        <input type="text" name="admin_qna_title" class="form-control-plaintext" id="staticEmail" placeholder="${one.admin_qna_title }" value="${one.admin_qna_title }">
      </div>
    </div>
    <div class="form-group row">
      <label for="staticEmail" class="col-sm-2 col-form-label">작성자</label>
      <div class="col-sm-10">
        <input type="text" name="admin_qna_writer" class="form-control-plaintext" id="staticEmail" placeholder="${one.admin_qna_writer }" value="${one.admin_qna_writer }">
      </div>
    </div>
    <div class="form-group">
      <label for="exampleTextarea">Example textarea</label>
      <textarea name="admin_qna_content" class="form-control" id="exampleTextarea" rows="5">${one.admin_qna_content }</textarea>
    </div>
    <input type="hidden" name="admin_qna_no1" value="${one.admin_qna_no }">
	   
    <div class="btn-group-vertical offset-md-0 col-md-12">
  		<button type="submit" class="btn btn-primary">등록</button>
	</div>
  </fieldset>
</form>

</div>
        </div>
    </div>
    </article></section>