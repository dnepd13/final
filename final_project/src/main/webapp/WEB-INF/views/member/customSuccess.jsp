<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="redirect">
	<h4>요청이 완료되었습니다.</h4>
	<span><a href="${pageContext.request.contextPath }">메인으로</a></span>
	 &verbar; 
	<span><a href="${pageContext.request.contextPath }/member/customListReq">보낸 요청서 확인하기</a></span>
</div>