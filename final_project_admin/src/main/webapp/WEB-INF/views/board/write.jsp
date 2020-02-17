<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
글작성
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
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
        <input type="text" name="admin_qna_writer" class="form-control-plaintext" id="staticEmail" placeholder="${admin_id }" value="${admin_id }">
      </div>
    </div>
    <div class="form-group">
      <label for="exampleTextarea">Example textarea</label>
      <textarea name="admin_qna_content" class="form-control" id="exampleTextarea" rows="5"></textarea>
    </div>
    <input type="hidden" name="admin_qna_no1" value="${admin_qna_no }">
    <div class="btn-group-vertical">
  		<button type="submit" class="btn btn-primary">등록</button>
	</div>
  </fieldset>
</form>