package com.aleks.pia.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestParam;

import com.aleks.pia.entity.PoljZahtev;

@CrossOrigin
@RepositoryRestResource(collectionResourceRel  = "poljzahtevi",  path = "poljzahtevi")
public interface PoljZahteviRepository extends JpaRepository<PoljZahtev, Long>{

	public Page<PoljZahtev> findByUsername(@RequestParam("username") String username, Pageable pageable);	
	
}
