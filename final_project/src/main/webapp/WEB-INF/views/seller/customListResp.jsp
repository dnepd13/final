<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
 <script src="https://cdn.jsdelivr.net/gh/hiphop5782/js/toast/hakademy-toast.min.js"></script>
     <script>
        Hakademy.util.toast.initializeOnLoad({
            duration:2,//메시지 출력 시간(초)
            position:"bottom-right",//출력 위치 : top, bottom, right, left 또는 혼합
            positionStyle:"nonblock",//출력스타일(block/nonblock)
            backgroundColor:"rgba(0,0,0,0.5)",//배경색(css style)
            fontColor:"white",//글자색(css style)
            fontSize:10,//글자크기(px)
            fontFamily:null,//글꼴(css style)
            isBorderRounded:true,//둥근 테두리
            isFade:true,//페이드 인/아웃 적용여부
        }); 
    </script>

    <script src="https://code.jquery.com/jquery-latest.js"></script>
    <script>
        $(function(){
            $("button.toast").click(function(){
                var option = {
                    
                };

                var text = $("input[name=alarm]").val();
                Hakademy.toast.set(option);
                Hakademy.toast.push("알림알림");
            });
        });
    </script> 
    
<button class="toast"></button>

<h3>판매자가 보낸 견적서 customListResp.jsp</h3>

<a href="remove">임시 세션지우기</a> &#124; 
<a href="customListReq">받은 요청서</a>
<h4>확인 안 한 요청서 몇 개냐: <span class="alarm">${customAlarm } 개</span></h4>	

<h4>보낸 견적서</h4>
<c:forEach var="sellerCustom" items="${getListResp }">
	<div>
	글번호: ${sellerCustom.custom_order_no }
	제목: <a href="customInfoResp?seller_custom_order_no=${sellerCustom.seller_custom_order_no }">
						${sellerCustom.custom_order_title }
			</a> <br>	
	작성일: ${sellerCustom.custom_order_date } <br>
	<hr>
	</div>
</c:forEach>

<div>
	<ul class="pagination">
		<c:if test="${paging.startBlock > 1 }">
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/seller/customListResp?pageNo=${paging.startBlock-1}">&laquo;</a>
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
      					<a class="page-link" href="${pageContext.request.contextPath}/seller/customListResp?pageNo=${p}">${p }</a>
   					 </li>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.finishBlock < paging.pagecount}">
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/seller/customListResp?pageNo=${paging.finishBlock+1}">&raquo;</a>
    		</li>
		</c:if>
	</ul>
</div>

