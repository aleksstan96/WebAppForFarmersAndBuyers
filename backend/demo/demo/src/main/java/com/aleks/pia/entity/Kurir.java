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
@Table(name = "kuriri")
@Data
public class Kurir {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
	private Long id;
	
	private String ime;
	
	private boolean slobodan;
	
	@ManyToOne
	@JoinColumn(name = "preduzece_id")
	private Preduzece preduzece;
	

}
