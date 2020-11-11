package com.aleks.pia.entity;

import java.math.BigDecimal;
import java.util.Date;

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
@Table(name = "porudzbine")
@Data
public class Porudzbina {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
	private Long id;
	
	private BigDecimal cena;
	
	private Date datumKreiranja;
	
	private Date datumPrihvatanja;
	
	private String status;
	
	@ManyToOne
	@JoinColumn(name = "preduzece_id")
	private Preduzece preduzece;
	
	@ManyToOne
	@JoinColumn(name = "polj_id")
	private Poljoprivrednik poljoprivrednik;
	
	@ManyToOne
	@JoinColumn(name = "rasadnik_id")
	private Rasadnik rasadnik;
	

}
