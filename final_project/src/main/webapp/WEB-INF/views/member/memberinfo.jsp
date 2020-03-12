<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
  </script>
  <script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
 
 <!-- 회원 내 정보 수정 페이지 -->
 
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<jsp:include page="/WEB-INF/views/template/menu.jsp"/>
  
  
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
<style>
input {
  width:400px;
  height:50px;
  font-size:20px;
}

card border-head {
  width:650px;
}
card border-body {
  width:650px;
}

</style>


   <div class="container-fluid">
        <div class="row">
            <div class="offset-md-4 col-md-4 ">
				<div class = "card border-secondary mb-5" style = "max-width : 700rem;">
  				<div class = "card-header">
  				   <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"size="4";>멤버 회원정보 </font></font>
  				</div>
  
  				<div class = "card-body">
  				<form action="memberinfo" method="post">
               <!--     <h4 class = "card-title"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> Seller Information </font> </font> </h4> -->
    			  	<thead>
    			  	<tr>
  						<th scope="row">아이디</th>
  						<td><p class = "grade"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> ${memberDto.member_id} </font></font></p></td>
  						<th width="20%">이름</th>
  						<th width="20%">등급</th>
  						<th width="20%">생년월일</th>
  						<th width="20%">이메일</th>
  						<th width="20%">연락처</th>
  					</tr>
    				</thead>
    		
    				<p class = "grade"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> ${memberDto.member_id} </font></font></p>
    			   <p class = "rate"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;">${memberDto.member_name} </font></font></p>
   				   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;">${memberDto.member_grade} </font></font></p>
   				   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;">${memberDto.member_birth} </font></font></p>
    			   
    			   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;">${memberDto.member_email} </font></font></p>
    			   <p class = "card-text"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;">${memberDto.member_phone} </font></font></p>
    			  <div data-member-no="${memberDto.member_no }">
    			   <button type="button" class="btn-modify  btn-block">수정</button>
    			  </div>
    	   		  
    			 </form>
  				</div>
 			 </div>
 		  </div>
 		</div> 
 	</div>	 
 
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>
