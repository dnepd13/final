<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
    <%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
 
<h1>판매자메인홈</h1>
<c:choose>
	<c:when test="${seller_id==null }">
	   <h3><a href="${pageContext.request.contextPath}/seller/regist_agree">가입하기</a></h3><br><br>
        <h3><a href="${pageContext.request.contextPath}/seller/login">로그인하기</a></h3><br><br>
        <h3><a href="${pageContext.request.contextPath}/seller/find_id">아이디 찾기</a></h3><br><br>
        </c:when>
	
	<c:otherwise>
       	 <h3><a href="${pageContext.request.contextPath}/seller/logout">로그아웃하기</a></h3><br><br>
		  <h3><a href="${pageContext.request.contextPath}/seller/management">판매자 관리페이지</a></h3><br><br>
	</c:otherwise>
</c:choose>
