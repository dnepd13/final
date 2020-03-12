<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap.min.css">
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/latest/js/bootstrap.min.js"></script>

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


<style>
  /* 사이드바 래퍼 스타일 */
  
  #page-wrapper {
    padding-left: 250px;
    z-index: 1;
  }
  
  #sidebar-wrapper {
    position: fixed;
    width: 250px;
    height: 100%;
    margin-left: -250px;
    background: #000;
    overflow-x: hidden;
    overflow-y: auto;
  }
  
  #page-content-wrapper {
    width: 100%;
    padding: 20px;
  }
  /* 사이드바 스타일 */
  
  .sidebar-nav {
    width: 250px;
    margin: 0;
    padding: 0;
    list-style: none;
  }
  
  .sidebar-nav li {
    text-indent: 1.5em;
    line-height: 2.8em;

  }
  
  .sidebar-nav li a {
    display: block;
    text-decoration: none;
    color: #999;
  }
  
  .sidebar-nav li a:hover {
    color: #fff;
    background: rgba(255, 255, 255, 0.2);
  }
  

	.sidebar-nav > .sidebar-home {
    font-size: 2em;
    line-height: 3em;
    
  }

</style>

<div id="page-wrapper">
  <!-- 사이드바 -->
 	<div id="sidebar-wrapper">
		<ul class="sidebar-nav">
			<li class="sidebar-brand sidebar-home">
				<a href="${pageContext.request.contextPath}/seller/main" class="navbar-brand" style="color:white;">ODERING</a>
			</li>
     		<li class="nav-item">00님 안녕하세요.</li>
			<li class="nav-item">상품관리
				<ul>
					<li><a href="${pageContext.request.contextPath}/goods/insert">상품등록</a></li>
					<li><a href="${pageContext.request.contextPath}/seller/portfolio_insert">포트폴리오</a></li>
					<li><a href="${pageContext.request.contextPath}/seller/category_insert">카테고리관리</a></li>
				</ul>
			</li>
			<li class="nav-item">판매관리
				<ul>
					<li><a href="${pageContext.request.contextPath}/seller/customListReq">받은 요청서
							<span class="badge badge-pill badge-info"></span>
							</a>
					</li>
					<li><a href="${pageContext.request.contextPath}/seller/customListResp">보낸 견적서</a></li>
					<li><a href="">취소/반품/교환 관리</a></li>
					<li><a href="">구매확정내역</a></li>
					<li><a href="">배송현황</a></li>
				</ul>
			</li>
            <li class="nav-item">정산관리
            	<ul>
		   			<li><a href="">판매정산</a></li>	
				</ul>
            </li>
            <li class="nav-item">판매자 정보 관리
		  	   <ul>
					<li><a href="${pageContext.request.contextPath}/seller/info">판매자 정보 조회</a></li>
					<li><a href="${pageContext.request.contextPath}/seller/check_pw">비밀번호 변경</a></li>
					<li><a href="${pageContext.request.contextPath}/seller/delete">탈퇴하기</a></li>
					<li><a href="${pageContext.request.contextPath}/seller/logout">로그아웃</a></li>
		       </ul>
			</li>
            <li class="nav-item">판매자 문의,신고
		   		<ul>
		       		<li><a href="${pageContext.request.contextPath}/board/sellerreport">관리자에게 신고</a></li>
		       		<li><a href="${pageContext.request.contextPath}/board/sellerqna">관리자에게 문의</a></li> 
	       		</ul>
			</li>
		</ul>
	</div>
</div>
  <!-- /사이드바 -->
