package com.aleks.pia.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.rest.webmvc.RepositoryRestController;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.aleks.pia.dao.PoljoprivrednikRepository;
import com.aleks.pia.dao.RasadnikRepository;
import com.aleks.pia.entity.Poljoprivrednik;
import com.aleks.pia.entity.Rasadnik;

@RepositoryRestController
public class RasadnikController {	
	
	@Autowired
	private RasadnikRepository rasadnikRepo;
	
	@Autowired
	private PoljoprivrednikRepository poljRepo;
	
//	@PostMapping(path = "/rasadnici/{poljoprivrednikId}", consumes="application/json")
//	@ResponseStatus(HttpStatus.CREATED)
//	public Rasadnik saveRasadnik( //@PathVariable("rasadnikId") Long rasadnikId,
//			@PathVariable("poljoprivrednikId") Long poljoprivrednikId
//			,@RequestBody Rasadnik rasadnik
//			){
//		
//		//log.info(rasadnik.toString());
//		Poljoprivrednik polj = poljRepo.findById(poljoprivrednikId).get();
//		//log.info(polj.toString());
//		rasadnik.setPoljoprivrednik(polj);
//		
//		return rasadnikRepo.save(rasadnik);
//		
//	
//	}
//	
	
	@PatchMapping(path = "/rasadnici/{rasadnikId}/{poljoprivrednikId}")
	//@ResponseStatus(HttpStatus.ACCEPTED)
	public ResponseEntity<?>  updateRasadnik( @PathVariable("rasadnikId") Long rasadnikId,
			@PathVariable("poljoprivrednikId") Long poljoprivrednikId
			//,@RequestBody Rasadnik rasadnik
			){
		
		//log.info(rasadnik.toString());
		Poljoprivrednik polj = poljRepo.findById(poljoprivrednikId).get();
		Rasadnik rasadnik = rasadnikRepo.findById(rasadnikId).get();
		rasadnik.setPoljoprivrednik(polj);
		
		rasadnikRepo.save(rasadnik);
		return ResponseEntity.ok(HttpStatus.ACCEPTED);
		//ova radi kako treba mada ne znam zasto vraca 404
	
	}

}
