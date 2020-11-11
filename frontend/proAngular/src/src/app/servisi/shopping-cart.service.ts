import { Injectable } from '@angular/core';
import { ProizvodKorpa, Proizvod } from '../models/proizvod';
import { PreduzeceService } from './preduzece.service';
import { Porudzbina } from '../models/porudzbina';
import { PorudzbinaPost } from '../models/porudzbinaPost';

@Injectable({
  providedIn: 'root'
})
export class ShoppingCartService {


  constructor(private preduzeceService: PreduzeceService) { }

  dodajUKorpu(proizvod: Proizvod, kolicina: number){
    alert("Proizvod dodat u korpu!");
    let proizvodi: ProizvodKorpa[] = [];
    let proizvodjaci: string[] = [];
    let kol: number = +kolicina; 
    let proizvodPostoji: boolean = false;
    let proizvodjacPostoji: boolean = false;
    
    proizvodi = JSON.parse(sessionStorage.getItem('proizvodiUKorpi'));
    proizvodjaci = JSON.parse(sessionStorage.getItem('proizvodjaci'))
    if(proizvodi.length>0){ //ako u korpi vec ima proizvoda
      let i = 0, j=0;
        for(let temp of proizvodi){

          if(temp.id == proizvod.id){ //proizvod vec postoji u korpi
            proizvodPostoji = true;
            break;
          }
          i++;
        }
        for(let temp of proizvodi){

          if(temp.proizvodjac == proizvod.proizvodjac){ //proizvod vec postoji u korpi
            proizvodjacPostoji = true;
            break;
          }
          j++;
        }

        if(proizvodjacPostoji==false){
          proizvodjaci.push(proizvod.proizvodjac)
        }


        if(proizvodPostoji == true){
          proizvodi[i].kolicina = proizvodi[i].kolicina + kol;
        }else{
          let p = new ProizvodKorpa();
          p.id = proizvod.id;
          p.naziv = proizvod.naziv;
          p.proizvodjac = proizvod.proizvodjac;
          p.slikaUrl = proizvod.slikaUrl;
          p.kolicina = kol;
          p.cena = proizvod.cena;
          proizvodi.push(p);
        }
     
    }else{  //ako prvi put dodajemo u korpu
      proizvodjaci.push(proizvod.proizvodjac);

      let p = new ProizvodKorpa();
      p.id = proizvod.id;
      p.naziv = proizvod.naziv;
      p.proizvodjac = proizvod.proizvodjac;
      p.slikaUrl = proizvod.slikaUrl;
      p.kolicina = kol;
      p.cena = proizvod.cena;
      proizvodi.push(p);
    }
    
   // console.log("Postavi:" + this.proizvodi)
    sessionStorage.setItem('proizvodiUKorpi',JSON.stringify(proizvodi));
    sessionStorage.setItem('proizvodjaci',JSON.stringify(proizvodjaci));

  }

  dohvatiIzKorpe(){
    return  JSON.parse(sessionStorage.getItem('proizvodiUKorpi'));
  }

  dohvatiProizvodjace(){
    return JSON.parse(sessionStorage.getItem('proizvodjaci'));
  }
  

  ukupnaCenaProizvodaUKorpi(){
    let cena = 0;
    let proizvodi: ProizvodKorpa[] = JSON.parse(sessionStorage.getItem('proizvodiUKorpi'));
    for(let temp of proizvodi){
      cena = cena + temp.cena*temp.kolicina;

    }
    return cena;
  }

  proslediPorudzbinu(rasadnikId: number, idPolj: number){
    let proizvodi: ProizvodKorpa[] = JSON.parse(sessionStorage.getItem('proizvodiUKorpi'));
    //anuliramo korpu
    let korpa: ProizvodKorpa[] = []
    sessionStorage.setItem('proizvodiUKorpi', JSON.stringify(korpa));
    //
    //dohvatamo sve proizvodjace 
    let proizvodjaci = JSON.parse(sessionStorage.getItem('proizvodjaci'));

    //za svakog proizvodjaca prvo moramo da dohvatimo id, a zatim da kreiramo porudzbine
    
    for(let temp of proizvodjaci){
      let idPorudzbine = 0;
      let idPreduzeca = 0;
      this.preduzeceService.findByNaziv(temp).subscribe(
        data=>{
          idPreduzeca = data.id; //dohvatimo id preduzeca
          //sad kroz sve proizvode iz korpe koje proizvodi dato preduzece moramo da kreiramo porudzbinu
          
          
            if(idPorudzbine==0){ //dakle ako tek pravimo porudzbinu
              let pordzbina: PorudzbinaPost = new PorudzbinaPost();
              pordzbina.cena = 0;
              pordzbina.datumKreiranja = new Date();
              pordzbina.status = 'kreirana';
              this.preduzeceService.kreirajPorudzbinu(pordzbina).subscribe(
                data=>{
                  idPorudzbine = data.id; //id porudzbine za dato preduzece
                  this.preduzeceService.updatePorudzbinaIds(idPorudzbine,idPolj,rasadnikId,idPreduzeca).subscribe(
                    data=>{
                      //sada kada smo kreirali porudzbinu moramo da dodajemo proizvode
                      let porId = idPorudzbine
                      for(let p of proizvodi){
                        if(p.proizvodjac == temp){ //ako proizvod pripada proizvodjacu
                          this.preduzeceService.createProizvodPorudzbina(porId,p.id,p.kolicina).subscribe()
                          
                        }
                      }
                    }
                  );
                }
              )
            }

          
        }
      )

    }

   //korpa prazna
   let pk: ProizvodKorpa[] = [];
   sessionStorage.setItem('proizvodiUKorpi', JSON.stringify(pk));
   //proizvodjaci prazni
   let p: string[] = [];
   sessionStorage.setItem('proizvodjaci', JSON.stringify(p));
  }

}
