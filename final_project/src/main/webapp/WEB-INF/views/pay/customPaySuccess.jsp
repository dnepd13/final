<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	결제에 성공하였습니다.
	<a href="${pageContext.request.contextPath }"><button>메인페이지</button></a>
	<a href="${pageContext.request.contextPath }/member/cartDetailPay?partner_order_id=${patner_order_id }"><button>결제내역 확인</button></a>
	결제내역은 추후 결제내역 상세페이지에서 확인하도록 하기. patner_order_id: ${patner_order_id }
</body>
</html>