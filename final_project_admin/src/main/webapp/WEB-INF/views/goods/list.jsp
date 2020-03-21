<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">

<style>
	.arti{
		overflow: scroll;
	}
</style>

<aside>
<div>
<jsp:include page="../template/header.jsp"></jsp:include>
</div>
</aside>

<section class="admin" style="padding-left: 250px;">
	<article class="arti">

<div class="container-fluid">
        <div class="row" style="padding: 50px;">
            <div class="offset-md-1 col-md-10">
<div class="row justify-content-center"  style="padding: 20px;"><h1>상품 관리</h1></div>

	
<table class="table table-hover" style="table-layout:fixed">
  <thead>
    <tr>
      <th width="7%"  height="90px" style="overflow:hidden">판매자 아이디</th>
      <th width="7%" height="90px" style="overflow:hidden">판매자 이름</th>
      <th width="16%" height="90px" style="overflow:hidden">카테고리</th>
      <th width="15%" height="90px" style="overflow:hidden;">상품이름</th>
      <th width="10%" height="90px" style="overflow:hidden">가격</th>
      <th width="5%" height="90px" style="overflow:hidden">제고</th>
      <th width="12%" height="90px" style="overflow:hidden">판매상태</th>
      <th width="18%" height="90px" style="overflow:hidden;">내용</th>
      <th width="10%" height="90px" style="overflow:hidden">상세보기</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="list" items="${list }">
    <tr class="table-light">
      <th scope="row" width="7%"  height="90px" style="text-overflow:ellipsis; overflow:hidden"><nobr>${list.seller_id}<nobr></th>
      <td width="7%" height="90px" style="text-overflow:ellipsis; overflow:hidden"><nobr>${list.seller_name}<nobr></td>
      <td width="16%" height="90px" style="text-overflow:ellipsis; overflow:hidden"><nobr>${list.category_large}-${list.category_middle}-${list.category_small}<nobr></td>
      <td width="15%" height="90px" style="text-overflow:ellipsis; overflow:hidden"><nobr>${list.goods_name}<nobr></td>
      <td width="10%" height="90px" style="text-overflow:ellipsis; overflow:hidden"><nobr>${list.goods_price}<nobr></td>
      <td width="5%" height="90px" style="text-overflow:ellipsis; overflow:hidden"><nobr>${list.goods_stock}<nobr></td>
      <td width="12%" height="90px" style="text-overflow:ellipsis; overflow:hidden"><nobr>${list.goods_status}<nobr></td>
      <td width="18%" height="90px" style="text-overflow:ellipsis; overflow:hidden"><nobr>${list.goods_content}<nobr></td>
      <td width="10%" height="90px" style="text-overflow:ellipsis; overflow:hidden">
			<div class="btn-group-vertical">
				<a href="${pageContext.request.contextPath}/goods/getone?goods_no=${list.goods_no }&seller_id=${list.seller_id } "><button type="button" class="btn btn-primary">상세보기</button></a>
			</div>
      </td>
    </tr>
	</c:forEach>
  </tbody>
</table>
<div class="row justify-content-center">
<div>
	<ul class="pagination">
		<c:if test="${paging.startBlock > 1 }">
			<c:choose>
				<c:when test="${param.key != null }">
					<li class="page-item">
		     			 <a class="page-link" href="${pageContext.request.contextPath}/goods/list?pno1=${paging.startBlock-1}&key=${param.key}&search=${param.search}">&laquo;</a>
		   			 </li>
				</c:when>
				<c:otherwise>
					<li class="page-item">
		     			 <a class="page-link" href="${pageContext.request.contextPath}/goods/list?pno1=${paging.startBlock-1}">&laquo;</a>
		   			 </li>
				</c:otherwise>
			</c:choose>
		</c:if>
		
		<c:forEach begin="${paging.startBlock }" end="${paging.finishBlock }" var="p">
			<c:choose>
				<c:when test="${p == paging.pno }">
					<li class="page-item active">
   					   <a class="page-link" >${p }</a>
   					 </li>
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${param.key!=null }">
							<li class="page-item">
								<a class="page-link" href="${pageContext.request.contextPath}/goods/list?pno1=${p}&key=${param.key}&search=${param.search}">${p }</a>
	    					</li>
						</c:when>
						<c:otherwise>
							<li class="page-item">
								<a class="page-link" href="${pageContext.request.contextPath}/goods/list?pno1=${p}">${p }</a>
				    		</li>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<c:if test="${paging.finishBlock < paging.pagecount}">
			<c:when test="${param.key!=null }">
				<li class="page-item">
					<a class="page-link" href="${pageContext.request.contextPath}/goods/list?pno1=${paging.finishBlock+1}&key=${param.key}&search=${param.search}">&raquo;</a>
				</li>
			</c:when>
			<c:otherwise>
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/goods/list?pno1=${paging.finishBlock+1}">&raquo;</a>
    		</li>
			</c:otherwise>
		</c:if>
		
	</ul>
</div>
</div>

<form action="list" method="get">
  <fieldset>
    <div class="form-group">
      <label for="exampleSelect1">검색 조건</label>
      <select class="form-control" name="key" id="exampleSelect1">
        <option value="seller_id">판매자</option>
        <option value="goods_name">상품이름</option>
      </select>
    </div>
    <div class="form-group row">
      <label for="staticEmail" class="col-sm-2 col-form-label">검색</label>
      <div class="col-sm-10">
        <input type="text"  name="search" class="form-control-plaintext" id="staticEmail" placeholder="검색어를 입력하세요">
      </div>
    </div>
  </fieldset>
  <button type="submit" class="btn btn-primary btn-delete offset-md-4 col-md-4" >검색</button>
</form>



   </div>
        </div>
    </div>
    
    </article></section>