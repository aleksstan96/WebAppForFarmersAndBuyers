package com.aleks.pia.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestParam;

import com.aleks.pia.entity.Sadnica;

@CrossOrigin 
@RepositoryRestResource(collectionResourceRel  = "sadnice",  path = "sadnice")
public interface SadnicaRepository extends JpaRepository<Sadnica, Long>{
	
	public Page<Sadnica> findByRasadnikId(@RequestParam("id") Long id, Pageable pageable);
	
	public Page<Sadnica> findByRasadnikIdAndBrPolja(@RequestParam("id") Long id, @RequestParam("br") int br, Pageable pageable);
	
	
	

}
 