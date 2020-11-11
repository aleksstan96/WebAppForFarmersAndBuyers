package com.aleks.pia.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.MailException;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.aleks.pia.dao.PoljoprivrednikRepository;
import com.aleks.pia.entity.Poljoprivrednik;
import com.aleks.pia.services.MailService;

@RestController
public class MailController {
	
	@Autowired
	MailService mailService;
	
	@Autowired
	PoljoprivrednikRepository poljRepo;
	
	@RequestMapping("/rasadnikodrzavanje/{id}/{rasadnik}")
	public ResponseEntity<?> rasadnikOdrzavanje(@PathVariable Long id, @PathVariable String rasadnik) {
		
		Poljoprivrednik polj = poljRepo.findById(id).get();
		
		try {
			mailService.sendMail(polj.getEmail() , "alexstan220196@gmail.com", rasadnik);
		}catch(MailException e) {
			System.out.println(e.getMessage());
		}
		return ResponseEntity.ok(HttpStatus.ACCEPTED);
		
		
	}

}
