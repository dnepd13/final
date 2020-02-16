<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%-- ${pageContext.request.contextPath} 절대경로--%>
<h1>홈</h1>
<c:if test="${admin_grade == '총괄관리자' }">
<h1><a href="${pageContext.request.contextPath}/regist">관리자가입</a></h1><br>
<h1><a href="${pageContext.request.contextPath}/admin/manage">관리자관리</a></h1><br>
</c:if>
<h1><a href="${pageContext.request.contextPath}/logout">로그아웃</a></h1><br>
<h1><a href="${pageContext.request.contextPath}/seller/manage">판매자관리</a></h1><br>
<h1><a href="${pageContext.request.contextPath}/member/manage">회원관리</a></h1><br>
<h1><a href="${pageContext.request.contextPath}/calculate/total">정산</a></h1><br>
<h1><a href="${pageContext.request.contextPath}/premium">수수료관리</a></h1><br>
<h1><a href="${pageContext.request.contextPath}/board/manageqna">관리문의게시판</a></h1><br>
<h1><a href="${pageContext.request.contextPath}/board/review">리뷰게시판</a></h1><br>
<h1><a href="${pageContext.request.contextPath}/sales/status">사이트매출현황</a></h1><br>
<h1><a href="${pageContext.request.contextPath}/category">카테고리 관리</a></h1><br>
<h1><a href="${pageContext.request.contextPath}/goods/list">전체 상품 관리</a></h1><br>
<h1><a href="${pageContext.request.contextPath}/blocklist">차단된 회원 목록</a></h1><br>