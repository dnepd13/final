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
		var comfirm1 = 0;
		var comfirm2 = 0;
		$("#span").hide();
		$("#span2").hide();
		$("#gradeinsert").on("keyup",function(){
			var grade = $(this).val();
			$(".grade").each(function(){
				if(grade == $(this).text()){
					comfirm1= 1;
					$("#span").show();
					$("#span").text("존재하는 등급입니다");
					$("#span").css("color", "red");
					$("#gradeinsert").focus();
					return false;
				}
				else{
					comfirm1=0;
					$("#span").show();
					$("#span").text("사용가능합니다");
					$("#span").css("color", "blue");
				}
			});
				if(comfirm1==0&&comfirm2==0){
					$(".insertbutton").attr('disabled', false);
				}
				else{
					$(".insertbutton").attr('disabled', true);
				}
		});
		$("#rateinsert").on("keyup",function(){
			var rate = $(this).val();
		
			$(".rate").each(function(){
				if(rate == $(this).text()){
					comfirm2= 1;
					$("#span2").show();
					$("#span2").text("존재하는 값입니다");
					$("#span2").css("color", "red");
					$("#rateinsert").focus();
					return false;
				}
				else{
					comfirm2=0;
					$("#span2").show();
					$("#span2").text("사용가능합니다");
					$("#span2").css("color", "blue");
				}
				if(comfirm1==0&&comfirm2==0){
					$(".insertbutton").attr('disabled', false);
				}
				else{
					$(".insertbutton").attr('disabled', true);
				}
			});
			console.log("grade"+comfirm1);
			console.log("rate"+comfirm2);
			if(comfirm1==0&&comfirm2==0){
				$(".insertbutton").attr('disabled', false);
			}
			else{
				$(".insertbutton").attr('disabled', true);
			}
		});
	});
</script>

<style>
	.arti{
		overflow: hidden;
	}
</style>

<aside>
<div>
<jsp:include page="template/header.jsp"></jsp:include>
</div>
</aside>

<section class="admin" style="padding-left: 250px;">
	<article class="arti">

<div class="container-fluid">
        <div class="row" style="padding: 50px;">
            <div class="offset-md-1 col-md-10">
<div class="row justify-content-center" style="padding: 20px;"><h1>구매자 등급 혜택</h1></div>

<h3>등급 혜택 등록하기</h3>
<form action="" method="post">
	<input id="gradeinsert" type="text" name="grade_benefit_grade" placeholder="등급" required="required">
	<input id="rateinsert" type="number" name="grade_benefit_rate" placeholder="혜택율" required="required">
	<input class="insertbutton" type="submit" value="등록" disabled="">
	<div><span id="span"></span>	</div>
	<div><span id="span2"></span></div>
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
    <tr id="tr1">
      <th scope="row" class="grade">${list.grade_benefit_grade }</th>
      <td class="rate">${list.grade_benefit_rate }</td>
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
    </article></section>