CREATE DEFINER=`root`@`localhost` PROCEDURE `progres_sadnica`()
BEGIN
  UPDATE sadnice SET progres = progres + 1/vek;
  INSERT INTO messages(message,created_at)
  VALUES('Sadnice obavile dnevni progres',NOW());
END