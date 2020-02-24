<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css"> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
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
				var grade_benefit_no = td.data("grade-benefit-no");
				
				$.ajax({
					url:"gradebenefitupdate",
					type:"post",
					data:{
						"grade_benefit_no":grade_benefit_no,
						"grade_benefit_grade":grade_benefit_grade,
						"grade_benefit_rate":grade_benefit_rate
					},
					success:function(resp){
					}
				});
			}
		});
		
		$(".btn-delete").click(function(){
			$(this).parent().parent().remove();
			
			var td = $(this).parent();
			var grade_benefit_no = td.data("grade-benefit-no");
			
			$.ajax({
				url:"gradebenefitdelete",
				type:"post",
				data:{
					"grade_benefit_no":grade_benefit_no
				},
				success:function(resp){
				}
			})
		});
		
	});
</script>
<div style="padding-top: 50px;">
<jsp:include page="template/header.jsp"></jsp:include>
</div>

<div class="container-fluid">
        <div class="row" style="padding: 50px;">
            <div class="offset-md-1 col-md-10">
<div class="row justify-content-center" style="padding: 20px;"><h1>구매자 등급 혜택</h1></div>

<h3>등급 혜택 등록하기</h3>
<form action="" method="post">
	<select name="grade_benefit_grade">
		<option>브론즈</option>
		<option>실버</option>
		<option>골드</option>
	</select>
	<input type="number" name="grade_benefit_rate" placeholder="혜택율" required="required">
	<input type="submit" value="등록">	
</form>
<table class="table table-hover">
  <thead>
    <tr>
      <th width="40%">조건 등급</th>
      <th width="40%">혜택율(%)</th>
      <th width="20%">수정 및 삭제</th>
    </tr>
  </thead>
  <tbody>
  <c:forEach var="list" items="${list }">
    <tr>
      <th scope="row">${list.grade_benefit_grade }</th>
      <td>${list.grade_benefit_rate }</td>
      <td data-grade-benefit-no="${list.grade_benefit_no }" >
   			<button type="button" class="btn-modify" >수정</button>
   			<button type="button" class="btn-delete" >삭제</button>
      </td>
    </tr>
  </c:forEach>
  </tbody>
</table>

   </div>
        </div>
    </div>