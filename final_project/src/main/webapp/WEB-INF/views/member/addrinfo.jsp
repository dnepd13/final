<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
	
 /*추가 modal 전체 스타일 */
 	.modal {
 		display: none;
 		z-index: 1;
 		top: 0;
 		bottom: 0;
 		letf: 0;
 		right: 0;
 		background-color: rgba(0,0,0,0.3);
 	}
 	
 /* modal 내부 컨텐츠 스타일 */
 	#sample6_postcode {
 		float: left;
 	}
 	.btn_findPost {
		position: relative;
		border-radius: 2px;
		margin-left: 10px;
		margin-top: 3px;
	}
	.btn_findPost::after {
		content: "";
		display: block;
		clear: both;
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

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<script>
	$(function(){
		var insert_modal = document.querySelector(".insert_modal");

		$(".btn_addrExtra").click(function(){
			var data = $(this).parents().children().find(".member_no").data("member_no");

			// 비동기로 회원의 주소 List 가져오기
			$.ajax ({
				url:"${pageContext.request.contextPath}/member/getAddrList",
				data: data,
				type: "get",
				success: function(resp){
					console.log(resp.length);
					insert_modal.style.display = "block";
				}
			});
			
		});
		$(".close").click(function(){
			insert_modal.style.display="none";
		});
	});
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
				<c:choose>
					<c:when test="${ empty addrinfo}">
						<tr>
							<td colspan="4" style="text-align: center;">
								배송지 정보가 없습니다. 기본 주소지를 추가해주세요.
							</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="addrInfo" items="${addrinfo}">
						    <tr>
								<td scope="row" style="padding:20px;"
															class="member_no"
															data-member_no ="${addrInfo.member_no}">
									${addrInfo.member_name_extra}</td>
								<td scope="row">
									(${addrInfo.member_addr_post})
									${addrInfo.member_addr_basic}<br>
									${addrInfo.member_addr_extra}
								</td>
								<td scope="row" style="text-align: center; border-right-style: none; padding:20px;">
									${addrInfo.member_addr_status} <br>
								</td>
								<td scope="row" style="text-align: center; border-left-style: none;">
									<form action="addrupdate" method="get">
										<input type="hidden" name="member_addr_no" value="${addrInfo.member_addr_no}">
										<input type="submit" value="수정" class="btn_custom" >
									</form>
									<form action="addrdelete" method="post">
										<input type="hidden" name="member_addr_no" value="${addrInfo.member_addr_no}">
										<input type="submit" value="삭제" class="btn_custom">
									</form>
								</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
				
			  </tbody>
			</table>  
		</div>
		<div class="btn_area" align="right">
			<button type="button" class="btn btn-primary btn_addrExtra">배송추가</button>
		</div>
	</div>
</div>

<!-- 배송지 추가 Modal 영역 -->
<div class="modal insert_modal" style="display:none;">
	<div class="modal-dialog" role="document" style="padding-top: 30px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body form-group">
				<form action="insertaddr" method="post">
	
					<input class="form-control" type="text" name="member_name_extra" placeholder="받는 사람" required style="width:45%;"><br>
					<input class="form-control" id="sample6_postcode" type="text" name="member_addr_post" placeholder="우편번호" required style="width:45%;">
					<button type="button" class="btn_custom btn_findPost" onclick="sample6_execDaumPostcode()">우편번호 찾기</button><br><br>
					<input class="form-control" id="sample6_address" type="text" name="member_addr_basic" placeholder="기본주소" required><br>
					<input class="form-control" id="sample6_detailAddress" type="text" name="member_addr_extra" placeholder="상세주소" required><br>
					<input class="form-control" type="text" id="sample6_extraAddress" placeholder="참고항목"><br>
					<p align="right"><input class="btn btn-primary" type="submit" value="배송지 추가"></p>
			
				</form>
			</div>
		</div>
	</div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"/>