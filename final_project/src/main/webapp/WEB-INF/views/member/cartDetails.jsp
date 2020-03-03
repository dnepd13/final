<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="functions" uri="http://java.sun.com/jsp/jstl/functions"%>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <style></style>
    <script src="https://cdn.jsdelivr.net/gh/hiphop5782/js/star/hakademy-star.min.js"></script>
    <script>
        window.addEventListener("load", function(){
            Hakademy.PointManager.factory(".star-wrap");
        });
    </script>
    <script type="text/javascript">

    $(function(){

    	$(".btn_confirm").click(function(){
    		var btn_confirm = $(this);
    		
    		if(confirm("구매를 확정하시겠습니까?")){
        		var cart_info_goods_no=$(this).data("cart_info_goods_no")
        		
        		$.ajax({
        			url:"${pageContext.request.contextPath}/member/updateConfirm",
        			method:"POST",
        			data:{"cart_info_goods_no":cart_info_goods_no},
        			success: function(resp){
        				alert("구매확정이 완료되었습니다.");
        				location.reload(true);
        			}
        		});
        		
    		}
    		else{
    			return false;
    		}        	
        });
        
        $(".btn_review").click(function(){
        	
        	if($(this).text()=="리뷰쓰기"){
	        	$(this).text("취소");
	        	$(this).next("div").show();
        	}
        	else{
        		$(this).text("리뷰쓰기")
        		$(this).next("div").hide();	
        	}
        });
        
    });
    </script>

<style>
	* {box-sizing: border-box;}
	table {border-collapse: collapse;}
</style>

<h4>회원 주문상품 상세 member/cartDetails.jsp</h4>

<div class="cartGoods">
	<table  border="1">
		<tr>
			<th>상품명</th>
			<th>수량</th>
			<th>가격</th>
			<th>리뷰</th>
		</tr>
		<c:forEach var="cartGoods" items="${getCartGoods }">
		<tr>
			<td>${cartGoods.goods_name}
				<c:forEach var="cartOption" items="${getCartOption }">
				<c:if test="${cartGoods.cart_info_goods_no == cartOption.cart_info_goods_no }">
					<ul>
						<li>${cartOption.goods_option_title } / ${cartOption.goods_option_content }</li>
					</ul>
				</c:if>
				</c:forEach>
			</td>
			<td>${cartGoods.cart_info_goods_quantity }</td>
			<td>${cartGoods.cart_info_goods_price }</td>
			<td class="td_confirm">
				<c:set var="status" value="${cartGoods.cart_ok_status}"/>
				<c:choose>
					<c:when test="${empty cartGoods.cart_ok_status && cartGoods.cart_info_status=='결제완료'}">
						<button class="btn_confirm" data-cart_info_goods_no="${cartGoods.cart_info_goods_no }">구매확정</button><br>
					</c:when>
					<c:when test="${functions:contains(status, '구매확정') }">
						<button class="btn_review">리뷰쓰기</button>
						<div style="display:none;">
							<p>리뷰 등록 시 포인트 50점이 적립됩니다.</p>
							<form action="insertReview" method="post" enctype="multipart/form-data" class="insertReview">	
								<input type="hidden" name="cart_info_no" value="${cartGoods.cart_info_no }">			
								<input type="hidden" name="cart_info_goods_no" value="${cartGoods.cart_info_goods_no }">
								<input type="hidden" name="member_no" value="${cartGoods.member_no }">
								<div data-sendname="goods_review_star" class="star-wrap" data-limit="5" data-point="1" data-unitsize="20" data-image="http://www.sysout.co.kr/file/image/288"></div><br>
								<input type="file" name="files" multiple><br>
								<textarea name="goods_review_content" required>	</textarea>
								<input type="submit" value="리뷰등록">							
							</form>
							<p> &middot; 개인정보(주민번호, 연락처, 주소, 계좌번호, 카드번호 등)가 타인에게 노출되지 않도록 주의해 주시기 바랍니다.</p>
							<p> &middot; 리뷰와 관련없는 비방, 광고, 불건전한 내용 등이 포함될 경우 사전동의 없이 삭제될 수 있습니다.</p>
						</div>
					</c:when>
					<c:when test="${functions:contains(status, '리뷰등록') }">
						<span><a href="${pageContext.request.contextPath }/goods/goodsInfo?goods_no=${cartGoods.goods_no}">리뷰보기</a></span>
					</c:when>
					<c:otherwise>
						${cartGoods.cart_ok_status }
					</c:otherwise>
				</c:choose>	
					
			</td>
		</tr>
		</c:forEach>
	</table>	
</div>
<span><a href="${pageContext.request.contextPath }/member/cartList">목록으로</a></span>

