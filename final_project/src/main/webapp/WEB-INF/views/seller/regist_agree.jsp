<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
  </script>
   <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<h1>이용약관동의페이지</h1>
<div class="continer-fluid">
	<div class="row"  style="padding:50px;">
		<div class="offset-md-4 col-md-4 ">
		  <div class="row justify-content-center" style="padding: 20px;"><h1>판매자 회원가입</h1></div>
          <br><br><br>
		  <div class="regist_content">
          <div class="regist_form">
		  <!-- 약관동의 -->
		  <div class="terms_p">
		  <p class="terms_chk_all">
		   <span class="input_chk">
		    <input type="checkbox" id="chk_all" name="chk_all">
		     <label for="chk_all">
		     <span class="chk_all_txt">
		      "이용약관, 개인정보 수집 및 이용,"
		      <br class="m_br">
		      "메일 수신(선택)에 모두 동의합니다."
		     </span>
		    </label>
		    </span>
		  </p>
		  <ul class="terms_bx_list">
		  <li class="terms_bx">
		  <span class="input_chk">
		  <input type="checkbox" id="temsService"name="temsService"
		  class="chk">
		  <label for="temsService">"ordering 이용약관"
		 	<span class="tems_necessary">(필수)
		 	</span>
		  </label>
		  </span>
		   <div class="terms_box" tabindex="0" id="divService">
		   </div>
		   </li>
		  </ul>
		  	<span class="error" id="areeMsg" style="display: none;">
		     ordering 이용약관과 개인정보 수집 및 이용에 대한 안내 모두 동의해주세요.
		    </span>
		   </div>
		  <!--//약관동의 -->
		  <a name="agreeBottom"></a>
		  <div class="btn_atra double">
		   <span>
		    <a href="#" id="btnCancel" class="btn_type btn_default" role="button">취소</a>
		   </span>
		   <span>
		    <a href="#" id="btnCancel" class="btn_type btn_default" role="button">확인</a>
		   </span>
		  </div>
		    

		 
<form id="regist_form" action="regist_agree" method="post">
<input type="radio">이용약관, 개인정보 수집 및 이용, 위치정보 이용약관(선택),
프로모션 안내 메일 수신(선택)에 모두 동의합니다.<br><br>
<input type="radio">이용약관동의(필수)<br><br>
<textarea rows="10" cols="80"></textarea><br><br>
<input type="radio">개인정보 수집 및 이용에 대한 안내(필수)<br><br>
<textarea rows="10" cols="80"></textarea><br><br>
<input type="radio">위치정보 이용약관 동의(선택)<br><br>
<textarea rows="10" cols="80"></textarea><br><br>
<input type="radio">이벤트 등 프로모션 알림 메일 수신(선택)<br><br>
<input type="hidden" name=seller_agree_date value="${dTime }">
<input type="submit" value="취소">
<input type="submit" value="확인">

</form>
</div>