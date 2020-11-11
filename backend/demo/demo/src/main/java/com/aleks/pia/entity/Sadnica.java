package com.aleks.pia.entity;

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
@Table(name = "sadnice")
@Data
public class Sadnica {
	
	 @Id
	 @GeneratedValue(strategy = GenerationType.IDENTITY)
	 @Column(name = "id")
	 private Long id;
	 
	 private String naziv;
	 
	 private String proizvodjac;
	 
	 private Double progres;
	 
	 private int vek;
	 
	 private int brPolja;
	 
	 private boolean uklonjena;
	 
	 	 
	 @ManyToOne //necu nista da bude cascade
	 @JoinColumn(name = "rasadnik_id")
	 private Rasadnik rasadnik;
	

}
