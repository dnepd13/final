<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<div style="padding-top: 50px;">
<jsp:include page="../template/header.jsp"></jsp:include>
</div>
<div class="container-fluid">
        <div class="row">
            <div class="offset-md-1 col-md-10">


<div class="row justify-content-center"  style="padding: 20px;"><h1>정산 목록</h1></div>

<form action="" method="get">
	<input type="text" name="seller_id" placeholder="아이디를 입력하세요">
	<input type="number" name="year" placeholder="2020년" value="2020">
	<select name="month">
		<option value="1">월</option>
		<option>1</option>
		<option>2</option>
		<option>3</option>
		<option>4</option>
		<option>5</option>
		<option>6</option>
		<option>7</option>
		<option>8</option>
		<option>9</option>
		<option>10</option>
		<option>11</option>
		<option>12</option>
	</select>
	
	
	
	<input type="submit" value="검색">
</form>

<table class="table table-hover">
  <thead>
    <tr>
      <th width="15%">판매자</th>
      <th width="15%">총 판매액</th>
      <th width="15%">수수료(%)</th>
      <th width="15%">수수료(원)</th>
      <th width="15%">정산 금액</th>
      <th width="15%">상세보기</th> 
      <th width="10%">정산</th> 
    </tr>
  </thead>
  <tbody>
    <c:forEach var="list" items="${list }">
    <tr class="table-light">
      <th scope="row" >${list.seller_id }</th>
      <td >${list.total_cal_price }</td>
      <td>${list.rate }</td>
      <td>${list.fee }</td>
      <td>${list.adjustment_price }</td>
      <td>
   			<a href="${pageContext.request.contextPath}/calculate/detail?seller_id=${list.seller_id}&year=${param.year}&month=${param.month}"><button type="button" class="btn btn-primary btn-delete" >상세보기</button></a>
      </td>
      <td>
   			<a href="#"><button type="button" class="btn btn-primary btn-delete" >정산</button></a>
      </td>
    </tr>
	</c:forEach>
  </tbody>
</table>

<div class="row justify-content-center">
	<ul class="pagination">
		<c:if test="${paging.startBlock > 1 }">
			<c:choose>
				<c:when test="${param.seller_id != null }">
					<li class="page-item">
		     			 <a class="page-link" href="${pageContext.request.contextPath}/calculate/total?pno1=${paging.startBlock-1}&seller_id=${param.seller_id}&year=${param.year}&month=${param.month}">&laquo;</a>
		   			 </li>
				</c:when>
				<c:otherwise>
					<li class="page-item">
		     			 <a class="page-link" href="${pageContext.request.contextPath}/calculate/total?pno1=${paging.startBlock-1}&year=${param.year}&month=${param.month}">&laquo;</a>
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
					<c:when test="${param.seller_id != null }">
						<li class="page-item">
							<a class="page-link" href="${pageContext.request.contextPath}/calculate/total?pno1=${p}&seller_id=${param.seller_id}&year=${param.year}&month=${param.month}">${p }</a>
    					</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a class="page-link" href="${pageContext.request.contextPath}/calculate/total?pno1=${p}&year=${param.year}&month=${param.month}">${p }</a>
			    		</li>
					</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<c:if test="${paging.finishBlock < paging.pagecount}">
			<c:when test="${param.seller_id != null }">
				<li class="page-item">
					<a class="page-link" href="${pageContext.request.contextPath}/calculate/total?pno1=${paging.finishBlock+1}&seller_id=${param.seller_id}&year=${param.year}&month=${param.month}">&raquo;</a>
				</li>
			</c:when>
			<c:otherwise>
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/calculate/total?pno1=${paging.finishBlock+1}&year=${param.year}&month=${param.month}">&raquo;</a>
    		</li>
			</c:otherwise>
		</c:if>
	</ul>
</div>
   </div>
        </div>
    </div>
