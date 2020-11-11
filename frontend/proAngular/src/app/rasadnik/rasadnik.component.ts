import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Rasadnik } from '../models/rasadnik';
import { ViewChild, AfterViewInit, ViewEncapsulation, Input } from '@angular/core';
import { jqxLinearGaugeComponent } from 'jqwidgets-ng/jqxlineargauge';
import { jqxBarGaugeComponent } from 'jqwidgets-ng/jqxbargauge';
import {NgbPopoverConfig} from '@ng-bootstrap/ng-bootstrap';
import { Sadnica, SadnicaPost } from '../models/sadnica';
import { RasadnikService } from '../servisi/rasadnik.service';
import { MagacinService } from '../servisi/magacin.service';
import { MagacinProizvod } from '../models/magacinproizvod';
import { PoljoprivrednikService } from '../servisi/poljoprivrednik.service';
import { AutentikacijaService } from '../servisi/autentikacija.service';


@Component({
  selector: 'app-rasadnik',
  templateUrl: './rasadnik.component.html',
  styleUrls: ['./rasadnik.component.css'],
  encapsulation: ViewEncapsulation.None,
  providers: [NgbPopoverConfig] // add NgbPopoverConfig to the component providers
})
export class RasadnikComponent implements   AfterViewInit {

  rasadnik: Rasadnik = new Rasadnik(); //rasadnik u kom smo
  magacinId:number;   //id magacina vezanog za rasadnik
  sadnice: Sadnica[] = [];   //sadnice rasadnika
  trenutnaSadnica: Sadnica = new Sadnica(); //trenutna sadnica koju posmatramo
  proizvodiSadnice: MagacinProizvod[] = []; //sadnice u magacinu
  proizvodiPreparati: MagacinProizvod[] = []; //preparati u magacinu
  kolicinaVodeProcentiVal : string = "";
  kolicinaVodeVal: string = "";
  poljId:number = 0;
  upozoreni: string[] = [];

  //konfiguracija za popover da ne bi reagovao na klik vec na prelaz misa
  constructor(private config: NgbPopoverConfig,
            private route: ActivatedRoute,
            private router: Router,
            private service: RasadnikService,
            private magService: MagacinService,
            private poljService: PoljoprivrednikService,
            private autService: AutentikacijaService) { 

         // customize default values of popovers used by this component tree
        config.placement = 'right';
        config.triggers = 'hover';
        config.autoClose = "inside" ; 
               
      }

  
  ngOnInit(): void {
    if(sessionStorage.getItem('upozoreni')!=null){
      this.upozoreni = JSON.parse(sessionStorage.getItem('upozoreni'));
    }
    
    this.route.paramMap.subscribe(()=>{
      //dohvatamo sadnice datog rasadnika
      this.getPoljoprivrednik();
       this.getSadnice();
       this.getRasadnik();
       this.dohvatiMagacin();
      
    }); //!!!!!!!!!!!!

  }


  getPoljoprivrednik(){
    this.poljService.getPoljoprivrednikByUserId(sessionStorage.getItem('authenticatedUserId')).subscribe(
      data=>{
        this.poljId=data.id;
      }
    )
  }

  //ovo sluzi da bismo podatak "duzina" i "sirina" rasadnika pretvorili u cnt za *ngFor
  counter(i: number) {
    return new Array(i);
  }    //brojac za for petlju koja mora da prodje kroz brojeve  


  ////dohvatanje sadnica datog rasadnika
  getSadnice(){
    const rasadnikId: number= +this.route.snapshot.paramMap.get('id');
    
    this.service.getSadnice(rasadnikId).subscribe(
      data =>{
        this.sadnice = data;
      } 
    )
  }

  //dohvatanje trenutnog rasadnika u kom smo
  getRasadnik(){
    const rasadnikId: number= +this.route.snapshot.paramMap.get('id');

    this.service.getRasadnik(rasadnikId).subscribe(
      data=>{
        this.rasadnik = data;
        this.myLinearGauge.value(this.rasadnik.temperatura); 
        //kolicina vode
        let procenat = (this.rasadnik.voda/400)*100;
        this.kolicinaVodeProcentiVal = procenat.toString();
        this.kolicinaVodeVal = this.rasadnik.voda.toString() + "ℓ";
        if(this.rasadnik.temperatura<12 || this.rasadnik.voda<75){
          let vecUpozoren=false;
          if(this.upozoreni.length>0){
            for(let u of this.upozoreni){
              if(u==this.rasadnik.naziv){
                vecUpozoren=true;
                break;
              }
            }
          }
          if(vecUpozoren==false){
           this.service.sendMail( this.poljId , this.rasadnik.naziv).subscribe();
            this.upozoreni.push(this.rasadnik.naziv);
            sessionStorage.setItem('upozoreni', JSON.stringify(this.upozoreni));
            this.autService.upozoreniV.next(true);
          }
          //
        }
        
      }
    );
  }

  //dohvatanje magacina trenutnog rasadnika
  dohvatiMagacin(){
    const rasadnikId: number= +this.route.snapshot.paramMap.get('id');

    this.service.dohvatiMagacin(rasadnikId).subscribe(
      data => {
        this.magacinId = data.id;
        //console.log("magacinId:" + this.magacinId)
        this.dohvatiPreparate(); //cim dohvatmo idMagacina odmah dohvatimo i proizvode
        this.dohvatiSadnice();
        
      }
    );
    
  }

  //dohvatamo proizvode kategorije "sadnica"
  dohvatiSadnice(){
    this.magService.dohvatiSadnice(this.magacinId).subscribe(
      data=>{
        this.proizvodiSadnice = data;
       
      }
    );

  }

  //dohvatamo proizvode kategorije "preparat"
  dohvatiPreparate(){
    this.magService.dohvatiPreparate(this.magacinId).subscribe(
      data=>{
        this.proizvodiPreparati = data;
        
      }
    );
  }

  //funkcija koja proverava da li odredjeno polje ima sadnicu u sebi
  imaSadnicu(polje): boolean{
      let cnt = 0;
    for (let temp of this.sadnice){
        if(temp.brPolja==polje && temp.uklonjena!=true){
            cnt++;
            break;
        }
    }
    if(cnt>0) return true;
    return false;
  }

  //funkcija koja proverava da li odredjeno polje ima zivadjenu sadnicu u sebi
  imaIzvadjenuSadnicu(polje): boolean{
    let cnt = 0;
  for (let temp of this.sadnice){
      if(temp.brPolja==polje && temp.uklonjena==true){
          cnt++;
          break;
      }
  }
  if(cnt>0) return true;
  return false;
}

  //funkcija koja sluzi za vadjenje sadnice iz rasadnika
  izvadiSadnicu(id){
    this.service.izvadiSadnicu(id).subscribe(
      data =>{
        //setTimeout(() => {
         // this.obrisiSadnicu(id);
      //  }, 
     //   (1000*15)   //30sec
       // (1000 * 60 * 60 * 24) //1 dan
     //   );  
        this.ngOnInit()
      }
    );

  }

  //obrisi sadnicu (nakon jednog dana od vadjenja sadnice)
  obrisiSadnicu(id){
    this.service.obrisiSadnicu(id).subscribe(
      data=>{
        this.rasadnik.brSadnica--;
        this.rasadnik.brSlobodnih++;
        this.service.updateRasadnik(this.rasadnik.id, this.rasadnik).subscribe(
          data=> this.ngOnInit()
        );
      }
    );
    
  }

  //fja koja sluzi za sadjenje sadnice
  zasadiSadnicu(polje, idSadnice){

    //dohvatimo sadnicu (proizvod) iz magacina
    let sadnica : MagacinProizvod  = new MagacinProizvod();
    this.magService.dohvatiProizvod(this.magacinId, idSadnice).subscribe(
      data=>{
        sadnica = data;

        //smanjimo kolicinu za 1 (ako je 0 i izbrisemo iz baze)
        sadnica.kolicina--;
        if(sadnica.kolicina==0){
          //brisemo iz baze
          this.magService.obrisiProizvod(this.magacinId, idSadnice).subscribe();
        }else{
          //izmenimo u bazi
          this.magService.updateProizvodKolicina(this.magacinId,idSadnice,sadnica.kolicina).subscribe();
        }
        
     
         //insertujemo u bazu
         let sadnicaPost = new SadnicaPost();
         sadnicaPost.naziv = sadnica.naziv;
         sadnicaPost.brPolja = polje;
         sadnicaPost.proizvodjac = sadnica.proizvodjac;
         sadnicaPost.uklonjena = false;
         sadnicaPost.progres = 0;
         sadnicaPost.vek = sadnica.dani;
         this.service.dodajSadnicu(sadnicaPost).subscribe(
           data=>{
           //  console.log(data.id)
            // console.log(this.rasadnik.id)
            
            this.rasadnik.brSadnica++;
            this.rasadnik.brSlobodnih--;
            this.service.updateRasadnik(this.rasadnik.id, this.rasadnik).subscribe();
            
            console.log(this.router.url)
             this.service.dodeliRasadnikSadnici(data.id, this.rasadnik.id).subscribe(
               data=>  this.ngOnInit()
             ) //kada insertujemo u bazu dobijamo id sadnice i tada joj dodelimo rasadnikId
    
              
            }
         )

      }
    )

  }

  //fja koja zadatoj sadnici dodaje preparat
  dodajPreparat(sadnicaId, preparatId){ 
   // console.log(sadnicaId);
   // console.log(preparatId);

    let preparat : MagacinProizvod  = new MagacinProizvod();
    this.magService.dohvatiProizvod(this.magacinId, preparatId).subscribe(
      data=>{
        preparat = data;

        preparat.kolicina--;
        if(preparat.kolicina==0){
          //brisemo iz baze
          this.magService.obrisiProizvod(this.magacinId, preparatId).subscribe();
        }else{
          //izmenimo u bazi
          this.magService.updateProizvodKolicina(this.magacinId,preparatId,preparat.kolicina).subscribe();
        }

        this.service.promeniProgresSadnice(sadnicaId,preparat.dani).subscribe(
          data => this.ngOnInit()
        );
        
      }
    )

  }
 

  //prikaz podataka o sadnici
  prikaziPodatke(brojSadnice){
    for (let temp of this.sadnice){
        if(temp.brPolja==brojSadnice){
            this.trenutnaSadnica = temp;
        }
    }
  }


  tempPlus(){
    this.rasadnik.temperatura++; 
    this.myLinearGauge.value(this.rasadnik.temperatura);
    const rasadnikId: number= +this.route.snapshot.paramMap.get('id');
    let upozoren=false;
    if(this.upozoreni.length>0 && this.rasadnik.temperatura>=12 && this.rasadnik.voda>75){
      let i=0;
      for(let u of this.upozoreni){
        if(u==this.rasadnik.naziv){
          upozoren=true;
          break;
        }
        i++;
      }
       if(upozoren){
      this.upozoreni.splice(i,1);
      sessionStorage.setItem('upozoreni',JSON.stringify(this.upozoreni));
      this.autService.upozoreniV.next(false)
    }
    }
   
    
    this.service.updateRasadnik(rasadnikId, this.rasadnik).subscribe(
      data=> this.ngOnInit()
    );
    
  }

  tempMinus(){
    this.rasadnik.temperatura--;
    this.myLinearGauge.value(this.rasadnik.temperatura);
    const rasadnikId: number= +this.route.snapshot.paramMap.get('id');
    
    this.service.updateRasadnik(rasadnikId, this.rasadnik).subscribe(
      data=> this.ngOnInit()
    );
    
  }

  vodaPlus(){
    this.rasadnik.voda++;
    const rasadnikId: number= +this.route.snapshot.paramMap.get('id');
    let upozoren=false;
    if(this.upozoreni.length>0 && this.rasadnik.temperatura>=12 && this.rasadnik.voda>75){
      let i=0;
      for(let u of this.upozoreni){
        if(u==this.rasadnik.naziv){
          upozoren=true;
          break;
        }
        i++;
      }
       if(upozoren){
      this.upozoreni.splice(i,1);
      sessionStorage.setItem('upozoreni',JSON.stringify(this.upozoreni))
      this.autService.upozoreniV.next(false)
    }
    }
    
    this.service.updateRasadnik(rasadnikId, this.rasadnik).subscribe(
      data=> this.ngOnInit()
    );
    
   
  }

  vodaMinus(){
    this.rasadnik.voda--;
    const rasadnikId: number= +this.route.snapshot.paramMap.get('id');
    
    this.service.updateRasadnik(rasadnikId, this.rasadnik).subscribe(
      data=> this.ngOnInit()
    );
   
  }



  ////////////TERMOMETAR////////

  
  @ViewChild('myLinearGauge', { static: false }) myLinearGauge: jqxLinearGaugeComponent;
  pointer: any = { size: '6%' };
  labels: any = { interval: 20 };
  ticksMinor: any = { size: '5%', interval: 2.5, style: { 'stroke-width': 1, stroke: '#aaaaaa' } };
  ticksMajor: any = { size: '10%', interval: 10 };
  
  ranges: any[] =
  [
      { startValue: -10, endValue: 10, style: { fill: '#FFF157', stroke: '#FFF157' } },
      { startValue: 10, endValue: 35, style: { fill: '#FFA200', stroke: '#FFA200' } },
      { startValue: 35, endValue: 60, style: { fill: '#FF4800', stroke: '#FF4800' } }
  ];
  ngAfterViewInit(): void {
      this.myLinearGauge.value(this.rasadnik.temperatura); //OVDE POSTAVIS PARAMETAR TEMPERATURE
  }

  ////////////////////////////////


 

}
