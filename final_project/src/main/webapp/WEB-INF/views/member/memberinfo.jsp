<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
  </script>
  <script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
 
 <!-- 회원 내 정보 수정 페이지 -->
 <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css"> 

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
	.myInfo_wrap {
		width: 1200px;
		height: 800px;
		margin: 0 auto;
	}
	.info_wrap {
		float: left;
		margin-left: 60px;
		padding-top: 100px;
		width: 900px;
	}
	.info_wrap::after{content:""; display: block; clear:both;}
	.info_main {
		margin: 0 auto;
		width: 90%;
		height: 50px;
		border-bottom: 2px solid #F3F5F8;
	}
	.info_titleBox {
		width: 200px;
		height: auto;
		padding-top: 10px;
		margin-left: 30px;
		float: left;
		font-size: large; 
	}
	.info_list {
		margin: 30px auto;
		width: 90%;
	}

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

<div class="myInfo_wrap">
<jsp:include page="/WEB-INF/views/template/memberInfoAside.jsp"/>
	<div class="info_wrap">
	
		<div class="info_main">
			<div class="info_titleBox">
				내 정보 관리
			</div>
		</div>
		
		<div class="info_list">
		   <div class="container-fluid" style="padding-top:100px;">
		        <div class="row">
		            <div class="offset-md-4 col-md-4 ">
						<div class = "card border-secondary mb-5" style = "max-width : 700rem;">
			  				<div class = "card-header">
			  				   <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"size="4";>멤버 회원정보 </font></font>
			  				</div>
		  
			  				<div class = "card-body">
			  				<form action="memberinfo" method="post">
			               <!--     <h4 class = "card-title"> <font style = "vertical-align : inherit;"> <font style = "vertical-align : inherit;"> Seller Information </font> </font> </h4> -->
			    		
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
		</div>
		
	</div>
</div>
	 
 
 
 <jsp:include page="/WEB-INF/views/template/footer.jsp"/>
