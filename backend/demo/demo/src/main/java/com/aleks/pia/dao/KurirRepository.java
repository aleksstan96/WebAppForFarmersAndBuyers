package com.aleks.pia.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestParam;

import com.aleks.pia.entity.Kurir;

@RepositoryRestResource(collectionResourceRel = "kuriri", path = "kuriri" )
//@CrossOrigin("http://localhost:4200") 
@CrossOrigin
public interface KurirRepository extends JpaRepository<Kurir, Long>{

	public Page<Kurir> findByPreduzeceId(@RequestParam("id") Long id, Pageable pageable);
}
