package com.aleks.pia.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.rest.webmvc.RepositoryRestController;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aleks.pia.dao.PorudzbinaRepository;
import com.aleks.pia.dao.ProizvodPorudzbinaRepository;
import com.aleks.pia.dao.ProizvodRepository;
import com.aleks.pia.entity.Porudzbina;
import com.aleks.pia.entity.Proizvod;
import com.aleks.pia.entity.ProizvodPorudzbina;
import com.aleks.pia.entity.ProizvodPorudzbinaKey;

@RepositoryRestController
public class ProizvodPorudzbinaController {
	
	@Autowired
	private ProizvodPorudzbinaRepository ppRepo;
	
	@Autowired
	private PorudzbinaRepository porRepo;
	
	@Autowired
	private ProizvodRepository proRepo;
	
	@RequestMapping(method = RequestMethod.GET, value = "/proizvodporudzbina/create/{porid}/{proid}/{kol}")
	   // @ResponseBody
	    public  ResponseEntity<?> createProizvodPorudzbina(@PathVariable Long porid, @PathVariable Long proid, @PathVariable int kol) {
			ProizvodPorudzbina pp= new ProizvodPorudzbina();
			ProizvodPorudzbinaKey ppk = new ProizvodPorudzbinaKey();
			
			Porudzbina por = porRepo.findById(porid).get();
			Proizvod pro = proRepo.findById(proid).get();
			ppk.setPorudzbina_id(por.getId());
			ppk.setProizvod_id(pro.getId());
			pp.setId(ppk);
			pp.setPorudzbina(por);
			pp.setProizvod(pro);
			pp.setKolicina(kol);
			while(true) {
				try {
					ppRepo.save(pp);
					break;
				}catch(Exception e) {
					System.out.println("Puklo");
				}
			}
			
			return ResponseEntity.ok(HttpStatus.NO_CONTENT);
					
	    }

}
