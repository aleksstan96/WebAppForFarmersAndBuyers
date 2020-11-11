package com.aleks.pia.entity;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "proizvodi")
@Data
public class Proizvod {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
	private Long id;
	
	private String info;
	
	private String naziv;
	
	private BigDecimal cena;
	
	private int kolicina;
	
	private String slikaUrl;
	
	private String kategorija;
	
	private int dani;
	
	private BigDecimal ocena;
	
	private int brOcena;
	
	@ManyToOne
	@JoinColumn(name = "preduzece_id")
	private Preduzece preduzece;
	

}
