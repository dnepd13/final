<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
  </script>
  <script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css"> 
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
  <jsp:include page="/WEB-INF/views/template/header-seller.jsp"/>
  
  
  <section class="sellerInfo" style="padding-left: 100px;margin-right: 250px; ">
	<article class="arti" >
	<div class="container-fluid">
        <div class="row" style="padding: 50px;">
            <div class="offset-md-1 col-md-10">
<div class="row justify-content-center"  style="padding:20px;margin-right: 50px"><h1>판매자 정보 조회</h1></div>


<!-- <div class="offset-md-2 col-md-5"> -->
   <form action="info" method="post">
	<table class="table table-hover">
  <thead>
    <tr>
      <th width="35%">${sellerDto.seller_id}님의 회원 정보입니다</th>
      <th width="65%"></th>
    </tr>
  </thead>
  <tbody>
    <tr class="table-light">
      <th scope="row">아이디</th>
      <td style="text-align:left: ;">${sellerDto.seller_id}</td>
    </tr>
    <tr class="table-light">
      <th scope="row">이름</th>
      <td>${sellerDto.seller_name}</td>
    </tr>
    <tr class="table-light">
      <th scope="row">이메일</th>
      <td>${sellerDto.seller_email}</td>
    </tr>
    <tr class="table-light">
      <th scope="row">연락처</th>
      <td>${sellerDto.seller_phone}</td>
    </tr>
    <tr class="table-light">
      <th scope="row">사업장 우편번호</th>
      <td>${sellerDto.seller_addr_post}</td>
    </tr>
    <tr class="table-light">
      <th scope="row">사업장 기본주소</th>
      <td>${sellerDto.seller_addr_basic}</td>
    </tr>
    <tr class="table-light">
      <th scope="row">사업장 상세주소</th>
      <td>${sellerDto.seller_addr_extra}</td>
    </tr>
     <tr class="table-light">
      <th scope="row">사업장 이름</th>
      <td>${sellerDto.seller_store_name}</td>
    </tr>
     <tr class="table-light">
      <th scope="row">사업장 전화번호</th>
      <td>${sellerDto.seller_store_phone}</td>
    </tr>
     <tr class="table-light">
      <th scope="row">사업장 팩스번호</th>
      <td>${sellerDto.seller_store_fax}</td>
    </tr>
     <tr class="table-light">
      <th scope="row">사업장 은행코드</th>
      <td>${sellerDto.seller_bank_code}</td>
    </tr>
     <tr class="table-light">
      <th scope="row">사업장 은행 계좌번호</th>
      <td>${sellerDto.seller_bank_account}</td>
    </tr>
     <tr class="table-light">
      <th scope="row">사업장 은행 예금주</th>
      <td>${sellerDto.seller_bank_username}</td>
    </tr>
      <tr class="table-light">
      <th scope="row">등급</th>
      <td>${sellerDto.seller_grade}</td>
    </tr>
    
  </tbody>
</table>
<br><br>
<button type="submit" class="btn btn-secondary disabled btn-block">정보 수정하기</button>
   </form>
   <button type="button" class="btn btn-secondary disabled btn-block" onclick="location.href = 'main' ">홈으로 가기</button>
</div>
</div>
</div>
</article></section>

 	<jsp:include page="/WEB-INF/views/template/footer-seller.jsp"/>