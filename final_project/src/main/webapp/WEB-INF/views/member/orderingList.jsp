<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="functions" uri="http://java.sun.com/jsp/jstl/functions"%>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/gh/hiphop5782/js/star/hakademy-star.min.js"></script>

<script>
	window.addEventListener("load", function(){
		Hakademy.PointManager.initializeOnLoad();
	});
// 구매확정-리뷰쓰기 버튼 전환
	$(function(){
		$(".orderConfirm").click(function(){
			if(confirm("구매를 확정하시겠습니까?")){
				$(this).hide();
				$(this).next(".btn_review").show();
			}
			else{
				return false;
			}
		});
		
//	리뷰작성
		$(".btn_review").click(function(){
			if($(this).text()=="리뷰쓰기"){
				$(this).next(".insertReview").show();
				$(this).text("취소");
				
				$(this).next(".form").submit(function(e){
					e.preventDefault();
					console.log($(this));
				});
			}
			
			else{
				$(this).next(".insertReview").hide();
				$(this).text("리뷰쓰기");
			}
		});

//	리뷰 수정 및 삭제
		$(".btn_update").click(function(){
			// 수정하기 버튼을 누르면 수정모드로 전환
			if($(this).text()=="수정"){
				var contentCell = $(this).prev();					
				var content = contentCell.text();

				contentCell.empty();
				
				$("<input>").val(content).appendTo(contentCell);
				
				$(this).text("완료");
			} // 위의 완료버튼 누르면 수정내용 비동기로 등록하기
			else{
				var contentCell = $(this).parent().prev().prev().prev();						
				var content = contentCell.children().val();
				
				contentCell.empty();
				contentCell.text(content);
				
				var goods_qna_content = contentCell.text();					
				var goods_qna_no =$(this).parent().data("goods_qna_no");
				var goods_no=$(this).parent().data("goods_no");
				var member_no=$(this).parent().data("member_no");
				
				console.log(goods_qna_content);
				
				$(this).text("수정");
				
				$.ajax({
		    		url: "updateQ",
		    		method: "POST",
		    		data: {"goods_no": goods_no,
		    					"goods_qna_no":goods_qna_no,
		    					"goods_qna_content": goods_qna_content,
		    					"member_no" : member_no,
		    				},
		    		success: function(resp){
		    			location.reload(true);
		    		}
		    	});				
			}
			
		});
	    $(".btn_delete").click(function(){
	    	var td = $(this).parent();
	    	var goods_qna_no= td.data("goods_qna_no");
	    	var goods_no = td.data("goods_no");
	    	
	    	if(confirm("문의를 삭제하시겠습니까?")){
	    		$.ajax({
		    		url: "deleteQ",
		    		method: "GET",
		    		data: {"goods_qna_no" : goods_qna_no,
		    					"goods_no" : goods_no
		    					},
		    		success: function(resp){
		    			location.reload(true);
		    		}
		    	});
	    	}
	    });
	});
</script>
<style>
	* {box-sizing: border-box;}
	table {border-collapse: collapse;}
</style>

<h4>회원 주문내역페이지 member/orderingList.jsp</h4>

<table border="1">
		<tr>
			<th>주문내역 PK</th>
			<th>주문번호</th>
			<th>배송지</th>
			<th>수량</th>
			<th>가격</th>
			<th>결제상태</th>
			<th>리뷰상태</th>
		</tr>
		<c:forEach var="cartList" items="${getCartList }">
		<tr>
			<td>${cartList.cart_info_no }</td>
			<td>${cartList.partner_order_id }</td>
			<td><h5>우편번호 ${cartList.cart_info_addr_post }</h5>
					${cartList.cart_info_addr_basic }<br>${cartList.cart_info_addr_extra }</td>
			<td>${cartList.total_quantity } 개</td>
			<td>${cartList.total_price } 원<h6>배송금액: ${cartList.total_delivery_price } 원</h6></td>
			<td data-cart_info_no="${cartList.cart_info_no }"
					data-member_no="${cartList.member_no }"
					data-goods_review_star="${goods_review_star }"
					data-goods_review_content="${goods_review_content }"
					data-files="${files }">
					${cartList.cart_info_status }	
					<c:set var="cartStatus" value="${cartList.cart_info_status }"/>
					<c:if test="${functions: contains(cartStatus, '결제완료') }">
						<button class="orderConfirm">구매확정</button>
						<button class="btn_review" style="display:none;">리뷰쓰기</button>
						
						<form action="insertReview" method="post" enctype="multipart/form-data" class="insertReview" style="display:none;">
							<input type="hidden" name="cart_info_no" value="${cartList.cart_info_no }">
							<input type="hidden" name="member_no" value="${cartList.member_no }">
							<div class="star-wrap" data-sendname="goods_review_star" data-limit="5" data-unitsize="30" data-image="/resources/img/star-custom.png"></div>
							<input type="file" name="files" multiple><br>
							<textarea name="goods_review_content" required>	</textarea>
							<input type="submit" value="리뷰등록">
						</form>			
					</c:if>
			</td>
			<td><button>리뷰보기</button></td>
		</tr>
		</c:forEach>
</table>
<div></div>
