package com.aleks.pia.entity;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "magacin_proizvod")
@Data
public class MagacinProizvod {
	
	@EmbeddedId
	private MagacinProizvodKey id;
	
	
	@ManyToOne
    @MapsId("magacin_id")
    @JoinColumn(name = "magacin_id")
    private Magacin magacin;
 
    @ManyToOne
    @MapsId("proizvod_id")
    @JoinColumn(name = "proizvod_id")
    private Proizvod proizvod;
    
    private String naziv;
    
    private String proizvodjac;
    
    private String kategorija;
    
    private int kolicina;
    
    private int dani;

}
