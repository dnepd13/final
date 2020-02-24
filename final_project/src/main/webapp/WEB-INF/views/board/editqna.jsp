<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h1>문의 수정하기</h1>

<form action="editqna" method="post">
	<input type="hidden" name="admin_qna_no" value="${updateget.admin_qna_no }">

	<table border="1" width="70%">

		<tr>
			<th>제목</th>
			<td>
				<input type="text" name="admin_qna_title" value="${updateget.admin_qna_title}" required>
			</td>
		</tr>
		<tr>
			<td colspan="2" >
				<textarea name="admin_qna_content" rquired rows="15" cols="100"
					style="resize:vertical;">${updateget.admin_qna_content}</textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="수정">


		</tr>

	</table>

</form> 