package com.aleks.pia.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

import lombok.Data;

@Embeddable
@Data
public class MagacinProizvodKey implements Serializable{
	
	@Column(name = "magacin_id")
	Long magacin_id;
	
	@Column(name = "proizvod_id")
	Long proizvod_id;

}
