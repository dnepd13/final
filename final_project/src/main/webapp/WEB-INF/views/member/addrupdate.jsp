<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    

<!-- 배송지 수정 게시판 -->  

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">   

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

<style>
	* {box-sizing: border-box;}
	.myInfo_wrap {
		width: 1200px;
		height: 800px;
		margin: 0 auto;
	}
	.addr_wrap {
		float: left;
		margin-left: 60px;
		padding-top: 100px;
		width: 900px;
	}
	.addr_wrap::after{content:""; display: block; clear:both;}
	.addr_main {
		margin: 0 auto;
		width: 90%;
		height: 50px;
		border-bottom: 2px solid #F3F5F8;
	}
	.addr_mainBox1 {
		width: 200px;
		height: auto;
		padding-top: 10px;
		margin-left: 30px;
		float: left;
		font-size: large; 
	}
	.addr_mainBox3 {
		width: 307px;
		height: 100%;
		padding-top: 35px;
		padding-left: 25px;
		margin-left: 500px;
		font-size: x-large; 
/* 		background: #F3F5F8; */
	}
	.addr_mainBox3 ::after {
		content="";
		display: block;
		clear: both;	
	}
	.addr_list {
		margin: 30px auto;
		width: 90%;
	}
	
	table thead {background: #F3F5F8; }
	table thead tr {
		border-top: 2px solid gray;
		text-align: center;
	}
	table tbody td{
		text-align: left;
	}
	
	.btn_area {
		margin: 0 auto;
		width: 90%;
	}

</style>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>

<div class="myInfo_wrap">
<jsp:include page="/WEB-INF/views/template/memberInfoAside.jsp"/>
	<div class="addr_wrap">
		<div class="addr_main">
			<div class="addr_mainBox1">
				내 주소 관리
			</div>
		</div>
		<div class="addr_list">
			<form action="addrupdate" method="post">
			<table class="table" border="1">
				<colgroup>
					<col width=100px;>
					<col width=500px;>
					<col width=100px;>
					<col width=100px;>
				</colgroup>
				<thead>
					<tr>
			      		<th scope="col">받는사람</th>
			      		<th scope="col">주소</th>
			      		<th scope="col" colspan="2">구분</th>
			    	</tr>
				</thead>
				<tbody>
					<tr>
						<td scope="row">
							<input type="hidden" name="member_addr_no" value="${addrupdateget.member_addr_no}">
							<input type="text" name="member_name_extra" value="${addrupdateget.member_name_extra}"  required>
						</td>
						<td scope="row">
							<input type="text" name="member_addr_post" id="sample6_postcode" value="${addrupdateget.member_addr_post}" required>
							<button type="button" class="btn_custom btn_findPost" onclick="sample6_execDaumPostcode()">우편번호 찾기</button>
							<input type="text" name="member_addr_basic" id="sample6_address" value="${addrupdateget.member_addr_basic}"  required><br>
							<input type="text" name="member_addr_extra" id="sample6_extraAddress" value="${addrupdateget.member_addr_extra}"  required>
						</td>
						<td scope="row" style="text-align: center; border-right-style: none; padding: 25px 0;">
									${addrupdateget.member_addr_status} <br>
						</td>
						<td scope="row" style="text-align: center; border-left-style: none;">
							<input type="submit" class="btn_custom" value="수정">
							<a href="${pageContext.request.contextPath }/member/addrinfo"><input type="button" class="btn_custom" value="취소"></a>
						</td>
					</tr>
				
			  </tbody>
			</table>  
			</form>
		</div>
	</div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"/>