<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="functions" uri="http://java.sun.com/jsp/jstl/functions"%>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>

<style>
	* {box-sizing: border-box;}
	
	.articleBox {
		width: 1200px;
		height: 800px;
		margin: 0 auto;
	}
	.cartGoods {
		float: left;
		margin-left: 60px;
		padding-top: 100px;
		width: 960px;
	}
	.goods_main {
		margin: 0 auto;
		width: 90%;
		height: 50px;
		border-bottom: 2px solid #F3F5F8;
	}
	.goods_mainBox1 {
		width: 200px;
		height: auto;
		padding-top: 10px;
		margin-left: 30px;
		float: left;
		font-size: large; 
	}		
	.goodsContent {
		margin: 30px auto;
		width: 80%;
	}
	
	table {
		border-collapse: collapse;
		margin: 0 auto;
		width: 90%;
		text-align: center;
	}		
	table .t_head {
		background-color: #F3F5F8;
	}
	.cartGoods table th {
		height: 30px;
	}
	.cartGoods table ul {
		list-style: none;
	}

 /*수정 modal 전체 스타일 */
 	.modal {
 		display: none;
 		z-index: 1;
 		top: 0;
 		bottom: 0;
 		letf: 0;
 		right: 0;
 		background-color: rgba(0,0,0,0.3);
 	}
 			
/*수정 modal 내부 input 스타일 */	
 	.insert_review  {
 		width: 90%;
 		margin: 0 auto;
 	}
 	.insert_review * {
 		width: 100%;
 	}
 	.insert_review textarea{
 		resize: none;
 		height: 250px;
 	}
 	
 	.files_table {
 		border: 1px darkgray solid;
 	}
 	.files_info td {
 		height: 50px;
 		padding: 5px;
 	}

</style>

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
        	$(this).next(".modal").show();
        	
        	if($(this).next(".modal").show()){
        		$(this).next(".modal").find(".close").click(function(){
        			$(this).parents(".modal").hide();
        		});
        	}

        });
        
     // 파일정보 미리보기
		$(upload).change(function(f){
			$(".files_Info").children().empty();
			var files = f.target.files;	
			if(files.length >5 ){
				alert("파일은 최대 5개까지만 등록 가능합니다. 다시 선택해주세요.");
				$("input[type=submit]").prop("disabled", true);
			}
			else{
				$("input[type=submit]").prop("disabled", false);
				for(var i=0 ; i<files.length ; i++){
					var filesName =files[i].name;
					var filesSizeOrigin = files[i].size/1024;
					var filesSize = String(filesSizeOrigin).substring(0,5);
					$(".files_name").append(filesName+"<br>");
					$(".files_size").append(filesSize+" KB <br>");
				}
			}
		});

        
    });
    </script>


<article class="articleBox">
<jsp:include page="/WEB-INF/views/template/memberInfoAside.jsp"/>
<div class="cartGoods">
	<div class="goods_main">
		<div class="goods_mainBox1">
			주문상품 상세
		</div>
	</div>	
	<div class="goodsContent">
	<table  border="1">
		<tr class="t_head">
			<th scope="col" width="50%">상품명</th>
			<th scope="col" width="10%">수량</th>
			<th scope="col" width="20%">가격</th>
			<th scope="col" width="20%">리뷰</th>
		</tr>
		<c:forEach var="cartGoods" items="${getCartGoods }">
		<tr>
			<td style="text-align: left; padding: 10px;">${cartGoods.goods_name}
				<c:forEach var="cartOption" items="${getCartOption }">
				<c:if test="${cartGoods.cart_info_goods_no == cartOption.cart_info_goods_no }">
					<ul style="margin-top:5px;; margin-bottom: 2px;">
						<li style="color: gray;"> - ${cartOption.goods_option_title } / ${cartOption.goods_option_content }</li>
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
						<button class="btn_confirm btn_custom" data-cart_info_goods_no="${cartGoods.cart_info_goods_no }">구매확정</button><br>
					</c:when>
					<c:when test="${functions:contains(status, '구매확정') }">
					
						<button class="btn_review btn_custom">리뷰쓰기</button>
						<div class="modal" style="display:none;">
							<div class="modal-dialog" role="document">
								<form action="insertReview" method="post" enctype="multipart/form-data" class="insertReview">	
								<div class="modal-content">
									<div class="modal-header">
							        	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							          		<span aria-hidden="true" id="close">&times;</span>
							        	</button>
									</div>
									<div class="modal-body insert_review">
										<p>리뷰 등록 시 포인트 50점이 적립됩니다.</p>
										
											<input type="hidden" name="cart_info_no" value="${cartGoods.cart_info_no }">			
											<input type="hidden" name="cart_info_goods_no" value="${cartGoods.cart_info_goods_no }">
											<input type="hidden" name="member_no" value="${cartGoods.member_no }">
											<div data-sendname="goods_review_star" class="star-wrap" data-limit="5" data-point="1" data-unitsize="20" data-image="http://www.sysout.co.kr/file/image/288"></div><br>
											<div class="row-empty-20"></div>
											<input type="file" name="files" id="upload" multiple><br>
											<!-- 파일정보 미리보기 영역-->
											 <div>
												<table class="files_table">
												  	<tbody>
												  		<tr class="files_Info">
															<td class="files_name" style="width:70%;" align="left"></td>
															<td class="files_size" style="width:30%;" align="right"></td>
														</tr>
													</tbody>
												</table>
											</div>
											<!-- 파일정보 끝 -->
											<div class="row-empty-20"></div>
											<textarea name="goods_review_content" required>	</textarea>
										
										<p style="text-align: left;"> &middot; 개인정보(주민번호, 연락처, 주소, 계좌번호, 카드번호 등)가 타인에게 노출되지 않도록 주의해 주시기 바랍니다.</p>
										<p style="text-align: left;"> &middot; 리뷰와 관련없는 비방, 광고, 불건전한 내용 등이 포함될 경우 사전동의 없이 삭제될 수 있습니다.</p>
									</div>
									<div class="modal-footer">
										<input type="submit" class="btn btn-primary" value="리뷰등록">
									</div>
								</div>
								</form>
							</div>
						</div>

					</c:when>
					<c:when test="${functions:contains(status, '리뷰등록') }">
						<span><a href="${pageContext.request.contextPath }/goods/goodsInfo?goods_no=${cartGoods.goods_no}">리뷰보기</a></span>
					</c:when>
					<c:otherwise>
						<span>${cartGoods.cart_info_status }</span>
					</c:otherwise>
				</c:choose>	
					
			</td>
		</tr>
		</c:forEach>
	</table>
	<div class="row-empty-20"></div>
	<p style="text-align: right;"><a href="${pageContext.request.contextPath }/member/cartList">목록으로</a></p>
	</div>	
</div>

</article>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>