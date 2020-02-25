<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
  <script>
  	$(function(){
  		location.reload();	
  		
  	});
  
  
  </script> 
  <div class="form-group">
  <fieldset>
    <label class="control-label" for="seller_id">판매자 아이디</label>
    <input class="form-control" id="seller_id" type="text"  value="${seller_id}">
  </fieldset>
</div>


    <h3>판매자 아이디: ${seller_id}</h3>
    <c:forEach var ="list" items="${category_list}">
    		<h3>${list.category_no}</h3>
    		<h3>${list.category_small}</h3>
    </c:forEach>
    
<h1>등록 완료 페이지</h1>