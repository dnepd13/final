<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<jsp:include page="/WEB-INF/views/template/header-seller.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 
<style>
	.articleBox {
		width: 1200px;
		height: 800px;
		margin: 0 auto;
	}
	.BigStore {
		border-collapse: collapse;
		float: left;
		margin-left: 60px;
		padding-top: 100px;
		width: 960px;
	}
	.Store_main{
		margin: 0 auto;
		width: 90%;
		height: 50px;
		border-bottom: 2px solid #F3F5F8;

	}
	.Store_main_box {
		width: 200px;
		height: auto;
		padding-top: 10px;
		margin-left: 30px;
		float: left;
		font-size: large;
	}
	.Store {
		margin:30px auto;
		width: 90%;
	}
</style>

<h1 style="text-align:center;">판매자 마이페이지</h1>
<article class="articleBox">
<jsp:include page="/WEB-INF/views/template/memberInfoAside.jsp"/>
<div class="BigStore">
	<div class="Store_main">
		<div class="Store_main_box">
			${sellerDto.seller_id}님의 사업장 정보
		</div>
	</div>	
	<div class="Store">
	<table class="table" border="1">
		<tr>
			<th>사업장 이름</th>
			<td>${sellerDto.seller_store_name}</td>
		</tr>
		<tr>
			<th>사업장 전화번호</th>
			<td>${sellerDto.seller_store_phone}</td>
		</tr>
		<tr>
			<th>사업장주소</th>
			<td><h6>우편번호 : ${sellerDto.seller_addr_post}</h6><hr>
					<h6>${sellerDto.seller_addr_basic}</h6>
					<h6>${sellerDto.seller_addr_extra}</h6>
			</td>
		</tr>
		<tr>
			<th rowspan="3">은행 정보</th>
			<td>은행 코드 : ${sellerDto.seller_bank_code}</td>
		</tr>
		<tr>
			<td>계좌번호 : ${sellerDto.seller_bank_account}</td>
		</tr>
		<tr>
			<td>예금주 : ${sellerDto.seller_bank_username}</td>
		</tr>
		<tr>
			<th>등급</th>
			<td>${sellerDto.seller_grade}</td>
		</tr>
	</table>


	</div>
</div>
</article>

<jsp:include page="/WEB-INF/views/template/footer-seller.jsp"/>

