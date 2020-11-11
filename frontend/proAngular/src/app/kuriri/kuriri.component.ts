import { Component, OnInit } from '@angular/core';
import { KuririService } from '../servisi/kuriri.service';
import { Kurir } from '../models/kurir';
import { ActivatedRoute, Router } from '@angular/router';
import { JeDodeljen } from '../models/jedodeljen';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';
import { Rasadnik } from '../models/rasadnik';
import { MapeService } from '../servisi/mape.service';
import { PorudzbiniService } from '../servisi/porudzbini.service';

@Component({
  selector: 'app-kuriri',
  templateUrl: './kuriri.component.html',
  styleUrls: ['./kuriri.component.css']
})
export class KuririComponent implements OnInit {

  kuriri: Kurir[] = [];
  rasadnik: Rasadnik = new Rasadnik();
  x: number;
  y:number;
  vremeh:number;
  minuti:number;
  vremem:number;
  traveltime:number;
  kilometraza:number;
  xBg:number=  44.79859;
  yBg:number= 20.47262;
 dodeljen:boolean=false;
 naCekanju:boolean=false;

  constructor(private kuririService: KuririService,
    private mapeServis: MapeService,
    private route: ActivatedRoute,
    private porService: PorudzbiniService,
    private router: Router) { }

  ngOnInit(): void {
    this.route.paramMap.subscribe(()=>{
      this.dohvatiKurire();
      this.dohvatiRasadnik();
    }); 
    
  }

  dohvatiRasadnik(){

    const porId: number= +this.route.snapshot.paramMap.get('porId');

    this.kuririService.getRasadnikPorudzbine(porId).subscribe(
      data=>{
        this.rasadnik=data;
        console.log(this.rasadnik.mesto)
        //kada dohvatimo rasadnik, racunamo koordinate
        this.getHereCoords(this.rasadnik.mesto)
      }
    )
  }

  getHereDistance(lat,lng,dlat,dlng){
    this.mapeServis.hereDistanca(lat,lng,dlat,dlng).subscribe(
      data=>{
        console.log(data)
    //    this.text=data.response.route[0].summary.text;
        console.log(data.response.route[0].summary.distance)
        this.kilometraza=Math.round(data.response.route[0].summary.distance/1000);
        console.log(data.response.route[0].summary.travelTime)
        this.traveltime=data.response.route[0].summary.travelTime ;
        this.vremeh=Math.floor(data.response.route[0].summary.travelTime/3600) ;
        this.minuti=Math.round( (data.response.route[0].summary.travelTime-this.vremeh*3600)/60);
        this.vremem=Math.round( data.response.route[0].summary.travelTime/60);
      }
    )
  }
  
  getHereCoords(mesto){
    let lat = 44.79859; //koordinate polazne tacke
      let lng =20.47262;
      let dlat = 0;
      let dlng = 0;
    this.mapeServis.hereDistancaCoord(mesto).subscribe(
      data=>{
        //koordinate destinacije
        console.log(data.Response.View[0].Result[0].Location.DisplayPosition.Latitude)
        dlat = data.Response.View[0].Result[0].Location.DisplayPosition.Latitude
        console.log(data.Response.View[0].Result[0].Location.DisplayPosition.Longitude)
        dlng=data.Response.View[0].Result[0].Location.DisplayPosition.Longitude
        //racuna distancu
        this.getHereDistance(lat,lng,dlat,dlng)
       
      }
    )
  
    
  }

  nazad(){
    this.router.navigateByUrl('preduzece');
  }
  
  

  dohvatiKurire(){

    const preduzeceId: number= +this.route.snapshot.paramMap.get('id');
    const porId: number= +this.route.snapshot.paramMap.get('porId');

    this.kuririService.dohvatiKurirePreduzeca(preduzeceId).subscribe(
      data=>{
        this.kuriri=data;
        let cnt=0;
       for(let i =0;i<this.kuriri.length;i++){
         if(this.kuriri[i].slobodan==false) cnt++;
       }
       if(cnt==5){
         this.naCekanju=true;
         this.porService.promeniStatusPorudzbine(porId,'cekanje').subscribe();
       } 
      }
    )

  }

  dodeli(kurirId){
    const porId: number= +this.route.snapshot.paramMap.get('porId');

     this.porService.promeniStatusPorudzbine(porId,"prihvacena").subscribe(
         data=>{
           //this.ngOnInit()
         }
       )
    

    this.kuririService.insertJeDodeljen(kurirId,porId,this.kilometraza,this.traveltime).subscribe(
      data=>{
        this.dodeljen=true;
        //this.ngOnInit()
      }
    )
  }

  
}
