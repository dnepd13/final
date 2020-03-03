package com.kh.admin.service;

import javax.mail.MessagingException;

public interface EmailService {
	public void sendMessage(String email) throws MessagingException;
}
