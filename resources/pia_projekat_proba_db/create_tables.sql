DROP TABLE IF EXISTS `polj_zahtevi`;

CREATE TABLE `pia_projekat_proba`.`polj_zahtevi` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `ime` VARCHAR(45) NULL,
  `prezime` VARCHAR(45) NULL,
  `username` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `datum_rodjenja` DATE NULL,
  `mesto_rodjenja` VARCHAR(45) NULL,
  `telefon` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `prihvacen` BIT NULL DEFAULT 0,
  `nije_prihvacen` BIT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  )ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
   
   

   DROP TABLE IF EXISTS `pred_zahtevi`;

   
   CREATE TABLE `pia_projekat_proba`.`pred_zahtevi` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `naziv` VARCHAR(45) NULL,
  `skracenica` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `datum_osnivanja` DATE NULL,
  `mesto_osnivanja` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `prihvacen` BIT NULL DEFAULT 0,
  `nije_prihvacen` BIT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;


	DROP TABLE IF EXISTS `users`;


	CREATE TABLE `pia_projekat_proba`.`users` (
	  `id` BIGINT NOT NULL AUTO_INCREMENT,
	  `username` VARCHAR(45) NULL,
	  `password` VARCHAR(45) NULL,
	  `role` VARCHAR(45) NULL,
	  PRIMARY KEY (`id`),
	  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE
	)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
	
	
	
	DROP TABLE IF EXISTS `poljoprivrednici`;	
	
	CREATE TABLE `pia_projekat_proba`.`poljoprivrednici` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT  NULL,
  `ime` VARCHAR(45) NULL,
  `prezime` VARCHAR(45) NULL,
  `datum_rodjenja` DATE NULL,
  `mesto_rodjenja` VARCHAR(45) NULL,
  `telefon` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `id_poljoprivrednik`
    FOREIGN KEY (`user_id`)
    REFERENCES `pia_projekat_proba`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
	
	
	
	DROP TABLE IF EXISTS `preduzeca`;		
	
	CREATE TABLE `pia_projekat_proba`.`preduzeca` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT  NULL,
  `naziv` VARCHAR(45) NULL,
  `datum_osnivanja` DATE NULL,
  `mesto_osnivanja` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `id_preduzece`
    FOREIGN KEY (`user_id`)
    REFERENCES `pia_projekat_proba`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


	
	DROP TABLE IF EXISTS `rasadnici`;	
	
	CREATE TABLE `pia_projekat_proba`.`rasadnici` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `poljoprivrednik_id` BIGINT NULL,
  `naziv` VARCHAR(45) NULL,
  `mesto` VARCHAR(45) NULL,
  `kapacitet` INT NULL,
  `br_sadnica` INT DEFAULT 0,
  `br_slobodnih` INT NULL,
  `voda` INT DEFAULT 200,
  `temperatura` REAL DEFAULT 18,
  `duzina` INT NULL,
  `sirina` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_poljoprivrednika_idx` (`poljoprivrednik_id` ASC) VISIBLE,
  CONSTRAINT `id_poljoprivrednika`
    FOREIGN KEY (`poljoprivrednik_id`)
    REFERENCES `pia_projekat_proba`.`poljoprivrednici` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

	
	
	DROP TABLE IF EXISTS `sadnice`;	

	CREATE TABLE `pia_projekat_proba`.`sadnice` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `rasadnik_id` BIGINT  NULL,
  `naziv` VARCHAR(45) NULL,
  `progres` REAL DEFAULT 0,
  `vek` INT NULL,
  `br_polja` INT NULL,
  `uklonjena` BIT DEFAULT 0,
  `proizvodjac` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `id_rasadnika_idx` (`rasadnik_id` ASC) VISIBLE,
  CONSTRAINT `id_rasadnika`
    FOREIGN KEY (`rasadnik_id`)
    REFERENCES `pia_projekat_proba`.`rasadnici` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

	
	
	DROP TABLE IF EXISTS `magacini`;		
	
	CREATE TABLE `pia_projekat_proba`.`magacini` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `rasadnik_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_rasadnika1_idx` (`rasadnik_id` ASC) VISIBLE,
  CONSTRAINT `id_rasadnika1`
    FOREIGN KEY (`rasadnik_id`)
    REFERENCES `pia_projekat_proba`.`rasadnici` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

	
	
	DROP TABLE IF EXISTS `proizvodi`;
		
	CREATE TABLE `pia_projekat_proba`.`proizvodi` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `preduzece_id` BIGINT  NULL,
  `naziv` VARCHAR(45) NULL,
  `sifra` VARCHAR(45) NULL,
  `info` VARCHAR(200) NULL,
  `cena` DECIMAL(13,2) NULL,
  `kolicina` INT NULL,
   `slika_url` VARCHAR(200) NULL,
   `kategorija` VARCHAR(45) NULL,
   `dani` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `sifra_UNIQUE` (`sifra` ASC) VISIBLE,
  INDEX `id_preduzece_idx` (`preduzece_id` ASC) VISIBLE,
  CONSTRAINT `id_preduzece1`
    FOREIGN KEY (`preduzece_id`)
    REFERENCES `pia_projekat_proba`.`preduzeca` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

	
	

	
	DROP TABLE IF EXISTS `magacin_proizvod`;	
	
	CREATE TABLE `pia_projekat_proba`.`magacin_proizvod` (
  `magacin_id` BIGINT NOT NULL,
  `proizvod_id` BIGINT NOT NULL,
  `naziv` VARCHAR(45) NULL,
  `proizvodjac` VARCHAR(45) NULL ,
  `kolicina` INT NULL,
  `dani` INT NULL,
  `kategorija` VARCHAR(45) NULL ,
  PRIMARY KEY (`magacin_id`, `proizvod_id`),
  INDEX `id_proizvod_idx` (`proizvod_id` ASC) VISIBLE,
  CONSTRAINT `magacin_id`
    FOREIGN KEY (`magacin_id`)
    REFERENCES `pia_projekat_proba`.`magacini` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `proizvod_id`
    FOREIGN KEY (`proizvod_id`)
    REFERENCES `pia_projekat_proba`.`proizvodi` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
	
	ALTER TABLE `pia_projekat_proba`.`magacin_proizvod` 
	ADD COLUMN `naziv` VARCHAR(45) NULL AFTER `proizvod_id`,
	ADD COLUMN `proizvodjac` VARCHAR(45) NULL AFTER `naziv`,
	ADD COLUMN `dani` INT NULL AFTER `kolicina`;

	
	
	
	DROP TABLE IF EXISTS `je_ocenio`;	
	
	CREATE TABLE `pia_projekat_proba`.`je_ocenio` (
  `user_id` BIGINT NOT NULL,
  `proizvod_id` BIGINT NOT NULL,
  `komentar` VARCHAR(450) NULL,
  `ocena` INT NULL,
  PRIMARY KEY (`id_user`, `id_proizvod`),
  INDEX `id_proizovd_idx` (`id_proizvod` ASC) VISIBLE,
  CONSTRAINT `id_user`
    FOREIGN KEY (`id_user`)
    REFERENCES `pia_projekat_proba`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `id_proizovd`
    FOREIGN KEY (`id_proizvod`)
    REFERENCES `pia_projekat_proba`.`proizvodi` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);

	
	
	DROP TABLE IF EXISTS `porudzbine`;	
	
	CREATE TABLE `pia_projekat_proba`.`porudzbine` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `preduzece_id` BIGINT  NULL,
  `polj_id` BIGINT  NULL,
  `rasadnik_id` BIGINT  NULL,
  `cena` DECIMAL(13) NULL DEFAULT 0 ,
  `status` VARCHAR(45) NULL DEFAULT 'kreirana',
  `datum_kreiranja` DATE NULL,
  `datum_prihvatanja` DATE NULL,
  PRIMARY KEY (`id`),
  INDEX `id_pred_idx` (`preduzece_id` ASC) VISIBLE,
  INDEX `id_polj_idx` (`polj_id` ASC) VISIBLE,
  INDEX `id_rasadnik_idx` (`rasadnik_id` ASC) VISIBLE,
  CONSTRAINT `id_pred`
    FOREIGN KEY (`preduzece_id`)
    REFERENCES `pia_projekat_proba`.`preduzeca` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `id_polj`
    FOREIGN KEY (`polj_id`)
    REFERENCES `pia_projekat_proba`.`poljoprivrednici` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `id_rasadnik`
    FOREIGN KEY (`rasadnik_id`)
    REFERENCES `pia_projekat_proba`.`rasadnici` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

	
	
	
	
	DROP TABLE IF EXISTS `proizvod_porudzbina`;		
	
	CREATE TABLE `pia_projekat_proba`.`proizvod_porudzbina` (
  `porudzbina_id` BIGINT NOT NULL,
  `proizvod_id` BIGINT NOT NULL,
  `kolicina` INT NULL,
  PRIMARY KEY (`porudzbina_id`, `proizvod_id`),
  INDEX `id_proizvod_idx` (`proizvod_id` ASC) VISIBLE,
  CONSTRAINT `id_porudzbina`
    FOREIGN KEY (`porudzbina_id`)
    REFERENCES `pia_projekat_proba`.`porudzbine` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `id_proizvod1`
    FOREIGN KEY (`proizvod_id`)
    REFERENCES `pia_projekat_proba`.`proizvodi` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


	
	
	DROP TABLE IF EXISTS `kuriri`;	
	
	CREATE TABLE `pia_projekat_proba`.`kuriri` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `preduzece_id` BIGINT NULL,
  `ime` VARCHAR(45) NULL,
  `slobodan` BIT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `id_preduzecekurir_idx` (`preduzece_id` ASC) VISIBLE,
  CONSTRAINT `id_preduzecekurir`
    FOREIGN KEY (`preduzece_id`)
    REFERENCES `pia_projekat_proba`.`preduzeca` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);
	
	
	
	
	DROP TABLE IF EXISTS `je_dodeljen`;
	
	CREATE TABLE `pia_projekat_proba`.`je_dodeljen` (
  `kurir_id` BIGINT NOT NULL,
  `porudzbina_id` BIGINT NOT NULL,
  `udaljenost` DECIMAL(15,5) NULL,
  `vreme` DECIMAL(15,5) NULL,
  PRIMARY KEY (`kurir_id`, `porudzbina_id`),
  INDEX `id_por_idx` (`porudzbina_id` ASC) VISIBLE,
  CONSTRAINT `id_kurira`
    FOREIGN KEY (`kurir_id`)
    REFERENCES `pia_projekat_proba`.`kurir` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `id_por`
    FOREIGN KEY (`porudzbina_id`)
    REFERENCES `pia_projekat_proba`.`porudzbine` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
	
	
	
	DROP TABLE IF EXISTS `messages`;
	
	CREATE TABLE `pia_projekat_proba`.`messages` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `message` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`));

