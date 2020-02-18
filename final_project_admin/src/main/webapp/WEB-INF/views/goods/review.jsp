<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style></style>
    <script src="https://cdn.jsdelivr.net/gh/hiphop5782/js/star/hakademy-star.min.js"></script>
    <script>
        window.addEventListener("load", function(){
            Hakademy.PointManager.factory(".star-wrap");
        });
    </script>
<h1>${param.goods_name } 상품리뷰보기</h1>
<c:forEach var="list" items="${list }">
	<hr>
	<div>리뷰</div>
	<div>작성자 : ${list.goods_review_writer}  리뷰 일시 : ${list.goods_review_date} </div>
    <div class="star-wrap" data-limit="5" data-unitsize="20" data-point="${list.goods_review_star}" data-image="http://www.sysout.co.kr/file/image/288" data-readonly></div><br>
	<div>리뷰 내용${list.goods_review_content}</div>
	<c:choose>
		<c:when test="${list.goods_review_reply_no > 0 }">
			<hr>
			<div>--->답변</div>
			<div>		답변자 : ${list.goods_review_reply_writer} 답변 일시 : ${list.goods_review_reply_date}</div>
			<div>		${list.goods_review_reply_content}</div>
		</c:when>
	</c:choose>
</c:forEach>
