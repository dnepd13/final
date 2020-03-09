<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

<div class="row justify-content-center"  style="padding: 20px;"><h1>내정보</h1></div>
<div align="right">
	<a href="${pageContext.request.contextPath}/admin/changepw?admin_no=${my.admin_no}">
		<button type="button" class="btn btn-primary btn-modify" >비밀번호 변경</button>
	</a>
</div>
<table class="table table-hover">
  <thead>
    <tr>
      <th width="30%">항목</th>
      <th width="70%">내용</th>
    </tr>
  </thead>
  <tbody>
    <tr class="table-light"">
      <th scope="row">사원번호</th>
      <td>${my.admin_no}</td>
    </tr>
    <tr class="table-light"">
      <th scope="row">사원이름</th>
      <td>${my.admin_name}</td>
    </tr>
    <tr class="table-light"">
      <th scope="row">사원이메일</th>
      <td>${my.admin_email}</td>
    </tr>
    <tr class="table-light"">
      <th scope="row">사원등급</th>
      <td>${my.admin_grade } </td>
    </tr>
    <tr class="table-light"">
      <th scope="row">사원가입일</th>
      <td>${my.admin_join_date}</td>
    </tr>
  </tbody>
</table>
	

</div>
</div>
</div>
</article></section>