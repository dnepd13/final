<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
  </script>
  <script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
  <jsp:include page="/WEB-INF/views/template/header-seller.jsp"/>
  
   <!--  <div class = "jumbotron">
  <h1 class = "display-3"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 판매자 정보 조회 페이지 </ font> </ font> </ h1>
  <p class = "lead"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 주요 선택 나 정보에 특별한주의를 선택해야합니다. 힘든 영웅 장치입니다. </ font> </ font> </ p>
  <hr class = "my-4">
  <p> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 타이포그래피 및 간격 및 옵션 > </ font> </ p>
  <p class = "lead">
    <a class="btn btn-primary btn-lg" href="#" role="button"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 더 많이 기 </ font> </ font> </a>
  </ p>
</ div> -->
   <div class="container-fluid">
        <div class="row">
            <div class="offset-md-4 col-md-4 ">
				<div class = "card border-secondary mb-3"style = "max-width : 500rem;">
  				<div class = "card-header">
  				   <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"size="4";>Seller Information </font></font>
  				</div>
  				<div class = "card-body">
  				  <form action="info" method="post">
               <!--     <h4 class = "card-title"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> Seller Information </font> </font> </h4> -->
    			   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 아이디 : ${sellerDto.seller_id} </font></font></p>
    			   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 이름 : ${sellerDto.seller_name} </font></font></p>
   				   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 이메일 : ${sellerDto.seller_email} </font></font></p>
    			   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 연락처 : ${sellerDto.seller_phone} </font></font></p>
    			   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 사업자번호 : ${sellerDto.seller_birth} </font></font></p>
    			   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 사업장 우편번호 : ${sellerDto.seller_addr_post} </font></font></p>
                   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 사업장 기본주소 : ${sellerDto.seller_addr_basic} </font></font></p>
        		   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 사업장 상세주소 : ${sellerDto.seller_addr_extra} </font></font></p>
        		   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 사업장 이름 : ${sellerDto.seller_store_name} </font></font></p>
       			   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 사업장 전화번호 : ${sellerDto.seller_store_phone} </font></font></p>
         		   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 사업장 팩스번호 : ${sellerDto.seller_store_fax} </font></font></p>
          		   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 사업장 은행명(코드) : ${sellerDto.seller_bank_code} </font></font></p>
    			   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 사업장 은행 계좌번호 : ${sellerDto.seller_bank_account} </font></font></p>
    			   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 사업장 은행 예금주 : ${sellerDto.seller_bank_username} </font></font></p>
    			   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 사업장 은행 주민 등록번호 : ${sellerDto.seller_bank_birth} </font></font></p>
    			   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 등급 : ${sellerDto.seller_grade} </font></font></p>
    			   <button type="submit" class="btn btn-secondary disabled btn-block">정보 수정하기</button>
    			 </form>
    			 <button type="button" class="btn btn-secondary disabled btn-block" onclick="location.href = 'management' ">아이디찾기</button>
  				</div>
 			 </div>
 		  </div>
 		</div> 
 	</div>	 

 	<jsp:include page="/WEB-INF/views/template/footer-seller.jsp"/>