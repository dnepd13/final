<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
  </script>
  <style>
  .aaa{
  	width: 600px;font-size: 1.2rem;
  }
  </style>
  <script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
  
<jsp:include page="/WEB-INF/views/template/header-seller.jsp"/>  
  
 <div class="container-fluid">
        <div class="row">
            <div class="offset-md-4 col-md-4 ">
				<div class = "card border-secondary mb-3"style = "width: 600px;font-size: 1.2rem;">
  				<div class = "card-header">
  				  <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"size="4";>Seller Information </font></font>
  				</div>
  				<div class = "card-body">
				 <form action="info_edit" method="post">
				  <%-- <h5 class = "card-title"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> ${sellerDto.seller_id}님의 정보입니다 </font> </font> </h5> --%>
    			   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 아이디 :${sellerDto.seller_id} </font></font></p>
    			   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 이름 :${sellerDto.seller_name} </font></font></p>
    			   <div class="form-group">
   				   	<p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 
   				   	   이메일 : <input style="width:15rem;" class="form-control form-control-sm" type="text" name="seller_email" value="${sellerDto.seller_email}"> </font></font></p>
    			   </div>
    			   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 
    			   	   연락처 : <input class="form-control form-control-sm" type="text" name="seller_phone" value="${sellerDto.seller_phone}"> </font></font></p>
    			   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 사업자번호 : ${sellerDto.seller_birth} </font></font></p>
    			   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 사업장 우편번호 : ${sellerDto.seller_addr_post} </font></font></p>
                   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 사업장 기본주소 : ${sellerDto.seller_addr_basic} </font></font></p>
        		   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 사업장 상세주소 : ${sellerDto.seller_addr_extra} </font></font></p>
        		   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 사업장 이름 : ${sellerDto.seller_store_name} </font></font></p>
        		   <div class="form-group">
       			    <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 
       			    	사업장 전화번호 : <input class="form-control form-control-sm" type="text" name="seller_store_phone" value="${sellerDto.seller_store_phone}"> </font></font></p>
         		   </div>
         		   <div class="form-group">
         		     <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 
         		     	사업장 팩스번호 : <input class="form-control form-control-sm" type="text" name="seller_store_fax" value="${sellerDto.seller_store_fax}"> </font></font></p>
          		   </div>
          		   <div class="form-group">
          		     <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 
          		     	사업장 은행명(코드) : <input class="form-control form-control-sm" type="text" name="seller_bank_code"value="${sellerDto.seller_bank_code}"> </font></font></p>
    			   </div>
    			   <div class="form-group">
    			     <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;">
    			     	 사업장 은행 계좌번호 : <input class="form-control form-control-sm" type="text" name="seller_bank_account" value="${sellerDto.seller_bank_account}"> </font></font></p>
    			   </div>
    			   <div class="form-group">
    			     <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 
    			     	사업장 은행 예금주 : <input class="form-control form-control-sm" type="text" name="seller_bank_username" value="${sellerDto.seller_bank_username}"> </font></font></p>
    			   </div>
    			   <div class="form-group">
    			     <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 
    			     	사업장 은행 주민 등록번호 : <input class="form-control form-control-sm" type="text" name="seller_bank_birth" value="${sellerDto.seller_bank_birth}"> </font></font></p>
    			   </div>    
    			   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 등급 :${sellerDto.seller_grade} </font></font></p>			  
    			   <button type="submit" class="btn btn-secondary disabled btn-block">수정하기</button>
    			 </form>
  				</div>
 			 </div>
 		  </div>
 		</div> 
 	</div>	 

 	
 	<jsp:include page="/WEB-INF/views/template/footer-seller.jsp"/>