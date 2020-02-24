<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


    
    
    
    
    
    
    
    
    
    
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

