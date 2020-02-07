<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h1>전체 조회 페이지(list)</h1>
<c:forEach var="goodsOptionDto" items="list">
	${list}
</c:forEach>