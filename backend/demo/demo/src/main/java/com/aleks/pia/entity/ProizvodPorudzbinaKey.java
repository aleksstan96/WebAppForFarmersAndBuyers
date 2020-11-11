package com.aleks.pia.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

import lombok.Data;

@Embeddable
@Data
public class ProizvodPorudzbinaKey implements Serializable{
	

	@Column(name = "porudzbina_id")
	Long porudzbina_id;
	
	@Column(name = "proizvod_id")
	Long proizvod_id;




}
