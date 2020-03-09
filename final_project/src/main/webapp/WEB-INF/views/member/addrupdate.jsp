<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">   

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>
<jsp:include page="/WEB-INF/views/template/memberInfoAside.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<div align="center" class="btn-group-vertical">

<h1>배송지 수정하기</h1>
<h2><a href="http://localhost:8001/ordering/member/addrinfo">이전 페이지로 이동</a></h2>

    

<form action="addrupdate" method="post">
	<input type="hidden" name="member_addr_no" value="${addrupdateget.member_addr_no}">
	
	<div class="btn-group-vertical">
	<a><button class="btn btn-primary" value="수정">수정</button></a>
	</div>
<table class="table table-hover">
	
<tbody class="col-lg-4 col-md-6">
	

		<tr>
			<th width="121px">제목</th>
				<td width="350px">
				<input type="text" name="member_name_extra" value="${addrupdateget.member_name_extra}"  required>
				</td>
		</tr>
		<tr>
			<td>우편번호를 적어주세요:
				<input type="text" name="member_addr_post" value="${addrupdateget.member_addr_post}" required>
			</td>
		</tr>
		<tr>
			<td>기본주소를 적어주세요:
				<input type="text" name="member_addr_basic" value="${addrupdateget.member_addr_basic}"  required>
			</td>
		</tr>
		<tr>
			<td>상세주소를 적어주세요:
				<input type="text" name="member_addr_extra" value="${addrupdateget.member_addr_extra}"  required>
			</td>
		</tr>
		<tr>

		
			<td>"주소타입을 적어주세요(기본주소,추가주소)"
				<input type="text" name="member_addr_status" value="${addrupdateget.member_addr_status}"  required>
			</td>
		</tr>
		</tbody>
		
		

	</table>
	</form>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>