<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
  </script>
  <script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"> 
<div class="continer-fluid">
	<div class="row"  style="padding:50px;">
		<div class="offset-md-4 col-md-4 ">
	 	 <div class="row justify-content-center" style="padding: 20px;"><h1>판매자 포토폴리오 등록</h1></div>
         <br><br><br> 
    	<form action="portfolio_insert" method="post"enctype="multipart/form-data">
      	<div>
        <input type="file" name="files" multiple><br><br>
        </div>
        <button type="submit" class="btn btn-secondary disabled">업로드하기</button>
    
   	    </form>
      </div>
    </div>
 </div>
   
    