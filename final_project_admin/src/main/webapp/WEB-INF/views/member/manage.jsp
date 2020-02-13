<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
<h1>회원 관리창 입니다</h1>
<h1><a href="${pageContext.request.contextPath}/home">홈으로</a></h1>
<h1><a href="${pageContext.request.contextPath}/member/manage">목록으로</a></h1>

<table class="table table-hover">
  <thead>
    <tr>
      <th width="15%">아이디</th>
      <th width="15%">이름</th>
      <th width="1%">이메일</th>
      <th width="10%">연락처</th>
      <th width="1%">등급</th>
      <th width="10%">가입일</th>
      <th width="10%">마지막 접속일시</th>
      <th width = "10%">상세보기</th>
      <th width = "10%">차단</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="list" items="${list}">
    <tr class="table-light"">
      <th scope="row">${list.member_id}</th>
      <td>${list.member_name}</td>
      <td>${list.member_email}</td>
      <td>${list.member_phone}</td>
      <td>${list.member_grade}</td>
      <td>${list.member_join_date}</td>
      <td>${list.member_last_login} </td>
      <td>
      		<form action="memberpage" method="post">
      			<input type="hidden" name="member_no" value="${list.member_no }">
      			<input type="submit" value="상세보기">
      		</form>
      </td>
      <c:choose>
      	<c:when test="${list.block_no > 0 }">
      		<td>차단된 회원</td>
      	</c:when>
      	<c:otherwise>
		      <td>
		      	<a href="${pageContext.request.contextPath}/block?member_no=${list.member_no}"><button type="button" class="btn btn-primary">차단하기</button></a>
		      </td>
      	</c:otherwise>
      </c:choose>
    </tr>
	</c:forEach>
  </tbody>
</table>

<form action="manage" method="get">
  <fieldset>
    <div class="form-group">
      <label for="exampleSelect1">검색 조건</label>
      <select class="form-control" name="key" id="exampleSelect1">
        <option value="member_id">아이디</option>
        <option value="member_name">이름</option>
        <option value="member_grade">등급</option>
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
		     			 <a class="page-link" href="${pageContext.request.contextPath}/member/manage?pno1=${paging.startBlock-1}&key=${param.key}&search=${param.search}">&laquo;</a>
		   			 </li>
				</c:when>
				<c:otherwise>
					<li class="page-item">
	     			 	<a class="page-link" href="${pageContext.request.contextPath}/member/manage?pno1=${paging.startBlock-1}">&laquo;</a>
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
								<a class="page-link" href="${pageContext.request.contextPath}/member/manage?pno1=${p}&key=${param.key}&search=${param.search}">${p }</a>
	    					</li>
						</c:when>
						<c:otherwise>
							<li class="page-item active">
		      					<a class="page-link" href="${pageContext.request.contextPath}/member/manage?pno1=${p}">${p }</a>
		   					 </li>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<c:if test="${paging.finishBlock < paging.pagecount}">
			<c:when test="${param.key!=null }">
				<li class="page-item">
					<a class="page-link" href="${pageContext.request.contextPath}/member/manage?pno1=${paging.finishBlock+1}&key=${param.key}&search=${param.search}">&raquo;</a>
				</li>
			</c:when>
			<c:otherwise>
				<li class="page-item">
	     			 <a class="page-link" href="${pageContext.request.contextPath}/member/manage?pno1=${paging.finishBlock+1}">&raquo;</a>
	    		</li>
			</c:otherwise>
		</c:if>
	</ul>
</div>