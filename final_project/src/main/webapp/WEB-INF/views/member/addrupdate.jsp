<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>배송지 수정하기</h1>

<form action="addrUpdate" method="post">
	<input type="hidden" name="member_addr_no" value="${addrupdateget.member_addr_no}">

	<table border="1" width="70%">

		<tr>
			<td>
				<input type="text" name="member_name_extra" value="${memberget.member_name_extra}" required>
			</td>
		</tr>
		<tr>
			<td>
				<input type="text" name="member_addr_post" value="${memberget.member_addr_post}" required>
			</td>
		</tr>
		<tr>
			<td>
				<input type="text" name="member_addr_basic" value="${memberget.member_addr_basic}" required>
			</td>
		</tr>
		<tr>
			<td>
				<input type="text" name="member_addr_extra" value="${memberget.member_addr_extra}" required>
			</td>
		</tr>
		<tr>
			<td>
				<input type="text" name="member_addr_status" value="${memberget.member_addr_status}" required>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="배송지수정">


		</tr>

	</table> 