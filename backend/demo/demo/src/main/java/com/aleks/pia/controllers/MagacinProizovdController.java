package com.aleks.pia.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.rest.webmvc.RepositoryRestController;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aleks.pia.dao.MagacinProizvodRepository;
import com.aleks.pia.entity.MagacinProizvod;
import com.aleks.pia.entity.MagacinProizvodKey;

@RepositoryRestController
public class MagacinProizovdController {
	
	@Autowired
	private MagacinProizvodRepository mpRepo;
	
	@RequestMapping(method = RequestMethod.GET, value = "/magacinproizvodi/delete/{mid}/{pid}")
   // @ResponseBody
    public ResponseEntity<?> deleteMagacinProizovd(@PathVariable Long mid, @PathVariable Long pid) {
		MagacinProizvodKey mpKey = new MagacinProizvodKey();
		mpKey.setMagacin_id(mid);
		mpKey.setProizvod_id(pid);
		MagacinProizvod mp = mpRepo.findById(mpKey).get();
        mpRepo.delete(mp);
        return ResponseEntity.ok(HttpStatus.NO_CONTENT);
    }
	
	
	@RequestMapping(method = RequestMethod.GET, value = "/magacinproizvodi/update/kolicina/{mid}/{pid}/{kolicina}")
	public ResponseEntity<?> updateMagacinProizvodKolicina(@PathVariable Long mid, @PathVariable Long pid, @PathVariable int kolicina){
		MagacinProizvodKey mpKey = new MagacinProizvodKey();
		mpKey.setMagacin_id(mid);
		mpKey.setProizvod_id(pid);
		MagacinProizvod mp = mpRepo.findById(mpKey).get();
		mp.setKolicina(kolicina);
		mpRepo.save(mp);
		return ResponseEntity.ok(HttpStatus.ACCEPTED);
		
	}
	

}
