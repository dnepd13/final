<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
<h1>차단된 회원 목록</h1>
<h1><a href="${pageContext.request.contextPath}/home">홈으로</a></h1>
<h1><a href="${pageContext.request.contextPath}/blocklist">목록으로</a></h1>
<table class="table table-hover">
  <thead>
    <tr>
      <th width="10%">아이디</th>
      <th width="10%">그룹</th>
      <th width="40%">차단사유</th>
      <th width = "20%">차단날짜</th>
      <th width = "20%">차단해제</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="list" items="${list}">
    <tr class="table-light"">
      <th scope="row">${list.block_id}</th>
      <td>${list.block_group}</td>
      <td>${list.block_content}</td>
      <td>${list.block_date}</td>
      <td>
	      <form action="blocklist" method="post">
	      	<input type="hidden" name="block_no" value="${list.block_no }">
	      	<input type="submit" value="차단해제">
	      </form>
      </td>
    </tr>
	</c:forEach>
  </tbody>
</table>

<form action="blocklist" method="get">
  <fieldset>
    <div class="form-group">
      <label for="exampleSelect1">검색 조건</label>
      <select class="form-control" name="key" id="exampleSelect1">
        <option value="block_group">그룹</option>
        <option value="block_id">아이디</option>
      </select>
    </div>
    <div class="form-group row">
      <label for="staticEmail" class="col-sm-2 col-form-label">검색</label>
      <div class="col-sm-10">
        <input type="text"  name="search" class="form-control-plaintext" id="staticEmail">
      </div>
    </div>
  </fieldset>
  <button type="submit" class="btn btn-primary btn-delete" >검색</button>
</form>

<div>
	<ul class="pagination">
		<c:if test="${paging.startBlock > 1 }">
			<c:choose>
				<c:when test="${param.key != null }">
					<li class="page-item">
		     			 <a class="page-link" href="${pageContext.request.contextPath}/blocklist?pno1=${paging.startBlock-1}&key=${param.key}&search=${param.search}">&laquo;</a>
		   			 </li>
				</c:when>
				<c:otherwise>
					<li class="page-item">
		     			 <a class="page-link" href="${pageContext.request.contextPath}/blocklist?pno1=${paging.startBlock-1}">&laquo;</a>
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
								<a class="page-link" href="${pageContext.request.contextPath}/blocklist?pno1=${p}&key=${param.key}&search=${param.search}">${p }</a>
	    					</li>
						</c:when>
						<c:otherwise>
							<li class="page-item">
								<a class="page-link" href="${pageContext.request.contextPath}/blocklist?pno1=${p}">${p }</a>
				    		</li>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<c:if test="${paging.finishBlock < paging.pagecount}">
			<c:when test="${param.key!=null }">
				<li class="page-item">
					<a class="page-link" href="${pageContext.request.contextPath}/blocklist?pno1=${paging.finishBlock+1}&key=${param.key}&search=${param.search}">&raquo;</a>
				</li>
			</c:when>
			<c:otherwise>
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/blocklist?pno1=${paging.finishBlock+1}">&raquo;</a>
    		</li>
			</c:otherwise>
		</c:if>
		
	</ul>
</div>