<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="functions" uri="http://java.sun.com/jsp/jstl/functions" %>


<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<%-- <script src="${pageContext.request.contextPath}/resources/js/goodsInfo.js"></script> --%>
<script>

$(function(){
	var goodsOptionVOList = JSON.parse('${jsonGoodsOptionVOList}');
	var goodsVO = JSON.parse('${jsonGoodsVO}');
	var VOindex = 0;
	var final_price = 0;
	var final_qtt = 0;
	var count = 0;
	
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
			
			var price = goodsVO.goods_price;
			var title;
			var content;
			var option_price;
			var option_no_list = new Array();
			var qtty;
			
			var div = $("<div class='total_price_area'></div>"); // 선택 상품+옵션 그룹div
			
			div.append($("<h4>선택한 옵션</h4>"));
			
			// 옵션 선택 정보 저장 (옵션번호리스트, 가격합계)
			$(".options").each(function(i){
				var no = $(this).val();
				var arr = goodsOptionVOList[i].goodsOptionList;
				var index = arr.findIndex(dto >= dto.goods_option_no == no);
				price += arr[index].goods_option_price;
				title = goodsOptionVOList[i].goods_option_title;
				content = arr[index].goods_option_content;
				option_price = arr[index].goods_option_price;
				
				// div에 옵션별 정보 추가
				var option_info = $("<h5>" + title + " : " + content + "(" + addComma(option_price) + "원)" +"</h5>");
				div.append(option_info);
				
				// div에 no 추가
				var option_no = $("<input type='hidden' name='itemVOList["+VOindex+"].option_no_list' value='"+no+"'>");
				div.append(option_no);
			});
			
			
			
			// div에 나머지 기능 추가
			var goods_name = $("<h3>" + goodsVO.goods_name + "</h3>");
			var span = $("<span class='total_price'>"+ addComma(price) + "원</span>");
			var plus = $("<a class='plus_btn' href='#'> + </a>");
			var minus = $("<a class='minus_btn' href='#'> - </a>");
			var delete_btn = $("<a class='delete' href='#'>X</a>");
			
			// div에 수량 추가
			var quantity = $("<input class='quantity' name='itemVOList["+VOindex+"].quantity' type='text' value='1'>");
			
			// div에 상품번호 추가
			var hidden_goods_no = $("<input type='hidden' name='itemVOList["+VOindex+"].goods_no' value='"+goodsVO.goods_no+"'>");
			div.append(hidden_goods_no);
			
			// div에 가격 추가
			var hidden_price = $("<input class='hPrice' type='hidden' name='itemVOList["+VOindex+"].price' value='"+price+"'>");
			div.append(hidden_price);
			
			$(".selected_area").append(div);
			div.append(goods_name).append(span).append(quantity).append(plus).append(minus)
			.append(delete_btn);
			
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
				if(qtt>0) {
					price = total_price * (parseInt(qtt)-1);
					$(this).siblings(".quantity").val(parseInt(qtt)-1);
					span.html(addComma(price) + "원");
					setFinalArea();
				}
			});
			
			// 수량 수정
			quantity.blur(function(){ 
				var qtt = $(this).val();
				if(qtt>=0) {
					qtty = parseInt(qtt);
					price = total_price * (parseInt(qtt));
					$(this).siblings(".quantity").val(parseInt(qtt));
					span.html(addComma(price) + "원");
					setFinalArea();
				}
			});
			
			// X 버튼
			delete_btn.click(function(e){
				e.preventDefault();
				$(this).parent(".total_price_area").remove();
				VOindex--;
				setFinalArea();
				
				count--;
				if(count < 1) $(".submit_ordering").attr("disabled",true);
			});
			
			// 리셋
			$(".options").val("");
			
			// VOindex++
			VOindex++;
			
			// 총 상품금액(수량) 업데이트
			setFinalArea();
		}
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

//////////////////// 문의게시판 영역///////////////
$(function(){
	// '문의하기' 보여주기
            var qna_member = document.querySelector(".qna_member");
            
            $(".btn_q").click(function(){
                if($(this).text()=="문의하기"){
                    qna_member.style.display="block";
                    $(this).text("취소");
                }
                else{
                    qna_member.style.display="none";
                    $(this).text("문의하기");
                }
            });
            
	$(".qna_member").find("form").submit(function(e){
		e.preventDfault();
		
		var url=$(this).attr("action");
    	var method=$(this).attr("method");
    	var data = $(this).serialize();
		
    	$.ajax({
    		url: url,
    		method: method,
    		data: data,
    		success: function(resp){
    			 alert("문의 등록 완료");
    		}
    	});
    	
    	$(this).parents(".qna_member").hide();
    	
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
//     	e.preventDefault();
    	
//     	var url=$(this).attr("action");
//     	var method=$(this).attr("method");
//     	var data = $(this).serialize();
    	
//     	$.ajax({
//     		url: url,
//     		method: method,
//     		data: data,
//     		success: function(resp){
// //     	        alert("답변 등록 완료");
//     		}
//     	});
    	
    	$(this).parents(".qna_seller").hide();
    });
        
});

</script>

<style>
/*	qna style */
	.qna {
		width: 80%
	}
	.qna_member textarea {
		resize: none;
		width: 100%;
	}
	.qna_seller textarea,
	.updateQ textarea {
		resize: none;
		width: 100%;
	}
</style>
<article>
<h1>상품 상세 페이지</h1>

<p>상품 상세 내용(goods_content)</p>
<p>${goodsVO.goods_content}</p>
<hr>
<br>

<span>
	<c:choose>
		<c:when test="${member_id !=null }">
			<a href="${pageContext.request.contextPath}/member/customOrder?seller_no=93">1:1 요청서</a>
		</c:when>
		<c:otherwise>
			<a href="${pageContext.request.contextPath}/member/login">1:1 요청서</a>
		</c:otherwise>
	</c:choose>
</span>

<hr>
<form action="../order/order" method="POST">
<!-- 옵션 선택하는 부분----------------------------------------->
<h1>옵션선택</h1>
<div class="option_area">
	<c:forEach items="${goodsOptionVOList}" var="goodsOptionVO" varStatus="status">
		<span>${goodsOptionVO.goods_option_title} : </span>
		<select class=options>
			<option value="">선택</option>
			<c:forEach items="${goodsOptionVO.goodsOptionList}" var="goodsOptionDto">
				<option value="${goodsOptionDto.goods_option_no}">${goodsOptionDto.goods_option_content}(${goodsOptionDto.goods_option_price})</option>			
			</c:forEach>
		</select>
		<br>
	</c:forEach>
</div>
<!-- --------------------------------------------------- -->
<hr>
<div class="selected_area">
	<h1>상품+옵션 선택 내용</h1>
</div>

<input class="submit_ordering" type="submit" value="주문하기" disabled="true">
</form>
<hr>
<div class="total_area">
<h1>총 상품금액(수량)</h1>
<span class="final_price">0원 </span><span class="final_qtt">(0개)</span>
</div>
<hr>
<!-- --------------------------------------------------- -->
<section>
<p>상품 문의</p>
	<div class="qna">
		<c:choose>
        <c:when test="${member_id !=null }">
        		<button class="btn_q">문의하기 </button>
        </c:when>
        <c:otherwise>
        	<a href="${pageContext.request.contextPath}/member/login"><button>문의하기</button></a>	        
        </c:otherwise>
        </c:choose>
        
		<div class="qna_member" style="display:none;"> <!-- 회원 입력 -->
			<form action="insertQ" method="post">
				<input type="hidden" name="seller_no" value="${goodsVO.seller_no }">
				<input type="hidden" name="goods_no" value="${goodsVO.goods_no }">
				<select name="goods_qna_head" required>
					<option value="상품문의">상품문의</option>
					<option value="배송문의">배송문의</option>
				</select>
				<br>
				글내용<br>
				<textarea name="goods_qna_content" required></textarea><br>
				<input type="submit" value="문의하기">
			</form>
				<p> &middot; 개인정보(주민번호, 연락처, 주소, 계좌번호, 카드번호 등)가 타인에게 노출되지 않도록 주의해 주시기 바랍니다.</p>
				<p> &middot; 문의와 관련없는 비방, 광고, 불건전한 내용 등이 포함될 경우 사전동의 없이 삭제될 수 있습니다.</p>
		</div>
	
		<table> <!-- 문의 목록 -->
			<thead>
				<tr>
					<th></th>
					<th>문의내용</th>
					<th>작성자</th>
					<th>작성일</th>
					<th></th>
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
						<td class="qna_head">${qna.goods_qna_head }</td>
						<td class="qna_content">${qna.goods_qna_content }</td>
						<td>${qna.goods_qna_writer }</td>
						<td>${qna.goods_qna_date }</td>
						<%-- 문의 작성자와 로그인한 member_id가 같을 때 --%>
						<c:if test="${qna.goods_qna_writer == member_id}">
							<td><button class="btn_update">수정</button>
									<button class="btn_delete">삭제</button>
							</td>
						</c:if>
						<%-- 상품의 seller_no와 로그인한 seller_no가 같을 때 --%>
						<c:if test="${seller_no ==goodsVO.seller_no }">
							<c:if test="${empty qna.goods_qna_status }">
								<td><button class="btn_a">답변하기</button></td>
							</c:if>
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
							<textarea name="goods_qna_content" required></textarea><br>
							<input type="submit" value="답변하기">
						</form>
					</td>
				</tr>
				
				</c:forEach>
			</tbody>
		</table>

		<!-- 내비게이터 -->
		<div>
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
    </div>
<hr>
</section>	
<section>
<p>리뷰</p>
<hr>
</section>
</article>