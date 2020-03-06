<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">    

<aside>
<div>
<jsp:include page="../template/header.jsp"></jsp:include>
</div>
</aside>

<section class="admin" style="padding-left: 250px;">
	<article>

<div class="container-fluid">
        <div class="row" style="padding: 50px;">
            <div class="offset-md-1 col-md-10">
<div class="row justify-content-center"  style="padding: 20px;"><h1>주문제작 목록</h1></div>

<table class="table table-hover">
  <thead>
    <tr>
    	<th width="15%">유형</th>
    	<th width="25%">카테고리</th>
      <th width="20%">제목</th>
      <th width="10%">작성자</th>
      <th width="10%">작성일자</th>
      <th width="10%">진행상황</th>
      <th width="10%">상세보기</th>
    </tr>
  </thead>
  <tbody>
  	<c:forEach var="list" items="${list }">
    <tr>
      <th class="table-light">${list.custom_order_type }</th>
      <c:choose>
	      <c:when test="${list.category_large != null }">
	      <td>${list.category_large }-${list.category_middle }-${list.category_small }</td>
	      </c:when>
	      <c:otherwise>
	      	<td>없음</td>
	      </c:otherwise>
	  </c:choose>    
      <td>${list.custom_order_title }</td>
      <c:choose>
      		<c:when test="${list.seller_id != null } ">
      			<td>${list.seller_id }</td>
      		</c:when>
      		<c:otherwise>
      			<td>${list.member_id }</td>
      		</c:otherwise>
      </c:choose>
      <td>${list.custom_order_date }</td>
      <td>${list.custom_order_status }</td>
      <td><a href="${pageContext.request.contextPath}/custom/detail?custom_order_no=${list.custom_order_no}"><button type="button" class="btn btn-primary">상세보기</button></a></td>
    </tr>
  	</c:forEach>
  </tbody>
</table>

<div class="row justify-content-center">
	<ul class="pagination">
		<c:if test="${paging.startBlock > 1 }">
			<c:choose>
				<c:when test="${param.key != null }">
					<li class="page-item">
		     			 <a class="page-link" href="${pageContext.request.contextPath}/custom/list?pno1=${paging.startBlock-1}&key=${param.key}&search=${param.search}">&laquo;</a>
		   			 </li>
				</c:when>
				<c:otherwise>
					<li class="page-item">
		     			 <a class="page-link" href="${pageContext.request.contextPath}/custom/list?pno1=${paging.startBlock-1}">&laquo;</a>
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
								<a class="page-link" href="${pageContext.request.contextPath}/custom/list?pno1=${p}&key=${param.key}&search=${param.search}">${p }</a>
	    					</li>
						</c:when>
						<c:otherwise>
							<li class="page-item">
								<a class="page-link" href="${pageContext.request.contextPath}/custom/list?pno1=${p}">${p }</a>
				    		</li>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<c:if test="${paging.finishBlock < paging.pagecount}">
			<c:when test="${param.key!=null }">
				<li class="page-item">
					<a class="page-link" href="${pageContext.request.contextPath}/custom/list?pno1=${paging.finishBlock+1}&key=${param.key}&search=${param.search}">&raquo;</a>
				</li>
			</c:when>
			<c:otherwise>
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/custom/list?pno1=${paging.finishBlock+1}">&raquo;</a>
    		</li>
			</c:otherwise>
		</c:if>
		
	</ul>
</div>

<form action="" method="get">
  <fieldset>
    <div class="form-group">
      <label for="exampleSelect1">검색 조건</label>
      <select class="form-control" name="key" id="exampleSelect1">
        <option value="custom_order_type">유형</option>
        <option value="id">아이디</option>
        <option value="custom_order_status">진행상황</option>
      </select>
    </div>
    <div class="form-group row">
      <label for="staticEmail" class="col-sm-2 col-form-label">검색</label>
      <div class="col-sm-10">
        <input type="text"  name="search" class="form-control-plaintext" id="staticEmail" placeholder="검색어를 입력하세요">
      </div>
    </div>
  </fieldset>
  <button type="submit" class="btn btn-primary btn-delete offset-md-0 col-md-12" >검색</button>
</form>

		</div>
	</div>
</div>
</article></section>


