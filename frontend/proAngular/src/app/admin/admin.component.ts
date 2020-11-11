import { Component, OnInit } from '@angular/core';
import { RegistrationService } from '../servisi/registration.service';
import { PredZahtev, PoljZahtev } from '../models/zahtev';

@Component({
  selector: 'app-admin',
  templateUrl: './admin.component.html',
  styleUrls: ['./admin.component.css']
})
export class AdminComponent implements OnInit {

  predZahtevi: PredZahtev[] = [];
  poljZahtevi: PoljZahtev[] = [];

  constructor(private service: RegistrationService) { }

  ngOnInit(): void {
    this.dohvatiPoljahteve();
    this.dohvatiPredZahteve();
  }

  dohvatiPredZahteve(){
    this.service.dohvatiPredZahteve().subscribe(
      data=> {
        this.predZahtevi = data;
      console.log(this.predZahtevi);
      }
    )
  }

  dohvatiPoljahteve(){
    this.service.dohvatiPoljZahteve().subscribe(
      data=> {
        this.poljZahtevi = data
        console.log(this.poljZahtevi);
      }
      
    )
  }

  prihvatiPoljZahtev(id){
    this.service.prihvatiPoljZahtev(id).subscribe(
      data => this.ngOnInit()
    );
  }

  odbijPoljZahtev(id){
    this.service.odbijPoljZahtev(id).subscribe(
      data=> this.ngOnInit()
    )

  }

  prihvatiPredZahtev(id){
    this.service.prihvatiPredZahtev(id).subscribe(
      data=> this.ngOnInit()
    )
  }

  odbijPredZahtev(id){
    this.service.odbjPredZajtev(id).subscribe(
      data => this.ngOnInit()
    )

  }


}
