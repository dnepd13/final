<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
<h1>qna게시판 수정</h1>
<h1><a href="${pageContext.request.contextPath}/home">홈으로</a></h1>
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
    <div class="btn-group-vertical">
  		<button type="submit" class="btn btn-primary">등록</button>
	</div>
  </fieldset>
</form>