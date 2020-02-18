package com.kh.ordering.service;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.web.bind.annotation.RequestParam;

public interface EmailService {
 String sendCertMessege(String email, String cert);


	
}
