<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>


<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<style>
	.myInfo_wrap {
		width: 1200px;
		height: 800px;
		margin: 0 auto;
		border: 1px dotted gray;
	}
	.main_wrap {
		float: left;
		margin-left: 60px;
		padding-top: 60px;
		width: 800px;
		border: 1px dotted gray;
	}
	.content_1,
	.content_2 {
		margin: 0 auto;
		width: 80%;
		border: 1px solid black;
	}
	
</style>

<div class="myInfo_wrap">
<jsp:include page="/WEB-INF/views/template/memberInfoAside.jsp"/>

	<div class="main_wrap">

		<div class="content_1">
			회원정보 마이페이지
		</div>
		<div class="content_2">
			
		</div>
		
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>