<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  

<jsp:include page="/WEB-INF/views/template/header-seller.jsp"/>

	셀러 메인 화면입니다. 내용 채우시면됩니다

	와아아아아아
	



</head>
<body>

<!-- 판매자회원 home -->
<c:choose>
	<c:when test="${seller_id==null }">
	<ul class="nav_login">
		<li class="left_line main_line"><a href="">공지사항</a></li>
		<li class="left_line main_line"><a href="${pageContext.request.contextPath }/member/login">문의하기</a></li>
		<li class="right_line main_line" style="margin-right:50px;">
			<a href="${pageContext.request.contextPath}/seller/regist_agree">회원가입</a>
		</li>
		<li class="right_line main_line">
			<a href="${pageContext.request.contextPath}/seller/login">로그인</a>
			<ul class="sub_line" style="border: 1px solid lightgray;">
				<li class=""><a href="${pageContext.request.contextPath}/seller/find_id">아이디찾기</a></li>
			</ul>
		</li>
	</ul>
	</c:when>
	
	<c:otherwise>
	<ul class="nav_login">
		<li class="left_line main_line"><a href="#">공지사항</a></li>
		<li class="left_line main_line"><a href="${pageContext.request.contextPath }/board/memberqna">문의하기</a></li>
		<%-- <li class="right_line main_line" style="margin-right:50px;"><a href="${pageContext.request.contextPath}/seller/management">관리페이지</a></li> --%>
		<li class="right_line main_line"><a href="${pageContext.request.contextPath}/seller/logout">로그아웃</a></li>
	</ul>
	</c:otherwise>
</c:choose>

<div class="row-empty-20"></div>
<hr class="basic_color">

<div class="logo-area" align="center">
	<a class="" href="${pageContext.request.contextPath }">
  		<img src="${pageContext.request.contextPath}/resources/img/logo-ordering.png" style="width:auto; height: 100px;'">
  	</a>
</div>

<div class="row-empty-40"></div>

<%-- <jsp:include page="/WEB-INF/views/template/footer.jsp"/> --%>

<jsp:include page="/WEB-INF/views/template/footer-seller.jsp"/>

