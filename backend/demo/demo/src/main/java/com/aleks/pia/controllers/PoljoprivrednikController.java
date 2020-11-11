package com.aleks.pia.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.rest.webmvc.RepositoryRestController;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aleks.pia.dao.PoljoprivrednikRepository;
import com.aleks.pia.dao.UserRepository;
import com.aleks.pia.entity.Poljoprivrednik;
import com.aleks.pia.entity.User;

@RepositoryRestController
public class PoljoprivrednikController {
	
	@Autowired
	private PoljoprivrednikRepository poljRepo;
	
	@Autowired
	private UserRepository userRepo;
	
	@RequestMapping(method = RequestMethod.GET, value = "/poljoprivrednici/update/{poljoprivrednikId}/{userId}")
	public ResponseEntity<?> updatePoljoprivrednikIdUser(@PathVariable Long poljoprivrednikId, @PathVariable Long userId){
		
		Poljoprivrednik poljoprivrednik = poljRepo.findById(poljoprivrednikId).get();
		
		User user = userRepo.findById(userId).get();
		poljoprivrednik.setUser(user);
		poljRepo.save(poljoprivrednik); 
		return ResponseEntity.ok(HttpStatus.ACCEPTED);
		
	}

}
