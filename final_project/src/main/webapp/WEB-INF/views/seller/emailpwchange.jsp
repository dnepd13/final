<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
<script>
//비밀번호 확인
$(function(){
$('#pw2').blur(function(){
   if($('#pw').val() != $('#pw2').val()){
    	if($('#pw2').val()!=''){
	    alert("비밀번호가 일치하지 않습니다.");
    	    $('#pw2').val('');
          $('#pw2').focus();
       }
    }
})  	   
});

</script> 
 
 <div class="container-fluid">
     <div class="row">
         <div class="offset-md-4 col-md-4 ">
            <div class="row justify-content-center"><h1>비밀번호 변경 페이지</h1></div>
            <br><br><br>
            <form action="pwchange" method="post">
 
				<!--비밀번호 입력창-->
               <div class="form-group">
               	 <label for="pw-input">비밀번호 입력 </label>
                 <input class="form-control" type="password" id="pw-input1" name="seller_pw" required>
               </div>
 				<button type="button" class="btn btn-secondary disabled btn-block">비밀번호 변경하기</button>
             </form>
          </div>
       </div>
</div>
 