<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">

<!--111  -->
<style>
 	aside { 
 		float : left; 
 		padding: 60px 0px;
		width: 150px;
 	}
 	aside div {
 		border-radius: 5px;
 	}	 
 	aside ul { 
 		list-style: none; 
 		padding : 0; 
 	}
	
	.aside-title {
		border: 2px solid #BFC9D9;
		margin: 5px;
		padding: 10px;
	}
	.aside-grade {
		border: 2px solid #BFC9D9;
		margin: 5px;
		padding: 10px;
	}
	.aside-content {
		border: 2px solid #BFC9D9;
		margin: 5px;
		padding: 10px;
	}
	
	aside::after {
		content: "";
		display: block;
		clear: both;
	}

	
</style>

<script src="https://code.jquery.com/jquery-latest.js"></script>

<script>
	$(function(){
		
		// 회원정보
		$.ajax({
			method : "get",
			url: "${pageContext.request.contextPath}/member/memberInfoAside",
			success: function(resp){
				var name = resp.member_name;
				var grade = resp.member_grade;
				$(".myName").append(name+" 님 안녕하세요");
				$(".myGrade").append(grade);
			}
		});
		
		// 회원 현재 총 포인트
		$.ajax({
			method : "get",
			url: "${pageContext.request.contextPath}/member/memberPointAside",
			success: function(resp){
				$(".myPoint").text(resp);
			}
		});
		
		// 받은 견적서 알람
		$.ajax({
			method : "get",
			url: "${pageContext.request.contextPath}/member/alarmCount",
			success: function(resp){

				$(".badge").text(resp);
			}
		});
		
	});
</script>

<c:if test="${member_id != null}">
<aside>
	<div class="aside-title">
		<a href="${pageContext.request.contextPath}/member/membermyinfo">마이페이지</a>
		<span class="myName"></span>
	</div>
	<div class="aside-grade">
		나의 등급
		<p align="right" style="margin:0;"><span class="myGrade"></span></p>
		<hr>
		나의 포인트 <br>
		<p align="right" style="margin:0;"><a href="${pageContext.request.contextPath}/member/pointinfo"><span class="myPoint" style="color:#0094EC;"></span></a> P</p>
	</div>
	<div class="aside-content">
		<ul>
			<li>주문내역
				<ul>
					<li><a href="${pageContext.request.contextPath}/member/cartList">주문/배송</a><li>
					<li><a href="#">교환/환불</a><li>
				</ul>
			</li>
		</ul>
		<ul>
			<li>주문제작
				<ul>
					<li><a href="${pageContext.request.contextPath}/member/customListResp">
							받은 견적서 
							</a>
							<span class="badge badge-pill badge-info"></span>
							</li>
					<li><a href="${pageContext.request.contextPath}/member/customListReq">보낸 요청서</a></li>
				</ul>
			</li>
		</ul>
		<ul>
			<li><a href="${pageContext.request.contextPath}/member/memberinfo">내 정보</a>
				<ul>
					<li><a href="${pageContext.request.contextPath}/member/pwchange">비밀번호 변경</a></li>
					<li><a href="${pageContext.request.contextPath}/member/pointinfo">포인트 조회</a></li>
					<li><a href="${pageContext.request.contextPath}/member/addrinfo">배송지 관리</a></li>
				</ul>
			</li>
		</ul>
		<ul>
<%-- 			<li><a href="javascript:void(window.open('${pageContext.request.contextPath}/board/qnaregist','관리자에게 문의하기','width=400px, height=800px'))">문의하기</a></li> --%>

			<li><a href="${pageContext.request.contextPath}/board/qnaregist">문의하기</a></li>
			<li><a href="${pageContext.request.contextPath}/board/reportregist">신고하기</a></li>

		</ul>
		<ul>
			<li><a href="${pageContext.request.contextPath}/member/memberdelete">회원탈퇴</a></li>
		</ul>

	</div>
</aside>
</c:if>
