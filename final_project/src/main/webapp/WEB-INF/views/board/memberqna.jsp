<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">   

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>


<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<style>
	* {box-sizing: border-box;}
	.myInfo_wrap {
		width: 1200px;
		height: 800px;
		margin: 0 auto;
		border: 1px dotted gray;
	}
	.point_wrap {
		float: left;
		margin-left: 60px;
		padding-top: 30px;
		width: 900px;
		border: 1px dotted gray;
	}
	.point_wrap::after{content:""; display: block; clear:both;}
	.point_main {
		margin: 0 auto;
		width: 90%;
		height: 120px;
		border: 2px solid #F3F5F8;
		border: 1px dotted gray;
	}
	.point_mainBox1 {
		width: 100px;
		height: auto;
		padding-top: 10px;
		margin-left: 30px;
		float: left;
	}
 	.point_mainBox2 { 
 		padding-top: 35px;
 		margin-left: 100px;
 		width: 250px;
 		font-size: x-large; 
 		float: left;
 	}
	.point_mainBox3 {
		width: 307px;
		height: 100%;
		padding-top: 35px;
		padding-left: 25px;
		margin-left: 500px;
		font-size: x-large; 
		background: #F3F5F8;
	}
	.point_mainBox3 ::after {
		content="";
		display: block;
		clear: both;	
	}
	.point_list {
		margin: 30px auto;
		width: 90%;
		border: 1px solid black;
	}
	
	table thead {background: #F3F5F8; }
	table thead tr {
		border-top: 2px solid gray;
		text-align: center;
	}
th, td {
    text-align: center;
    vertical-align: middle;
}
</style>

<div class="btn-group-vertical">
<jsp:include page="/WEB-INF/views/template/memberInfoAside.jsp"/>
<h2>회원 문의 목록</h2>
<h2><a href="${pageContext.request.contextPath}/">홈으로</a></h2>
<div class="point_wrap"></div>
	<div class="point_main"></div>
		<tr style="text-align: center">
			<b><font color="bf0000" style="text-align: center">해당 게시판의 특성에 맞는 카테고리에 문의 남겨 주시면 보다 정확하고 빠른 답변을 얻으실 수 있어요!
				</font>
			</b>
		</tr>
		
		<div class="point_mainBox1"></div>

			<div class="btn-group-vertical" align="left">
				<a href="${pageContext.request.contextPath}/board/qnaregist">
				<button type="button" class="btn btn-primary">글쓰기</button>
				</a>
			</div>
<table class="table table-hover">
	<thead>
		<tr>
			<th width="40%">제목</th>
			<th width="15%">작성자</th>
			<th width="15%">작성자 구분</th>
			<th width="20%">작성일</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="getListQna" items="${getListQna}">
		<tr>
			<td>
			<c:choose>
			<c:when test="${getListQna.super_no > 0}">
				<a href="${pageContext.request.contextPath}/board/detailmqna?admin_qna_no=${getListQna.admin_qna_no}">---->${getListQna.admin_qna_title }</a>
			</c:when>
				<c:otherwise>
					<a href="${pageContext.request.contextPath}/board/detailmqna?admin_qna_no=${getListQna.admin_qna_no}">${getListQna.admin_qna_title }</a>	
				</c:otherwise>	
			</c:choose>
			</td>

		    <td>${getListQna.admin_qna_writer}</td>
			<td>${getListQna.admin_qna_usertype}</td>
			<td>${getListQna.admin_qna_date}</td>

		</tr>
		</c:forEach>
	</tbody>


</table>

	<ul class="pagination">
		<c:if test="${paging1.startBlock > 1 }">
			<li class="page-item">
				<a class="page-item" href="${pageContext.request.contextPath}/board/memberqna?pno1=${paging1.startBlock-1}">&laquo;</a>

			</li>
		</c:if>
		<c:forEach begin="${paging1.startBlock }" end="${paging1.finishBlock }" var="p">
			<c:choose>
				<c:when test="${p == paging1.pno }">
					<li class="page-item active">
						<a class="page-link">${p }</a>
					</li>
				</c:when>
				<c:when test="${p != paging1.pno }">
					<li class="page-item active">
						<a class="page-link" href="${pageContext.request.contextPath}/board/memberqna?pno1=${p}">${p}</a>
					</li>

				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging1.finishBlock < paging1.pagecount}">
			<li class="page-item">
				<a class="page-link" href="${pageContext.request.contextPath}/board/memberqna?pno=${paging1.finishBlock+1}">&raquo;</a>
			</li>
		</c:if>
	</ul>

</div> 

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>