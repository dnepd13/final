<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h1>상품 상세 페이지</h1>

<p>상품 상세 내용(goods_content)</p>
<p>${goodsVO.goods_content}</p>
<hr>
<br>

<p>상품 옵션 (goodsOptionList)</p>
<p>${goodsVO.goodsOptionList}</p>

<p>1:1 요청서 <a href="${pageContext.request.contextPath}/member/customOrder?seller_no=91">seller_no 받아오기</a></p>
<hr>

<p>상품 문의</p>
<hr>

<p>리뷰</p>
<hr>