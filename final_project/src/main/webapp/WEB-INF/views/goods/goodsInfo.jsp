<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="functions" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<style>
/* tab */
	.tab {
		border: 2px solid rgb(248,245,240);
		text-align: center;
		height: 40px;
		padding: 10px 0;
	}
	.tab span {
		padding: 0 100px;
	}

/*	qna style */
	.articleBox {
		width: 80%;
		margin: 0 auto;
	}
	.qnaBox,
	.reviewBox {
		width: 90%;
		margin: 0 auto;
	}
	
	/*문의작성 Modal*/
	.modal {
 		display: none;
 		z-index: 1;
 		top: 0;
 		bottom: 0;
 		letf: 0;
 		right: 0;
 		background-color: rgba(0,0,0,0.3);
 	}
 	.modal-body {
 		width: 90%;
 		margin: 0 auto;
 	}
	
	.qna_member textarea,
	.qna_seller textarea,
	.updateQ textarea,
	.reviewBox textarea {
		resize: none;
		width: 100%;
		height: 80px;
	}
	.reviewBox {
		border: 1px solid darkgray;
	}
	.reviewBox td {
		padding: 12px;
	}
	.replyBox {
		border: 1px solid lightgray;
		margin: 2px;
		padding: 5px;
		border-radius: 5px;
	}
	.reply_content {
		margin: 10px 0
	}
	
</style>

<!-- 별점 script -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"/>
<script src="https://cdn.jsdelivr.net/gh/hiphop5782/js/star/hakademy-star.min.js"></script>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
    window.addEventListener("load", function(){
        Hakademy.PointManager.factory(".star-wrap");
    });
</script>
<script>
$(function(){
	var goodsOptionVOList = JSON.parse('${jsonGoodsOptionVOList}');
	var goodsVO = JSON.parse('${jsonGoodsVO}');
	var VOindex = 0;
	var final_price = 0;
	var final_qtt = 0;
	var count = 0;
	
	$(".one_btn").click(function(e){
		e.preventDefault();
		var url = $(".alink").attr("href");
		$(location).attr('href', url);
	});
	
	// 옵션 선택 이벤트
	$(".options").change(function(){
		var selectedAll = true;
		$(".options").each(function(){
			if(!$(this).val()){
				selectedAll = false;
				return false;
			}
		});
		
		// 옵션 전체 선택했을 때
		if(selectedAll){
			count++;
			$(".submit_ordering").attr("disabled",false);
			$(".add_cart_btn").attr("disabled",false);
			
			var price = goodsVO.goods_price;
			var title;
			var content;
			var option_price;
			var option_no_list = new Array();
			var qtty;
			
			var div = $("<div class='total_price_area col-12'></div>"); // 선택 상품+옵션 그룹div
			
			// 옵션 선택 정보 저장 (옵션번호리스트, 가격합계)
			$(".options").each(function(i){
				var no = $(this).val();
				var arr = goodsOptionVOList[i].goodsOptionList;
				var index = arr.findIndex(dto => dto.goods_option_no == no);
				price += arr[index].goods_option_price;
				title = goodsOptionVOList[i].goods_option_title;
				content = arr[index].goods_option_content;
				option_price = arr[index].goods_option_price;
				
				// div에 옵션별 정보 추가
				var option_info = $("<br><span>" + title + " : " + content + "(" + addComma(option_price) + "원)" +"</span><br>");
				div.append(option_info);
				
				// div에 no 추가
				var option_no = $("<input type='hidden' name='itemVOList["+VOindex+"].option_no_list' value='"+no+"'>");
				div.append(option_no);
			});
			
			
			
			// div에 나머지 기능 추가
			var goods_name = $("<h5>" + goodsVO.goods_name + "</h5>");
			var span = $("<span class='total_price'>"+ addComma(price) + "원</span>");
			var plus = $("<a class='plus_btn' href='#'> + </a>");
			var minus = $("<a class='minus_btn' href='#'> - </a>");
			var delete_btn = $("<a class='delete_btn' href='#'>X</a>");
			
			// div에 수량 추가
			var quantity = $("<input class='quantity' name='itemVOList["+VOindex+"].quantity' type='text' value='1'>");
			
			// div에 상품번호 추가
			var hidden_goods_no = $("<input type='hidden' name='itemVOList["+VOindex+"].goods_no' value='"+goodsVO.goods_no+"'>");
			div.append(hidden_goods_no);
			
			// div에 가격 추가
			var hidden_price = $("<input class='hPrice' type='hidden' name='itemVOList["+VOindex+"].price' value='"+price+"'>");
			div.append(hidden_price);
			
			$(".selected_area").append(div);
			div.prepend(goods_name).append(span).append(quantity).append(plus).append(minus)
			.append(delete_btn).append("<hr style='margin-bottom: 0'>");
			
			// 상품+옵션 가격
			var total_price = price;
			
			
			// + 버튼
			plus.click(function(e){
				e.preventDefault();
				var qtt = $(this).siblings(".quantity").val();
				price = total_price * (parseInt(qtt)+1);
				$(this).siblings(".quantity").val(parseInt(qtt)+1);
				span.html(addComma(price) + "원");
				setFinalArea();
			});
			
			// - 버튼
			minus.click(function(e){
				e.preventDefault();
				var qtt = $(this).siblings(".quantity").val();
				if(qtt>1) {
					price = total_price * (parseInt(qtt)-1);
					$(this).siblings(".quantity").val(parseInt(qtt)-1);
					span.html(addComma(price) + "원");
					setFinalArea();
				}
			});
			
			// 수량 수정
			quantity.blur(function(){ 
				var qtt = $(this).val();
				if(qtt>=1) {
					qtty = parseInt(qtt);
					price = total_price * (parseInt(qtt));
					$(this).val(parseInt(qtt));
					span.html(addComma(price) + "원");
					setFinalArea();
				} else {
					$(this).val(1);
					qtt = 1;
					qtty = 1;
					price = total_price * (parseInt(qtt));
					span.html(addComma(price) + "원");
					setFinalArea();
				}
			});
			
			// X 버튼
			delete_btn.click(function(e){
				e.preventDefault();
				$(this).parent(".total_price_area").remove();
// 				VOindex--;
				setFinalArea();
				
				count--;
				if(count < 1) {
					$(".submit_ordering").attr("disabled",true);
					$(".add_cart_btn").attr("disabled",true);
				}
				
			});
			
			// 리셋
			$(".options").val("");
			
			// VOindex++
			VOindex++;
			
			// 총 상품금액(수량) 업데이트
			setFinalArea();
		}
		
	});
	// 장바구니
	$(".add_cart_btn").click(function(e){
		e.preventDefault();
		setFinalArea();
		//버튼 바로 위에 있는 form을 데이터화하여 전송
		var form = $(this).parents("#form_box");
		var url = "../member/addCart";
//			var data = {이름:값, 이름:값};
		var data = form.serialize();
		$.ajax({
			type: "POST",
			url: url,
			data:data,
			success: function(){
				window.alert("추가되었습니다!");
			}
		});
	});	
	
	// 총 상품금액(수량) 업데이트
	function setFinalArea(){
		var fPrice = 0;
		var fQuantity = 0;
		$(".total_price_area").each(function(){
			fQuantity += parseInt($(this).children(".quantity").val());
			fPrice += $(this).children(".hPrice").val() * parseInt($(this).children(".quantity").val());
		});
		
		$(".final_price").html(addComma(fPrice) + "원");
		$(".final_qtt").html(" ("+fQuantity+")개");
	}
	
	function addComma(num){
		var regexp = /\B(?=(\d{3})+(?!\d))/g;
		return num.toString().replace(regexp, ',');
	}
	
}); 
////////////////////문의게시판 영역///////////////
$(function(){
// '문의하기' Modal
			var qna_member = document.querySelector(".qna_member");
            
            $(".btn_q").click(function(){
                qna_member.style.display="block";
            });
            
            $(".qna_member").find(".close").click(function(){
            	qna_member.style.display="none";
            });
            
	// 문의 작성
			$(".qna_member").find("form").submit(function(e){
				e.preventDfault();
		
		    	var data = $(this).serialize();
				
		    	$.ajax({
		    		url: "insertQ",
		    		method: "post",
		    		data: data,
		    		success: function(resp){
		    			alert("문의가 등록되었습니다.");
		    		}
		    	});
		    	
		    	$(this).parents(".qna_member").hide();
		    	
			});
	// 문의 수정 및 삭제
			$(".btn_update").click(function(){
				// 수정하기 버튼을 누르면 수정모드로 전환
				if($(this).text()=="수정"){
					var contentCell = $(this).parent().prev().prev().prev();					
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
    
// '답변하기' 숨김, 보여주기
		$(".qna_seller").hide();
	
	    var btn_a = document.querySelector(".btn_a");
	    
	    var qna_head= document.querySelector(".qna_head");
	    if($(qna_head).text()=="답변완료"){
	        btn_a.style.display="none";
	    }
	    
	    $(".btn_a").click(function(){
	    	
	        if($(this).text()=="답변하기"){
	            $(this).parents().next(".qna_seller").show();
	            $(this).text("취소");
	        }
	        else{
	            $(".qna_seller").hide();
	            $(this).text("답변하기");
	        }
	    });
	    
	    $(".qna_seller").find("form").submit(function(){
	    	e.preventDefault();
	
	    	var data = $(this).serialize();
	    	
	    	$.ajax({
	    		url: "insertA",
	    		method: "POST",
	    		data: data,
	    		success: function(resp){
	    	        location.reload(true);
	    		}
	    	});
	    	
	    	$(this).parents(".qna_seller").hide();
	    });
	    $(".btn_reply").click(function(){
	    	
	        if($(this).text()=="댓글쓰기"){
	        	$(this).parents().next(".reply").show();
	            $(this).text("취소");
	        }
	        else{
	            $(".reply").hide();
	            $(this).text("댓글쓰기");
	        }
	        
	    });
	    	    
});



///////// 문의,리뷰게시판 tab
	function tabView(event, tabName){

		// tab_content 숨김처리
		var tab_content = document.querySelector(".tab_content");

		for(var i=0 ; i<tab_content.length ; i++){
			tab_content[i].style.display = "none";
		}
		
		// tab 불러와서 초기화
		var tab_links = document.querySelector(".tab_links");
		for(var i=0 ; i<tab_links.length ; i++){
			tab_links[i].className = tab_links[i].className.replace(" active", "");
		}
		
		document.getElementById(tabName).style.display = "block"; // 해당 tab_content만 보여주기
		event.currentTarget.className += "active"; // 이벤트로 클릭한 탭 활성화
	};

</script>
<style>
.final_price, .final_qtt {
	font-size: 1.5rem;
	font-weight: 600;
}
.total_price {
	font-size: 1rem;
}
.table th, .table td{
	border: none;
}
.quantity {
	margin-left:130px;
	width: 50px;
}
.total_price_area {
	margin: 15px 0px;
}
.plus_btn {
	color: black;
	font-size: 1.5rem;
	margin-left: 10px;
	margin-right: 3px;
}
.minus_btn {
	color: black;
	font-size: 2rem;
	margin-right: 3px;
}
.delete_btn {
	color: black;
	font-size: 1.2rem;
}
.total_area {
	margin-bottom: 15px;
}

.mainImage_box {
	padding: 10px;
	width: 100%;
	height: auto;
}
.mainImage_box > img {
	width: 100%;
	height: auto;
}
.contentImage_box {
	width: 100%;
	height: 100px;
}
.contentImage_box > img {
	width: 150px;
	height: 100px;
	margin: 5px;
}
.options {
	margin-left: 10px;
}

.submit_ordering {
	height:40px;
	font-size: 0.9rem;
}

.add_cart_btn {
	height:40px;
	font-size: 0.9rem;
}
 
.one_btn {
	height:40px;
	font-size: 0.9rem;
}

.btn_area {
	padding: 0px 5px;
}

.options {
	width: 40%;
}

.goods_info_section{
	margin: 30px 0px;
}

</style>
<article>
<section class="goods_info_section">
	<form id="form_box" action="../order/order" method="POST">
	<hr>
	<div class="row justify-content-center">
	<div class="detail_area col-lg-8">
		<div class="row">
			<div class="col-lg-6">
				<div class="mainImage_box">
					<img class="rounded" src="${pageContext.request.contextPath}/goods/mainImageDown?files_no=${files_no}">
				</div>
				<div class="contentImage_box">
					<c:forEach var="content_files" items="content_files_list">
						<img class="rounded" src="${pageContext.request.contextPath}/goods/mainImageDown?files_no=${files_no}">
					</c:forEach>
				</div>
			</div>		
			<div class="col-lg-6">
				<div class="goods_title_area">
					<h3>${goodsVO.goods_name}</h3>
				</div>
				<div class="row">
					<table class="table">
						<tbody>
						<tr>
							<th width="20%">상품명</th>
							<th><span>${goodsVO.goods_name}</span></th>
							<th></th>
						</tr>
						<tr>
							<th>판매가</th>
							<th colspan="2">
							<fmt:formatNumber pattern="###,###,###" type="number">
							${goodsVO.goods_price}
							</fmt:formatNumber>
							원
							</th>
						</tr>
						<tr>
							<td>적립금</td>
							<td colspan="2">
							<fmt:formatNumber pattern="###,###,###" type="number">
							${goodsVO.goods_price/100*rate}
							</fmt:formatNumber> 원
							</td>
						</tr>
						</tbody>
					</table>
					<div class="option_area col-12">
						<c:forEach items="${goodsOptionVOList}" var="goodsOptionVO" varStatus="status">
							<p>${goodsOptionVO.goods_option_title}</p>
							<select class="options form-control">
								<option value="">선택</option>
								<c:forEach items="${goodsOptionVO.goodsOptionList}" var="goodsOptionDto">
									<option value="${goodsOptionDto.goods_option_no}">${goodsOptionDto.goods_option_content}(${goodsOptionDto.goods_option_price})</option>
								</c:forEach>
							</select>
							<hr>
						</c:forEach>
					</div>
				</div>
					<div class="selected_area row">
					</div>
				<div class="row">
					<div class="total_area col-12">
						<h4>총 상품금액(수량)</h4>
						<span class="final_price">0원 </span><span class="final_qtt">(0개)</span>
				</div>
					</div>
				<div class="row">
					<div class="col-4 btn_area">
						<input class="submit_ordering btn btn-primary btn-block" type="submit" value="주문하기" disabled>
					</div>
					<div class="col-4 btn_area">
						<button class="add_cart_btn btn btn-primary btn-block" disabled>장바구니</button>
					</div>
					<div class="col-4 btn_area">
						<span>
							<c:choose>
								<c:when test="${member_id !=null }">
									<a class="alink" href="${pageContext.request.contextPath}/member/customOrder?seller_no=${goodsVO.seller_no }">
										<button class="one_btn btn btn-primary btn-block">1:1 요청서</button>
									</a>
								</c:when>
								<c:otherwise>
									<a class="alink" href="${pageContext.request.contextPath}/member/login">
										<button class="one_btn btn btn-primary btn-block">1:1 요청서</button>
									</a>
								</c:otherwise>
							</c:choose>
						</span>
					</div>
				</div>
			</div>		
		</div>
	</div>
	</div>
	</form>
	<hr>
	<br>
</section>
</article>
<!-- --------------------------------------------------- -->
<div class="tab">
<!-- 	<button class="tab_links active" onclick="tabView(event, 'tab1')">문의하기</button> -->
<!-- 	<button class="tab_links" onclick="tabView(event, 'tab2')">리뷰</button> -->
	<span><a href="#">상품정보</a></span>&verbar;
	<span><a href="#tab2">문의하기</a></span>&verbar;
	<span><a href="#tab3">리뷰</a></span>
</div>

<article class="articleBox">
<div id="tab2" class="tab_content">
	<div class="row-empty-20"></div>
	<div class="qnaBox">
		
		<c:choose>
        <c:when test="${member_id !=null }">
        	<button class="btn_q btn_custom">문의하기 </button>
        </c:when>
        <c:otherwise>
        	<a href="${pageContext.request.contextPath}/member/login"><button class="btn_custom">문의하기</button></a>	        
        </c:otherwise>
        </c:choose>
		<hr>
		
        <fieldset>
        <div class="modal qna_member" style="display:none;">  <!-- 회원 입력 -->
			<div class="modal-dialog" role="document">
		        <form action="insertQ" method="post">
					<div class="modal-content">
						<div class="modal-header">
			        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          			<span aria-hidden="true">&times;</span>
			        		</button>
						</div>
						<div class="modal-body">
								<input type="hidden" name="seller_no" value="${goodsVO.seller_no }">
								<input type="hidden" name="goods_no" value="${goodsVO.goods_no }">
								<select name="goods_qna_head" class="form-control" required>
									<option value="상품문의">상품문의</option>
									<option value="배송문의">배송문의</option>
								</select>
								<br>
								<textarea name="goods_qna_content" class="form-control" required></textarea><br>
								<br>
								<h6> &middot; 개인정보(주민번호, 연락처, 주소, 계좌번호, 카드번호 등)가 타인에게 노출되지 않도록 주의해 주시기 바랍니다.</h6>
								<h6> &middot; 문의와 관련없는 비방, 광고, 불건전한 내용 등이 포함될 경우 사전동의 없이 삭제될 수 있습니다.</h6>
			      		</div>
			      		<div class="modal-footer">
							<input type="submit" value="문의하기" class="btn_custom">
						</div>
					</div>
				</form>
			</div>
		</div>
	
		<table style="width:100%;" border="1" class="table table-hover"> <!-- 문의 목록 -->
			<colgroup>
				<col width="13%"/>
				<col width="50%"/>
				<col width="10%"/>
				<col width="15%"/>
				<col width="12%"/>
			</colgroup>
			<thead>
				<tr align="center">
					<th></th>
					<th>문의내용</th>
					<th>작성자</th>
					<th>작성일</th>
					
				</tr>
			</thead>
			<tbody>
				<c:forEach var="qna" items="${goodsQna }">
				<c:choose>
					<c:when test="${qna.goods_qna_superno != 0 }">
					<tr> <!-- 판매자 답변 목록 -->
						<td></td>
						<td>[${qna.goods_qna_head }] ${qna.goods_qna_content }</td>
						<td>${qna.goods_qna_writer }</td>
						<td>${qna.goods_qna_date }</td>
						<td></td>
					</tr>
					</c:when>
					<c:otherwise>
					<tr>	<!-- 구매자 문의 목록 -->
						<td>${qna.goods_qna_head }</td>
						<td>${qna.goods_qna_content }</td>
						<td>${qna.goods_qna_writer }</td>
						<td>${qna.goods_qna_date }</td>
						<%-- 문의 작성자와 로그인한 member_id가 같을 때 --%>
						<c:if test="${qna.member_no == member_no && empty qna.goods_qna_status}">
							<td data-goods_no = "${goodsVO.goods_no }"
									data-goods_qna_no="${qna.goods_qna_no }"
									data-member_no="${qna.member_no }" style="border-right: none;">
									<button class="btn_update btn_clean">수정</button>
									<button class="btn_delete btn_clean">삭제</button>
							</td>
						</c:if>
						<%-- 상품의 seller_no와 로그인한 seller_no가 같을 때 --%>
						<c:if test="${not empty seller_no && goodsVO.seller_no == seller_no }" >
							<c:if test="${empty qna.goods_qna_status }">
								<td><button class="btn_a btn_clean">답변하기</button></td>
							</c:if>
						</c:if>
						<c:set var="status" value="${qna.goods_qna_status}"></c:set>
						<c:if test="${functions : contains(status, '답변완료') }">
							<td>답변완료</td>
						</c:if>
					</tr>
					</c:otherwise>
				</c:choose>
					
				<tr class="qna_seller"> <!-- 판매자 입력 -->
					<td colspan="5">
						<form action="insertA" method="post">
							<input type="hidden" name="seller_no" value="${goodsVO.seller_no }">
							<input type="hidden" name="goods_no" value="${goodsVO.goods_no }">
							<input type="hidden" name="goods_qna_groupno" value="${qna.goods_qna_groupno }">
							<input type="hidden" name="goods_qna_no" value="${qna.goods_qna_no }">
							<br>
							<textarea class="form-control" name="goods_qna_content" required></textarea><br>
							<input type="submit" value="답변하기" class="btn_custom">
						</form>
					</td>
				</tr>
				
				</c:forEach>
			</tbody>
		</table>
		</fieldset>
		<!-- 페이징 내비게이터 -->
		<div class="row justify-content-center">
			<ul class="pagination">
				<c:if test="${paging.startBlock > 1 }">
					<li class="page-item">
		     			 <a class="page-link" href="${pageContext.request.contextPath}/goods/goodsInfo?goods_no=${goodsVO.goods_no}&pageNo=${paging.startBlock-1}">&laquo;</a>
		   			 </li>
				</c:if>
				<c:forEach begin="${paging.startBlock }" end="${paging.finishBlock }" var="p">
					<c:choose>
						<c:when test="${p == paging.pno }">
							<li class="page-item active">
		   					   <a class="page-link" >${p }</a>
		   					 </li>
						</c:when>
						<c:when test="${p != paging.pno }">
							<li class="page-item active">
		      					<a class="page-link" href="${pageContext.request.contextPath}/goods/goodsInfo?goods_no=${goodsVO.goods_no}&pageNo=${p}">${p }</a>
		   					 </li>
						</c:when>
					</c:choose>
				</c:forEach>
				<c:if test="${paging.finishBlock < paging.pagecount}">
					<li class="page-item">
		     			 <a class="page-link" href="${pageContext.request.contextPath}/goods/goodsInfo?goods_no=${goodsVO.goods_no}&pageNo=${paging.finishBlock+1}">&raquo;</a>
		    		</li>
				</c:if>
			</ul>	
		</div>
		<!-- 내비게이터 영역 끝 -->
    </div>
</div>	
<hr>

<!-- ----------------------------------------------------------------------- -->

<div id="tab3" class="tab_content">
	<div class="row-empty-20"></div>
	<p class="reviewBox" style="border:0;">&mid; 리뷰 &mid;</p>
	<div class="row-empty-20"></div>
	<c:forEach var="review" items="${goodsReview }">
	<table class="reviewBox">
		<tr>
			<td class="star" colspan="2">
				<div class="star-wrap" data-limit="5" data-unitsize="20" data-point="${review.goods_review_star}" data-image="http://www.sysout.co.kr/file/image/288" data-readonly></div>
			</td>
		</tr>
		<tr>
			<td width="150px">${review.goods_review_writer }</td>
			<td width="" align="right">
				<fmt:parseDate value="${review.goods_review_date }" var="review_date" pattern="yyyy-MM-dd HH:mm:ss"/>
				<fmt:formatDate value="${review_date }" pattern="yyyy/MM/dd HH:mm:ss"/>
			</td>
		</tr>
		<c:if test="${ not empty filesVO }">
			<tr>
				<td colspan="2">
				<c:forEach var="filesVO" items="${filesVO }">
				<c:if test="${review.goods_review_no==filesVO.goods_review_no }">
					<img src="http://localhost:8080/ordering/member/reviewFile?files_no=${filesVO.files_no}" width=100px; height=100px;>
				</c:if>
				</c:forEach>
				</td>
			</tr>
		</c:if>
		<tr>
			<td colspan="2">${review.goods_review_content }</td>
		</tr>
		<!-- 리뷰댓글 영역 시작 -->
		<tr> 
			<td colspan="2">
				<c:choose>
		        <c:when test="${member_id !=null }">
		        	&or;<button class="btn_reply btn_clean">댓글쓰기</button>
		        </c:when>
		        <c:otherwise>
		        	&or;<a href="${pageContext.request.contextPath}/member/login"><button class="btn_clean">댓글쓰기</button></a>	        
		        </c:otherwise>
		        </c:choose>
			</td>
		</tr>
		<tr class="reply" style="display:none;">
			<td colspan="2">
				<form action="insertReply" method="post">
					<input type="hidden" name="goods_review_no" value="${review.goods_review_no }">
					<input type="hidden">
					<textarea name="goods_review_reply_content" class="form-control" required></textarea>
					<br>
					<p align="right"><input type="submit" value="댓글등록" class="btn_custom"></p>					
				</form>
				</td>
		</tr>
		<c:forEach var="reviewReply" items="${reviewReply }">
			<c:if test="${review.goods_review_no==reviewReply.goods_review_no }">
			<tr>
				<td colspan="2" style="padding: 0 12px;">
					<div class="replyBox">
							<span>${reviewReply.goods_review_reply_writer }</span>
							<span style="float:right;">
								<fmt:parseDate value="${reviewReply.goods_review_reply_date }" var="reply_date" pattern="yyyy-MM-dd HH:mm:ss"/>
								<fmt:formatDate value="${reply_date }" pattern="yyyy/MM/dd HH:mm:ss"/>							
							</span>
							<div class="reply_content">${reviewReply.goods_review_reply_content }</div>
					</div>
				</td>
			</tr>
			</c:if>
		</c:forEach>
		<!-- 리뷰댓글영역 끝 -->
	</table>
	<br>
	</c:forEach>
	<!-- 페이징 내비게이터 -->
		<div class="row justify-content-center">
			<ul class="pagination">
				<c:if test="${paging.startBlock > 1 }">
					<li class="page-item">
		     			 <a class="page-link" href="${pageContext.request.contextPath}/goods/goodsInfo?goods_no=${goodsVO.goods_no}&reviewPage=${paging.startBlock-1}">&laquo;</a>
		   			 </li>
				</c:if>
				<c:forEach begin="${paging.startBlock }" end="${paging.finishBlock }" var="p">
					<c:choose>
						<c:when test="${p == paging.pno }">
							<li class="page-item active">
		   					   <a class="page-link" >${p }</a>
		   					 </li>
						</c:when>
						<c:when test="${p != paging.pno }">
							<li class="page-item active">
		      					<a class="page-link" href="${pageContext.request.contextPath}/goods/goodsInfo?goods_no=${goodsVO.goods_no}&reviewPage=${p}">${p }</a>
		   					 </li>
						</c:when>
					</c:choose>
				</c:forEach>
				<c:if test="${paging.finishBlock < paging.pagecount}">
					<li class="page-item">
		     			 <a class="page-link" href="${pageContext.request.contextPath}/goods/goodsInfo?goods_no=${goodsVO.goods_no}&reviewPage=${paging.finishBlock+1}">&raquo;</a>
		    		</li>
				</c:if>
			</ul>	
		</div>
		<!-- 내비게이터 영역 끝 -->
</div>

</article>

<div class="row-empty-40"></div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>