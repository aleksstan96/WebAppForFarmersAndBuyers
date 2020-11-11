package com.aleks.pia.controllers;

import java.math.BigDecimal;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.rest.webmvc.RepositoryRestController;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aleks.pia.dao.JeDodeljenRepository;
import com.aleks.pia.dao.KurirRepository;
import com.aleks.pia.dao.PorudzbinaRepository;
import com.aleks.pia.entity.JeDodeljen;
import com.aleks.pia.entity.JeDodeljenKey;
import com.aleks.pia.entity.Kurir;
import com.aleks.pia.entity.Porudzbina;

@RepositoryRestController
public class JeDodeljenController {
	
	@Autowired
	private JeDodeljenRepository jDRepo;
	
	@Autowired
	private KurirRepository kurirRepo;
	
	@Autowired
	private PorudzbinaRepository porRepo;
	
	@RequestMapping(method = RequestMethod.GET, value = "/jedodeljen/create/{kurId}/{porId}/{udaljenost}/{vreme}")
	   // @ResponseBody
	    public  ResponseEntity<?> createJeDodeljen(@PathVariable Long kurId, @PathVariable Long porId,@PathVariable BigDecimal udaljenost , @PathVariable BigDecimal vreme) {
			JeDodeljen jo = new JeDodeljen();
			JeDodeljenKey jok = new JeDodeljenKey();
			
			Kurir kurir  = kurirRepo.findById(kurId).get();
			Porudzbina por = porRepo.findById(porId).get();
			jok.setKurir_id(kurir.getId());
			jok.setPorudzbina_id(por.getId());
			jo.setId(jok);
			jo.setKurir(kurir);
			jo.setPorudzbina(por);
			jo.setVreme(vreme);
			jo.setUdaljenost(udaljenost);
			Date vremePreuzimanja = new Date();
			
			jo.setVremePreuzimanja(vremePreuzimanja);
			//vreme je u sekundama 
			long vremeIsporuke = vremePreuzimanja.getTime()+vreme.longValue()*1000;
			jo.setVremeIsporuke(new Date(vremeIsporuke));
			while(true) {
				try {
					jDRepo.save(jo);
					break;
				}catch(Exception e) {
					System.out.println("Puklo");
				}
			}
			
			return ResponseEntity.ok(HttpStatus.NO_CONTENT);
					
	    }

}
