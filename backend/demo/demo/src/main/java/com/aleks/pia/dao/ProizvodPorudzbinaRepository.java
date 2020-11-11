package com.aleks.pia.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.web.bind.annotation.CrossOrigin;

import com.aleks.pia.entity.ProizvodPorudzbina;
import com.aleks.pia.entity.ProizvodPorudzbinaKey;

@CrossOrigin
@RepositoryRestResource(collectionResourceRel  = "proizvodporudzbina",  path = "proizvodporudzbina")
public interface ProizvodPorudzbinaRepository extends JpaRepository<ProizvodPorudzbina, ProizvodPorudzbinaKey>{
	
	@Query("select pp from ProizvodPorudzbina pp where pp.id.porudzbina_id=:id")
	public Page<ProizvodPorudzbina> findByPorudzbinaId(@Param("id") Long id, Pageable pageable);
	
	@Query("select pp from ProizvodPorudzbina pp where pp.id.proizvod_id=:prid and  pp.id.porudzbina_id=:poid")
	public Page<ProizvodPorudzbina> findByProizvodIdAndPorudzbinaId(@Param("prid") Long prid,@Param("poid") Long poid, Pageable pageable);
	
//	@Query("select jo from JeOcenio jo where jo.proizvod.id=:id")
//	public Page<JeOcenio> findByProizvodId(@Param("id") Long id, Pageable pageable);
//	
//	@Query("select jo from JeOcenio jo where jo.user.id=:uid and jo.proizvod.id=:pid")
//	public Page<JeOcenio> findByUserIdAndProizvodId(@Param("uid") Long mid, @Param("pid") Long pid, Pageable pageable);
	
	
	
}
