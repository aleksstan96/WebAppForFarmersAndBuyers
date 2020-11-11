package com.aleks.pia.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.web.bind.annotation.CrossOrigin;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.aleks.pia.entity.JeDodeljen;
import com.aleks.pia.entity.JeDodeljenKey;

@CrossOrigin
@RepositoryRestResource(collectionResourceRel  = "jedodeljen",  path = "jedodeljen")
public interface JeDodeljenRepository extends JpaRepository<JeDodeljen, JeDodeljenKey>{
	
	@Query("select jo from JeDodeljen jo where jo.kurir.id=:id")
	public Page<JeDodeljen> findByKurirId(@Param("id") Long id, Pageable pageable);
	
	@Query("select jo from JeDodeljen jo where jo.porudzbina.id=:id")
	public Page<JeDodeljen> findByPorudzbinaId(@Param("id") Long id, Pageable pageable);
	
	@Query("select jo from JeDodeljen jo where jo.kurir.id=:uid and jo.porudzbina.id=:pid")
	public Page<JeDodeljen> findByKurirIdAndPorudzbinaId(@Param("uid") Long mid, @Param("pid") Long pid, Pageable pageable);
	
	
	
}
