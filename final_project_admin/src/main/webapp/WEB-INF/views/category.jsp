<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
	
	$(function(){
		$(".btn-modify").click(function(){
			if($(this).text()=="수정"){
				var largeCell = $(this).parent().prev().prev().prev();
				var middleCell = $(this).parent().prev().prev();
				var smallCell = $(this).parent().prev();
				
				var large = largeCell.text();
				var middle = middleCell.text();
				var small = smallCell.text();
				
				largeCell.empty();
				middleCell.empty();
				smallCell.empty();
				
				$("<input>").val(large).appendTo(largeCell);
				$("<input>").val(middle).appendTo(middleCell);
				$("<input>").val(small).appendTo(smallCell);
				
				$(this).text("완료");
			}
			else{
				var no = $(this).parent().prev().prev().prev().prev().val;
				var largeCell = $(this).parent().prev().prev().prev();
				var middleCell = $(this).parent().prev().prev();
				var smallCell = $(this).parent().prev();
				
				var large = largeCell.children().val();
				var middle = middleCell.children().val();
				var small = smallCell.children().val();
				
				largeCell.empty();
				middleCell.empty();
				smallCell.empty();
				
				largeCell.text(large);
				middleCell.text(middle);
				smallCell.text(small);
				
				$(this).text("수정");
				
				var category_no = no;
				var category_large = largeCell.text();
				var category_middle = middleCell.text();
				var category_small = smallCell.text();
				
				
				var td = $(this).parent();
				var category_no = td.data("category-no");
				
				console.log(category_no);
				console.log(category_large);
				console.log(category_middle);
				console.log(category_small);
				
				$.ajax({
					url:"categoryUpdate",
					type:"post",
					data:{
						"category_no": category_no,
						"category_large": category_large,
						"category_middle": category_middle,
						"category_small": category_small
					},
					success : function(resp){
						console.log(resp);
					}
				});
			}
		});
		
		$(".btn-delete").click(function(){
			$(this).parent().parent().remove();
			
			var td = $(this).parent();
			var category_no = td.data("category-no");
			
			$.ajax({
				url:"categoryDelete",
				type:"post",
				data:{
					"category_no":category_no
				},
				success:function(resp){
					console.log(resp);
				}
			});
		});
	});
</script>

<카테고리관리창>
<h1><a href="${pageContext.request.contextPath}/home">홈으로</a></h1>

<div>
	<form  action="category" method="post">
		<div>
			<input type="text" name="category_large" placeholder="대분류" required="required">
			<input type="text" name="category_middle" placeholder="중분류" required="required">
			<input type="text" name="category_small" placeholder="소분류" required="required">
			<input type="submit" value="등록">
		</div>
	</form>
</div>

<table class="table table-hover">
  <thead>
    <tr>
      <th width="10%">번호</th>
      <th width="20%">카테고리 대</th>
      <th width="30%">카테고리 중</th>
      <th width="30%">카테고리 소</th>
      <th width="10%">수정 및 삭제</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="list" items="${list }">
    <tr class="table-light"">
      <th scope="row" id="category_no">${list.category_no }</th>
      <td >${list.category_large }</td>
      <td>${list.category_middle }</td>
      <td>${list.category_small }</td>
      <td data-category-no="${list.category_no}" 
 						data-category-large="${list.category_large}" 
 						data-category-middle="${list.category_middle}" 
 						data-category-small="${list.category_small}">
   			<button type="button" class="btn btn-primary btn-modify" >수정</button>
   			<button type="button" class="btn btn-primary btn-delete" >삭제</button>
      </td>
    </tr>
	</c:forEach>
  </tbody>
</table>
<div>
	<ul class="pagination">
		<c:if test="${paging.startBlock > 1 }">
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/category?pno1=${paging.startBlock-1}">&laquo;</a>
   			 </li>
		</c:if>
		<c:forEach begin="${paging.startBlock }" end="${paging.finishBlock }" var="p">
			<c:choose>
				<c:when test="${p == paging.pno }">
					<li class="page-item active">
   					   <a class="page-link" >${p }</a>
   					 </li>
				</c:when>
				<c:when test="${p != paging.pno }">
					<li class="page-item active">
      					<a class="page-link" href="${pageContext.request.contextPath}/category?pno1=${p}">${p }</a>
   					 </li>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.finishBlock < paging.pagecount}">
			<li class="page-item">
     			 <a class="page-link" href="${pageContext.request.contextPath}/category?pno1=${paging.finishBlock+1}">&raquo;</a>
    		</li>
		</c:if>
	</ul>
</div>




