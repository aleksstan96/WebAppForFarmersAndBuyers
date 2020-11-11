package com.aleks.pia.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestParam;

import com.aleks.pia.entity.Magacin;

@CrossOrigin
@RepositoryRestResource(collectionResourceRel  = "magacini",  path = "magacini")
public interface MagacinRepository extends JpaRepository<Magacin, Long>{
	
	public Page<Magacin> findByRasadnikId(@RequestParam("id") Long id, Pageable pageable);
	

}
