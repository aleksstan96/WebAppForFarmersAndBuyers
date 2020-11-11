package com.aleks.pia.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.rest.webmvc.RepositoryRestController;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aleks.pia.dao.JeOcenioRepository;
import com.aleks.pia.dao.ProizvodRepository;
import com.aleks.pia.dao.UserRepository;
import com.aleks.pia.entity.JeOcenio;
import com.aleks.pia.entity.JeOcenioKey;
import com.aleks.pia.entity.Proizvod;
import com.aleks.pia.entity.User;

@RepositoryRestController
public class JeOcenioController {
	
	@Autowired
	private JeOcenioRepository jORepo;
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired
	private ProizvodRepository proRepo;
	
	@RequestMapping(method = RequestMethod.GET, value = "/jeocenio/create/{proId}/{userId}/{komentar}/{ocena}")
	   // @ResponseBody
	    public  ResponseEntity<?> createJeOceni(@PathVariable Long proId, @PathVariable Long userId,@PathVariable String komentar , @PathVariable int ocena) {
			JeOcenio jo = new JeOcenio();
			JeOcenioKey jok = new JeOcenioKey();
			
			User user  = userRepo.findById(userId).get();
			Proizvod pro = proRepo.findById(proId).get();
			jok.setUser_id(user.getId());
			jok.setProizvod_id(pro.getId());
			jo.setId(jok);
			jo.setUser(user);
			jo.setProizvod(pro);
			jo.setKomentar(komentar);
			jo.setOcena(ocena);
			while(true) {
				try {
					jORepo.save(jo);
					break;
				}catch(Exception e) {
					System.out.println("Puklo");
				}
			}
			
			return ResponseEntity.ok(HttpStatus.NO_CONTENT);
					
	    }

}
