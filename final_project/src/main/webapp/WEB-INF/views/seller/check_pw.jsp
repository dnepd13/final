<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
  </script>
  <script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<div class="container-fluid">
     <div class="row">
         <div class="offset-md-4 col-md-4 ">
            <div class="row justify-content-center"><h1>현재 비밀번호를 입력해주세요</h1></div>
            <br><br><br>
    		<form action="check_pw" method="post">
    		   <!--비밀번호 입력창-->
               <div class="form-group">
               	 <label for="pw-input">현재 비밀번호 </label>
                 <input class="form-control" type="password" id="pw-input" name="seller_pw" required>
               </div>
               <button type="submit" class="btn btn-secondary disabled btn-block">다음</button>
           </form>
          </div>
      </div>
</div>             
            
<!-- 현재비밀번호<input type="password" name="seller_pw">
<input type="submit" value="변경하기">
</form> -->