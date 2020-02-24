<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
</style>


<h1>홈</h1>

	<span><a href="${pageContext.request.contextPath }/seller/login">판매자로그인</a></span>
	<span> &#124; </span>
	<span><a href="${pageContext.request.contextPath }/goods/insert">상품등록</a></span>
<!-- 바뀐 session의 member_no에서 memeber_id를 구해서 확인  -->

<!-- 로그인 내용  -->
<c:choose>
	<c:when test="${member_id == null}">
		<form role="form" method="post" autocomplete="off" action="/member/login">
			<p><a href="/ordering/member/login">일반회원 로그인</a></p>
			<p><a href="/ordering/member/regist">회원가입</a></p>
		</form>
		<span><a href="${pageContext.request.contextPath }/goods/getList">상품List</a></span>
		<p><a href="/ordering/member/login">요청서 보내기</a>
	</c:when>

	<c:otherwise>
		<p>${member_id}님 환영합니다.</p>
    <h1><a href="/ordering/member/membermyinfo">마이페이지</a></h1>
		<h1><a href="${pageContext.request.contextPath}/member/logout">로그아웃</a></h1>
		
		<h1><a href="/ordering/board/memberreport">회원신고게시판</a></h1><br>
<h1><a href="/ordering/board/memberqna">회원문의게시판</a></h1><br>
		
		<span><a href="${pageContext.request.contextPath }/goods/getList">상품List</a></span>
		<span>&verbar;</span>
		<span><a href="${pageContext.request.contextPath }/member/customCate">요청서 보내기</a></span>
	</c:otherwise>
</c:choose>

  














    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="resources/css/bootstrap.min.css" />
	<script type="text/javascript">

// 페이지가 로드될 때 기본적으로 첫번째 tab이 기본적으로 설정되도록 한다
$(document).ready(function(){
	$("#tabs").tabs();
	getContentTab(1);
});

function getContentTab(index){
	var url="/user/list" + index;  
	var targetDiv = "#tabs-" + index; 

	$.get(url, null, function(result){
		$(targetDiv).html(result);   // 해당 div에 결과가 나타남
	});
}
</script>

<div id="tabs">
	<ul>
		<li><a href="${pageContext.request.contextPath }/seller/regist" onclick="getContentTab(1);">Tab1</a></li>
		<li><a href="${pageContext.request.contextPath }/member/regist" onclick="getContentTab(2);">Tab2</a></li>
	</ul>


	<div id="tabs-1"></div>      
	<div id="tabs-2"></div>
</div>

<ul class="nav nav-tabs navbar-light bg-light">
  <li class="nav-item">
    <a class="nav-link" data-toggle="tab" href="#home" style="width:400;height=200;">Home</a>
 	<a href="${pageContext.request.contextPath }/seller/regist"></a>
  </li>


  <li class="nav-item">
    <a class="nav-link active" data-toggle="tab" href="#profile" style="width:400;height=200;">Profile</a>
  	<a href="${pageContext.request.contextPath }/member/regist"></a>
  </li>

</ul>
<div id="tabs-1" class="tab-content">
  <div class="tab-pane fade" id="home">
    <p>
		 <legend>Legend</legend>

    <div class="form-group">
      <label for="exampleInputEmail1">Email address</label>
      <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
      <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
    </div>
    <div class="form-group">
      <label for="exampleInputPassword1">Password</label>
      <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
    </div>
     <div class="form-group">
      <label for="exampleInputEmail1">Email address</label>
      <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
      <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
    </div>
     <div class="form-group">
      <label for="exampleInputEmail1">Email address</label>
      <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
      <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
    </div>
     <div class="form-group">
      <label for="exampleInputEmail1">Email address</label>
      <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
      <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
    </div>
     <div class="form-group">
      <label for="exampleInputEmail1">Email address</label>
      <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
      <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
    </div>
     <div class="form-group">
      <label for="exampleInputEmail1">Email address</label>
      <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
      <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
    </div>
    <button type="submit" class="btn btn-primary">Submit</button>
  </fieldset>
	</form>
	</p>
  </div>
  
  
  <div class="tab-pane fade active show" id="profile">
    </div>
 
	</form>


	</p>
  </div>
  <div class="tab-pane fade" id="dropdown1">
    <p>Etsy mixtape wayfarers, ethical wes anderson tofu before they sold out mcsweeney's organic lomo retro fanny pack lo-fi farm-to-table readymade. Messenger bag gentrify pitchfork tattooed craft beer, iphone skateboard locavore carles etsy salvia banksy hoodie helvetica. DIY synth PBR banksy irony. Leggings gentrify squid 8-bit cred pitchfork.</p>
  </div>
  <div class="tab-pane fade" id="dropdown2">
    <p>Trust fund seitan letterpress, keytar raw denim keffiyeh etsy art party before they sold out master cleanse gluten-free squid scenester freegan cosby sweater. Fanny pack portland seitan DIY, art party locavore wolf cliche high life echo park Austin. Cred vinyl keffiyeh DIY salvia PBR, banh mi before they sold out farm-to-table VHS viral locavore cosby sweater.</p>
  </div>
</div>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
  </body>






<div id="tabs-1" class="tab-content">
  <div class="tab-pane fade" id="home">
