import { Component, OnInit } from '@angular/core';
import { Proizvod } from '../models/proizvod';
import { ProizvodService } from '../servisi/proizvod.service';
import { Router } from '@angular/router';
import { ShoppingCartService } from '../servisi/shopping-cart.service';


@Component({
  selector: 'app-shop',
  templateUrl: './shop.component.html',
  styleUrls: ['./shop.component.css']
})
export class ShopComponent implements OnInit {

  proizvodiPrikaz: Proizvod[] = [];
  proizvodiSvi: Proizvod[] = [];
  proizvodiSadnice: Proizvod[] = []; //sadnice u prodavnici
  proizvodiPreparati: Proizvod[] = []; //preparati u prodavnici
  kategorija: string = 'sve';
  gridDuzina: number =0;
  gridSirina: number =4;
  currentRate = 3.14;
  role:string = 'shop';
  ulogaKorisnika: string = "";
  message:string=""

  constructor(private service: ProizvodService,
              private router: Router,
              private shoppingcartservice: ShoppingCartService) { }

  ngOnInit(): void {
    this.dohvatiSveProizvode();
    this.dohvatiSadnice();
    this.dohvatiPreparate();
    this.ulogaKorisnika = sessionStorage.getItem('authenticatedUserRole');
   // console.log(this.gridDuzina)
  }

  pretrazi(value){
    this.message=""
   // console.log(`value=${value}`);
    this.service.pretraziProizvode(value).subscribe(
      data =>{
        
        this.proizvodiPrikaz = data;
        if(this.proizvodiPrikaz.length==0) this.message="Nijedan proizvod ne ispunjava traženi kriterijum!"
        //console.log(this.proizvodiPrikaz)
        for(let temp of this.proizvodiPrikaz){
          this.service.dohvatiPreduzeceProizvoda(temp.id).subscribe(
            data=>{
              temp.proizvodjac = data.naziv;
            }
          )
        }
      //  console.log(this.proizvodiPrikaz)
      } 
    )
  }

  counter(i: number) {
    return new Array(i);
  }    //brojac za for petlju koja mora da prodje kroz brojeve  


  dohvatiSveProizvode(){
    this.service.dohvatiSveProizvode().subscribe(
      data=>{
        this.proizvodiSvi = data
        for(let temp of this.proizvodiSvi){
          this.service.dohvatiPreduzeceProizvoda(temp.id).subscribe(
            data=>{
              temp.proizvodjac = data.naziv;
            }
          )
        }
        //na pocetku je kategorija uvek "sve"
         this.proizvodiPrikaz = this.proizvodiSvi;
        // console.log(this.proizvodiPrikaz)
        this.gridDuzina = Math.ceil(this.proizvodiSvi.length/4);
      //  console.log(this.gridDuzina)
      } 
      
    )
  }

  dohvatiSadnice(){
    this.service.dohvatiSadnice().subscribe(
      data=>{
        this.proizvodiSadnice = data;
        for(let temp of this.proizvodiSadnice){
          this.service.dohvatiPreduzeceProizvoda(temp.id).subscribe(
            data=>{
              temp.proizvodjac = data.naziv;
            }
          )
        }
      } 
      
    )
  }

  dohvatiPreparate(){
    this.service.dohvatiPreparate().subscribe(
      data=>{
        this.proizvodiPreparati = data;
        for(let temp of this.proizvodiPreparati){
          this.service.dohvatiPreduzeceProizvoda(temp.id).subscribe(
            data=>{
              temp.proizvodjac = data.naziv;
            }
          )
        }
      } 
    )
  }
  
  setKategorija(k){
    this.kategorija=k;
    if(this.kategorija=='sve'){
      this.proizvodiPrikaz = this.proizvodiSvi;
      this.gridDuzina = Math.ceil(this.proizvodiSvi.length/4);
    }else if(this.kategorija=='sadnice'){
      this.proizvodiPrikaz = this.proizvodiSadnice;
      this.gridDuzina = Math.ceil(this.proizvodiSadnice.length/4);
    }else{
      this.proizvodiPrikaz = this.proizvodiPreparati;
      this.gridDuzina = Math.ceil(this.proizvodiPreparati.length/4);
    }
  }

  prikazi(i){
   // console.log(i)
    return this.proizvodiPrikaz[i];
  }


  dodajUKorpu(proizvod, kolicina){
    //console.log(proizvod,kolicina)
    if(kolicina>0){
      this.shoppingcartservice.dodajUKorpu(proizvod,kolicina);
    }else{
      alert("Broj proizvoda mora biti veći od 0!")
    }
    
  }

}
