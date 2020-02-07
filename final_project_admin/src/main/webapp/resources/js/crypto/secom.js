$(function(){
	$("form").submit(function(e){
		e.preventDefault();//기본작업 중지
		//this==폼
		
		$(this).find("input[type=password]").each(function(){
			//this == 입력창
			var text = $(this).val();
			text=CryptoJs.HmacSHA256(text, "kh");
			text = CryptoJs.enc.Base64.stringify(text);
			$(this).val(text);
			
			//보낸다(자바스크립트 명령)
		});
			this.submit();
	});
});