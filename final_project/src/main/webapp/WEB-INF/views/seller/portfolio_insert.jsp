<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css">  

<style>
	.portfolio_area {
		width: 1000px;
		margin: 0 auto;
	}
	.portfolio_content{
		width: 800px;
		margin: 0 auto;
	}
</style>
   
<script type="text/javascript">
	
	$(function(){
		// 파일 미리보기
		var upload = document.querySelector("#upload");
		
		$(upload).change(function(f){
			var files = f.target.files;	
			for(var i=0 ; i<files.length ; i++){
				var filesName =files[i].name;
				var filesSizeOrigin = files[i].size/1024;
				var filesSize = String(filesSizeOrigin).substring(0,5);
				$(".filesName").append(filesName);
				$(".filesSize").append(filesSize+" KB");
				$(".filesDelete").append("<button class='btn_clean'>&times;</button>");
				
				var img = $("<img>"); // 미리보기를 담을 태그
				reader = new FileReader(); // 파일 리더 객체
				
				reader.onload(function(){
					
				});
			}
		});
		
		// 파일 미리보기 삭제
// 		$(".filesDelete").click(function(){
// 			$(this).remove();
// 			$(this).prev(".filesSize").text().remove();
// 			$(this).prev().prev(".filesName").text().remove();
// 		});
		
		$(".btn_delete").click(function(e){
			if(confirm('포트폴리오를 삭제하시겠습니까?')){
				return true;
			}
			else{
				return false;
			}
		});
	});
</script>

<div class="continer-fluid">
	<div class="row"  style="padding:50px;">
		<div class="offset-md-4 col-md-4 ">
	 	 <div class="row justify-content-center" style="padding: 20px;"><h1>판매자 포토폴리오 등록</h1></div>
         <br><br><br> 
    	<form action="portfolio_insert" method="post"enctype="multipart/form-data">
      	<div>
        <input id="upload" type="file" name="files" multiple><br><br>
        </div>
        <button type="submit" class="btn btn-secondary disabled">업로드하기</button>
    
   	    </form>
      </div>
    </div>
 </div>
  <!-- 파일정보 미리보기 영역-->
  <div align="center">
  	<table border="1">
  		<colgroup>
  			<col width="400px">
  			<col width="100px">
  			<col width="30px">
  		</colgroup>
  		<thead>
  			<tr>
  				<td>파일이름</td>
  				<td colspan="2">파일크기</td>
  				<td></td>
  			</tr>
  		</thead>
  		<tbody>
  			<tr>
  				<td class="filesName"></td>
  				<td class="filesSize"></td>
  				<td class="filesReadyDelete"></td>
  			</tr>
  		</tbody>
  	</table>
  </div>

<br>
 <div class="row-empty-40"></div>
 
  <!-- 등록된 포트폴리오 출력 영역 -->
	 <div class="portfolio_area" align="center">
	 <p>아래의 이미지가 판매중인 모든 상품에 등록됩니다.</p>
	 <c:if test="${ not empty filesVO }">
		 <c:forEach var="filesVO" items="${filesVO }">
		 	<span>${filesVO.files_no}</span>
			 <div class="portfolio_content" align="center">
			 	<form action="portfolio_delete" method="post" class="portfolio_delete">
					<input type="hidden" name="files_no" value="${filesVO.files_no}">			 			
					<input type="hidden" name="seller_no" value="${seller_no }">
					<input type="submit" value="&times;" class="btn_custom btn_delete">
			 	</form>
			 	<img src="${pageContext.request.contextPath }/seller/portfolio_download?files_no=${filesVO.files_no}" style="width:800px; height:auto;">
			 </div>
		 </c:forEach>
	</c:if>   
	</div>
 
<%--  <jsp:include page="/WEB-INF/views/seller/portfolio_img.jsp"/> --%>
