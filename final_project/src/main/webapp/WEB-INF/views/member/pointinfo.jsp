<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
	table tbody tr{
		text-align: center;
	}
	
</style>

<div class="myInfo_wrap">
<jsp:include page="/WEB-INF/views/template/memberInfoAside.jsp"/>
	<div class="point_wrap">
		<div class="point_main">
			<div class="point_mainBox1">
				<img src="${pageContext.request.contextPath}/resources/img/memberPoint.png" style="width:100px;">
			</div>
			<div class="point_mainBox2">
				사용 가능 포인트
			</div>
			<div class="point_mainBox3">
				<fmt:formatNumber pattern="###,###,###" type="number">
					${totalPoint } 
				</fmt:formatNumber> point
			</div>
		</div>
		<div class="point_list">
			<table class="table">
				<thead>
					<tr>
			      		<th scope="col">일자</th>
			      		<th scope="col">구분</th>
			      		<th scope="col">내용</th>
			      		<th scope="col">포인트</th>
			      		<th scope="col">유효기간</th>
			    	</tr>
				</thead>
				<tbody>
				<c:forEach var="Pointinfo" items="${pointinfo}">
			    <tr>
					<fmt:parseDate value="${memberCustom.custom_order_date }" var="custom_order_date" pattern="yyyy-MM-dd HH:mm:ss"/>
					<fmt:formatDate value="${custom_order_date }" pattern="yyyy/MM/dd HH:mm:ss"/>
					<td scope="row">
						<fmt:parseDate value="${Pointinfo.member_point_date}" var="point_date" pattern="yyyy-MM-dd HH:mm:ss"/>
						<fmt:formatDate value="${point_date}" pattern="yyyy/MM/dd HH:mm:ss"/>
					</td>
					<td scope="row">${Pointinfo.member_point_status}</td>
					<td scope="row" align="left">${Pointinfo.member_point_content}</td>
					<td scope="row" align="right">
						<fmt:formatNumber pattern="###,###,###" type="number">
							${Pointinfo.member_point_change}
						</fmt:formatNumber>
					</td>
					<td scope="row">
						<fmt:parseDate value="${Pointinfo.member_point_limit}" var="point_limit" pattern="yyyy-MM-dd HH:mm:ss"/>
						<fmt:formatDate value="${point_limit}" pattern="yyyy/MM/dd HH:mm:ss"/>
					</td>
				</tr>
				</c:forEach>
			  </tbody>
			</table>  
		</div>
		
		<!-- 내비게이터 -->
		<div class="row justify-content-center">
			<ul class="pagination">
				<c:if test="${paging.startBlock > 1 }">
					<li class="page-item">
		     			 <a class="page-link" href="${pageContext.request.contextPath}/member/pointinfo?pageNo=${paging.startBlock-1}">&laquo;</a>
		   			 </li>
				</c:if>
				<c:forEach begin="${paging.startBlock }" end="${paging.finishBlock }" var="p">
					<c:choose>
						<c:when test="${p == paging.pno }">
							<li class="page-item active">
		   					   <a class="page-link" >${p }</a>
		   					 </li>
						</c:when>
						<c:when test="${p != paging.pno }">
							<li class="page-item active">
		      					<a class="page-link" href="${pageContext.request.contextPath}/member/pointinfo?pageNo=${p}">${p }</a>
		   					 </li>
						</c:when>
					</c:choose>
				</c:forEach>
				<c:if test="${paging.finishBlock < paging.pagecount}">
					<li class="page-item">
		     			 <a class="page-link" href="${pageContext.request.contextPath}/member/pointinfo?pageNo=${paging.finishBlock+1}">&raquo;</a>
		    		</li>
				</c:if>
			</ul>	
		</div>
		<!-- 내비게이터 영역 끝 -->	
		
	</div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"/>