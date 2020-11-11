import { Component, OnInit } from '@angular/core';
import { Proizvod, ProizvodKorpa } from '../models/proizvod';
import { ShoppingCartService } from '../servisi/shopping-cart.service';
import { PoljoprivrednikService } from '../servisi/poljoprivrednik.service';
import { UsersService } from '../servisi/users.service';
import { Poljoprivrednik } from '../models/poljoprivrednik';
import { Rasadnik } from '../models/rasadnik';

@Component({
  selector: 'app-shopping-cart',
  templateUrl: './shopping-cart.component.html',
  styleUrls: ['./shopping-cart.component.css']
})
export class ShoppingCartComponent implements OnInit {

  proizvodi: ProizvodKorpa[] = [];
  ukupanIznos: number = 0;
  userId = 0;
  idPolj = 0;
  poljoprivrednik: Poljoprivrednik = new Poljoprivrednik();
  rasadnici: Rasadnik[] = [];
  selectedValue = null;
  message:string="";

  constructor(private service: ShoppingCartService, private poljservice: PoljoprivrednikService, private userService: UsersService) { }

  ngOnInit(): void {
    //console.log(this.service.dohvatiIzKorpe())
   
    this.proizvodi = this.service.dohvatiIzKorpe();
  //  console.log(this.proizvodi.length)
   this.ukupanIznos = this.service.ukupnaCenaProizvodaUKorpi();

   this.userId = +sessionStorage.getItem('authenticatedUserId');
    this.getPoljoprivrednik();
  }

  proslediPorudzbinu(rasadnik: number, poljId:number){
   
    this.service.proslediPorudzbinu(rasadnik,poljId);
    this.message="Porudžbina uspešno prosleđena!";
    //alert("Porudžbina uspešno prosleđena!");
    //this.ngOnInit();
  }

  //dohvate rasadnike za datog poljoprivrednika
  getRasadnici(){
    this.poljservice.getRasadnici(this.idPolj).subscribe(
      data => {
        this.rasadnici = data;
      }
    )
  }

  //dohvatamo trazenog poljoprivrednika, za sada fiksan id
  getPoljoprivrednik(){
    this.userService.findPoljoprivrednikByUserId(this.userId).subscribe(
      data=> {
        this.poljoprivrednik = data;
        this.idPolj = data.id;
        //dohvati njegove rasadnike
        this.getRasadnici();
      }
    )
  }

  kolicinaPlus(proizvod:ProizvodKorpa){
   // let i = 0;
    for(let temp of this.proizvodi){
      if(temp.id==proizvod.id){
        temp.kolicina++;
        break;
      }
    }
    sessionStorage.setItem('proizvodiUKorpi', JSON.stringify(this.proizvodi))
    this.ngOnInit()
  }

  kolicinaMinus(proizvod:ProizvodKorpa){
    let i = 0;
    for(let temp of this.proizvodi){
      if(temp.id==proizvod.id){
        temp.kolicina--;
        break;
      }
      i++;
    }
    if(this.proizvodi[i].kolicina==0){
      this.proizvodi.splice(i,1);
    }
    sessionStorage.setItem('proizvodiUKorpi', JSON.stringify(this.proizvodi))
    this.ngOnInit()

  }

}
