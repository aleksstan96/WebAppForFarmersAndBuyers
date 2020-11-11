import { Component, OnInit } from '@angular/core';
import { PoljoprivrednikService } from '../servisi/poljoprivrednik.service';
import { ActivatedRoute } from '@angular/router';
import { Porudzbina } from '../models/porudzbina';
import { MagacinService } from '../servisi/magacin.service';
import { RasadnikService } from '../servisi/rasadnik.service';
import { PorudzbiniService } from '../servisi/porudzbini.service';
import { ProizvodService } from '../servisi/proizvod.service';
import { Proizvod } from '../models/proizvod';

@Component({
  selector: 'app-mag-porudzbine',
  templateUrl: './mag-porudzbine.component.html',
  styleUrls: ['./mag-porudzbine.component.css']
})
export class MagPorudzbineComponent implements OnInit {

  poljId:number = 0;
  magId: number = 0;
  rasId:number = 0;
  porudzbine: Porudzbina[] = [];
  proizvodiPrikaz: ProPrikaz[]=[];

  constructor(private poljService: PoljoprivrednikService, private rasSer: RasadnikService,
    private route: ActivatedRoute,
    private magacinService: MagacinService, 
    private porService: PorudzbiniService,
    private proizvSerivce: ProizvodService) { }

  ngOnInit(): void {
    this.magId = +this.route.snapshot.paramMap.get("id");
    let id: number = +sessionStorage.getItem("authenticatedUserId");
    this.poljService.getPoljoprivrednikByUserId(id).subscribe(
      data=>{
        this.poljId=data.id;
        this.dohvatiPorudzbine();
      } 
    )
  }

  dohvatiPorudzbine(){
    this.rasSer.findByMagacinId(this.magId).subscribe(
      data=>{
        this.rasId = data.id;
        this.magacinService.dohvatiPorudzbineRasadnika(this.poljId,this.rasId).subscribe(
      data=>{
        this.porudzbine=data;
      }
    )
      }
    )
    
  }

  dohvatiProizvodePorudzbine(porId){
    //console.log(porId)
    this.proizvodiPrikaz = [];
    let proizvodi: Pro[]=[];
    this.porService.dohvatiProizvodPorudzbina(porId).subscribe(
      data=>{
        
        for(let temp of data){
          let pro = new Pro();
         pro.id=temp.id.proizvod_id;
         pro.kolicina=temp.kolicina;
        proizvodi.push(pro);
        }
        
        for(let temp of proizvodi){
          this.proizvSerivce.dohvatiProizvod(temp.id).subscribe(
            data=>{
              let proPrikaz = new ProPrikaz();
              proPrikaz.proizvod=data;
              proPrikaz.kolicina=temp.kolicina;
              this.proizvodiPrikaz.push(proPrikaz);
              
            }
          )
        }
    
      }
    )
  }


  otkazi(porId:number){
    this.porService.promeniStatusPorudzbine(porId,"otkazana").subscribe(
      data=>{
        this.ngOnInit()
      }
    );
    
  }

}

class Pro{
  id:number;
  kolicina:number;
}

class ProPrikaz{
  proizvod: Proizvod;
  kolicina:number;
}