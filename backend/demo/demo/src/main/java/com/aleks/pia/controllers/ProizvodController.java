package com.aleks.pia.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.rest.webmvc.RepositoryRestController;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aleks.pia.dao.PreduzeceRepository;
import com.aleks.pia.dao.ProizvodRepository;
import com.aleks.pia.entity.Preduzece;
import com.aleks.pia.entity.Proizvod;

@RepositoryRestController
public class ProizvodController {
	
	@Autowired
	private ProizvodRepository proizvodRepo;
	
	@Autowired
	private PreduzeceRepository preduzeceRepo;
	

	@RequestMapping(method = RequestMethod.GET, value = "/proizvodi/update/{proizvodId}/{preduzeceId}")
	public ResponseEntity<?> updateProizvodPreduzece(@PathVariable Long proizvodId, @PathVariable Long preduzeceId){
		
		Preduzece preduzece = preduzeceRepo.findById(preduzeceId).get();
		Proizvod proizvod = proizvodRepo.findById(proizvodId).get();
		proizvod.setPreduzece(preduzece);
		proizvodRepo.save(proizvod); 
		return ResponseEntity.ok(HttpStatus.ACCEPTED);
		
	}
	

}
