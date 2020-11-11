package com.aleks.pia.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name="pred_zahtevi")
@Data
public class PredZahtev {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
	private Long id;
	
	private String naziv;
	
	private String skracenica;
	
	private String password;
	
	private Date datumOsnivanja;
	
	private String mestoOsnivanja;
	
	private String email;
	
	private boolean prihvacen;
	
	private boolean nijePrihvacen;
	

}
