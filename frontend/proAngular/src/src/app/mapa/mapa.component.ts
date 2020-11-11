import { Component, OnInit } from '@angular/core';
import { MapeService } from '../servisi/mape.service';

@Component({
  selector: 'app-mapa',
  templateUrl: './mapa.component.html',
  styleUrls: ['./mapa.component.css']
})
export class MapaComponent implements OnInit {

  public lat = 24.799448;
public lng = 120.979021;
public dlat = 26.799448;
public dlng = 130.979021;
 
public origin: any;
public destination: any;

kilometraza:number;
vremeh:number;
vremem:number;

text:string;

  constructor(private mapeServis: MapeService,
   
    ) { }

  ngOnInit() {
  // this.getDirection();
  // this.getHereCoords(mesto)
  }



// getDirection() {
//    this.origin = 'Mutapova 28 Beograd';
//    this.destination = 'Dragoslava Srejovica 766 Beograd';
// }

getHereDistance(lat,lng,dlat,dlng){
  this.mapeServis.hereDistanca(lat,lng,dlat,dlng).subscribe(
    data=>{
      console.log(data)
      this.text=data.response.route[0].summary.text;
      console.log(data.response.route[0].summary.distance)
      this.kilometraza=Math.round(data.response.route[0].summary.distance/1000);
      console.log(data.response.route[0].summary.travelTime)
      this.vremeh=Math.round(data.response.route[0].summary.travelTime/3600) ;
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
      this.getHereDistance(lat,lng,dlat,dlng)
      //koordinate uzica
  //     this.mapeServis.hereDistancaCoordUe().subscribe(
  //   data=>{
  //    // console.log(data)
  //     console.log(data.Response.View[0].Result[0].Location.DisplayPosition.Latitude)
  //     dlat=data.Response.View[0].Result[0].Location.DisplayPosition.Latitude
  //     console.log(data.Response.View[0].Result[0].Location.DisplayPosition.Longitude)
  //     dlng=data.Response.View[0].Result[0].Location.DisplayPosition.Longitude
  //     distanca
      
  //   }
  // )
    }
  )

  
}




}
