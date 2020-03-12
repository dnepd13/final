<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css">  

<jsp:include page="/WEB-INF/views/template/header-seller.jsp"/>

<style>
	.portfolio_area {

	}
 	.portfolio_content{ 

 	} 
	.btn_delete {
		float: right;
	}
	.btn_delete::after{
		content:"";
		display: block;
		clear: both;
	}
	
	table {
		border: 1px darkgray solid;
		border-collapse: collapse;
	}
	table thead :nth-child(1) {	
		border-bottom: 1px darkgray solid;
	}
	table tbody td {
		height: 100px;
	}
</style>
   
<script type="text/javascript">
	
	$(function(){
		// 파일 미리보기
		var upload = document.querySelector("#upload");
		
		$(upload).change(function(f){
			$(".filesInfo").children().empty();
			var files = f.target.files;	
			if(files.length >5 ){
				alert("파일은 최대 5개까지만 등록 가능합니다. 다시 선택해주세요.");
				$(".btn_upload").prop("disabled", true);
			}
			else{
				$(".btn_upload").prop("disabled", false);
				for(var i=0 ; i<files.length ; i++){
					var filesName =files[i].name;
					var filesSizeOrigin = files[i].size/1024;
					var filesSize = String(filesSizeOrigin).substring(0,5);
					$(".filesName").append(filesName+"<br>");
					$(".filesSize").append(filesSize+" KB <br>");
				}
			}
		});
		
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
        <button type="submit" class="btn btn-secondary btn_upload">업로드하기</button>   
   	    </form>
      </div>
    </div>
 </div>
  <!-- 파일정보 미리보기 영역-->
  <div align="center">
  	<table>
  		<colgroup>
  			<col width="400px">
  			<col width="150px">
  		</colgroup>
  		<thead>
  			<tr>
  				<td>파일이름</td>
  				<td>파일크기</td>
  			</tr>
  		</thead>
  		<tbody>
  			<tr class="filesInfo">
  				<td class="filesName"></td>
  				<td class="filesSize"></td>
  			</tr>
  		</tbody>
  	</table>
  </div>

<br>
 <div class="row-empty-40"></div>
 
  <!-- 등록된 포트폴리오 출력 영역 -->
	 <div class="portfolio_area" align="center">
	 <p>아래의 이미지가 판매중인 모든 상품의 상세페이지에 노출됩니다.</p>
	 <c:if test="${ not empty filesVO }">
		 <c:forEach var="filesVO" items="${filesVO }">
			 <div class="portfolio_content" align="center">
			 	<form action="portfolio_delete" method="post" class="portfolio_delete">
					<input type="hidden" name="files_no" value="${filesVO.files_no}">			 			
					<input type="hidden" name="seller_no" value="${seller_no }">
			 	<img src="${pageContext.request.contextPath }/seller/portfolio_download?files_no=${filesVO.files_no}" style="width:800px; height:auto;">
					<span><input type="submit" value="&times;" class="btn_clean btn_delete"></span>
			 	</form>
			 </div>
		 </c:forEach>
	</c:if>   
	</div>
 
<jsp:include page="/WEB-INF/views/template/footer-seller.jsp"/>
