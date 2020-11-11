package com.aleks.pia.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestParam;

import com.aleks.pia.entity.Preduzece;

@CrossOrigin
@RepositoryRestResource(collectionResourceRel  = "preduzeca",  path = "preduzeca")
public interface PreduzeceRepository extends JpaRepository<Preduzece, Long>{
	
	public Page<Preduzece> findByUserId(@RequestParam("id") Long id, Pageable pageable);
	
	public Page<Preduzece> findByNaziv(@RequestParam("naziv") String naziv, Pageable pageable);

}
