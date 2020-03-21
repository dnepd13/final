<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
  </script>
  <script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<jsp:include page="/WEB-INF/views/template/header-seller.jsp"/>  
  
  
  
  <section class="sellerInfo" style="padding-left: 100px;margin-right: 250px; ">
	<article class="arti" >
	<div class="container-fluid">
        <div class="row" style="padding: 50px;">
            <div class="offset-md-1 col-md-10">
			 <div class="row justify-content-center"  style="padding:20px;margin-right: 50px"><h1>판매자 정보 수정하기</h1></div>
    			<form action="info_edit" method="post">
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
    					<tr class="table-light" >
      					 <th scope="row">이메일</th>
     					 <td><input class="form-control form-control-sm" type="text" name="seller_email" value="${sellerDto.seller_email}" style="width: 230px;" ></td>
   					    </tr>
    <tr class="table-light">
      <th scope="row">연락처</th>
      <td><input class="form-control form-control-sm" type="text" name="seller_phone" value="${sellerDto.seller_phone}"style="width: 230px;"></td>
    </tr>
    <tr class="table-light">
      <th scope="row">사업장 우편번호</th>
      <td style="text-align: left;">${sellerDto.seller_addr_post}</td>
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
      <td><input class="form-control form-control-sm" type="text" name="seller_store_phone" value="${sellerDto.seller_store_phone}"style="width: 230px;"></td>
    </tr>
     <tr class="table-light">
      <th scope="row">사업장 팩스번호</th>
      <td><input class="form-control form-control-sm" type="text" name="seller_store_fax" value="${sellerDto.seller_store_fax}" style="width: 230px;"></td>
    </tr>
     <tr class="table-light">
      <th scope="row">사업장 은행코드</th>
      <td><input class="form-control form-control-sm" type="text" name="seller_bank_code"value="${sellerDto.seller_bank_code}" style="width: 230px;"></td>
    </tr>
     <tr class="table-light">
      <th scope="row">사업장 은행 계좌번호</th>
      <td><input class="form-control form-control-sm" type="text" name="seller_bank_account" value="${sellerDto.seller_bank_account}" style="width: 230px;"></td>
    </tr>
     <tr class="table-light">
      <th scope="row">사업장 은행 예금주</th>
      <td><input class="form-control form-control-sm" type="text" name="seller_bank_username" value="${sellerDto.seller_bank_username}" style="width: 230px;"></td>
    </tr>
 <div><input class="form-control form-control-sm" type="hidden" name="seller_bank_birth"  value="0000"></div>

      <tr class="table-light">
      <th scope="row">등급</th>
      <td>${sellerDto.seller_grade}</td>
    </tr>
    
  </tbody>
</table>
<br><br>
<button type="submit" class="btn btn-secondary disabled btn-block">수정하기</button>
  </form>
</div>
</div>
</div>
</article></section>
 	
 	<jsp:include page="/WEB-INF/views/template/footer-seller.jsp"/>