<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">       

<script>
	$(".btn-delete").click(function()){
		$(this).parent().parent().remove();
		
		var td = $(this).parent();
		var admin_qna_no = td.data("admin-qna-no");
		
		$.ajax({
			url:"deleteqna",
			type:"post",
			data{
				"admin_qna_no":admin_qna_no
				
			},
				success:function(reps){
		})
	
	});
</script>

<h1>문의 게시판 상세보기</h1>
<h1><a href="${pageContext.request.contextPath}/home">홈으로</a></h1>

<hr>
<h1>제목:${qnaone.admin_qna_title}</h1>
<h1>회원등급:${qnaone.admin_qna_usertype}</h1>
<h1>작성자:${qnaone.admin_qna_writer}</h1>
<h1>작성일:${qnaone.admin_qna_date}</h1>
<hr>
<hr>
<h3>내용:${qnaone.admin_qna_content}</h3>
<hr>
<div class="btn-group-vertical">
	<a href="${pageContext.request.contextPath}/board/editqna?admin_qna_no=${qnaone.admin_qna_no}">
		<button type="button">수정</button>
	</a>
</div> 
<br><br>
<div class="btn-group-vertical">
	<a href="${pageContext.request.contextPath}/board/deleteqna?admin_qna_no=${qnaone.admin_qna_no}">
		<button type="button" class="btn-delete">삭제</button>
	</a>
</div> 