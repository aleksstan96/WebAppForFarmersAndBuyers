package com.aleks.pia.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.rest.webmvc.RepositoryRestController;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aleks.pia.dao.PoljoprivrednikRepository;
import com.aleks.pia.dao.PorudzbinaRepository;
import com.aleks.pia.dao.PreduzeceRepository;
import com.aleks.pia.dao.RasadnikRepository;
import com.aleks.pia.entity.Poljoprivrednik;
import com.aleks.pia.entity.Porudzbina;
import com.aleks.pia.entity.Preduzece;
import com.aleks.pia.entity.Rasadnik;

@RepositoryRestController
public class PorudzbinaController {

	@Autowired
	private PorudzbinaRepository porRepo;
	
	@Autowired
	private PoljoprivrednikRepository poljRepo;
	
	@Autowired
	private RasadnikRepository rasRepo;	
	

	@Autowired
	private PreduzeceRepository preduzeceRepo;	
	

	@RequestMapping(method = RequestMethod.GET, value = "/porudzbine/updateids/{porudzbinaId}/{preduzeceId}/{poljId}/{rasadnikId}")
	public ResponseEntity<?> updatePorudzbinaIds(@PathVariable Long porudzbinaId, @PathVariable Long preduzeceId, @PathVariable Long poljId, @PathVariable Long rasadnikId){
		
		Porudzbina porudzbina = porRepo.findById(porudzbinaId).get();
		Preduzece preduzece = preduzeceRepo.findById(preduzeceId).get();
		Rasadnik rasadnik = rasRepo.findById(rasadnikId).get();
		Poljoprivrednik polj = poljRepo.findById(poljId).get();
		
		porudzbina.setRasadnik(rasadnik);
		porudzbina.setPreduzece(preduzece);
		porudzbina.setPoljoprivrednik(polj);
		
		porRepo.save(porudzbina); 
		return ResponseEntity.ok(HttpStatus.ACCEPTED);
		
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/porudzbine/updatestatus/{porudzbinaId}/{status}")
	public ResponseEntity<?> updatePorudzbinaStatus(@PathVariable Long porudzbinaId, @PathVariable String status){
		
		Porudzbina porudzbina = porRepo.findById(porudzbinaId).get();
		
		porudzbina.setStatus(status);
		
		porRepo.save(porudzbina); 
		return ResponseEntity.ok(HttpStatus.ACCEPTED);
		
	}
	
}
