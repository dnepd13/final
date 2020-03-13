<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">

<jsp:include page="/WEB-INF/views/template/header-seller.jsp"/>

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
				url:"category_insert_proc",
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
 	 
 	$(function(){
 		$(".deleteButton").on('click',function(){
 	 		var categoryNo = $(this).parents('tr').children(":first").text();
 	 		var sellerNo = $("#sellerNo").val();
 	 		$.ajax({
				url:"category_delete",
				type:"post",
				data:{
					"category_no": categoryNo,
					"seller_no" : sellerNo
				},
				success : function(resp){
					console.log(resp);
					location.reload();
				}
			});
 	 	 });
	 });
	 
 </script>
<div class="container-fluid">
        <div class="row" style="padding: 50px;">
            <div class="offset-md-1 col-md-10">
<div class="row justify-content-center"  style="padding: 20px;"><h1>${seller_id}님의 카테고리 관리페이지</h1></div>

<div>
<form action="category_insert_proc" method="post">
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
	<input type="hidden" id="sellerNo" name="sellerNo" value="${seller_no}"/>
	<c:forEach var ="list" items="${category_list}">
  <tr class="table-light"">
      <th scope="row" id="category_no">${list.category_no }</th>
      <td class="bigcate">${list.category_large }</td>
      <td class="middlecate" >${list.category_middle }</td>
      <td class="smallcate" >${list.category_small }</td>
      <td data-category-no="${list.category_no}" 
 						data-category-large="${list.category_large}" 
 						data-category-middle="${list.category_middle}" 
 						data-category-small="${list.category_small}">
   		 		<td><button type="button" class="deleteButton">삭제</button></td>
      </td>
    </tr>
	</c:forEach>
  </tbody>
  </form>
</div>
</div>
</div>
</table>	
</div>
   </div>
        </div>
    </div>




<jsp:include page="/WEB-INF/views/template/footer-seller.jsp"/>