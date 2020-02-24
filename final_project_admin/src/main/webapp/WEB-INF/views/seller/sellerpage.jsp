<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css"> 
<div style="padding-top: 50px;">
<jsp:include page="../template/header.jsp"></jsp:include>
</div>
<%-- <c:if test="${admin_grade == '총괄관리자' }"> --%>
<!-- <div class="btn-group-vertical"> -->
<%-- 	<a href="${pageContext.request.contextPath}/seller/delete?seller_no=${seller.seller_no }"><button type="button" class="btn btn-primary">삭제</button></a> --%>
<!-- </div> -->
<%-- </c:if> --%>

<div class="container-fluid">
        <div class="row" style="padding: 50px;">
            <div class="offset-md-1 col-md-10">
<div class="row justify-content-center"  style="padding: 20px;"><h1>판매자 관리 상세</h1></div>
<div class="row justify-content-center"><h1>판매자 ${seller.seller_id } 님의 상세보기 창 입니다</h1></div>
<table class="table table-hover">
  <thead>
    <tr>
      <th width="30%">항목</th>
      <th width="70%">내용</th>
      </th>
    </tr>
  </thead>
  <tbody>
    <tr class="table-light"">
      <th scope="row">이름</th>
      <td>${seller.seller_name}</td>
    </tr>
    <tr class="table-light"">
      <th scope="row">이메일</th>
      <td>${seller.seller_email}</td>
    </tr>
    <tr class="table-light"">
      <th scope="row">연락처</th>
      <td>${seller.seller_phone}</td>
    </tr>
    <tr class="table-light"">
      <th scope="row">주소</th>
      <td>${seller.seller_addr_post}  ${seller.seller_addr_basic }  ${seller.seller_addr_extra }</td>
    </tr>
    <tr class="table-light"">
      <th scope="row">상호명</th>
      <td>${seller.seller_store_name}</td>
    </tr>
    <tr class="table-light"">
      <th scope="row">상호 연락처</th>
      <td>${seller.seller_store_phone}</td>
    </tr>
    <tr class="table-light"">
      <th scope="row">상호 팩스</th>
      <td>${seller.seller_store_fax}</td>
    </tr>
    <tr class="table-light"">
      <th scope="row">가입날짜</th>
      <td>${seller.seller_join_date}</td>
    </tr>
    <tr class="table-light"">
      <th scope="row">마지막 로그인</th>
      <td>${seller.seller_last_login}</td>
    </tr>
    <tr class="table-light"">
      <th scope="row">동의 시간</th>
      <td>${seller.seller_agree_date}</td>
    </tr>
    <tr class="table-light"">
      <th scope="row">은행 번호</th>
      <td>${seller.seller_bank_code}</td>
    </tr>
    <tr class="table-light"">
      <th scope="row">계좌</th>
      <td>${seller.seller_bank_account}</td>
    </tr>
    <tr class="table-light"">
      <th scope="row">은행주 이름 </th>
      <td>${seller.seller_bank_username}</td>
    </tr>
    <tr class="table-light"">
      <th scope="row">등급</th>
      <td>${seller.seller_grade}</td>
    </tr>
  </tbody>
</table>


   </div>
        </div>
    </div>

