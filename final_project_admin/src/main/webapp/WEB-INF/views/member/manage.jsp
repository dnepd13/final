<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js" ></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/secom.js"></script>
<script>
	$(function(){
		$(".memberPw").hide();
		
	});
	function checkAll(){
		if($("#th_checkAll").is(':checked')){
			$("input[name=checkRow]").prop("checked",true);
		}
		else{
			$("input[name=checkRow]").prop("checked", false);
		}
	}
	$(function(){
		$(".btn-regist").click(function(){
			var checkRow =[];
			$("input[name='checkRow']:checked").each(function(){
				checkRow.push($(this).val());
			});
			
			var point = $(this).prev().prev().prev().val();
			var reason =$(this).prev().prev().val();
			var lastdate = $(this).prev().val();
			$.ajax({
				url:"pointAllRegist",
				type:"post",
				dataType:'text',
				data:{
					valueArrTest: checkRow,
					'point':point,
					'reason':reason,
					'lastdate':lastdate
					
				},
				success:function(resp){
					window.alert(resp);
						$("input[name='checkRow']:checked").each(function(){
							$("input[name=checkRow]").prop("checked", false);
						});
				}
			});
		});
	});
</script>

<aside>
<div>
<jsp:include page="../template/header.jsp"></jsp:include>
</div>
</aside>

<section class="admin" style="padding-left: 250px;">
	<article>

<div class="container-fluid">
        <div class="row" style="padding: 50px;">
            <div class="offset-md-1 col-md-10">
<div class="row justify-content-center"  style="padding: 20px;"><h1>회원 관리 목록</h1></div>

<form action="manage" method="get">
  <fieldset>
    <div class="form-group">
      <label for="exampleSelect1">검색 조건</label>
      <select class="form-control" name="key" id="exampleSelect1">
        <option value="member_id">아이디</option>
        <option value="member_name">이름</option>
        <option value="member_grade">등급</option>
      </select>
    </div>
    <div class="form-group row">
      <label for="staticEmail" class="col-sm-2 col-form-label">검색</label>
      <div class="col-sm-10">
        <input type="text"  name="search" class="form-control-plaintext" id="staticEmail" placeholder="검색어를 입력하세요">
      </div>
    </div>
  </fieldset>
  
  <button type="submit" class="btn btn-primary offset-md-4 col-md-4" >검색</button>
</form>
<table class="table table-hover">
  <thead>
    <tr>
      <th width="9%"><input type="checkbox" name="checkAll" id="th_checkAll" onclick="checkAll();"></th>
      <th width="5%">아이디</th>
      <th width="5%">이름</th>
      <th width="10%">이메일</th>
      <th width="10%">연락처</th>
      <th width="2%">등급</th>
      <th width="10%">가입일</th>
      <th width="15%">마지막 접속일시</th>
      <th width = "8%">상세보기</th>
      <th width = "8%">차단</th>
      <th width="15%">비밀번호초기화</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="list" items="${list}">
    <tr class="table-light">
    <th class="center"><input type="checkbox" id="checkRow" name="checkRow" value="${list.member_no }"  style="width:20px;height:20px;"></th>
      <th scope="row">${list.member_id}</th>
      <td>${list.member_name}</td>
      <td>${list.member_email}</td>
      <td>${list.member_phone}</td>
      <td>${list.member_grade}</td>
      <td>${list.member_join_date}</td>
      <td>${list.member_last_login} </td>
      <td>
      		<form action="memberpage" method="post">
      			<input type="hidden" name="member_no" value="${list.member_no }">
      			<input type="submit" value="상세보기">
      		</form>
      </td>
      <c:choose>
      	<c:when test="${list.block_no > 0 }">
      		<td>
      		<a href="${pageContext.request.contextPath}/unlock?member_no=${list.member_no}"><button type="button" class="btn btn-danger">해제</button></a>
			</td>      
      	</c:when>
      	<c:otherwise>
		      <td>
		      	<a href="${pageContext.request.contextPath}/block?member_no=${list.member_no}"><button type="button" class="btn btn-primary">차단</button></a>
		      </td>
      	</c:otherwise>
      </c:choose>
      <td>
      		<form action="reset" method="post" class="resetForm">
      			<input type="hidden" name="member_no" value="${list.member_no }">
      			<input type="hidden" name="member_email" value="${list.member_email }">
      			<input class="memberPw" type="password" name="member_pw" value="123456789a">
      			<button class="btn btn-primary reset" >초기화</button>
      		</form>
      </td>
      
    </tr>
	</c:forEach>
  </tbody>
</table>

<div class="row justify-content-center">
<div>
	<ul class="pagination">
		<c:if test="${paging.startBlock > 1 }">
		 	<c:choose>
		 		<c:when test="${param.key != null }">
					<li class="page-item">
		     			 <a class="page-link" href="${pageContext.request.contextPath}/member/manage?pno1=${paging.startBlock-1}&key=${param.key}&search=${param.search}">&laquo;</a>
		   			 </li>
				</c:when>
				<c:otherwise>
					<li class="page-item">
	     			 	<a class="page-link" href="${pageContext.request.contextPath}/member/manage?pno1=${paging.startBlock-1}">&laquo;</a>
	   				 </li>
				</c:otherwise>
		 	</c:choose>
		</c:if>
		
		<c:forEach begin="${paging.startBlock }" end="${paging.finishBlock }" var="p">
			<c:choose>
				<c:when test="${p == paging.pno }">
					<li class="page-item active">
   					   <a class="page-link" >${p }</a>
   					 </li>
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${param.key!=null }">
							<li class="page-item">
								<a class="page-link" href="${pageContext.request.contextPath}/member/manage?pno1=${p}&key=${param.key}&search=${param.search}">${p }</a>
	    					</li>
						</c:when>
						<c:otherwise>
							<li class="page-item active">
		      					<a class="page-link" href="${pageContext.request.contextPath}/member/manage?pno1=${p}">${p }</a>
		   					 </li>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<c:if test="${paging.finishBlock < paging.pagecount}">
			<c:when test="${param.key!=null }">
				<li class="page-item">
					<a class="page-link" href="${pageContext.request.contextPath}/member/manage?pno1=${paging.finishBlock+1}&key=${param.key}&search=${param.search}">&raquo;</a>
				</li>
			</c:when>
			<c:otherwise>
				<li class="page-item">
	     			 <a class="page-link" href="${pageContext.request.contextPath}/member/manage?pno1=${paging.finishBlock+1}">&raquo;</a>
	    		</li>
			</c:otherwise>
		</c:if>
	</ul>
</div>
</div>

<form>
	<input type="number" placeholder="포인트"  required="required" class="offset-md-0 col-md-12">
	<input type="text"  name="member_point_content"  class="form-control-plaintext" id="staticEmail1" placeholder="축하드립니다" value="축하드립니다">
	<input type="date" min="${today }" max="2099-12-31" name="member_point_limit" class="form-control-plaintext" id="staticEmail2" >
	<button type="button" class="btn btn-primary btn-regist offset-md-4 col-md-4" >포인트등록</button><br>
</form>



</div>
        </div>
    </div>
    </article></section>