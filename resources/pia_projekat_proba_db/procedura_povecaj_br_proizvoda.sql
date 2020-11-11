CREATE PROCEDURE `povacaj_br_proizvoda_u_magacinu` (porId  BIGINT(20), magId  BIGINT(20))
BEGIN
	DECLARE done INT DEFAULT FALSE;
	DECLARE proizvodId  BIGINT(20);
	DECLARE kol  INT;
    DECLARE cnt  INT;
	DECLARE kursor CURSOR FOR SELECT proizvod_id, kolicina from proizvod_porudzbina where porudzbina_id=porId;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN kursor;

  read_loop: LOOP
    FETCH kursor INTO proizvodId, kol;
   
    IF done THEN
      LEAVE read_loop;
    END IF;
set cnt = (select count(*)  from magacin_proizvod where magacin_id=magId and proizvod_id=proizvodId);
    if cnt>0 then
		update magacin_proizvod set kolicina = kolicina+kol where proizvod_id=proizvodId;    
	else
		insert into magacin_proizvod(magacin_id, proizvod_id, kolicina) values (magId,proizvodId, kol);
    end if;
  END LOOP;

  CLOSE kursor;
END
