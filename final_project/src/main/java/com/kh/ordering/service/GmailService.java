package com.kh.ordering.service;



import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.kh.ordering.entity.CertDto;
import com.kh.ordering.repository.CertDao;

import lombok.extern.slf4j.Slf4j;





@Service
@Slf4j
public class GmailService implements EmailService{




	
	@Autowired
	private JavaMailSender sender;

	@Autowired
	private CertDao certDao;


	@Autowired
	private RandomService randomService;


	public String sendCert(String email, String cert) {
		try {
			SimpleMailMessage message = new SimpleMailMessage();
			String[] to = {email};
			message.setTo(to);
			message.setSubject("[ordering shop회원] 인증을 위한 이메일입니다.");
			message.setText("인증번호 : " + cert);
			sender.send(message);
			return "success";
		}
		catch(Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}

	@Override
	public void sendChangePasswordMail(String email) throws MessagingException {
		//1. 랜덤번호를 3자리 생성
				String cert = randomService.generateCertificationNumber(3);

				//2. DB에 랜덤번호/이메일/시각을 저장
				certDao.certregist(CertDto.builder().email(email).cert_no(cert).build());

				//3. 이메일 전송
				MimeMessage message = sender.createMimeMessage();
				MimeMessageHelper helper = 
						new MimeMessageHelper(message, true, "UTF-8");

				helper.setTo(email);
				helper.setSubject("[KH정보교육원] 비밀번호 변경 메일");

//						주소 생성
//						String url = "http://localhost:8080/sts21/pw/change?cert="+cert+"&email="+email;
				String url = ServletUriComponentsBuilder
											.fromCurrentContextPath()
											.port(8080)
											.path("/pw/change")
											.queryParam("cert", cert)
											.queryParam("email", email)
											.toUriString();

				StringBuffer buffer = new StringBuffer();
				buffer.append("<h1>비밀번호 변경을 위해 하단 링크를 누르세요</h1>");
				buffer.append("<h2>");
				buffer.append("<a href='");
				buffer.append(url);
				buffer.append("'>");
				buffer.append("이동");
				buffer.append("</a>");
				buffer.append("</h2>");

				helper.setText(buffer.toString(), true);

				sender.send(message);
			}
	
	@Override
	public String sendCertMessege(String email, String cert) {
		try {
			SimpleMailMessage message = new SimpleMailMessage();
			String[] to = {email};
			message.setTo(to);
			message.setSubject("[ordering판매자] 인증을 위한 이메일입니다.");
			message.setText("인증번호 : " + cert);
			sender.send(message);
			System.out.println("성공");
			return "success";
		}
		catch(Exception e) {
			System.out.println("오류");
			e.printStackTrace();
			return "fail";
		}
	}

	
	 



}


	