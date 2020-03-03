<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<h1>회원 문의 글쓰기</h1>

<form action="qnaregist" method="post">
	<input type="text" name="admin_qna_title" placeholder="문의 제목을 적어주세요" required>
	<br><br>
	<textarea name="admin_qna_content" rows="5" placeholder="문의 내용을 적어주세요" required></textarea>
	<input type="submit" value="문의작성">
</form> 