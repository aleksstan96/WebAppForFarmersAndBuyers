package com.aleks.pia.entity;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "je_ocenio")
@Data
public class JeOcenio {
	
	@EmbeddedId
	private JeOcenioKey id;
	
	
	@ManyToOne
    @MapsId("user_id")
    @JoinColumn(name = "user_id")
    private User user;
 
    @ManyToOne
    @MapsId("proizvod_id")
    @JoinColumn(name = "proizvod_id")
    private Proizvod proizvod;
    
    private String komentar;
    
    private int ocena;

}
