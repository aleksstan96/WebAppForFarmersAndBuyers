package com.aleks.pia.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.rest.webmvc.RepositoryRestController;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aleks.pia.dao.RasadnikRepository;
import com.aleks.pia.dao.SadnicaRepository;
import com.aleks.pia.entity.Rasadnik;
import com.aleks.pia.entity.Sadnica;

@RepositoryRestController
public class SadnicaController {
	
	@Autowired
	private SadnicaRepository sadnicaRepo;
	
	@Autowired
	private RasadnikRepository rasadnikRepo;
	
	
	@RequestMapping(method = RequestMethod.GET, value = "/sadnice/update/{sadnicaId}/{rasadnikId}")
	public ResponseEntity<?> updateSadnicaRasadnikId(@PathVariable Long sadnicaId, @PathVariable Long rasadnikId){
		
		Sadnica sadnica = sadnicaRepo.findById(sadnicaId).get();
		
		Rasadnik rasadnik = rasadnikRepo.findById(rasadnikId).get();
		sadnica.setRasadnik(rasadnik);
		sadnicaRepo.save(sadnica); 
		return ResponseEntity.ok(HttpStatus.ACCEPTED);
		
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/sadnice/update/progres/{sadnicaId}/{progres}")
	public ResponseEntity<?> updateSadnicaProgres(@PathVariable Long sadnicaId, @PathVariable double progres){
		
		Sadnica sadnica = sadnicaRepo.findById(sadnicaId).get();
		double newprogres = sadnica.getProgres() + progres/sadnica.getVek();
		if(newprogres>=1) {
			newprogres=1; 
		}
		sadnica.setProgres(newprogres);
		sadnicaRepo.save(sadnica); 
		return ResponseEntity.ok(HttpStatus.ACCEPTED);
		
	}
	

	@RequestMapping(method = RequestMethod.GET, value = "/sadnice/update/uklonjena/{sadnicaId}")
	public ResponseEntity<?> updateSadnicaUklonjena(@PathVariable Long sadnicaId){
		
		Sadnica sadnica = sadnicaRepo.findById(sadnicaId).get();
		sadnica.setUklonjena(true);
		sadnicaRepo.save(sadnica); 
		return ResponseEntity.ok(HttpStatus.ACCEPTED);
		
	}


}
