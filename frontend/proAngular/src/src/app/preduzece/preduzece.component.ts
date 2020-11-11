import { Component, OnInit } from '@angular/core';
import { Porudzbina } from '../models/porudzbina';
import { PreduzeceService } from '../servisi/preduzece.service';
import { UsersService } from '../servisi/users.service';
import { PoljoprivrednikService } from '../servisi/poljoprivrednik.service';
import { Router, ActivatedRoute } from '@angular/router';
import { Route } from '@angular/compiler/src/core';
import { PorudzbiniService } from '../servisi/porudzbini.service';
import { KuririService } from '../servisi/kuriri.service';
import { Kurir } from '../models/kurir';

@Component({
  selector: 'app-preduzece',
  templateUrl: './preduzece.component.html',
  styleUrls: ['./preduzece.component.css']
})
export class PreduzeceComponent implements OnInit {

  
  //proizvodi: Proizvod[] = [];
  porudzbine: Porudzbina[] = [];
  userId: number = 0;
  preduzeceId: number = 1; 
  imaSlobodnih: boolean = false;
  kuriri: Kurir[] = [];

  constructor(private service: PreduzeceService,
              private poljService: PoljoprivrednikService,
              private router: Router,
              private route: ActivatedRoute,
              private porService: PorudzbiniService,
              private kuririService: KuririService
    ) { }

  ngOnInit(): void {
    this.userId = +sessionStorage.getItem('authenticatedUserId');
    this.dohvatiKurire();
    this.dohvatiPreduzece();
    
  }

  dohvatiKurire(){

   
    this.kuririService.dohvatiKurirePreduzeca(this.preduzeceId).subscribe(
      data=>{
        this.kuriri=data;
        let cnt=0;
       for(let i =0;i<this.kuriri.length;i++){
         if(this.kuriri[i].slobodan==true) cnt++;
       }

       if(cnt>0){
         this.imaSlobodnih=true;
       }
       
      }
    )

  }

  dohvatiPreduzece(){
    let preduzece = this.service.findByUserdId(this.userId).subscribe(
      data=>{
        this.preduzeceId = data.id;
        //dohvati porudzbine preduzeca
        this.dohvatiPorudzbine();
      }
    )
  }

  navigirajNaStranicuSaProizvodima(){
    const url = `${this.preduzeceId}/proizvodi`
    this.router.navigate([url], {relativeTo: this.route} );
  }

  dohvatiPorudzbine(){
    this.service.dohvatiPorudzbinePreduzeca(this.preduzeceId).subscribe(
      data=>{
        this.porudzbine = data;
        let i = 0;
        for(let temp of this.porudzbine){
          this.service.dohvatiPoljoprivrednikaIzPorudzbine(temp.id).subscribe(
            data=>{
              this.poljService.getUser(data.id).subscribe(
                data=>{
                  this.porudzbine[i].user = data.username;
                  i++;
                }
              )
            }
          )
        }
     
      }
    )
  }

  sortirajRastuce(){
    this.service.dohvatiPorudzbinePreduzecaSortiranoPoDatumuRastuce(this.preduzeceId).subscribe(
      data=>{
        this.porudzbine = data;
        let i = 0;
        for(let temp of this.porudzbine){
          this.service.dohvatiPoljoprivrednikaIzPorudzbine(temp.id).subscribe(
            data=>{
              this.poljService.getUser(data.id).subscribe(
                data=>{
                  this.porudzbine[i].user = data.username;
                  i++;
                }
              )
            }
          )
        }
     
      }
    )
  }

  sortirajOpadajuce(){
    this.service.dohvatiPorudzbinePreduzecaSortiranoPoDatumuOpadajuce(this.preduzeceId).subscribe(
      data=>{
        this.porudzbine = data;
        let i = 0;
        for(let temp of this.porudzbine){
          this.service.dohvatiPoljoprivrednikaIzPorudzbine(temp.id).subscribe(
            data=>{
              this.poljService.getUser(data.id).subscribe(
                data=>{
                  this.porudzbine[i].user = data.username;
                  i++;
                }
              )
            }
          )
        }
     
      }
    )
  }

  ukloniPorudzbinu(porId){
    this.porService.ukloniPorudzbinu(porId).subscribe(
      data=>{
        this.ngOnInit();
      }
    )

  }

    

  prihvatiPorudzbinu(porId){
    const url = `${this.preduzeceId}/kuriri/${porId}`
    this.router.navigate([url],{relativeTo: this.route});

      // this.porService.promeniStatusPorudzbine(porId,"prihvacena").subscribe(
      //   data=>{
      //     this.ngOnInit()
      //   }
      // )
  }  

  odbijPorudzbinu(porId){
    this.porService.promeniStatusPorudzbine(porId,"odbijena").subscribe(
      data=>{
        this.ngOnInit()
      }
    )
  }

}
