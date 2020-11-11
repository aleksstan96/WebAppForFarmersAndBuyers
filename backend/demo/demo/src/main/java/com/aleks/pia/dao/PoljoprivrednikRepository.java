package com.aleks.pia.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestParam;

import com.aleks.pia.entity.Poljoprivrednik;

@CrossOrigin 
@RepositoryRestResource(collectionResourceRel  = "poljoprivrednici",  path = "poljoprivrednici")
public interface PoljoprivrednikRepository extends JpaRepository<Poljoprivrednik, Long>{
	
	public Page<Poljoprivrednik> findByUserId(@RequestParam("id") Long id, Pageable pageable);
	

}
