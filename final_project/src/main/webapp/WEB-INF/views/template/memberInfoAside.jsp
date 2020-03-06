<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<style>
 	aside { 
 		float : left; 
 		padding: 30px; 
		width: 200px;
 	}	 
 	aside ul { 
 		list-style: none; 
 		padding : 0; 
 	}
	
	.aside-title {
		border: 2px solid black;
		margin: 5px;
		padding: 10px;
	}
	.aside-grade {
		border: 2px solid black;
		margin: 5px;
		padding: 10px;
	}
	.aside-content {
		border: 2px solid black;
		margin: 5px;
		padding: 10px;
	}
	
	aside::after {
		content: "";
		display: block;
		clear: both;
	}
	
	.infoPage-area {
		width: 80%;
		padding: 30px;
 		flex: 1; 
	}
	
</style>

<aside>
	<div class="aside-title">
		마이페이지
	</div>
	<div class="aside-grade">
		회원등급
	</div>
	<div class="aside-content">
		<ul>
			<li><a href="${pageContext.request.contextPath}/member/cartList">주문/배송</a><li>
			<li><a href="#">교환/환불</a><li>
		</ul>
		<ul>
			<li>주문제작
				<ul>
					<li><a href="${pageContext.request.contextPath}/member/customListReq">
							받은 견적서 
							</a>
							<span class="badge badge-pill badge-info">${customAlarm}</span>
							</li>
					<li><a href="${pageContext.request.contextPath}/member/customListResp">보낸 요청서</a></li>
				</ul>
			</li>
		</ul>
		<ul>
			<li><a href="${pageContext.request.contextPath}/member/memberinfo">내 정보</a>
				<ul>
					<li><a href="">비밀번호 변경</a></li>
					<li><a href="${pageContext.request.contextPath}/member/pointinfo">포인트 조회</a></li>
					<li><a href="${pageContext.request.contextPath}/member/addrinfo">배송지 관리</a></li>
				</ul>
			</li>
		</ul>
		<ul>
			<li><a href="${pageContext.request.contextPath}/board/memberqna">문의하기</a></li>
			<li><a href="${pageContext.request.contextPath}/board/memberrepert">신고하기</a></li>
		</ul>
		<ul>
			<li><a href="${pageContext.request.contextPath}/member/memberdelete">회원탈퇴</a></li>
		</ul>
		<ul>
			<li><a href="/ordering/member/style">style</a></li>
		</ul>
	</div>
</aside>