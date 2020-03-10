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
<div class="row justify-content-center"  style="padding: 20px;"><h1>관리문의 게시판</h1></div>

   

<table class="table table-hover">
  <thead>
    <tr>
      <th width="10%">말머리</th>
      <th width="40%">제목</th>
      <th width="15%">작성자</th>
      <th width="15%">작성자 구분</th>
      <th width="20%">작성일자</th>
    </tr>
  </thead>
  <tbody>
  	<c:forEach var="list" items="${list }">
    <tr>
      <th class="table-light">${list.admin_qna_head }</th>
      <td>
      <c:choose>
      <c:when test="${list.super_no > 0}">
     	 	<a href="${pageContext.request.contextPath}/board/detailqna?admin_qna_no=${list.admin_qna_no}">
     	 	<img src="${pageContext.request.contextPath}/resources/file/arrow.png" width=20px; height=20px;>
     	 	${list.admin_qna_title }</a>
      </c:when>
     	<c:otherwise>
     		<a href="${pageContext.request.contextPath}/board/detailqna?admin_qna_no=${list.admin_qna_no}">${list.admin_qna_title }</a>
     	</c:otherwise>
      </c:choose>
      </td>
      <td>${list.admin_qna_writer }</td>
      <td>${list.admin_qna_usertype }</td>
      <td>${list.admin_qna_date }</td>
    </tr>
  	</c:forEach>
  </tbody>
</table>
<div class="offset-md-10 col-md-12">

<div class="btn-group-vertical">
	  <a href="${pageContext.request.contextPath}/board/write"><button type="button" class="btn btn-primary">글쓰기</button></a>
</div>
</div>


<div class="row justify-content-center">


<div>
	<ul class="pagination">
		<c:if test="${paging.startBlock > 1 }">
			<c:choose>
				<c:when test="${param.key != null }">
					<li class="page-item">
		     			 <a class="page-link" href="${pageContext.request.contextPath}/board/manageqna?pno1=${paging.startBlock-1}&key=${param.key}&search=${param.search}">&laquo;</a>
		   			 </li>
				</c:when>
				<c:otherwise>
					<li class="page-item">
		     			 <a class="page-link" href="${pageContext.request.contextPath}/board/manageqna?pno1=${paging.startBlock-1}">&laquo;</a>
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
							<a class="page-link" href="${pageContext.request.contextPath}/board/manageqna?pno1=${p}&key=${param.key}&search=${param.search}">${p }</a>
    					</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a class="page-link" href="${pageContext.request.contextPath}/board/manageqna?pno1=${p}">${p }</a>
			    		</li>
					</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<c:if test="${paging.finishBlock < paging.pagecount}">
			<c:when test="${param.key!=null }">
				<li class="page-item">
					<a class="page-link" href="${pageContext.request.contextPath}/board/manageqna?pno1=${paging.finishBlock+1}&key=${param.key}&search=${param.search}">&raquo;</a>
				</li>
			</c:when>
			<c:otherwise>
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/board/manageqna?pno1=${paging.finishBlock+1}">&raquo;</a>
    		</li>
			</c:otherwise>
		</c:if>
	</ul>
</div>

</div>
<form action="manageqna" method="get">
  <fieldset>
    <div class="form-group">
      <label for="exampleSelect1">검색 조건</label>
      <select class="form-control" name="key" id="exampleSelect1">
        <option value="admin_qna_title">제목</option>
        <option value="admin_qna_head">말머리</option>
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