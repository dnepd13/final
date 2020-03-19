<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
  </script>
 <script>
 $(function test() {
		if ($('input[name="member_pwcheck"]').val() == "") {
			alert("비밀번호 확인을 해주세요.");
			return false;
		}
		if ($('input[name="member_pwcheck"]').val() != $('input[name="member_pw"]').val()) {
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		}
		$("#frm").submit();
 });
 </script>
 
 
 <!-- 비밀번호 변경->비밀번호 확인창 -->
 
  <script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
  
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>
  
   <div class="container-fluid">
        <div class="row">
            <div class="offset-md-4 col-md-4 ">
                <div class="row justify-content-center"><h1>회원 비밀번호 확인</h1></div>
                <br><br><br>
                <form id="frm" action="" method="get">  
              <!-- 비밀번호 입력창 -->
               <div class="form-group">
  				<label class="col-form-label" >PW : </label>
  				<input type="password" class="form-control" name="member_pw"  required>
			  </div>
			  <div>
			  	<label class="col-form-label" >PW 확인 창: </label>
			  	<input type="password" class="form-control" name="member_pwcheck"  required/>
			  </div>
  			  <div class="form-group">
			   	<button type="button" class="btn btn-secondary disabled btn-block" onclick="test()" value="확인"/>
			  </div>
  			   </form>
  		   </div>
  		</div>
  	</div>
  		
  		<jsp:include page="/WEB-INF/views/template/footer.jsp"/>	  












