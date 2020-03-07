<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<style>
	.redirect-box {
		border: 1px solid #A6A6A6;
		width: 400px;
		height: 200px;
		margin-top: 10%;
		margin-left: 35%;
	}
	.redirect-content {
		padding: 50px;
	}
</style>

<div class="redirect-box row justify-content-center">

<div class="redirect-content">
	<h4 align="center">결제에 성공하였습니다.</h4><br>
	<div class="row-empty-40"><br>
	<a href="${pageContext.request.contextPath }"><button>계속 쇼핑하기</button></a>
	 &verbar; 
	<a href="${pageContext.request.contextPath }/member/cartDetailPay?partner_order_id=${patner_order_id }"><button>결제내역 확인</button></a>
	</div>
</div>

</div>






<jsp:include page="/WEB-INF/views/template/footer.jsp"/>    
>