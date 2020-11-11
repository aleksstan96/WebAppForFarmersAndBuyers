package com.aleks.pia.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.rest.webmvc.RepositoryRestController;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aleks.pia.dao.PoljZahteviRepository;
import com.aleks.pia.dao.PredZahteviRepository;
import com.aleks.pia.entity.PoljZahtev;
import com.aleks.pia.entity.PredZahtev;

@RepositoryRestController
public class ZahtevController {

	@Autowired
	private PoljZahteviRepository poljZahtevRepo;
	
	@Autowired
	private PredZahteviRepository predZahtevRepo;
	
	@RequestMapping(method = RequestMethod.GET, value = "/poljzahtevi/prihvati/{id}")
	public ResponseEntity<?> updatePoljZahtevPrihvati(@PathVariable Long id){
		
		PoljZahtev zahtev = poljZahtevRepo.findById(id).get();
		zahtev.setPrihvacen(true);
		poljZahtevRepo.save(zahtev); 
		return ResponseEntity.ok(HttpStatus.ACCEPTED);
		
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/poljzahtevi/odbij/{id}")
	public ResponseEntity<?> updatePoljZahtevOdbij(@PathVariable Long id){
		
		PoljZahtev zahtev = poljZahtevRepo.findById(id).get();
		zahtev.setNijePrihvacen(true);
		poljZahtevRepo.save(zahtev); 
		return ResponseEntity.ok(HttpStatus.ACCEPTED);
		
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/predzahtevi/prihvati/{id}")
	public ResponseEntity<?> updatePredZahtevPrihvati(@PathVariable Long id){
		
		PredZahtev zahtev = predZahtevRepo.findById(id).get();
		zahtev.setPrihvacen(true);
		predZahtevRepo.save(zahtev); 
		return ResponseEntity.ok(HttpStatus.ACCEPTED);
		
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/predzahtevi/odbij/{id}")
	public ResponseEntity<?> updatePredZahtevOdbij(@PathVariable Long id){
		
		PredZahtev zahtev = predZahtevRepo.findById(id).get();
		zahtev.setNijePrihvacen(true);
		predZahtevRepo.save(zahtev); 
		return ResponseEntity.ok(HttpStatus.ACCEPTED);
		
	}
	
}
