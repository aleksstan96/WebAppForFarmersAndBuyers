package com.aleks.pia.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "preduzeca")
@Data
public class Preduzece {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Long id;
	
	private String naziv;
	
	private Date datumOsnivanja;
	
	private String mestoOsnivanja;
	
	private String email;
	
	@OneToOne
	@JoinColumn(name = "user_id")
	private User user;
	
	@OneToMany(mappedBy = "preduzece", cascade = CascadeType.ALL) //zelim da ako mi se obrise/izmeni preduzece obrisem/izmenim i proizvode
	private List<Proizvod> proizvodi;
	

	@OneToMany(mappedBy = "preduzece", cascade = CascadeType.ALL) //zelim da ako mi se obrise/izmeni preduzece obrisem/izmenim i proizvode
	private List<Porudzbina> porudzbine;
	
	@OneToMany(mappedBy = "preduzece")
	private List<Kurir> kuriri;

}
