package com.aleks.pia.entity;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "je_dodeljen")
@Data
public class JeDodeljen {
	
	@EmbeddedId
	private JeDodeljenKey id;
	
	
	@ManyToOne
    @MapsId("kurir_id")
    @JoinColumn(name = "kurir_id")
    private Kurir kurir;
 
    @ManyToOne
    @MapsId("porudzbina_id")
    @JoinColumn(name = "porudzbina_id")
    private Porudzbina porudzbina;
    

	private BigDecimal udaljenost;
	
	private BigDecimal vreme;
	
	private Date vremePreuzimanja;
	
	private Date vremeIsporuke;

}
