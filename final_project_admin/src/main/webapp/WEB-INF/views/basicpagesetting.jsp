<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	.arti{
		overflow: hidden;
	}
</style>

<aside>
<div>
<jsp:include page="template/header.jsp"></jsp:include>
</div>
</aside>

<section class="admin" style="padding-left: 250px;">
	<article class="arti">
<div class="container-fluid">
        <div class="row" style="padding: 50px;">
            <div class="offset-md-1 col-md-10">
<div class="row justify-content-center"  style="padding: 20px;"><h1>사이트 기본정보 관리</h1></div>
<form action="" method="post">
  <fieldset>
    <div class="form-group row">
      <label for="staticEmail" class="col-sm-2 col-form-label">회사명</label>
      <div class="col-sm-10">
        <input type="text" name="co_name" class="form-control-plaintext" id="staticEmail" placeholder="${list.co_name }" value="${list.co_name }">
      </div>
    </div>
    <div class="form-group row">
      <label for="staticEmail1" class="col-sm-2 col-form-label">대표</label>
      <div class="col-sm-10">
        <input type="text" name="co_ceo" class="form-control-plaintext" id="staticEmail1" placeholder="${list.co_ceo }" value="${list.co_ceo }">
      </div>
    </div>
    <div class="form-group row">
      <label for="staticEmail2" class="col-sm-2 col-form-label">위치</label>
      <div class="col-sm-10">
        <input type="text" name="co_location" class="form-control-plaintext" id="staticEmail2" placeholder="${list.co_location }" value="${list.co_location }">
      </div>
    </div>
    <div class="form-group row">
      <label for="staticEmail3" class="col-sm-2 col-form-label">연락처</label>
      <div class="col-sm-10">
        <input type="text" name="co_call" class="form-control-plaintext" id="staticEmail3" placeholder="${list.co_call }" value="${list.co_call }">
      </div>
    </div>
    <div class="form-group row">
      <label for="staticEmail4" class="col-sm-2 col-form-label">이메일</label>
      <div class="col-sm-10">
        <input type="text" name="co_email" class="form-control-plaintext" id="staticEmail4" placeholder="${list.co_email }" value="${list.co_email }">
      </div>
    </div>
    <div class="form-group">
      <label for="exampleTextarea">이용약관</label>
      <textarea name="co_termsofuse" class="form-control" id="exampleTextarea" rows="5">${list.co_termsofuse }</textarea>
    </div>
     <div class="form-group">
      <label for="exampleTextarea">개인정보 처리방침</label>
      <textarea name="co_privacy" class="form-control" id="exampleTextarea" rows="5">${list.co_privacy }</textarea>
    </div>
    <div class="btn-group-vertical offset-md-0 col-md-12">
  		<button type="submit" class="btn btn-primary">등록</button>
	</div>
  </fieldset>
</form>


   </div>
        </div>
    </div>
    </article></section>