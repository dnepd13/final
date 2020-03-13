<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
  </script>
  <script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<script>
$(function(){
	$(".btn-modify").click(function(){
		if($(this).text()=="수정"){
			var gradeCell = $(this).parent().prev().prev();
			var rateCell = $(this).parent().prev();
			
			var grade = gradeCell.text();
			var rate = rateCell.text();
			
			gradeCell.empty();
			rateCell.empty();
			
			$("<input>").val(grade).appendTo(gradeCell);
			$("<input>").val(rate).appendTo(rateCell);
			
			$(this).text("완료");
		}
		else{
			var gradeCell = $(this).parent().prev().prev();
			var rateCell = $(this).parent().prev();
			
			var grade = gradeCell.children().val();
			var rate = rateCell.children().val();
			
			gradeCell.empty();
			rateCell.empty();
			
			gradeCell.text(grade);
			rateCell.text(rate);
			
			$(this).text("수정");
			
			var grade_benefit_grade = gradeCell.text();
			var grade_benefit_rate = rateCell.text();
			
			var td = $(this).parent();
			var member_no = td.data("member-no");
			
			$.ajax({
				url:"memberedit",
				type:"post",
				data:{
					"member_no":member_no,
					"member_phone":member_phone,
					"member_email":member_email
				},
				success:function(resp){
				}
			});
		}
	});
});
</script>
 <div class="container-fluid">
        <div class="row">
            <div class="offset-md-4 col-md-4 ">
				<div class = "card border-secondary mb-3"style = "max-width : 500rem;">
  				<div class = "card-header">
  				  <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"size="4";>회원정보 수정 </font></font>
  				</div>
  				
  				<div class = "card-header">
  				  <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"size="4";>회원정보 수정 등록 </font></font>
  				</div>
  				<form action="" method="post">
					<input id="gradeinsert" type="text" name="grade_benefit_grade" placeholder="이메일" maxlength="48" required="required">
					<input id="rateinsert" type="number" name="member_phone" placeholder="전화번호" maxlength="12" required="required">
					<input class="insertbutton" type="submit" value="등록" disabled="">
					<div><span id="span"></span>	</div>
					<div><span id="span2"></span></div>
				</form>	
  				
  				<div class = "card-body">
  				
			
				  <%-- <h5 class = "card-title"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> ${sellerDto.seller_id}님의 정보입니다 </font> </font> </h5> --%>
    			   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 아이디 :${memberDto.member_id} </font></font></p>
    			   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 이름 :${memberDto.member_name} </font></font></p>
    			   <div class="form-group">
   				   	<p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 
   				   	   이메일 : <input style="width:15rem;" class="rate" type="text" name="member_email" value="${memberDto.member_email}"> </font></font></p>
    			   </div>
    			    <div class="form-group">
        			   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 
    			   	   연락처 : <input class="grade" type="text" name="member_phone" value="${memberDto.member_phone}"> </font></font></p>
    			      </div> 
    			    <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 생년월일 :${memberDto.member_birth} </font></font></p> 
        			<p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> 등급 :${memberDto.member_grade} </font></font></p>  		  
    			
    			  <td data-member-no="${memberDto.member_no }">
    			   <button type="button" class="btn-modify  btn-block">수정</button>
    			  </td>

  				</div>
 			 </div>
 		  </div>
 		</div> 
 	</div>	 
