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
	
<div class="row justify-content-center"  style="padding: 20px;"><h1>회원 상세</h1></div>

<c:if test="${admin_grade == '총괄관리자' }">
<div class="btn-group-vertical">
<%-- 	<a href="${pageContext.request.contextPath}/member/delete?member_no=${one.member_no }"><button type="button" class="btn btn-primary">삭제</button></a> --%>
</div>
</c:if>

<div class="offset-md-3 col-md-6">

<div class="row justify-content-center" style="padding: 50px;"><h1>${one.member_id }님의 상세보기 창입니다</h1></div>
<div class="offset-md-10 col-md-12">
<div class="btn-group-vertical">
	<a href="${pageContext.request.contextPath}/member/point?member_no=${one.member_no }&member_id=${one.member_id}"><button type="button" class="btn btn-primary  ">포인트조회</button></a>
</div>
</div>

	<table class="table table-hover">
  <thead>
    <tr>
      <th width="30%">항목</th>
      <th width="70%">내용</th>
    </tr>
  </thead>
  <tbody>
    <tr class="table-light">
      <th scope="row">이름</th>
      <td>${one.member_name}</td>
    </tr>
    <tr class="table-light">
      <th scope="row">이메일</th>
      <td>${one.member_email}</td>
    </tr>
    <tr class="table-light">
      <th scope="row">연락처</th>
      <td>${one.member_phone}</td>
    </tr>
    <tr class="table-light">
      <th scope="row">가입일</th>
      <td>${one.member_join_date}</td>
    </tr>
    <tr class="table-light">
      <th scope="row">최종로그인</th>
      <td>${one.member_last_login}</td>
    </tr>
    <tr class="table-light">
      <th scope="row">동의날짜</th>
      <td>${one.member_agree_date}</td>
    </tr>
    <tr class="table-light">
      <th scope="row">등급</th>
      <td>${one.member_grade}</td>
    </tr>
  </tbody>
</table>

</div>
</article></section>