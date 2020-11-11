package com.aleks.pia.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class MailService {
	
	private JavaMailSender javaMailSender;
	
	@Autowired
	public MailService(JavaMailSender javaMailSender) {
		this.javaMailSender = javaMailSender;
	}

	//samo moras ukljuciti access 
	public void sendMail(String sendTo, String sendFrom, String rasadnik) throws MailException{
		SimpleMailMessage mail = new SimpleMailMessage();
		
		mail.setTo(sendTo);
		mail.setFrom(sendFrom);
		mail.setSubject("Održavanje rasadnika");
		mail.setText("Vašem rasadniku " + rasadnik + " je potrebno održavanje!");
		
		javaMailSender.send(mail);
		
	}
}
