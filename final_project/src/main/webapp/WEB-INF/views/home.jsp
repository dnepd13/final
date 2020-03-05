<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/menu.jsp"></jsp:include>

	<span><a href="${pageContext.request.contextPath }/goods/getList">상품List</a></span>
	<span>&verbar;</span>
	<span><a href="${pageContext.request.contextPath }/goods/insert">상품등록</a></span>
<!-- 바뀐 session의 member_no에서 memeber_id를 구해서 확인  -->

이하 메인이다 
부트스트랩 nav가 너무 두꺼운거 같아서 좀 건드렸더니 다른 페이지에서 불렀을 때 변경한걸로 적용 안되는 경우도 있더라구요 ..
홈이랑 크기가 다르면 header style에서 부트스트랩 style 가져가시면 되여.. 괜히건드렸나 ......음..<br>
누가 있어보이게 만들어주세요 .. 저는 글렀어요 ...


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>