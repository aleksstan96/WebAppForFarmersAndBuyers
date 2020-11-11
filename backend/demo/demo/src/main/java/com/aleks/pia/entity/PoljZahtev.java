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
@Table(name="polj_zahtevi")
@Data
public class PoljZahtev {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
	private Long id;
	
	private String ime;
	
	private String prezime;
	
	private String username;
	
	private String password;
	
	private Date datumRodjenja;
	
	private String mestoRodjenja;
	
	private String telefon;
	
	private String email;
	
	private boolean prihvacen;
	
	private boolean nijePrihvacen;
	

}
