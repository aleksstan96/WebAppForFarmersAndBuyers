package com.aleks.pia.entity;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Embeddable;

import lombok.Data;

@Embeddable
@Data
public class JeDodeljenKey implements Serializable{
	

	@Column(name = "kurir_id")
	Long kurir_id;
	
	@Column(name = "porudzbina_id")
	Long porudzbina_id;
	




}
