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
		width: 90%;
		padding: 30px;
 		flex: 1; 
	}
	
</style>

<script src="https://code.jquery.com/jquery-latest.js"></script>

<script>
	$(function(){
		
		// 받은 견적서 알람
		$.ajax({
			method : "get",
			url: "${pageContext.request.contextPath}/seller/alarmCount",
			success: function(resp){
				$(".badge").text(resp);
			}
		});
		
	});
</script>


<aside>
	<div class="aside-title">
		마이페이지
	</div>
	<div class="aside-grade">
		회원등급
	</div>
	<div class="aside-content">
		<ul> 
			<li>상품관리
		   	  <ul>
				<li><a href="${pageContext.request.contextPath}/seller/portfolio_insert">포토폴리오</a><li>
				<li><a href="${pageContext.request.contextPath}/seller/category_insert">카테고리관리</a><li>
				<li><a href="${pageContext.request.contextPath}/goods/insert">상품등록</a></li>
			  </ul>
		   </li>
		</ul>
		<ul>
			<li>판매관리
				<ul>
					<li><a href="${pageContext.request.contextPath}/seller/customListResp">보낸 견적서</a></li>
					<li><a href="${pageContext.request.contextPath}/seller/customListReq">받은 요청서</a>
						<span class="badge badge-pill badge-info"></span>
					</li>
					<li><a href="">판매정산</a></li>
					<li><a href="">구매확정내역</a></li>
					<li><a href="">배송현황</a></li>					
				</ul>
			</li>
		</ul>
		<ul>
		   <li>정산관리
				<ul>
		   			<li><a href="">취소/반품/교환 관리</a></li>	
				</ul>
		   </li>
		</ul>
		<ul>
			<li>판매자 정보 관리
		  	   <ul>
				<li><a href="${pageContext.request.contextPath}/seller/info">판매자 정보 조회</a></li>
				<li><a href="${pageContext.request.contextPath}/seller/check_pw">비밀번호 변경</a></li>
				<li><a href="${pageContext.request.contextPath}/seller/delete">탈퇴하기</a></li>
				<li><a href="${pageContext.request.contextPath}/seller/logout">로그아웃</a></li>
		       </ul>
		   </li>	
	   </ul>
<ul>
	   <li>판매자 문의,신고
	   		<ul>
       		<li><a href="${pageContext.request.contextPath}/board/sellerreport">관리자에게 신고</a></li>
       		<li><a href="${pageContext.request.contextPath}/board/sellerqna">관리자에게 문의</a></li> 
       		</ul>
       </li>
</ul>        
		<ul>
			<li><a href="/ordering/member/style">style</a></li>
		</ul>
	</div>
</aside>