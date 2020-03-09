<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8" />
 <meta name="viewport" content="width=device-width, initial-scale=1.0" />
 <meta http-equiv="X-UA-Compatible" content="ie=edge" />
 <script src="https://code.jquery.com/jquery-latest.js"></script>
 <script src="${pageContext.request.contextPath}/resources/js/goodsOption.js"></script>
 <script>
 	 $(function(){
////////////	카테고리	///////////////////////////////////
//------------------------카테고리 등록----------------------//
 		 var category_largeList = "${category_largeList}";
	 	 category_largeList = category_largeList.substring(1, category_largeList.length-1).split(",");
 		 $.each(category_largeList, function(index, item){
 			 var option = $("<option value='"+item+"'>"+item+"</option>");
 			 $(".category_large").append(option);
 		 });
 		 
 		 $(".category_large").change(function(){
	 		 $(".middleChild").nextAll().remove();
	 		 $(".smallChild").nextAll().remove();
 			 var category_name = $(this).val();
 			 var url = "../goods/large";
 			 $.ajax({
 				 type: "POST",
 			 	 url: url,
 			 	 data: {"category_name":category_name},
 			 	 success: function(resp){
 			 		 $.each(resp, function(index, item){
 			 			var option = $("<option value='"+item+"'>"+item+"</option>");
 			 			$(".category_middle").append(option);
 			 		 });
 			 	 }
 			 });
 		 });
 		 
 		 $(".category_middle").change(function(){
 			$(".smallChild").nextAll().remove();
			 var category_name = $(this).val();
			 var url = "../goods/middle";
			 $.ajax({
				 type: "POST",
			 	 url: url,
			 	 data: {"category_name":category_name},
			 	 success: function(resp){
			 		 $.each(resp, function(index, item){
			 			var option = $("<option value='"+item+"'>"+item+"</option>");
			 			$(".category_small").append(option);
			 		 });
			 	 }
			 });
 		 });
 		 
 		 $(".category_small").change(function(){
 			var category_name = $(this).val();
			 var url = "../goods/small";
			 $.ajax({
				 type: "POST",
			 	 url: url,
			 	 data: {"category_name":category_name},
			 	 success: function(resp){
		 			 $(".category_no").val(resp);
			 	 }
			 });
 		 });
	 });
 	 
 	 $(function(){
 		 $(".submit_btn").on('click',function(){
 			 //alert('success');
 			 var category_small = $(".category_small option:selected").val();
 			 //submit
 			$.ajax({
				url:"category_insert",
				type:"post",
				data:{
					"category_small": category_small
				},
				success : function(resp){
					console.log(resp);
				}
			});
 		 });
 	 });
//----------------------------리스트----------------------------------------------------//
/* $(function(){
		$(".btn-modify").click(function(){
			console.log("ddd");
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
 	 
 	  */
//////////////////////////////////////////////////////////////////////		 
 </script>
<body>
<h1>카테고리 관리 페이지</h1>
<form action="category_info" method="post">
<select class="category_large" name="category_large">
<option class="largeChild">선택</option>
</select>
<select class="category_middle" name="category_middle">
<option class="middleChild">선택</option>
</select>
<select class="category_small" name="category_small">
<option class="smallChild">선택</option>
</select>
<!-- 리스트 -->
	<input class="submit_btn" type="submit" value="등록" >
	
	
	<div class="form-group">
  <fieldset>
    <label class="control-label" for="seller_id">판매자 아이디</label>
    <input class="form-control" id="seller_id" type="text"  value="${seller_id}">
  </fieldset>
</div>


    <h3>판매자 아이디: ${seller_id}</h3>
    <c:forEach var ="list" items="${category_list}">
    		<h3>${list.category_no}</h3>
    		<h3>${list.category_large}</h3>
    		<h3>${list.category_middle}</h3>
    		<h3>${list.category_small}</h3>
    </c:forEach>
    
 <%-- c:forEach var="list" items="${list }">
    <tr class="table-light">
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
		</c:if>--%>

</form>
</body>
</html>