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
@Table(name = "poljoprivrednici")
@Data
public class Poljoprivrednik {
	
	
	 @Id
	 @GeneratedValue(strategy = GenerationType.IDENTITY)
	 @Column(name = "id")
	private Long id;
	
	private String ime;
	
	private String prezime;
	
	private Date datumRodjenja;
	
	private String mestoRodjenja;
	
	private String telefon;
	
	private String email;

	@OneToOne
	@JoinColumn(name = "user_id")
	private User user;
	
	//@OneToMany(mappedBy = "poljoprivrednik", cascade = CascadeType.ALL) //neka ovako dok ne izmenis i u bazi da bude cascade
	@OneToMany(mappedBy = "poljoprivrednik", cascade = CascadeType.ALL)
	private List<Rasadnik> rasadnici;
	
	@OneToMany(mappedBy = "poljoprivrednik", cascade = CascadeType.ALL)
	private List<Porudzbina> porudzbine;
	
}
