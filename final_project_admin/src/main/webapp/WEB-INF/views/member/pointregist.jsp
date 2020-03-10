<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        <div class="row" style="padding: 50px;">
            <div class="offset-md-1 col-md-10">

	<div class="offset-md-4 col-md-4">

</div>
   
<div class="row justify-content-center" style="padding-top:100px;">
<h1>${member.member_id }님의 포인트를 등록합니다</h1>
</div>
<form action="pointregist" method="post">
  <fieldset>
    <div class="form-group">
      <label for="exampleSelect1">포인트 항목</label>
      <select class="form-control" name="member_point_status" id="exampleSelect1">
        <option>적립</option>
        <option>사용</option>
        <option>소멸</option>
      </select>
    </div>
    <div class="form-group row">
      <label for="staticEmail" class="col-sm-2 col-form-label">포인트</label>
      <div class="col-sm-10">
        <input type="number"  name="member_point_change" class="form-control-plaintext" id="staticEmail"  placeholder="0" value="0">
      </div>
    </div>
    <div class="form-group row">
      <label for="staticEmail1" class="col-sm-2 col-form-label">포인트 내용</label>
      <div class="col-sm-10">
        <input type="text" name="member_point_content"  class="form-control-plaintext" id="staticEmail1" placeholder="축하드립니다" value="축하드립니다">
      </div>
    </div>
    <div class="form-group row">
      <label for="staticEmail2" class="col-sm-2 col-form-label">포인트 마감</label>
      <div class="col-sm-10">
        <input type="date" value="xxx" min="yyy" max="zzz" name="member_point_limit" class="form-control-plaintext" id="staticEmail2" >
      </div>
    </div>
    <input type="hidden" name="member_no" value="${member.member_no }">
  </fieldset>
  <button type="submit" class="btn btn-primary btn-delete offset-md-1 col-md-10" >포인트 등록</button>
</form>
</div>
        </div>
    </div>
    </article></section>