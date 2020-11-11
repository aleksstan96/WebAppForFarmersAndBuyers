package com.aleks.pia.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.web.bind.annotation.CrossOrigin;

import com.aleks.pia.entity.JeOcenio;
import com.aleks.pia.entity.JeOcenioKey;

@CrossOrigin
@RepositoryRestResource(collectionResourceRel  = "jeocenio",  path = "jeocenio")
public interface JeOcenioRepository extends JpaRepository<JeOcenio, JeOcenioKey>{
	
	@Query("select jo from JeOcenio jo where jo.user.id=:id")
	public Page<JeOcenio> findByUserId(@Param("id") Long id, Pageable pageable);
	
	@Query("select jo from JeOcenio jo where jo.proizvod.id=:id")
	public Page<JeOcenio> findByProizvodId(@Param("id") Long id, Pageable pageable);
	
	@Query("select jo from JeOcenio jo where jo.user.id=:uid and jo.proizvod.id=:pid")
	public Page<JeOcenio> findByUserIdAndProizvodId(@Param("uid") Long mid, @Param("pid") Long pid, Pageable pageable);
	
	
	
}
