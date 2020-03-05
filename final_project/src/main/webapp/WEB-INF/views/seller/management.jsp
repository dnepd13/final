<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>판매자 관리 페이지</h1>
    
<div class="btn-group-vertical">
  <h3>상품관리</h3><br>
  <button type="button" class="btn btn-primary" onclick="location='portfolio_insert'">포토폴리오등록</button><br>
  <button type="button" class="btn btn-primary" onclick="location='category_insert'">카테고리관리</button><br>
  <button type="button" class="btn btn-primary"  onclick="location='../goods/insert'">상품등록</button><br>
  <h3>판매관리</h3><br>
  <button type="button" class="btn btn-primary"  onclick="location='customListReq'">받은 요청서</button><br>
  <button type="button" class="btn btn-primary"  onclick="location='customListResp'">보낸 견적서</button><br>
  <button type="button" class="btn btn-primary"  onclick="location=' '">판매정산</button><br>
  <button type="button" class="btn btn-primary"  onclick="location=' '">구매확정내역</button><br>
  <button type="button" class="btn btn-primary"  onclick="location=' '">배송현황</button><br>
   <h3>정산관리</h3><br>
   <button type="button" class="btn btn-primary"  onclick="location=' '">취소/반품/교환 관리</button><br>
   <h3>판매자 정보 관리</h3>
    <button type="button" class="btn btn-primary"  onclick="location='info'">판매자 정보 조회</button><br>
    <button type="button" class="btn btn-primary"  onclick="location='check_pw'">비밀번호 변경</button><br>
     <button type="button" class="btn btn-primary"  onclick="location='delete'">탈퇴하기</button><br>
     <button type="button" class="btn btn-primary"  onclick="location='main '">홈으로가기</button><br>                            
</div>