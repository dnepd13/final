<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js" ></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
<script>
$(function(){
	$(".sellerPw").hide();
	
	var email = "${param.email}";
	if(email!=""){
		window.alert(email+"에 비밀번호 초기화 이메일을 발송했습니다");
	}
	
});
</script>

<style>
	.arti{
		overflow: hidden;
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
<div class="row justify-content-center"  style="padding: 20px;"><h1>판매자 관리 목록</h1></div>

<table class="table table-hover">
  <thead>
    <tr>
      <th width="10%">아이디</th>
      <th width="10%">이름</th>
      <th width="10%">이메일</th>
      <th width="10%">연락처</th>
      <th width="10%">등급</th>
      <th width="10%">가입일</th>
      <th width="10%">마지막 접속일시</th>
      <th width="10%">상세보기</th>
      <th width="10%">차단
      <th width="10%">비밀번호초기화</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="list" items="${list }">
    <tr class="table-light">
      <th scope="row">${list.seller_id}</th>
      <td>${list.seller_name}</td>
      <td>${list.seller_email}</td>
      <td>${list.seller_phone}</td>
      <td>${list.seller_grade}</td>
      <td>${list.seller_join_date}</td>
      <td>${list.seller_last_login}</td>
      <td>
      		<form action="sellerpage" method="post">
      			<input type="hidden" name = "seller_no" value="${list.seller_no }">
      			<input type="submit" value="상세보기">
      		</form>
      </td>
      <c:choose>
      	<c:when test="${list.block_no > 0 }">
      		<td>
      		<a href="${pageContext.request.contextPath}/unlock?seller_no=${list.seller_no}"><button type="button" class="btn btn-danger">차단해제</button></a>
      		</td>
      	</c:when>
      	<c:otherwise>
		       <td>
		      		<a href="${pageContext.request.contextPath}/block?seller_no=${list.seller_no}"><button type="button" class="btn btn-primary">차단하기</button></a>
		      </td>
      	</c:otherwise>
      </c:choose>
      
       <td>
      		<form action="reset" method="post" class="resetForm">
      			<input type="hidden" name="seller_no" value="${list.seller_no }">
      			<input type="hidden" name="seller_email" value="${list.seller_email }">
      			<input class="sellerPw" type="password" name="seller_pw" value="123456789a">
      			<button class="btn btn-primary reset" >초기화</button>
      		</form>
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
		     			 <a class="page-link" href="${pageContext.request.contextPath}/seller/manage?pno1=${paging.startBlock-1}&key=${param.key}&search=${param.search}">&laquo;</a>
		   			 </li>
				</c:when>
				<c:otherwise>
					<li class="page-item">
		     			 <a class="page-link" href="${pageContext.request.contextPath}/seller/manage?pno1=${paging.startBlock-1}">&laquo;</a>
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
								<a class="page-link" href="${pageContext.request.contextPath}/seller/manage?pno1=${p}&key=${param.key}&search=${param.search}">${p }</a>
	    					</li>
						</c:when>
						<c:otherwise>
							<li class="page-item">
								<a class="page-link" href="${pageContext.request.contextPath}/seller/manage?pno1=${p}">${p }</a>
				    		</li>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<c:if test="${paging.finishBlock < paging.pagecount}">
			<c:when test="${param.key!=null }">
				<li class="page-item">
					<a class="page-link" href="${pageContext.request.contextPath}/seller/manage?pno1=${paging.finishBlock+1}&key=${param.key}&search=${param.search}">&raquo;</a>
				</li>
			</c:when>
			<c:otherwise>
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/seller/manage?pno1=${paging.finishBlock+1}">&raquo;</a>
    		</li>
			</c:otherwise>
		</c:if>
		
	</ul>
</div>

</div>
	
	<form action="manage" method="get">
  <fieldset>
    <div class="form-group">
      <label for="exampleSelect1">검색 조건</label>
      <select class="form-control" name="key" id="exampleSelect1">
        <option value="seller_id">아이디</option>
        <option value="seller_grade">등급</option>
      </select>
    </div>
    <div class="form-group row">
      <label for="staticEmail" class="col-sm-2 col-form-label">검색</label>
      <div class="col-sm-10">
        <input type="text"  name="search" class="form-control-plaintext" id="staticEmail" placeholder="검색어를 입력하세요">
      </div>
    </div>
  </fieldset>
  <div class="offset-md-4 col-md-4">

  <button type="submit" class="btn btn-primary btn-delete offset-md-1 col-md-11" >검색</button>
</div>
</form>


</div>
        </div>
    </div>
    
</article></section>