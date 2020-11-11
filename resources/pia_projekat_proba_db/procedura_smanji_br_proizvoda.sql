CREATE DEFINER=`root`@`localhost` PROCEDURE `smanji_br_proizvoda`(porId BIGINT(20))
BEGIN
	DECLARE done INT DEFAULT FALSE;
	DECLARE proizvodId  BIGINT(20);
	DECLARE kol  INT;
	DECLARE kursor CURSOR FOR SELECT proizvod_id, kolicina from proizvod_porudzbina where porudzbina_id=porId;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN kursor;

  read_loop: LOOP
    FETCH kursor INTO proizvodId, kol;
   
    IF done THEN
      LEAVE read_loop;
    END IF;
    
    update proizvodi set kolicina = kolicina-kol where id=proizvodId;
  END LOOP;

  CLOSE kursor;
END