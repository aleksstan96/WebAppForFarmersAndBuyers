package com.aleks.pia.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "rasadnici")
@Data
public class Rasadnik {
	
	 @Id
	 @GeneratedValue(strategy = GenerationType.IDENTITY)
	 @Column(name = "id")
	 private Long id;
	 
	 private String naziv;
	 
	 private String mesto;
	 
	 private int brSadnica;
	 
	 private int brSlobodnih;
	 
	 private int kapacitet;
	 
	 private int voda;
	 
	 private Double temperatura;
	 
	 private int duzina;
	 
	 private int sirina;
	 
	 @ManyToOne //necu nista da bude cascade
	 @JoinColumn(name = "poljoprivrednik_id")
	 private Poljoprivrednik poljoprivrednik;
	 
	// @OneToMany(mappedBy = "rasadnik", cascade = CascadeType.ALL) //ovako ce valjda promena rasadnika da utice na sadnice
	 @OneToMany(mappedBy = "rasadnik", cascade = CascadeType.ALL) //neka ovako dok ne promenis i u bazi na cascade
	 private List<Sadnica> sadnice;
	 
	 @OneToOne(mappedBy = "rasadnik", cascade = CascadeType.ALL)
	 private Magacin magacin;
	 
	 @OneToMany(mappedBy = "rasadnik",  cascade = CascadeType.ALL)
		private List<Porudzbina> porudzbine;
		
	 
	

}
