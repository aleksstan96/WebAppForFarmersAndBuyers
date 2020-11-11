DROP TRIGGER IF EXISTS `pia_projekat_proba`.`rasadnici_AFTER_INSERT`;

DELIMITER $$
USE `pia_projekat_proba`$$
CREATE DEFINER = CURRENT_USER TRIGGER `pia_projekat_proba`.`rasadnici_AFTER_INSERT` AFTER INSERT ON `rasadnici` FOR EACH ROW
BEGIN
 INSERT INTO magacini SET rasadnik_id = NEW.id;
END$$
DELIMITER ;

-- triggeri za magacin_proizvod---

DROP TRIGGER IF EXISTS `pia_projekat_proba`.`magacin_proizvod_naziv_BEFORE_INSERT`;

CREATE DEFINER = CURRENT_USER TRIGGER `pia_projekat_proba`.`magacin_proizvod_naziv_BEFORE_INSERT` BEFORE INSERT ON `magacin_proizvod` FOR EACH ROW

		SET NEW.naziv = (SELECT naziv FROM `pia_projekat_proba`.`proizvodi` WHERE id = NEW.proizvod_id );
        
		

DROP TRIGGER IF EXISTS `pia_projekat_proba`.`magacin_proizvod_dani_BEFORE_INSERT`;

CREATE DEFINER = CURRENT_USER TRIGGER `pia_projekat_proba`.`magacin_proizvod_dani_BEFORE_INSERT` BEFORE INSERT ON `magacin_proizvod` FOR EACH ROW
FOLLOWS `magacin_proizvod_naziv_BEFORE_INSERT`
	SET NEW.dani =  (SELECT dani FROM `pia_projekat_proba`.`proizvodi` WHERE NEW.proizvod_id = id);
    
    

DROP TRIGGER IF EXISTS `pia_projekat_proba`.`magacin_proizvod_pro_BEFORE_INSERT`;

CREATE DEFINER = CURRENT_USER TRIGGER `pia_projekat_proba`.`magacin_proizvod_pro_BEFORE_INSERT` BEFORE INSERT ON `magacin_proizvod` FOR EACH ROW
FOLLOWS `magacin_proizvod_dani_BEFORE_INSERT`
SET NEW.proizvodjac =  (SELECT proizvodjac.naziv FROM `pia_projekat_proba`.`preduzeca` proizvodjac, `pia_projekat_proba`.`proizvodi` proizvod 
								WHERE NEW.proizvod_id = proizvod.id AND proizvod.preduzece_id = proizvodjac.id)	;
								
								

								
DROP TRIGGER IF EXISTS `pia_projekat_proba`.`magacin_proizvod_kategorija_BEFORE_INSERT`;

CREATE DEFINER = CURRENT_USER TRIGGER `pia_projekat_proba`.`magacin_proizvod_kategorija_BEFORE_INSERT` BEFORE INSERT ON `magacin_proizvod` FOR EACH ROW

		SET NEW.kategorija = (SELECT kategorija FROM `pia_projekat_proba`.`proizvodi` WHERE id = NEW.proizvod_id );
        
		
								
	-------------------
	
		
CREATE TRIGGER sadnica_brisanje AFTER UPDATE ON sadnice
FOR EACH ROW
BEGIN
   IF (NEW.uklonjena = 1) THEN
      DROP EVENT ukloni_sadnicu

		CREATE EVENT ukloni_sadnicu
		
			ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 DAY
			DO
				delete from sadnice where id=NEW.id;
      
   END IF;
END;

-------------
CREATE DEFINER = CURRENT_USER TRIGGER `pia_projekat_proba`.`polj_zahtevi_AFTER_UPDATE` AFTER UPDATE ON `polj_zahtevi` FOR EACH ROW
BEGIN
	IF OLD.prihvacen = 1 THEN
    INSERT INTO poljoprivrednici(ime,prezime,datum_rodjenja,mesto_rodjenja,telefon,email) 
		VALUES (OLD.ime, OLD.prezime, OLD.datum_rodjenja, OLD.mesto_rodjenja, OLD.telefon, OLD.email);
		INSERT INTO users(username, password, role) VALUES (OLD.username, OLD.PASSWORD,"ROLE_POLJOPRIVREDNIK");
			END IF;
END


--------------

CREATE DEFINER=`root`@`localhost` TRIGGER `pred_zahtevi_AFTER_UPDATE` AFTER UPDATE ON `pred_zahtevi` FOR EACH ROW BEGIN
	IF OLD.prihvacen = 1 THEN
    INSERT INTO preduzeca(naziv,datum_osnivanja,mesto_osnivanja,email) 
		VALUES (OLD.naziv, OLD.datum_osnivanja, OLD.mesto_osnivanja, OLD.email);
		INSERT INTO users(username, password, role) VALUES (OLD.skracenica, OLD.PASSWORD,"ROLE_PREDUZECE");
			END IF;
END
			
---------------

CREATE DEFINER = CURRENT_USER TRIGGER `pia_projekat_proba`.`users_AFTER_INSERT` AFTER INSERT ON `users` FOR EACH ROW
BEGIN
	IF NEW.role = "ROLE_POLJOPRIVREDNIK" THEN
		UPDATE poljoprivrednici SET user_id = NEW.id WHERE user_id IS NULL;
	END IF;	
	IF NEW.role = "ROLE_PREDUZECE" THEN
		UPDATE preduzeca SET user_id=NEW.id WHERE user_id IS NULL;
	END IF;
	
END
------------------------------------

CREATE DEFINER=`root`@`localhost` TRIGGER `je_ocenio_AFTER_INSERT` AFTER INSERT ON `je_ocenio` FOR EACH ROW BEGIN
 UPDATE  proizvodi SET ocena = (ocena*br_ocena + NEW.ocena)/(br_ocena+1) WHERE id = NEW.proizvod_id;
 UPDATE proizvodi SET br_ocena = br_ocena + 1  WHERE id = NEW.proizvod_id;
END

-------------------------------------

CREATE DEFINER=`root`@`localhost` TRIGGER `proizvod_porudzbina_AFTER_INSERT` AFTER INSERT ON `proizvod_porudzbina` FOR EACH ROW BEGIN
	UPDATE porudzbine SET cena = cena + NEW.kolicina*(
    SELECT cena FROM proizvodi p where p.id = NEW.proizvod_id ) WHERE id =NEW.porudzbina_id;
END


-----------------------------------
CREATE DEFINER = CURRENT_USER TRIGGER `pia_projekat_proba`.`je_dodeljen_AFTER_INSERT` AFTER INSERT ON `je_dodeljen` FOR EACH ROW
BEGIN

 update kuriri set slobodan=false where id=NEW.kurir_id;
END
-------------------------------------------------
CREATE DEFINER=`root`@`localhost` TRIGGER `porudzbine_AFTER_UPDATE` AFTER UPDATE ON `porudzbine` FOR EACH ROW BEGIN
	if(NEW.status='prihvacena')then
		call smanji_br_proizvoda(NEW.id);
    end if; 
    if(NEW.status='isporucena')then
		call povacaj_br_proizvoda_u_magacinu(
			NEW.id,
            (select id  from magacini where rasadnik_id=NEW.rasadnik_id)
        );
        
    end if;
END


-------------------------------------------------------------------------------------
CREATE DEFINER=`root`@`localhost` TRIGGER `sadnice_BEFORE_DELETE` BEFORE DELETE ON `sadnice` FOR EACH ROW BEGIN
	update rasadnici set br_sadnica=br_sadnica-1, br_slobodnih=br_slobodnih+1 where id=OLD.rasadnik_id;
END
