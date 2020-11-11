CREATE DEFINER=`root`@`localhost` PROCEDURE `update_kuriri`()
BEGIN
	DECLARE done INT DEFAULT FALSE;
	DECLARE kurirId  BIGINT(20);
	DECLARE porId  BIGINT(20);
    DECLARE vi  datetime;
	DECLARE kursor CURSOR FOR SELECT kurir_id, porudzbina_id, vreme_isporuke from je_dodeljen;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN kursor;

  read_loop: LOOP
    FETCH kursor INTO kurirId, porId, vi;
   
    IF done THEN
      LEAVE read_loop;
    END IF;
    
    if now()>=vi then
		update porudzbine set status = 'isporucena' where id=porId; 
        update kuriri set slobodan=true where id = kurirId;
    end if;
  END LOOP;

  CLOSE kursor;
END