package com.aleks.pia.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.web.bind.annotation.CrossOrigin;

import com.aleks.pia.entity.MagacinProizvod;
import com.aleks.pia.entity.MagacinProizvodKey;

@CrossOrigin
@RepositoryRestResource(collectionResourceRel  = "magacinproizvodi",  path = "magacinproizvodi")
public interface MagacinProizvodRepository extends JpaRepository<MagacinProizvod, MagacinProizvodKey>{
	
	@Query("select mp from MagacinProizvod mp where mp.magacin.id=:id")
	public Page<MagacinProizvod> findByMagacinId(@Param("id") Long id, Pageable pageable);
	
	@Query("select mp from MagacinProizvod mp where mp.magacin.id=:mid and mp.proizvod.id=:pid")
	public Page<MagacinProizvod> findByMagacinIdAndProizvodId(@Param("mid") Long mid, @Param("pid") Long pid, Pageable pageable);
	
	@Query("select mp from MagacinProizvod mp where mp.magacin.id=:id and mp.kategorija=:kategorija")
	public Page<MagacinProizvod> findByMagacinIdAndKategorija(@Param("id") Long id, @Param("kategorija") String kategorija, Pageable pageable);

	
}
