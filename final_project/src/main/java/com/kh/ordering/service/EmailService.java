package com.kh.ordering.service;

import javax.mail.MessagingException;

public interface EmailService {

		String sendCert(String email, String cert);

		void sendChangePasswordMail(String email) throws MessagingException;

		String sendCertMessege(String email, String cert);

	
	
}