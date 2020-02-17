package com.kh.ordering.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.ordering.service.EmailService;
import com.kh.ordering.service.RandomService;
@Controller
@RequestMapping("/seller")
public class EmailCheckController {
	@Autowired
	private EmailService emailService;

	@Autowired
	private RandomService randomService;
	
@GetMapping("/check")
	public String check(){
	return "seller/check";			
}

@GetMapping("/send")//jsp로 결과가 나가면 안된다
@ResponseBody//내가 반환하는 내용이 곧 결과물
public String send(@RequestParam String email,HttpSession session) {
//	String cert ="1236";
	String cert = randomService.generateCertificationNumber(6);
	session.setAttribute("cert", cert);
	
	return emailService.sendCertMessege(email, cert);
}
@GetMapping("/validate")
@ResponseBody
public String validate(HttpSession session, @RequestParam String cert) {
		String value =(String)session.getAttribute("cert");//서버에 저장된 번호를 내놔라 사용자가 입력한 값이 cert로 들어와야한다
		      session.removeAttribute("cert");//세션값을 지운다 한번쓰면 지워야한다(버려야한다)
		if (value.equals(cert)) {  //사용자가 입력한 값이 cert랑 같으면
			return "success";
		}	
			else {
				return "fail";
				
			}
		}
}
