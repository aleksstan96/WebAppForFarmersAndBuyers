import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import { ActivatedRoute } from '@angular/router';
import { map } from 'rxjs/operators';
import { Proizvod } from '../models/proizvod';
import { MatDialogConfig, MatDialog } from '@angular/material/dialog';
import { RejtingComponent } from '../dialog/rejting/rejting.component';
import { ShoppingCartService } from '../servisi/shopping-cart.service';
import { ProizvodService } from '../servisi/proizvod.service';

@Component({
  selector: 'app-proizvod-detalji',
  templateUrl: './proizvod-detalji.component.html',
  styleUrls: ['./proizvod-detalji.component.css']
})
export class ProizvodDetaljiComponent implements OnInit {
  state$: Observable<ProizvodState>;
  proizvod: Proizvod = new Proizvod();
  role: string = "";
  ulogaKorisnika=""

  constructor(public activatedRoute: ActivatedRoute,
              private dialog: MatDialog,
              private service: ShoppingCartService,
              private proizvodService:ProizvodService) { }

  ngOnInit(): void {
    this.ulogaKorisnika = sessionStorage.getItem('authenticatedUserRole')
    this.state$ = this.activatedRoute.paramMap
    .pipe(map(() => window.history.state))
    this.state$.subscribe(
      data => {
        if(data.proizvod!=null && data.proizvod!=undefined){ //ako smo ovde dosli preko shopa ili preduzeca
         // this.proizvod = data.proizvod;
         this.role = data.role;
         this.proizvodService.dohvatiProizvod(data.proizvod.id).subscribe(
           data=>{
            this.proizvod = data;
            localStorage.setItem("proizvod", JSON.stringify(this.proizvod));
           localStorage.setItem("role", JSON.stringify(this.role));
           }
         )
          
        //  console.log(this.role)
         //  localStorage.setItem("proizvod", JSON.stringify(this.proizvod));
        //   localStorage.setItem("role", JSON.stringify(this.role));
         //  console.log(this.proizvod);
        }else{ //u slucaju da je odradjen refresh
          this.proizvod = JSON.parse(localStorage.getItem('proizvod'));
          this.role = JSON.parse(localStorage.getItem('role'));
        }
      
      }
    )

  }

  openDialog(id: number) {
    const dialogConfig = new MatDialogConfig();
    dialogConfig.data = { id: id} //na ovaj nacin prosledjujemo dijalogu id proizvoda
    let matDialog = this.dialog.open(RejtingComponent, dialogConfig);
    
    matDialog.afterClosed().subscribe(
      data =>{
        this.ngOnInit();

      }
      
    );
  }

  dodajUKorpu(proivod: Proizvod, kolicina: number){
  //  console.log(proivod,kolicina)
  if(kolicina<1) 
    alert("Kolicina mora biti veca od 0!")
  else
    this.service.dodajUKorpu(proivod,kolicina)
  }

}


interface ProizvodState{
  proizvod: Proizvod;
  role: string;
}