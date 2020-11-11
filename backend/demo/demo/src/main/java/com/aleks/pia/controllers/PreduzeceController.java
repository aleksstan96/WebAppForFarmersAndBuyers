package com.aleks.pia.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.rest.webmvc.RepositoryRestController;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aleks.pia.dao.PreduzeceRepository;
import com.aleks.pia.dao.UserRepository;
import com.aleks.pia.entity.Preduzece;
import com.aleks.pia.entity.User;

@RepositoryRestController
public class PreduzeceController {
	
	@Autowired
	private PreduzeceRepository preduzeceRepo;
	
	@Autowired
	private UserRepository userRepo;
	
	@RequestMapping(method = RequestMethod.GET, value = "/preduzeca/update/{preduzeceId}/{userId}")
	public ResponseEntity<?> updatePreduzeceIdUser(@PathVariable Long preduzeceId, @PathVariable Long userId){
		
		Preduzece preduzece = preduzeceRepo.findById(preduzeceId).get();
		
		User user = userRepo.findById(userId).get();
		preduzece.setUser(user);
		preduzeceRepo.save(preduzece); 
		return ResponseEntity.ok(HttpStatus.ACCEPTED);
		
	}

}
