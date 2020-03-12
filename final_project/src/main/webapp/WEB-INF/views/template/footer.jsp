<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<style>
	
/*	footer */
	footer {
		bottom: 0;
		left: 0;
		right: 0;
		height: 150px;
		position: absolute;
		background: #F3F5F8;
	}
	footer div {
		width: 100%;
		height: 150px;
		bottom: 0;
		background: #F3F5F8;
		padding: 15px 0 ;
	}
	.footer_area * {
		list-style: none;
		padding: 0;
	}
	.footer_area ul {
		float: left;
		position: relative;
		margin: 0 10px;
	}
	.footer_area ul::after {
		content: "";
		display: block;
		clear: both;
	}
	.footer_title {
		padding-bottom: 70px ;
		width: 30%;
		text-align: right;
		padding-right: 30px;
	}
	.footer_company {
		width: 30%;
	}
	.footer_cs {
		width: 30%;
	}
	
	@media screen and (max-width: 720px){
		.footer_company {
			display: none;
		}
	}
</style>

<script>

	$(function(){
		
		// 기업정보
		$.ajax({
			method : "get",
			url: "${pageContext.request.contextPath}/company",
			success: function(resp){

				$("#co_name").append(resp.co_name);
				$("#co_ceo").append(resp.co_ceo);
				$("#co_location").append(resp.co_location);
				$("#co_call").append(resp.co_call);
				$("#co_email").append(resp.co_email);
			}
		});
		
	});
</script>

<footer>
<div class="footer_area">
	<ul class="footer_title">
		<li><strong><span id="co_name"></span></strong></li>
	</ul>
	<ul class="footer_company">
		<li>대표이사: <span id="co_ceo"></span></li>
		<li>개인정보보호 책임자: 모름</li>
		<li>주소: <span id="co_location"></span></li>
		<li>사업자등록번호: 000-00-12345</li>
	</ul>
	<ul class="footer_cs">
		<li><span><a href="${pageContext.request.contextPath }/board/memberreport">신고하기</a></span><br>
				<strong>고객센터: <span id="co_call">02-1234-5678</span></strong> (평일 09:00~18:00)</li>		
		<li>팩스: 02-123-4567</li>
		<li>이메일: <span id="co_email"></span></li>
	</ul>
</div>
</footer>
</section>
</body>
</html>
