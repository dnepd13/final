<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 


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
<body>
<h1>카테고리 관리 페이지</h1>
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
	
	
	<div class="form-group">
  <fieldset>
    <label class="control-label" for="seller_id">판매자 아이디</label>
    <input class="form-control" id="seller_id" type="text" value="${seller_id}">S
  </fieldset>
</div>
    <input type="hidden" id="sellerNo" name="sellerNo" value="${seller_no}"/>
    <c:forEach var ="list" items="${category_list}">
	    <table>
	    	<tr>
	    		<td>${list.category_no}</td>
	    		<td>${list.category_large}</td>
	    		<td>${list.category_middle}</td>
	    		<td>${list.category_small}</td>
	    		<td><button type="button" class="deleteButton">삭제</button></td>
	    	</tr>
	    </table>
    </c:forEach>
    

</form>


<jsp:include page="/WEB-INF/views/template/footer-seller.jsp"/>