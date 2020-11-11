package com.aleks.pia.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

import lombok.Data;

@Embeddable
@Data
public class JeOcenioKey implements Serializable{
	

	@Column(name = "user_id")
	Long user_id;
	
	@Column(name = "proizvod_id")
	Long proizvod_id;




}
