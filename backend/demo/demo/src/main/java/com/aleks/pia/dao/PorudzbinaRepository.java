package com.aleks.pia.dao;

import java.util.Date;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestParam;

import com.aleks.pia.entity.Porudzbina;

@CrossOrigin(origins = "*", allowedHeaders = "*") 
@RepositoryRestResource(collectionResourceRel  = "porudzbine",  path = "porudzbine")
public interface PorudzbinaRepository extends JpaRepository<Porudzbina, Long>{
	
//	public Page<Poljoprivrednik> findByUserId(@RequestParam("id") Long id, Pageable pageable);
	 
	public Page<Porudzbina> findByPreduzeceId(@RequestParam("id") Long id, Pageable pageable);
	
	public Page<Porudzbina> findByPoljoprivrednikIdAndRasadnikId(@RequestParam("pid") Long pid, @RequestParam("rid") Long rid, Pageable pageable);
	
	public Page<Porudzbina> findByPreduzeceIdAndDatumKreiranjaBetween(@RequestParam("id") Long id,@RequestParam("startDate") Date startDate,@RequestParam("endDate") Date endDate, Pageable pageable);

	public Page<Porudzbina> findByPoljoprivrednikIdAndStatus(@RequestParam("pid") Long pid,@RequestParam("status") String status ,Pageable pageable);
	

	
}
