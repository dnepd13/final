package com.kh.admin.service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class EmailServiceImpl implements EmailService{

	@Autowired
	private JavaMailSender sender;
	
	@Override
	public void sendMessage(String email) throws MessagingException {
		
		MimeMessage message= sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message);
		
		helper.setFrom("ordering.kh@gmail.com");
		helper.setTo(email);
		helper.setSubject("[Ordering] 회원님의 비밀번호가 초기화되었습니다.");
		helper.setText("초기화된 비밀번호는 123456789a 입니다");
		
		sender.send(message);
	}
}