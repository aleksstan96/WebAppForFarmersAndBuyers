package com.aleks.pia.entity;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "proizvod_porudzbina")
@Data
public class ProizvodPorudzbina {
	
	@EmbeddedId
	private ProizvodPorudzbinaKey id;
	
	
	@ManyToOne
    @MapsId("porudzbina_id")
    @JoinColumn(name = "porudzbina_id")
    private Porudzbina porudzbina;
 
    @ManyToOne
    @MapsId("proizvod_id")
    @JoinColumn(name = "proizvod_id")
    private Proizvod proizvod;

    private int kolicina;

}
