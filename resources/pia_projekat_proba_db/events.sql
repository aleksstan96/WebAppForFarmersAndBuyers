

-- DROP EVENT  rasadnik_update;

CREATE EVENT rasadnik_update
ON SCHEDULE EVERY 5 minute
STARTS CURRENT_TIMESTAMP
DO
  UPDATE rasadnici SET temperatura = temperatura - 0.5, voda = voda - 1;
  INSERT INTO messages(message,created_at)
  VALUES('Temperatura smanjena za pola stepena',NOW()),('Kolicina vode smanjena za litar',NOW());
  
  ------------------
  
-- DROP EVENT  sadnica_update;

CREATE EVENT sadnica_update
ON SCHEDULE EVERY 3 minute
DO  CALL progres_sadnica();


-------------------

-- DROP EVENT  sadnica_izvadjena;

  CREATE EVENT sadnica_izvadjena
ON SCHEDULE EVERY 1 second
DO  CALL sadnica_izvadjena();


--------------
-- DROP EVENT  refresh_kuriri;

CREATE EVENT refresh_kuriri
ON SCHEDULE EVERY 1 MINUTE
STARTS CURRENT_TIMESTAMP
DO
   call update_kuriri();
   
SET GLOBAL event_scheduler = ON;

SHOW PROCESSLIST;