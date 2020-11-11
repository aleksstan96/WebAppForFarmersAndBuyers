package com.aleks.pia.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestParam;

import com.aleks.pia.entity.Rasadnik;

@RepositoryRestResource(collectionResourceRel = "rasadnici", path = "rasadnici" )
//@CrossOrigin("http://localhost:4200") 
@CrossOrigin
public interface RasadnikRepository extends JpaRepository<Rasadnik, Long>{

		public Page<Rasadnik> findByMagacinId(@RequestParam("id") Long id, Pageable pageable);
	
}
