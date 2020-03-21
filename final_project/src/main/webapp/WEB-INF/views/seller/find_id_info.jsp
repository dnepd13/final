 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
  </script>
  <script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
  <jsp:include page="/WEB-INF/views/template/header.jsp"/>
 <jsp:include page="/WEB-INF/views/template/menu.jsp"/>                  
  
  <style>
  .redirect-box {
  		margin:auto;
		border: 1px solid #A6A6A6;
		width: 400px;
		height: 200px;
		margin-top: 10%;
		margin-left: 10%;
	}
	
  </style>
   <div class="container-fluid">
        <div class="row">
            <div class="offset-md-4 col-md-4 ">
            	<div align="center" style="margin-top: 10%"><h1>판매자 아이디 찾기</h1></div>
                	<div class="redirect-box row justify-content-center">
                	<br><br><br>
                	 <div class="redirect-content">
                	 <br><br>
                	   <P style="font-size: 18px ">고객님 정보와 일치하는 아이디 입니다.</P>
   				 		<form action="find_id_info" method="post">  
                		 <div align="center">
                			<h3 >${sellerDto.seller_id}</h3>                
                		</div>
                		
         			   </form>
         			<a href="${pageContext.request.contextPath }/seller/login">
						<button class="btn btn-secondary" style="width:48%;">로그인하기</button>
				   </a>
         		   <a href="${pageContext.request.contextPath }/seller/pwfind">
					<button class="btn btn-secondary" style="width:48%;">비밀번호 찾기</button>
				   </a>
					</div>
					</div>
			</div>
		 </div>
	</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>         

