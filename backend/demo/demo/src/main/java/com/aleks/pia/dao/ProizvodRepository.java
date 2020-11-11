package com.aleks.pia.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestParam;

import com.aleks.pia.entity.Proizvod;

@CrossOrigin("http://localhost:4200") 
@RepositoryRestResource(collectionResourceRel  = "proizvodi",  path = "proizvodi")
public interface ProizvodRepository extends JpaRepository<Proizvod, Long>{
	
	public Page<Proizvod> findByNazivContaining(@RequestParam("name") String name, Pageable pageable);
	//izgenerise upit na foru SELECT * FROM Product p 
	//WHERE p.name LIKE CONCAT('%', :name, '%')

	

	public Page<Proizvod> findByKategorija(@RequestParam("kategorija") String kategorija, Pageable pageable);
	
	public Page<Proizvod> findByPreduzeceId(@RequestParam("id") Long id, Pageable pageable);
}
