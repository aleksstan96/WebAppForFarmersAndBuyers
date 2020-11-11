-- users --

INSERT INTO `pia_projekat_proba`.`users`
(
`username`,
`password`,
`role`)
VALUES
('marko123', '123', 'ROLE_POLJOPRIVREDNIK'),
('aleks123', '123', 'ROLE_ADMIN'),
('milan123', '123', 'ROLE_POLJOPRIVREDNIK'),
('sasa123', '123', 'ROLE_ADMIN'),
('kata123', '123', 'ROLE_POLJOPRIVREDNIK'),
('milos123', '123', 'ROLE_POLJOPRIVREDNIK'),
('ivan123', '123', 'ROLE_POLJOPRIVREDNIK'),
('zanka123', '123', 'ROLE_POLJOPRIVREDNIK'),
('djordje123', '123', 'ROLE_POLJOPRIVREDNIK'),
('alka', '111', 'ROLE_PREDUZECE'),
('libis', '111', 'ROLE_PREDUZECE'),
('aeron', '111', 'ROLE_PREDUZECE'),
('zitoplan', '111', 'ROLE_PREDUZECE'),
('sevojnicanka', '111', 'ROLE_PREDUZECE'),
('agros', '111', 'ROLE_PREDUZECE'),
('zdravka', '111', 'ROLE_PREDUZECE')
;

-- poljoprivrednici--

INSERT INTO `pia_projekat_proba`.`poljoprivrednici`
(`id_user`,
`ime`,
`prezime`,
`datum_rodjenja`,
`mesto_rodjenja`,
`telefon`,
`email`)
VALUES
(1 ,'Marko', 'Maric', '1990-09-01' , 'Bajina Basta', '0655050444' , 'mare123@gmail.com'),
(3 ,'Milan', 'Milic', '1971-06-09' , 'Uzice ', '0655050444' , 'milan123@gmail.com'),
(5 ,'Katarina', 'Stanic', '1966-09-12' , 'Uzice ', '0655050444' , 'kata123@gmail.com'),
(6 ,'Milos', 'Lilic', '1960-03-03' , 'Svilajnac', '0655050444' , 'milos123@gmail.com'),
(7 ,'Ivan', 'Rakic', '1990-06-13' , 'Baranda', '0655050444' , 'ivan123@gmail.com'),
(8 ,'Zanka', 'Katic', '1967-09-01' , 'Ljubanje', '0655050444' , 'zanka123@gmail.com'),
(9 ,'Marko', 'Maric', '1984-11-27' , 'Buar', '0655050444' , 'mare123@gmail.com')
;


-- preduzeca --

INSERT INTO `pia_projekat_proba`.`preduzeca`
(`id_user`,
`naziv`,
`datum_osnivanja`,
`mesto_osnivanja`,
`email`)
VALUES
(10, 'alka' , '2001-01-11'  , 'Beograd'  ,  'alka@gmail.com' ),
(11, 'libis' , '2003-01-11'  , 'Beograd'  ,  'libis@gmail.com' ),
(12, 'aeron' , '2005-01-11'  , 'Novi Sad'  ,  'aeron@gmail.com' ),
(13, 'zitoplan' , '2007-01-11'  , 'Cacak'  ,  'zitoplan@gmail.com' ),
(14, 'sevojnicanka' , '2002-01-11'  , 'Uzice'  ,  'sevojnicanka@gmail.com' ),
(15, 'agros' , '2011-01-11'  , 'Nis'  ,  'agros@gmail.com' ),
(16, 'zdravka' , '2004-01-11'  , 'Kraljevo'  ,  'zdravka@gmail.com' )
;


-- rasadnici, ujedno i magacini --

INSERT INTO `pia_projekat_proba`.`rasadnici`
(`id`,
`id_polj`,
`naziv`,
`mesto`,
`kapacitet`,
`br_slobodnih`,
`duzina`,
`sirina`)
VALUES
(1, 1, 'R1_1', 'Rogacica', 100, 100, 10, 10),
(2, 1, 'R1_2', 'Rogacica', 90, 90, 9, 10),
(3, 1, 'R1_3', 'Ovcinja', 120, 120, 10, 12),
(4, 1, 'R1_1', 'Okletac', 100, 100, 10, 10),
(5, 3, 'R3_1', 'Krvavci', 80, 80, 10, 8),
(6, 3, 'R3_2', 'Krvavci', 130, 130, 13, 10),
(7, 3, 'R3_3', 'Buar', 200, 200, 20, 10),
(8, 3, 'R3_4', 'Buar', 72, 72, 8, 9),
(9, 3, 'R3_5', 'Krvavci', 100, 100, 10, 10),
(10, 5, 'R5_1', 'Milicevo selo', 90, 90, 9, 10),
(11, 5, 'R5_2', 'Godovik', 120, 120, 12, 10),
(12, 5, 'R5_3', 'Virovo', 150, 150, 10, 15),
(13, 6, 'R6_1', 'Markovac', 100, 100, 10, 10),
(14, 6, 'R6_2', 'Novo selo', 100, 100, 10, 10),
(15, 6, 'R6_3', 'Staro selo', 100, 100, 10, 10),
(16, 6, 'R6_4', 'Raca', 100, 100, 10, 10),
(17, 7, 'R7_1', 'Baranda', 200, 200, 20, 10),
(18, 7, 'R7_2', 'Baranda', 131, 131, 12, 11),
(19, 7, 'R7_3', 'Sakule', 131, 131, 11, 12),
(20, 7, 'R7_4', 'Opovo', 121, 121, 11, 11)
;



-- sadnice --

INSERT INTO `pia_projekat_proba`.`sadnice`
(
`id_rasadnika`,
`naziv`,
`vek`,
`br_polja`)
VALUES
(1, 'kupus', 120, 1),
(1, 'kupus', 120, 2),
(1, 'kupus', 120, 3),
(1, 'kupus', 120, 4),
(1, 'kupus', 120, 5),
(1, 'luk', 120, 6),
(1, 'luk', 120, 7),
(1, 'luk', 120, 8),
(1, 'luk', 120, 9),
(1, 'luk', 120, 10),
(1, 'sargarepa', 150, 15),
(1, 'sargarepa', 150, 16),
(1, 'sargarepa', 150, 17),
(1, 'sargarepa', 150, 18),
(1, 'sargarepa', 150, 19),
(1, 'sargarepa', 150, 20),
(1, 'kupus', 120, 30),
(1, 'kupus', 120, 31),
(1, 'kupus', 120, 32),
(1, 'kupus', 120, 33),
(1, 'kupus', 120, 34),
(1, 'kupus', 120, 35),
(2, 'cvekla', 140, 10),
(2, 'cvekla', 140, 11),
(2, 'cvekla', 140, 12),
(2, 'cvekla', 140, 13),
(2, 'cvekla', 140, 17),
(2, 'cvekla', 140, 18),
(2, 'cvekla', 140, 19),
(2, 'cvekla', 140, 21),
(2, 'cvekla', 140, 22),
(2, 'cvekla', 140, 23),
(2, 'cvekla', 140, 24),
(2, 'repa', 180, 50),
(2, 'repa', 180, 60),
(2, 'repa', 180, 70),
(2, 'repa', 180, 80),
(2, 'repa', 180, 90),
(2, 'repa', 180, 51),
(2, 'repa', 180, 61),
(2, 'repa', 180, 71),
(2, 'repa', 180, 81),
(2, 'repa', 180, 91)
;

-- proizvodi --


-- preduzece 1: luk --

INSERT INTO `pia_projekat_proba`.`proizvodi`
(
`preduzece_id`,
`naziv`,
`info`,
`cena`,
`kolicina`,
`slika_url`)
VALUES
(1, "Beli luk bosut 25g",  "Jesenja sorta.
Lukovice kompaktne, bele boje, težine oko 60 g.
Čenovi ujednačeni, težine iznad 5 g.
Visok sadržaj suve materije do 35%.", 300, 6000,
 "https://nsseme.com/wp-content/uploads/2019/04/bosut-400x274.jpg"),
 (1, "Beli luk bosut 100 000s", "1blbs", "Jesenja sorta.
Lukovice kompaktne, bele boje, težine oko 60 g.
Čenovi ujednačeni, težine iznad 5 g.
Visok sadržaj suve materije do 35%.", 15000, 1000,
 "https://nsseme.com/wp-content/uploads/2019/04/bosut-400x274.jpg"),
(1, "Crni luk holandski zuti 25g",  
"Lukovica je pljosnato-okrugla, mase 80-120 g.
Suvi ovojni listovi su čvrsti i dobro obavijaju lukovicu, slamastožute boje.
To je poluljuta sorta sa 12% suve materije.
Gaji se iz arpadžika, koji je okruglog oblika.",
250.00, 5000,
"https://nsseme.com/wp-content/uploads/2019/03/crni-luk-holandski-zuti-600x449.jpg"
),
(1, "Crni luk holandski zuti 100 000s", 
"Lukovica je pljosnato-okrugla, mase 80-120 g.
Suvi ovojni listovi su čvrsti i dobro obavijaju lukovicu, slamastožute boje.
To je poluljuta sorta sa 12% suve materije.
Gaji se iz arpadžika, koji je okruglog oblika.",
14400.00, 700,
"https://nsseme.com/wp-content/uploads/2019/03/crni-luk-holandski-zuti-600x449.jpg"
),
(1, "Crni luk Elenka F1 100 000s", 
"Novi, izuzetno prinosan hibrid (preko 90 t/ha) namenjen za najduži lager - čuvanje i do 10 meseci nakon vađenja, sa atraktivnim lukovicama sjajne tamno-bronzane boje. Biljka je brzog i snažnog porasta, tolerantna na plamenjaču. Izuzetno čvrste lukovice sa min. 4 sloja ovojnih listova omogućuje postojanost lukovica i nakon vađenja i nekoliko prebiranja tj.pakovanja.

Kultura: 
Luk
Pakovanje: 
100 000 s
Namena: 
Profesionalna
F1/sorta: 
F1",
14400.00, 560,
"http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/209-elenka.jpg?itok=tITWHjuy"
),
(1, " Fiamma F1 100 000s", 
"Vrlo prinosan hibrid sa najatraktivnijom, sjajnom ljubičastom bojom, ujednačenih krupnih i okruglih lukovica, sa nekoliko čvrstih ovojnih listova od kojih svaki ima visoki sjaj bez obzira na vreme i način čišćenja. Ovaj hibrid luka, za razliku od sličnih, nema problema sa mašinskim vađenjem, zato što su glavice veoma čvrste i otporne na mehanička habanja
Kultura: 
Luk
Pakovanje: 
100 000 s
Namena: 
Profesionalna
F1/sorta: 
F1",
14400.00, 660,
"http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/215-fiamma.jpg?itok=SPovuGp5"
),
(1, "Srebrenjak Kosma F1 100g", 
"Prezimljavajući luk u tipu srebrenjaka. Koristi se za mladi luk ili kad sazre za svežu potrošnju. Lukovice su slatke, hrskave, veoma ukusne. Setva može biti krajem avgusta ili u rano proleće.

Kultura: 
Luk
Pakovanje: 
100 g
Namena: 
Profesionalna
F1/sorta: 
F1
Izvor: 
Uvozni",
1612, 7600,
"http://www.agromaxshop.rs/sites/default/files/styles/product-zoom/public/images/products/1-014-0359-kosma.jpg?itok=4QfeezM5"
),

(1, "Praziluk Lancelot F1 10 000s",
"Ovaj plavo-zeleni tip praziluka namenjen je kasnoj letnjoj i jesenjoj proizvodnji. Vrlo je rodan. Ima lepe, dugačke stabljike, bez okruglih zadebljanja. Formira mnogo tamno zelenog lišća. Dobro podnosi napad virusa. U povoljnim uslovima proizvodnje ova je sorta dala prinos od 56 t/ha. 90 dana vegetacije.

Kultura: 
Praziluk
Pakovanje: 
10 000 s
Namena: 
Profesionalna
F1/sorta: 
F1
Izvor: 
Uvozni",
3720, 860,
"http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/90-lancelot.jpg?itok=5v5VUaWN"
),
(1, "Praziluk Lincoln F1 10 000s", 
"Ova je sorta u tipu dugačkih bugarskih praziluka za letnju proizvodnju. Formira vrlo duge, bele, čvrste, izdužene lukovice, bez okruglastog zadebljanja. Uspravnog je i vrlo visokog rasta. Vrlo rana sorta, s visokim prinosom. 75 dana vegetacije.

Kultura: 
Praziluk
Pakovanje: 
10 000 s
Namena: 
Profesionalna
F1/sorta: 
F1
Izvor: 
Uvozni",
3720, 840,
"http://www.agrhttp://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/88-lincoln.jpg?itok=N_ERzAbtomaxshop.rs/sites/default/files/styles/product/public/images/products/90-lancelot.jpg?itok=5v5VUaWN"
)
;

-- preduzece2: salate --

INSERT INTO `pia_projekat_proba`.`proizvodi`
(
`preduzece_id`,
`naziv`,
`info`,
`cena`,
`kolicina`,
`slika_url`)
VALUES
( 2, "Puterica Baglin 5000s",
"Zimska puterica najotpornija na hladnoću. Proizvodnja od jeseni do ranog proleća. Preporučuje se proizvodnju u plastenicima i staklenicima. Svetlo zelena boja listova. Brzo rastuća sorta. Vrlo fleksibilna na različite sklopove sadnje. Tolerantna na promene temperature.
Visoka otpornost (HR) = Plamenjača Bl 1-25, 27.

*Zatvorena proizvodnja
*Težina glave: 0,4-3 kg
Kultura: 
Salata
Pakovanje: 
5000 s
Namena: 
Profesionalna
F1/sorta: 
Sorta",
3600, 500,
"http://www.agromaxshop.rs/sites/default/files/styles/product_thumb/public/images/products/1-014-0285-baglin.jpg?itok=8NdiKlUF"
),
( 2, "Puterica Daguan 5000s", 
"Puterica za letnju proizvodnju od proleća do jeseni na otvorenom polju. Formira vrlo krupne glavice prosečne mase 550-600 g. Listovi svetlo zelene boje. Otporna na prorastanje tokom leta. Otporna na vršnu trulež listova (nedostatak Ca). Srednje rana sorta, vrlo robusna, lagana i sigurna za proizvodnju. Ne traži previše intenzivnu proizvodnju. 
*Otvorena proizvodnja
*Težina glave: 0,5-0,6 kg
Kultura: 
Salata
Pakovanje: 
5000 s
Namena: 
Profesionalna
F1/sorta: 
Sorta",
3600, 900,
"http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/1-014-0281-daguan.jpg?itok=WdH6urSw"
),
( 2, "Puterica Julian  5000s",
"Puterica za leto. Preporučujemo za proizvodnju na otvorenom polju tokom leta zbog izrazito visoke otpornosti na prorastanje. Glavice su kompaktne i dobro zbijene. Listovi su uspravnog položaja svetlo zelene boje. Unutrašnja boja listova je svetložuta. Dobro se drži nakon dozrevanja u polju i kasnije na pultu nakon berbe.
Visoka otpornost (HR) = Plamenjača Bl 16-24, 27-28, 30-32 /NR: 0. Srednja otpornost (IR) = Virus mozaika salate LMV1.

*Otvorena proizvodnja
*Težina glave: 0,5-0,6 kg
Kultura: 
Salata
Pakovanje: 
5000 s
Namena: 
Profesionalna
F1/sorta: 
Sorta",
3600, 700,
"http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/171-tizian.jpg?itok=AjArl-o2"
),
( 2, "Puterica Mafalda 10 000s", 
"Kultura: 
Salata
Pakovanje: 
10 000 s
Namena: 
Profesionalna
F1/sorta: 
Sorta
Izvor: 
Uvozni",
6944, 600,
"http://www.agromaxshop.rs/sites/default/files/styles/product_thumb/public/images/products/187-mafalda.jpg?itok=csBmrDSu"
),
( 2, "Puterica Majska kraljica 25 g",
"Kultura: 
Salata
Pakovanje: 
25 g
Namena: 
Profesionalna
F1/sorta: 
Sorta
Izvor: 
Domaći",
125, 1500,
"http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/1-014-1110-majskakraljica_0.jpg?itok=YeqiWoWM"
),
( 2, "Rukola Celebris F1", 
"U pitanju je nova Corina selekcija rukole, namenjena pre svega za zimski ciklus proizvodnje. Odlikuju je brzi porast, čvrsti i uspravni listovi i dobra tolerancija na niže temperature u hladnijim periodima godine. Tamno zeleni listovi su takođe veoma kovrdžavi već kod prvog branja.

Kultura: 
Rukola
Pakovanje: 
500 g
Namena: 
Profesionalna
F1/sorta: 
F1
Izvor: 
Uvozni",
823, 5000,
"http://www.agromaxshop.rs/sites/default/files/styles/product_thumb/public/images/products/196-celebris.jpg?itok=GSv4Or85"
),
( 2, "Rukola Corastar F1", 
"Standardna sorta rukole koja se radi u svim proizvodnim regijama i zastupljena je kod svih većih proizvođača rukole i drugog Baby leaf programa. CORASTAR se odlikuje, po veličini i obliku, ujednačenim listovima tamno zelene boje i veoma kovrdžavim već kod prvog branja. Pogodnaje ca celogodišnju proizvodnju.

Kultura: 
Rukola
Pakovanje: 
50 g
Namena: 
Profesionalna
F1/sorta: 
F1
Izvor: 
Uvozni",
780, 2500,
"http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/194-corastar.jpg?itok=9hFw_6fC"
)
;

-- preduzece3: zacini --

INSERT INTO `pia_projekat_proba`.`proizvodi`
(
`preduzece_id`,
`naziv`,
`info`,
`cena`,
`kolicina`,
`slika_url`)
VALUES
( 3, "Anis 10g", 
"Anis je jednogodišnja zeljasta biljka. Lekoviti deo biljke su plod i zrelo seme. Seme anisa rešava nadimanje, jača probavne organe i pospešuje varenje. Čisti krv i sluz iz pluća, želuca, bubrega i jača nervni sistem. Efikasan je sekretolik, spazmolitik, ekspetorans i karminativ. Upotrebljava se u konditorskoj industriji, kozmetičkoj industriji i proizvodnji likera. Seme sadrži eterično ulje (1,5-4,0%), masna ulja (10%), proteine (20%) i uglenje hidrate. Dominantna komponenta eteričnog ulja je trans-anetol (85-90%).

Seje se u proleće na stalnom mestu.

Kultura: 
Začin
Pakovanje: 
10 g
Namena: 
Profesionalna
F1/sorta: 
Sorta",
105, 6000,
"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMSEhUSEhIVFhUXFRUWFRcVFxcXFxUVFRUXFhUVFhcYHSggGBolGxUVITEhJSkrLi4uFx8zODMtNygtLisBCgoKDg0OGxAQGy0lICUtLS8vLS0tLS0tLy0tLS0tLS0tLS0tLS0tNS8tLS0tLS0tLS0tNS0tLS0tLi0tLS0tLf/AABEIAOEA4QMBIgACEQEDEQH/xAAcAAABBQEBAQAAAAAAAAAAAAAAAQMEBQYHAgj/xABDEAABAwIEAwUFBQYEBQUAAAABAAIDBBEFEiExBkFREyJhcYEHMkKRoVJiscHRFCMzcpKiJFOC4RUXQ/DxFjRjssL/xAAaAQEAAwEBAQAAAAAAAAAAAAAAAQIDBAUG/8QALxEAAgEDAgQFAwQDAQAAAAAAAAECAxESITEEEyJBUWFxgZEyM6FCsdHwFMHhI//aAAwDAQACEQMRAD8A7KlQlQCJUIQAhCEAISoQCJUIQAhCEAIQhACEIQAhCEAJEqEAiEqEAiEIQAkSoQCISoQCJEqEAqEIQAhCEAJUIQAhCquJcZFJA6YtzW2HUqG7K5KTbsi1QqbhbiGOthEseh+JvNp/RXKJ3DTTswSWSoUkAhCRxQC3Quf8R8YyU85ja24C0HD3E0dQ0agO5gqimr2NHSko5W0NAhIDdKrmYIQhACEIQAhCEAJEqEAiEIQAhCEAIQlQAhCEAIQhACxvtRjc6ks0gHvHX+X/AHWzWZ4+hDqc35B31aVlX+2zbh/uI4/7M+IzBMxhdZuaxHUHQ3+i+hGuuLjYr5JpXlktxyN/ku5cBcdMkjbDMbPaLA/a8PNUjNRlZ7M3qUnOOS3R0VCh0eJxS+48HqL6jzCmXXQcQJHbJUFAcj4yg/xRJ6KjeS3vRktcOi1vtFoHiRsjBe+hXNcXxzsiY4zd3xu/Jt/xXn1YSc9D2uHnHlK5vuHuPJGODJ9Rtfmun0NY2Voc03BXz3HNE+Dt3FzXXAsLWJW19nWPlj+ye7un3fAqaNeSeMivFcJCUc6e51dCRpulXeeOCZqalrBdxsnSbLBcdYuAMgPmqVJ4Rua0qbqSxNnSV7ZBcHRSwVxzhXiGWSRsTNr/AEXX6cd0XUU55IVqXLdhxCELQyBCEIAshCEAIQhACEIQAhCVAIqPjBpNOQLc9/5SrxU3Fv8A7cno4fXRZVvty9DWh9yPqfMdWwiXu735K8pI7WOoeOumqfbShlW7Nu29vO9rq5xWju1r7WJGh+oPlb8F59WreyPfoUUrt92NTyPc3t45HRzNsH5To4bB3n1T0HHWIxCxcHjxGqi4VUDML6g9146g6FVtXJ2byy+rSRZWo1JfSjHiKME7tGmp/a3UtPfiafmFqMG9pgljdJJCWMbu8nu36DmSuZUcHbPOcAMaMz3W2aPzVVjeMGUthibaJptGwbnxNtyt+ZNuyOXkUrXZouLfaHPVucGfu49gBvbqT1Kw8MZlkDBuT/5KvIuG3dmXyvydABc3O109wXhZzue7kco+eqo6sFFyTuzdUJNxjayJlbGG9nABYMbmPiTsvVDOY3jqDcKvxaZ3bPsbjMQNb6Ar1DMTus3DpRrCrebR9DcM1/bQMf4a+atSVz/2WV+aN0ZOxv8ANXfFvEAp2WHvHYLuhNYZM8epRfNcIjnFGOtgYbG7jsFwviziB0j8jTck6q04mxl+Qvc67jt/ssnhFN3u1k9Fg5Z9T2Wx1xp8voW73fkdL9ldBZ4JGwuuxNWI9mtF+57Uj3tvJbhb0YtR1OTiZqU9NkCEIWpzghCEAIQhACEzUVccfvva3+ZwH4pr/ikH+dH/AFBRdEqLfYloUU4lCBfto7fzt/VNS41TtbmMzMvW+nzUOcVuyVCT7E9Ks3NxxRN3mB8tVMoeJqWUXZKD4cx5qqqwfdF3QqLVxfwW6p+LD/hZPIemu6tIZ2vF2uDvIgpnFKXtYZI/tNIHnbT6q0leLRSLxkmfPfEEtqhs1rB416Zhof19Ve1uKdrTRsIHcboeeh2+SosYcXNfTuaRIyQuaOdxfO3TryVdQ1ugF/8AsrzJReJ9DSlFv8omUE9pSOov8lX8QvIqH73OU+paEkD/AN8zzI9LKbiEYkqXHa3Yj1I/QfRXprGd/Iz4nqhbzI+N1XYU7YL99/fk8B8LfoT6BXHs6wOPWqqWksaLm3j7rfXmsjXy9vVE8s39o0A+QC1WJYnlgbA3Qbutz6/orT0io93qylKGTcuy0R4x7Fw95ygNYCcoHIdVJoqjsKPtToX3DPN2x9BqszSU5nlEY933nnk1g3T3EuKds8Mi/hx91vj1dZZqim1H3ZpUr4xbXoI03Fj80Qh17KqiqXt3CtqKuG5C2lFowhOMn4G14TxY0ri7kRqvGLYq6plMh2GyzwrbjYhTIMQiy2JtosuvGxt/5qeXcoMXlMkmvutXimmMsjIx7uYBR8RBLiG6i6seGImxStkl0AN10xSSVzhm5Nux9G4BTiOBjRyaPwVldcym9p8EbQGNc63RVs3tbd8NObeJW+aOTkz8DsF0q49D7XnfFT/Iq+wr2p08hAka5nnspzRV0prsdDQq+gxmGYXjkafIqcJB1VjO1j0hJdCA5b7T+EJXvdVxvkcwgZ2tc7NHbmBs5npcLlNXhFQ0ZmOL2anuk5h5t/RfVKzeOcHQT3fGBFLuHNFgT94D8QsZwa1iddKvG2M/lHzOKp99XG/iSpEVSbWJNvNdHx7hCMucypZ2cgF2yt912/vcjfqsNi3DM0GtszORGoKw5kXo9GdcVKOq1RHbU9E4yse3UBwtzsQrTA6lrWNsxgNu8SDckb6rQ0WMwMN5qbO3YgOuPPkR8ysHPqtY7VCWOVyjwrjaeHZ9/O4P9QsVu+HvakSQ2docOoNnDyOx8j81h8Tjpp3OcxjWgnRoJu3w11KzdXSuhN2k26K9OSv06MxrUdLzSa8VudG9qFJG4sr6Vwc1+j8uhDwPiG7XW5FYBzr/ALxthc95o+E/aHgfon6TEO0YWlxB0vY722BHPwKdZQPY4PAOu2lwerT4eavKV733Ip03FLF3QxSi88fib/Qr06ZxqZiNgSfVjSFdswjvxVDBaPVr279m62mp+E8imKyhAFS9ne1IuNe892gAG+l1jGor+1vybTp39nf8GVwgXkJVhO58jiGC5PyA6k8gOqYp6IxAiW7XH4GjM+3kNG7cyoNViRsWMGVp3HN38x5+W3gujHOd0c6qKlSs9yzr69kMZp4HZi7WaXbOeTG/cH1VK26egwuV4zEZG/af3R/up7MPpY7drOX/AHYx/wDrVaLGOm5yNzm72svPQgxud1ClRVBHRezXU7f4cF+hef8Ac3Sf8XOlmMbboB+SizfYsnFfqJNLFLKfdcRyACkjh+U+89jPAm5HoFWHG5QdHW8r2TkMksvxG3M7AegVGprwRdOnLxbLF2HNYP47S4Dax1KhPqT8TSlp6fI4h3oppabaEHzVe/iaLbTT8kI4g1otlUKSvuptWz7cfqFC/Ymn3XehWkcTKpnshrtyn4qohRpInM3C8tctbJmGTTLqkxV7DdrnN8iQryn42qme7MfXVZOlp3yGzGFx8AtXg/s/rJiMzMjTzPRVwfYl1I9yb/zBrP8AMCFpf+Uw/wAwoVrMzzh4HWkIQtTmGaqlZIMsjQ4dCFjMe4UkYC6m77dbxnXToL7/AIrcoWdSlGa6ka0q06bvFnAMWoYHOIcHU8vPQlpP3gRcKmqcNnb7mWZvWNwP9u675xHwvBWD94C14Fg9hs4efUea5ri/sxrI7ugmie3kXnsnD53H1XM+HlHY9CHHRa6tDm9RIWnvtcw/eaW/iEn7fpYm48VOqqyrgeWZy+2hLHiZh9RcHZRZMTntd0DSOromG/0UYPwXybKuvF/BAfYHMw+YWmwLGnEBvZOlaPsglzbctN/IqjjqZybtgaDyLYWD5HKr7Dn1GU5pOzJ2uSCT0ytFzfyVKqVrO3yWovVuN/ghxTT1ksjI8zYSc1tww66fTZTjgtRTNaIp7kEyOFgAAQWlw11IF7C684W0CJ/+Is8F3abhgubadeWv6p6NoY4Qsec72Zs8wdbJY3axuhuevK6pKTvaOy8iyhpeWrfmVldDFbOJJHOA1IsXajZwAsPJU8eIRx/w4hf7T+8b9bbK4xTE3D90zLGQbjIB2bibXuCN9Dr46qqjri0kuZHn6ljbg/JbU721/czqWb00foMSTT1BuGySdLNJA+QsEDB6g7xgfzSRNPyc4FSzXySGxc956XJ8tFMhw+c7RO9bA/IlWdXHwRmuHz1bb/vuU8uD1LRcwuI6ss8f2EqE5rgbEEHoQQfqtYKSZmpicLfZ1/Beo8UkAym0jde5IMwF+l9QVC4h+Cf99xLgl2bXr/UZgU5aRn5rQ0EjQMoGiiVlMyV+Zh7N32HnuH+V/LyPzSwyZXWOhGitJ5opCLptokPGa8btCPdP4Kt/a3MJa7lurSu1yvHkfyTGL0hfGJhu3R35FUg1ezL1Iu112/Y8R19xYajoUPjY/UAtP0Kp4nHkpsNVYWO61cLbGUKl9yRZzNHi7VsuAeF6SsJzOIcDfLfcLEsrSO6dQeqnUFU+KQS07i0jVQm4smSU1ZH0VhXDlPAAGRtFudtVcNaByWJ4H43ZVsDJCGyjcHn4hbIPXRFprQ86cXF2Y8hN5kKxUcQheSUB6XlzgBcmwXh8gGpNlxj2i+0R0pdT0rrRDR7xu8g/CeTVSc8TWlSc35Gv4v8AaRBS5o4jnkFx3bENPjfQfXyXIMb40qal1szj0Hvu+dtPQBQ8Gwd1U4uJLYwdTzPgF0XBaTDqSMuqLD7LBfM7xNtT+C451Vli9X+EelToYxyirL0u2cwdR1Umpa7/AFFNSYdUN3C33EfGccjQyCnbG1p7pcdf6R+J1WPq8Ue7d2+gDefQADdQqlRvRKxtyaeN5N39UUzpHs3uPVXNMA1waC7MWgyF3/SZa7tRsT+gSR0DmkudbOBc3NxADs54+KQ/CwbWufCJVzgNyt0bubm7nn7TzzPhsFo3lojKKcNS4qMec+EtDQIw9rGttplAvb81E4irnuEMu1r2I3Fjy6bqHh0JfDI77LgR09wqwxumvSQHfuu28mHnqqKMYyS8/wDRZylOm35X+GNwRtqddGyWvc+6/wA/sn6eSffBGSGVLCHAczlcB4OHvt8D6WVfhdBKGNkDbtPTceivYalsjOzlGduwJ99h+6dx+HgqzlZ2T0/Y0pwc43a18+5Ko4w0WgDXC17NsH+rdz6Ep2mxkMcczL8iCXAg/kVlcWpHwWObNG4nI8bG24P2XeHqLhOR8QymweWvA2EjQ767j0Kp/jX6lqaf5tuiSsaOox5x2LgOhcXD5OuoNVWxyD943Xk9uhHpzUOOrp5D3mPj0P8ACcHi9tO6/Ua/eSfsjHDuzs8nte0/2hwHzUcpJ9y3PTVlYiyNs7KbHoRsR+Sea0EZXejvib+rfA+iaOGzZrhocLXu1zT9L3+inMgIHeBb5gj8VeUsdmUhFTumjzHGR3Hatd7rhsSNrfon8LlHeieNHd0g8j1TDJi3QEeR1B9E4Xhzs47rrXLTsbblp/IqG7ojl4MzlfB2cjmdCmQVa8SxkyNeNnNv681Vhp6Ltg7xTPKqrGbR6a5SoJi3ZRWQO6H5L2WuG4VmisZtF3TVOocxxa4a3C6Dw77RnxgMqWlw+03f1XK4tE9JORYgrJRaehu5RmupHd/+Y1J9p3ySLh37SfFCveZjhTPqspt5tqUlbUtiY6R5s1gLnHoBuuFcee099ReGmJZHqC4HV3kVpKVjGEMvQufajx60tNJTOuD/ABXg/wBjT+K4/JNdSGYfPIbNieSfulWVPwhMf4hbGPvOA2WLlFO8nqdcYyatBaE/C8fa2BkbBlytAeRuXDc35KvrcUaSTr5k3U2HhunaCXzuv0YN/XZI2pp4DeKFpcL96U9ofMA90fJc6ULtxTZ1upUUUpNIq4qWWUZ7Bkel5JO63X7PNx8ApVHkBMdOS6SzjJUSAARxgd5zG65Ol99QOai4jiEk3vOJHIHYenqn3N7GFrBfPKBJIfuf9Jg8N3ebh0Wkk7a/BlGalKy+f4PFXMHZY42nKDZjd3Ocd3PPxOPXlsNArKk4da0B8/edvk+FvS/2lN4Zw5rGmokFza4Hgfdb5u3PgClxSs0Oup3XLOo28YfJ6VGjG2U17EaVjWU8jm3sZcum2kd/0FvFeqhueig8Mzfm0b/0qBi0pbSxNI0e+SQ+hbGP/oVYcKkyUj4ydi4gdSLuH0LhorOLUMvP/hhzE62PkWeCkdk0eAFvCyaxfD8vfb71gQR8Tdwfy8wVEwmoyks6G35j8lqcXawxscwnLluAfhJ/isJ8HWI83LmcXGTkduaaUTMU0QqIzA74xZm3dlAOQ6+Oiwz2lri12hBII6EbrXsdllLQd9Rv7zdVA40oh24lA0la1+mguRr9bru4eVpY+J5fGwus1utGUkcllMin6hQmR2T7QV1OJwRnYnRvaef1UmOtLdpPS5H01uqlzSUjmG2io6d9zRcRbYvTiROpe0+bQ78QpFKe0DhlaC4GxDQ0k78vJZWOZwO5Wlw+qGW43GqynSUVodNKu5vUJoc0Wu7DY+q9YaxocLtCmkA97k/uv8HciEsVAQVNF6WM+Kj1KXibbAcPgcB+7b8grWs4LppxqwDxGipOG3EWBW8on6LdHDLQzDfZnRndp+anUPs6oWG/ZZv5jdauNOtV0kUyZUf+l6X/ACI/6QhXKFJF2LV0zJWOjkaHMeC1zTsQdwVhcZ9n8IF4p3RDk0sjcB4A2BC35VTikRcColCMt0XhUlD6XY4xjlM6EkOqC8jazSDptzWWnr5eRt42/VdMxbhVznF173WdquFnjksuUl2OnnSa+ow880rvecT/AN+CaylamowJ7fhUGTDyOSvt2M3d9ytoaXtJGM+04A+AJ1PyupU7v2ip2s1zgLdGNGjR4Bot6Kbh0GV5f9mOV3qInW+pVfg5Hbs8zb6rCq9X5I6uFS+WarF6gNtGNm6+ZIsPkPxKy9XUFxsNTsB4k6D1UjFqi8j/ADKj4Y3vOlO0TbjoZHAhgv4Wc/8A0eK5qVOyuejWq/pRF4mlHadm22WJrYxvqWDvO16uLirrhmYRxs15kn/Uf/CytVcu315+ZVlHLlFgu3lpwxPHdVqpmi/xyAxuEjdWm+tjtpb5fonqTEbtAvrzHUbX+SMNqmTxGKTKDrlJuNbcz0P5rM1pdA8tN9D3SfwPiuGNO/S90etz7LNbMl19Rlka7o4fLYqyx0B9NGfsuLedxrf8HBZCrqy8jXW4WsAzU7hvq35lv6tWsoYOLOfNVVNIz7Yk/FDcpxkasMOgu4XXXc82w6MK7l7KG6iXQaCiDo9lS11DlcdFJQxVTQHcDVNQgtB71iOR5rVzUwUjDsHinOWQeRGhVWzWPiU+G1jchDgS7um/SxXQcIwl0kQkcLF13AdGnZQ8P9nUYeHGV5b9kaX8Cei6BBBYAKkKaUnItVruUFEzVPQFh2WhoJlKdSgpp1JbZdFjlbLGF6ktKq4XEKdE9CCTdC8Z0IQS02+O6cQpBBlogeSgVGGhXtk25qkGRqsLbzaqeqwBp5Bb+WAFQJ6JSTdnM8WwTsopnDT908fMarlcjiNRoQb+Wt13rjaPs6Kc/dt/UQFwaXb5rlqfWd9DWn7/AMEebEib5hr1V/iLBFBHT/F/FnP/AMrtAzya1oHnfqo3D9AO9VSDuR6xi2j5b90Hq0bn0UatqC59ibknfnfqVFk5WXYZSUW5v0I8bNbp8JGMTrWLY5dxymkLTcK8nY2qjyEahoF+pGw05jr5KqhhupUQLTcLGpTy1W500a2HS9jNPwx0cgaeunjZbPDWFzHxC23aG/MRA6DxOb5KwEEdXGBltKCSH3AuANARsHXO/NJh7ewljztDgRldcEWDhY2v03XJVquWj3R30KMYRbjszPtiVvhcGq8VdLleRbS+npp+SnYa2xC64u6TPNqRxbRsMJh7qZxagvrZTMJkFgraSAOC1sYX1Oc1FLZe8KbleFp8QwroqRlMWPVGXTN3hhu0K0ZGqLBn6BaGJXRlIcYxKY04wJwBXKkR0KRrLKZlXksUkDVkJ3IhASkIQgBCEIDyQvDmJ1JZAYX2qShlC8WuTltra13WzeNtdFxvh3h99XNkBysaM0j3e6xg3J5X6LpvtQpX1dVT0kR7xBfI74Y42aZnchq53nYDmszjtQ1wbh9Bm7Jv8R1hmmdexkeQLhnidOnK/JNtydj0aTUaaXuZbHq9pf2UGkbbtjAINwNC8kaEm24/JVbIANefVXNbRtj7rQCR7zup/RRWwrSKxVjKcnN3YwyNSYYLp+GmJ2Cv8Mwk7kK25mV9NRaKQ6j8Foo8OtySmh8FNiLmZZT28uauI4nTgWNns08XN03NvDfoOSkvw/wTcET43ZmGxsR6HcLmq0sjqo13BWIeIAGVx1359U7SxJ0UxOp3UiCC3JXprFJGdSWUmy1w4kWWjpHXCoaEK9pFujmkSJYbhVFbhwOtloWjRNSRI0QmVeGxZVoYFXxQaqyhapSIbJDQnAvDQnAFJU9BFkBKpAmVC9WQgPSEIQAhCEAIQhAZ7HuGo5+0d2jozKGCUtALnNZezQXXyjU/NZXFKCGjhdHTxho+I7udyu5x1K6FV7LJY7hZkVcUtUaKbejZyWeAudspdLhBO4W6p+GbclaU+BgclTBmjmjI4ZgF9SFpqbCwBsr6DDwNgpLaUK6jYycrlD+wpp9EtE6BR3wK1iLmffR+CYdRLQPgTRgUOJKkUf7AlFH4K9bToNMq4k5FVDTWVlTNTrYE/HEpSKtj8QXpzF6iansikgYiapkbU01ikRhCBQF7CLJbKQKEqRKgBCVCAEqRKgBCEIAQhCA8vbdR30wUpCAh/s4SiFSrJLIBns0FieskIQEVzE0+NS3NXhzVIIEkaa7JT3sTZYgI4iSiJSAxewxQCMIkrY1JyJciA8ManQ1DWpwBAecq9NC9WRZAKEqRKgFQhCAVCEIBUIQgBCEIAKAhCAEIQgAIKEIASFCEB4K8FCFIG3LyUIQAvQQhQD0lCEIBQvQQhAekIQgFSIQgFShCEAIQhAf/2Q=="
),
( 3, "Bosiljak 10", 
"Bosiljak je jednogodišnja biljka jakog prijatnog mirisa, visine 30 cm sa razgranatom stabljikom. U tradicionalnoj medicini koristi kao jak antioksidant i protiv svih upalnih procesa. Rešava problem kašlja, bubrežnih bolesti, glavobolje, depresije i kardiovaskularnih bolesti. U kulinarstvu, pored prijatnog aromatičnog svojstva deluje kao antiseptični sastojak koji uništava štetne bakterije u hrani. Koristi se sušen i u svežem stanju. Listovi bosiljka koriste se kako u svežem tako i suvom stanju u industrijske svrhe koristi se etrično ulje.

Kultura: 
Začin
Pakovanje: 
10 g
Namena: 
Profesionalna
F1/sorta: 
Sorta",
105, 6000,
"data:image/jpeg;base64,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"
),
( 3, "Kamilica 5g", 
"Kamilica je jedna od najpoznatijih lekovitih biljaka na našim prostorima i prisutna je u svakom domaćinstvu. Glavna lekovitost ove biljke ogleda se u lečenju želudačno crevnih bolesti. Spoljnom upotrebom reguliše se upala kože i sluzokože, prave se različite kupke jer poseduje dobro antibakterijsko, virusno i fungicidno dejtsvo. Eterična ulja kamilice koriste se u farmaceutskoj industriji i za izradu kozmetičkih proizvoda. Seje se u proleće na stalnom mestu.

Kultura: 
Začin
Pakovanje: 
5 g
Namena: 
Profesionalna
F1/sorta: 
Sorta
Izvor: 
Uvozni",
175, 6000,
"data:image/jpeg;base64,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"
),
( 3, "Korijander  10g",
"Korijander je biljka koja potiče iz Južne Evrope i sa Srednjeg istoka. Veoma lekovita biljka koja čisti organizam od toksina i teških metala, koristi se kao lek protiv anemije, jer sadrži gvožđe koje se lekao usvaja, smanjuje holesterol i šećer. Koristi se u kulinarstvu zbog svoje veoma prijatne arome, u supama i varivima od povrća. Veoma pozitivno utiče na lečenje anemije, na smanjenje holesterola i šećera, upalnih procesa i kožnih bolesti kao i za lečenje reume. Seje se tokom proleća i leta na otvorenom polju i u saksijama.

Kultura: 
Začin
Pakovanje: 
10 g
Namena: 
Profesionalna
F1/sorta: 
Sorta
Izvor: 
Uvozni",
83, 6000,
"data:image/jpeg;base64,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"
),
( 3, "Lavanda 5 g",
"Lavanda je višegodišnja mediteranska biljka. Zbog svog prijatnog mirisa koristi se u farmaceutskoj i kozmetičkoj industriji, a gaji se i kao dekorativna biljka u dvorištima. Koristi se kao antiseptik i antispazmatik i kao sredstvo protiv raznih infekcija grla i ždrela. Lavanda veoma dobro uspeva i u kontinentalnim krajevima i na nadmorskim visinama preko 1000 m. Dobro podnosi i niske temperature, do -20C. Lavanda je višegodišnja polugrmolika biljka visine od 50-70 cm. Seje se od proleća direktnom setvom na otvorenom ili u saksijama.

Kultura: 
Začin
Pakovanje: 
5 g
Namena: 
Profesionalna
F1/sorta: 
Sorta
Izvor: 
Uvozni",
170, 6000,
"data:image/jpeg;base64,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"
),
( 3, "Majčina dušica 5 g",
"Lekovito dejstvo majčine dušice je veoma cenjeno u narodnoj medicini, a njena primena je takođe značajna i u farmaceutskoj industriji. Koristi se za ublažavanje kašlja, lečenje želudačnih smetnjih, bolesti pluća, organa za disanje, malokrvnosti i bolesti bubrega. Zbog izraženog antiseptičkog, antibaketrijskog i dezinfekcionog delovanja koristi se za spravljanje mnogih farmaceutskih medikamenta. Najvažniji sastojak ove lekovite biljke je eterično ulje smeđe crvene boje, aromatičnog blago ljutog ukusa. Eterično ulje sadrži do 55% timola, borneola, linalola i fenolna jedinjena.

Seje se tokom proleća i leta na otvorenom i u saksijama.

Kultura: 
Začin
Pakovanje: 
5 g
Namena: 
Profesionalna
F1/sorta: 
Sorta
Izvor: 
Uvozni",
105, 6000,
"data:image/jpeg;base64,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"
),
( 3, "Mirođija 10 g", 
"Začinska aromatična biljka prijatnog mirisa. Blagotvorno deluje protiv stomačnih tegoba, nadimanja i pomaže pri varenju hrane. Koristi se kao začinska biljka u kulinarstvu gde njenom upotrebom hrana dobija prijatan i aromatična ukus. Semenke mirođije sadrže vitamine, minerale i eterična ulja koja povoljno deluju na zdravlje. Najveća koncentracija lekovitih i aromatičnih materija nalazi se u plodovima biljke, ali ima ih i u listovima i cvetovima. Pored primene u kulinarstuv eterično ulje se koristi u farmaciji. Seje se tokom proleća i leta.

Kultura: 
Začin
Pakovanje: 
10 g
Namena: 
Profesionalna
F1/sorta: 
Sorta
Izvor: 
Uvozni",
83, 6000,
"data:image/jpeg;base64,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"
),
( 3, "Origano 5 g", 
"Origano je višegodišnja zeljasta biljka sa veoma izraženim lekovitim dejstvom. Blagotvorno deluje na unutrašnje organe: jetru, slezinu, bubrege, bešiku i pluća. Takođe se koristi za lečenje organa za varenje i disanje, kao i protiv upale kože i sluzokože. U kulinarstvu je veoma zastupljena kao začinska biljka široke primene. Sadrži eterično ulje (timol, cimol, karvakrol...), flavonoide, tanine, askorbinsku kiselinu. Sadrži gvožđe, molibden i selen. Seje se tokom proleća i leta direktno u zemljište i u saksijama.

Kultura: 
Začin
Pakovanje: 
5 g
Namena: 
Profesionalna
F1/sorta: 
Sorta
Izvor: 
Uvozni",
170, 6000,
"data:image/jpeg;base64,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"
)
;

-- preduzece5: yara --

INSERT INTO `pia_projekat_proba`.`proizvodi`
(
`preduzece_id`,
`naziv`,
`info`,
`cena`,
`kolicina`,
`slika_url`)
VALUES
(5,"Calcinit 2 kg" ,
"YaraLiva Calcinit – kalcijum nitrat – 100% vodotopivo đubrivo

Calcinit je đubrivo u obliku belih kristalnih granula, rastvorljivo je u vodi bez ostataka i namenjeno je za prevenciju i otklanjanje simptoma nedostatka kalcijuma. Calcinit je glavni izvor kalcijuma za sve useve koji su osetljivi na nedostatak kalcijuma (povrće, voće, cveće…). Azot i kalcijum su lako pristupačni i odmah dostupni biljci. Amonijum nitrat pomaže u stabilizaciji pH vrednosti prilikom ishrane kod hidroponskog načina proizvodnje. Upotrebom YaraLiva Calcinit sprečavate pojavu gorkih pega kod jabuke, suve truleži vrha ploda kod paprike, rubne paleži lista salate i kupusnjača.

PRIMENA
- Fertigacija
- Folijarno
- Direktnim unošenjem u zemljište predsetveno ili prihranom

NAMENJENO ZA

- Zaštićeni prostor
- Otvoreno polje
- Hidroponiju

Kultura: 
Đubrivo
Pakovanje: 
2 kg
Izvor: 
Uvozni",
 210.50, 1300,
 "http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/calcinit2.jpg?itok=O3Jbv_s_"
),
(5,"Cropcare 11-11-21 5kg" ,
"Veoma kvalitetno osnovno, startno đurivo ali i đubrivo za prihranu. Sa podjednakim uspehom se primenjuje u proizvodnji na otvorenom polju i u zaštićenom prostoru (plastenici, staklenici). Preporučuje se za korišćenje kod svih intenzivnih kultura (povrće, voće, vinova loza, cveće, ukrasne biljke). Zbog svog idealnog sastava pogodno je i za upotrebu u rasadničkoj proizvodnji. Maksimalni rezultati se postižu kod povrtarske kulture koje se navodnjavaju tokom vegetacije, u intenzivnom voćarstvu i vinogradarstvu, profesionalnom cvećarstvu. Idealno za sve tipove travnjaka i sportskih terena. Pogodno za dodavanje zemljišnim smešama i supstratima namenjenim za proizvodnju ukrasnog, balkonskog i saksijsko cveće.

PRIMENA: Koristi se kao osnovno i startno đubrivo za voće, povrće, grožđe, cveće i travnjake u količini od 300 do 500 kg/ha, kao i za prihrane (2 do 3 puta) u količini od 100 do 300 kg/ha.

Kultura: 
Đubrivo
Pakovanje: 
5 kg
Izvor: 
Uvozni",
 635.40, 1300,
 "http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/cropcare_11-11-21.jpg?itok=crRe0QlT"
),
(5,"Ferticare I 14-11-25 10g" ,
"Pogodan za ishranu svih vrsta biljaka tokom cele vegetacije zbog idealnog odnosa NPK elemenata. Značajno ubrzava cvetanje i poboljšava zametanje plodova. Idealan je za folijarnu prihranu svih ratarskih, povrtarskih, voćarskih kultura, vinove loze, cveća i ukrasnog bilja.

Kultura: 
Đubrivo
Pakovanje: 
10 g
Namena: 
Profesionalna/Hobi
Izvor: 
Uvozni",
 575, 2300,
 "http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/ferticare1_14-11-25.jpg?itok=EwberyRJ"
),
(5,"Ferticare II 24-8-16 2kg" ,
"FERTICARE II 24-8-16 – bogat azotom, za rast i razvoj vegetativnih organa

Mineralno đubrivo sa visokim sadržajem azota. Upotrebljava se nakon ukorenjavanja, tokom intenzivnog porasta i razvoja svih intenzivnih kultura. Odlično đubrivo za korekciju ishrane useva koji zaostaju u porastu i imaju slabiju bujnost i vegetativnost. Preporučuje se i za folijarne tretmane za povrtarske, voćarske i ratarske kulture tokom intenzivnog porasta.

Kultura: 
Đubrivo
Pakovanje: 
2 kg
Namena: 
Profesionalna/Hobi
Izvor: 
Uvozni",
 460, 1300,
 "http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/ferticare_ii_24-8-16-2kg.jpg?itok=PQmGl8pv"
),
(5,"Ferticare III 10-5-26 2kg" ,
"FERTICARE III 10-5-26 – posle cvetanja, za plodonošenje

Mineralno đubrivo sa višim sadržajem kalijuma i idealnim odnosom hraniva za period plodonošenja. Preporučuje se kod kultura koje zahtevaju veću količinu kalijuma u drugom periodu vegetacije. Obezbeđuje lepšu boju plodovima, poboljšava kvalitet i mogućnost dugotrajnijeg skladištenja.

Kultura: 
Đubrivo
Pakovanje: 
2 kg
Namena: 
Profesionalna/Hobi
Izvor: 
Uvozni",
 437, 1300,
 "http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/ferticare_iii_10-5-26.jpg?itok=y64oFtFe"
)
;

-- preduzece6: substral --

INSERT INTO `pia_projekat_proba`.`proizvodi`
(
`preduzece_id`,
`naziv`,
`info`,
`cena`,
`kolicina`,
`slika_url`)
VALUES
(6 , "SUBSTRAL mineralno tečno đubrivo 1l" , 
"Tekuće mineralno đubrivo za sve vrste balkonskih biljaka, takođe i drugih biljaka u saksijama i žardinjerama. Specijalan sastav prilagođen potrebama biljaka sa Substral Aktivom omogućuje zdrav rast, razvoj lepih zelenih listova kao i bujno cvetanje. Kod redovne upotrebe đubriva možete očekivati bujno cvetanje tokom celog leta sve do kasne jeseni.

Kultura: 
Đubrivo
Pakovanje: 
1 l
Namena: 
Hobi
Izvor: 
Uvozni
",
435 ,1400 ,
 "http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/45137771_638153833248906_804993080200527872_n.jpg?itok=-jG9v1a3")
;


-- preduzece7: fitofert --

INSERT INTO `pia_projekat_proba`.`proizvodi`
(
`preduzece_id`,
`naziv`,
`info`,
`cena`,
`kolicina`,
`slika_url`)
VALUES
( 7, "FitoFert Kristal 4:10:40 + 3MgO +ME", 
"FitoFert za brzo sazrevanje plodova

FitoFert Kristal 4:10:40+3MgO+ME namenjen je za brzo sazrevanje plodova (voća, povrća, i ratarskih kultura), kvalitetnu pigmentaciju plodova i sadržaj suve materije u plodovima. Prisutni fosfor ubrzava zrenje, dok visok sadržaj kalijuma garantuje kvalitetnu pigmentaciju i visok sadržaj šećera u plodu. Broj tretiranja 1 – 3 puta, neposredno pred berbu i u toku berbe. Kompatibilan je sa većinom preparata za zaštitu bilja, osim alkalnih bakarnih preparata.

Primena:

folijarno konc. 0,3% -0,8%
fertigac. konc. 0.08-0.1%.

Kultura: 
Đubrivo
Pakovanje: 
2 kg
Namena: 
Profesionalna/Hobi",
 565, 1200,
 "http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/4-10-40.jpg?itok=0LlG3jlK"
),
( 7, "Fitofert Ferro Max 11", 
"FitoFert FERRO MAX 11 je đubrivo na bazi helata gvožđa u obliku DTPA kompleksa. Predstavlja visoko koncentrovani izvor gvožđa, stabilnog u opsegu pH 3-8. Zbog svoje lake rastvorljivosti pogodno je za sve oblike primene, folijarnim ili fertigacionim putem. Fertigaciono se primenjuje u svim biljnim kulturama gde je moguće kontrolisati pH zalivnih voda i gde pH zemljišta ne prelazi 7,5. Kompatibilan je sa svim kiselim đubrivima i sredstvima za zaštitu bilja, osim sa alkalnim, bakarnim preparatima.

Primena:

folijarno konc. 0.2% – 0.3%
fertigaciono 10 do 20 kg/ha

Kultura: 
Đubrivo
Pakovanje: 
200 g
Namena: 
Profesionalna/Hobi",
 500, 1500,
 "http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/ferro-max-11.jpg?itok=D-ZoGYFC"
),
( 7, "Fitofert Combivit 20", 
"
FITOFERT COMBIVIT 20 je proizvod na bazi mikroelemenata, namenjen za folijarni tretman ratarskih, povrtarskih i voćarskih useva. Univerzalni helatni AFP kompleks jako visokog sadržaja mikroelemenata. Preporučuju se preventivni tretmani na usevima osetljivim na nedostatke mikroelemenata ili na zemljištima na kojima postoji deficit mikroelemenata, visok sadržaj organske materije, karbonata, fosfata I pH>6,5. Preporučuje se primena početkom vegetacije jer niska temperatura tla onemogućuje pravilan rad korena i lučenje materija koje utiču na usvajanje mikroelemenata. U zasadima voća preporučuje se i tretman nakon berbe.

Primenjuje se folijarno u količini od 1kg/ha.

Kultura: 
Đubrivo
Pakovanje: 
1 kg
Namena: 
Profesionalna/Hobi",
 1260,700 ,
 "http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/combivit20.jpg?itok=qg39AhB1"
),
( 7, "Fitofert Humisuper plus", 
"Za intenzivan rast

FITOFERT HUMISUPER PLUS 8:4:8 je đubrivo u obliku koncentrovane suspenzije, koje pored organski aktivnih komponenata sadrži huminske i fulvinske kiseline, kao i ugljenehidrate, betaine i lignosulfonate. U odnosu na stariju verziju ovog preparata (HUMISUPER 10:5:10), HUMISUPER PLUS sadrži povećan broj mikroelemenata a smanjen sadržaj NPK elemenata, što rezultira boljom rastvorljivošću proizvoda na niskim temperaturama. Organske materije prirodnog porekla stimulišu niz pozitivnih biohemijskih procesa u ćelijama biljaka, pojačavaju asimilaciju hraniva i čine useve vitalnijim i otpornijim na stres i bolesti. Sprovedeni ogledi potvrdili su izuzetnu efikasnost ovog preparata, kontrolu stresa i uvećanje prinosa.

Primena: Primenjuje se folijarno u kombinaciji sa različitim sredstvima za ishranu biljaka. Doze primene po tretmanu se kreću od 3- 5 litara/ha.

Kultura: 
Đubrivo
Pakovanje: 
1 l
Namena: 
Profesionalna
Izvor: 
Domaći",
 436, 700,
 "http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/fitofert-humisuper-plus-qudal.jpg?itok=2KivRkQF"
),
( 7, "Fitofert CINK Organo 14", 
"ZA ENZIMSKE FUNKCIJE

FitoFert CINK ORGANO 14 je mikroelementarno đubrivo na bazi ЕDTA helatnog kompleksa. Nedostatak cinka se uglavnom manifestuje nekrozom na mlađem i starijem lišću. U slučajevima nedostatka ćelije biljke za enzimske molekule vezuju druge metalne komponente, koje često mogu biti fitotoksične.  Preparat se koristi preventivno ali se može primeniti i po pojavi simptoma nedostatka.

Primena:

folijarno konc. 0.2% – 0.3%

fertigaciono 10 do 20 kg/ha

Kultura: 
Đubrivo
Pakovanje: 
1 kg
Izvor: 
Domaći",
 1260, 900,
 "http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/cinkorgano14.jpg?itok=bGw7s3cV"
),
( 7, "Fitofert Calcium Organo 30",
"
ZA ČVRSTINU PLODOVA

Fitofert CALCIUM ORGANO 30 je preparat u obliku vodotopivih kristala, sa maksimalnih 30% cao. Namenjen je za folijarni tretman useva. Kalcijum je u potpunosti helatiziran i lako transportabilan kroz list do plodova a iskorišćenje je potpuno. Ono što ga u potpunosti izdvaja od drugih preparata na bazi kalcijuma je potpuno odsustvo nitrata i hlorida.Takođe fertigacionom primenom kalcijum nitrata dolazi do blokiranja kalijuma i fosfata u zemljištu što je još jedan od negativnih efekata. U slučaju tretiranja sa kalcijum hloridom dolazi do fitotoksičnih reakcija.

Primena:

folijarno konc. 0,3% -0,6%

Kultura: 
Đubrivo
Pakovanje: 
1 kg
Namena: 
Profesionalna/Hobi",
 610, 1000,
 "http://www.agromaxshop.rs/sites/default/files/styles/product-zoom/public/images/products/calcium-organo-30.jpg?itok=1eVD0o_H"
),
( 7, "Fitofert Bor Max 20", 
"ZA OPLODNJU I DIGESTIJU

FitoFert BOR MAX 20 je đubrivo u obliku vodotopivog praha namenjeno za folijarni tretman useva sa povećanom asimilacijom bora, ili na borom siromašnim zemljištima. Sadrži visoku koncentraciju bora od 20%, u obliku lako pristupačnog boratnog anjona. Njegov nedostatak može da prouzrokuje mnogobrojne anomalije na usevima koje se ogledaju u vidu smanjene oplodnosti, truljenja korena korenastih useva, neujednačenih plodova i slabe asimilacije šećera. FitoFert BOR MAX 20 se najčešće primenjuje u usevima šećerne repe, soje, suncokreta, vinove loze, voća (jabuka, višnja) i kupusastog povrća (brokoli, kelj, karfiol).

Primena:

folijarno konc. 0,1% – 0,5%

Kultura: 
Đubrivo
Pakovanje: 
1 kg
Namena: 
Profesionalna/Hobi",
 650,900 ,
 "http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/bormax-20.jpg?itok=1zQZyy3f"
)
;


-- ovde sam rucno u vezu magacin_proizvod ubacila podatke a ostatak ce biti popunjen uz pomoc kursora --

INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`) VALUES ('1', '1');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`) VALUES ('1', '2');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`) VALUES ('1', '3');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`) VALUES ('1', '10');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`) VALUES ('1', '11');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`) VALUES ('1', '12');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`) VALUES ('1', '28');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`, `kolicina`) VALUES ('1', '29', '5');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`, `kolicina`) VALUES ('1', '30', '5');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`, `kolicina`) VALUES ('1', '51', '5');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`, `kolicina`) VALUES ('1', '52', '5');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`, `kolicina`) VALUES ('1', '53', '5');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`, `kolicina`) VALUES ('1', '54', '5');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`, `kolicina`) VALUES ('1', '64', '5');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`, `kolicina`) VALUES ('1', '65', '5');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`, `kolicina`) VALUES ('1', '66', '5');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`, `kolicina`) VALUES ('1', '67', '5');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`, `kolicina`) VALUES ('1', '70', '5');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`, `kolicina`) VALUES ('1', '71', '5');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`, `kolicina`) VALUES ('1', '72', '5');

INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`) VALUES ('2', '4');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`) VALUES ('2', '5');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`) VALUES ('2', '3');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`) VALUES ('2', '13');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`) VALUES ('2', '11');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`) VALUES ('2', '12');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`) VALUES ('2', '31');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`, `kolicina`) VALUES ('2', '32', '5');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`, `kolicina`) VALUES ('2', '33', '5');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`, `kolicina`) VALUES ('2', '55', '5');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`, `kolicina`) VALUES ('2', '58', '5');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`, `kolicina`) VALUES ('2', '56', '5');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`, `kolicina`) VALUES ('2', '57', '5');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`, `kolicina`) VALUES ('2', '64', '5');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`, `kolicina`) VALUES ('2', '65', '5');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`, `kolicina`) VALUES ('2', '66', '5');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`, `kolicina`) VALUES ('2', '67', '5');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`, `kolicina`) VALUES ('2', '70', '5');
INSERT INTO `pia_projekat_proba`.`magacin_proizvod` (`magacin_id`, `proizvod_id`, `kolicina`) VALUES ('2', '71', '5');


----------------------------------------------------------


INSERT INTO `pia_projekat_proba`.`je_ocenio` (`id_user`, `id_proizvod`, `komentar`, `ocena`) VALUES ('90', '1', 'odlican', '5');
INSERT INTO `pia_projekat_proba`.`je_ocenio` (`id_user`, `id_proizvod`, `komentar`, `ocena`) VALUES ('90', '2', 'odlican', '5');
INSERT INTO `pia_projekat_proba`.`je_ocenio` (`id_user`, `id_proizvod`, `komentar`, `ocena`) VALUES ('90', '3', 'odlican', '5');
INSERT INTO `pia_projekat_proba`.`je_ocenio` (`id_user`, `id_proizvod`, `komentar`, `ocena`) VALUES ('90', '10', 'odlican', '5');
INSERT INTO `pia_projekat_proba`.`je_ocenio` (`id_user`, `id_proizvod`, `komentar`, `ocena`) VALUES ('90', '11', 'odlican', '5');
INSERT INTO `pia_projekat_proba`.`je_ocenio` (`id_user`, `id_proizvod`, `komentar`, `ocena`) VALUES ('90', '12', 'odlican', '5');
INSERT INTO `pia_projekat_proba`.`je_ocenio` (`id_user`, `id_proizvod`, `komentar`, `ocena`) VALUES ('3', '1', 'ok', '4');
INSERT INTO `pia_projekat_proba`.`je_ocenio` (`id_user`, `id_proizvod`, `komentar`, `ocena`) VALUES ('3', '2', 'ok', '4');
INSERT INTO `pia_projekat_proba`.`je_ocenio` (`id_user`, `id_proizvod`, `komentar`, `ocena`) VALUES ('3', '3', 'ok', '4');
INSERT INTO `pia_projekat_proba`.`je_ocenio` (`id_user`, `id_proizvod`, `komentar`, `ocena`) VALUES ('3', '10', 'ok', '4');
INSERT INTO `pia_projekat_proba`.`je_ocenio` (`id_user`, `id_proizvod`, `komentar`, `ocena`) VALUES ('3', '11', 'ok', '4');
INSERT INTO `pia_projekat_proba`.`je_ocenio` (`id_user`, `id_proizvod`, `komentar`, `ocena`) VALUES ('3', '12', 'ok', '4');
