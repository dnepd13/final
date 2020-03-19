<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
  </script>
  <script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
  <jsp:include page="/WEB-INF/views/template/header-seller.jsp"/>
  
  <section class="sellerInfo" style="padding-left: 200px; ;">
	<article class="arti">
	
<div class="row justify-content-center"  style="padding-left:0px;"><h1>Seller Information</h1></div>


<div class="offset-md-2 col-md-5">
	<table class="table table-hover">
  <thead>
    <tr>
      <th >${sellerDto.seller_id}님의 회원 정보입니다</th>
      
    </tr>
  </thead>
   <form action="info" method="post">
  <tbody>
    <tr class="table-light">
      <th scope="row">아이디</th>
      <td>${sellerDto.seller_id}</td>
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
<button type="submit" class="btn btn-secondary disabled btn-block">정보 수정하기</button>
   </form>
    			 <button type="button" class="btn btn-secondary disabled btn-block" onclick="location.href = 'main' ">홈으로기가기</button>
</div>
</article></section>

<!--    <div class="container-fluid"> -->
<!--         <div class="row"> -->
<!--             <div class="offset-md-4 col-md-4 "> -->
<!-- 				<div class = "card border-secondary mb-3"style = "width : 500px]"> -->
<!--   				<div class = "card-header"> -->
<!--   				   <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"size="4";>Seller Information </font></font> -->
<!--   				</div> -->
<!--   				<div class = "card-body" style="margin-right: 20px;"> -->
<!--   				  <form action="info" method="post"> -->
<!--                    <h4 class = "card-title"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> Seller Information </font> </font> </h4> -->
<%--     			   <p class = "card-text" style="border-bottom: 1px solid#DCDCDC"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 아이디 : ${sellerDto.seller_id} </font></font></p> --%>
<%--     			   <p class = "card-text"style="border-bottom: 1px solid#DCDCDC"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 이름 : ${sellerDto.seller_name} </font></font></p> --%>
<%--    				   <p class = "card-text"style="border-bottom: 1px solid#DCDCDC"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 이메일 : ${sellerDto.seller_email} </font></font></p> --%>
<%--     			   <p class = "card-text"style="border-bottom: 1px solid#DCDCDC"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 연락처 : ${sellerDto.seller_phone} </font></font></p> --%>
<%-- <%--     			   <p class = "card-text"style="border-bottom: 1px solid#DCDCDC"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 사업자번호 : ${sellerDto.seller_birth} </font></font></p> --%> --%>
<%--     			   <p class = "card-text"style="border-bottom: 1px solid#DCDCDC"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 사업장 우편번호 : ${sellerDto.seller_addr_post} </font></font></p> --%>
<%--                    <p class = "card-text"style="border-bottom: 1px solid#DCDCDC"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 사업장 기본주소 : ${sellerDto.seller_addr_basic} </font></font></p> --%>
<%--         		   <p class = "card-text"style="border-bottom: 1px solid#DCDCDC"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 사업장 상세주소 : ${sellerDto.seller_addr_extra} </font></font></p> --%>
<%--         		   <p class = "card-text"style="border-bottom: 1px solid#DCDCDC"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 사업장 이름 : ${sellerDto.seller_store_name} </font></font></p> --%>
<%--        			   <p class = "card-text"style="border-bottom: 1px solid#DCDCDC"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 사업장 전화번호 : ${sellerDto.seller_store_phone} </font></font></p> --%>
<%--          		   <p class = "card-text"style="border-bottom: 1px solid#DCDCDC"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 사업장 팩스번호 : ${sellerDto.seller_store_fax} </font></font></p> --%>
<%--           		   <p class = "card-text"style="border-bottom: 1px solid#DCDCDC"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 사업장 은행코드 : ${sellerDto.seller_bank_code} </font></font></p> --%>
<%--     			   <p class = "card-text"style="border-bottom: 1px solid#DCDCDC"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 사업장 은행 계좌번호 : ${sellerDto.seller_bank_account} </font></font></p> --%>
<%--     			   <p class = "card-text"style="border-bottom: 1px solid#DCDCDC"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 사업장 은행 예금주 : ${sellerDto.seller_bank_username} </font></font></p> --%>
<%-- <%--     			   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 사업장 은행 주민 등록번호 : ${sellerDto.seller_bank_birth} </font></font></p> --%> --%>
<%--     			   <p class = "card-text"style="border-bottom: 1px solid#DCDCDC"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 등급 : ${sellerDto.seller_grade} </font></font></p> --%>
<!--     			   <button type="submit" class="btn btn-secondary disabled btn-block">정보 수정하기</button> -->
<!--     			 </form> -->
<!--     			 <button type="button" class="btn btn-secondary disabled btn-block" onclick="location.href = 'main' ">홈으로기가기</button> -->
<!--   				</div> -->
<!--  			 </div> -->
<!--  		  </div> -->
<!--  		</div>  -->
<!--  	</div>	  -->

 	<jsp:include page="/WEB-INF/views/template/footer-seller.jsp"/>