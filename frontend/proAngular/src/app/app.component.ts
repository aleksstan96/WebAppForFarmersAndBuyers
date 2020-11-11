import { Component, OnInit } from '@angular/core';
import { AutentikacijaService } from './servisi/autentikacija.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit{
  title = 'proAngular';

  upozoreni:string[] =null;

  constructor(private autServis: AutentikacijaService){}

  ngOnInit(){
    this.upozoreni= this.autServis.jeUpozoren();
    this.autServis.isloggedinV.subscribe(
      data=>{
        this.ngOnInit()
      }
    )
    this.autServis.upozoreniV.subscribe(
      data=>
      this.ngOnInit()
    )
  }
}
