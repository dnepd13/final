<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h1>회원정보 수정하기</h1>

<h1><a href="/ordering/member/memberinfo">내 정보 보기로 이동</a></h1>

<form action="editmember" method="post">
	<input type="hidden" name="member_no" value="${memberget.member_no}">

	<table border="1">

		<tr>
			<td>
				<input type="text" name="member_email" value="${memberget.member_email}" required>
			</td>
		</tr>
		<tr>
			<td>
				<input type="text" name="member_phone" value="${memberget.member_phone}" required>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="회원수정">
			</td>

		</tr>

	</table> 
</form>	