import { Component, OnInit } from '@angular/core';
import { Poljoprivrednik } from '../models/poljoprivrednik';
import { Rasadnik } from '../models/rasadnik';
import { Router } from '@angular/router';
import { MatDialog, MatDialogConfig } from '@angular/material/dialog';
import { CreateRasadnikComponent } from '../create-rasadnik/create-rasadnik.component';
import { PoljoprivrednikService } from '../servisi/poljoprivrednik.service';
import { UsersService } from '../servisi/users.service';
import { AutentikacijaService } from '../servisi/autentikacija.service';
import { RasadnikService } from '../servisi/rasadnik.service';

@Component({
  selector: 'app-poljoprivrednik',
  templateUrl: './poljoprivrednik.component.html',
  styleUrls: ['./poljoprivrednik.component.css']
})
export class PoljoprivrednikComponent implements OnInit {

  poljoprivrednik: Poljoprivrednik = new Poljoprivrednik();
  rasadnici: Rasadnik[] = [];
  id: number = 1;
  userId: number = 1;
  mailSent=false;

  constructor(private router: Router,
              private dialog: MatDialog,
              private service: PoljoprivrednikService, private userService: UsersService
              ,private autServis:AutentikacijaService, private rasService: RasadnikService) { }

  ngOnInit(): void {
    if(sessionStorage.getItem('authenticatedUserId')!=null){
      this.userId = +sessionStorage.getItem('authenticatedUserId');
    }
    
    this.getPoljoprivrednik();
    
  }


  //dohvatamo trazenog poljoprivrednika, za sada fiksan id
  getPoljoprivrednik(){
    this.userService.findPoljoprivrednikByUserId(this.userId).subscribe(
      data=> {this.poljoprivrednik = data;
        this.id = data.id;
        //dohvati njegove rasadnike
        this.getRasadnici();
      }
    )
  }

  //otvara se dijalog za kreiranje novog rasadnika
  openDialog() {
    const dialogConfig = new MatDialogConfig();
    dialogConfig.data = { poljoprivrednikId: `${this.id}`} //na ovaj nacin prosledjujemo dijalogu id poljoprivrednika
    let matDialog = this.dialog.open(CreateRasadnikComponent, dialogConfig);
    
    matDialog.afterClosed().subscribe(
      data =>{
       
        this.ngOnInit();

      }
      
    );
  }
  
  //otvara izabrani rasadnik
  openRasadnik(id){
   // console.log(id);
    this.router.navigate([`/rasadnik/${id}`]);
  }

  //dohvate rasadnike za datog poljoprivrednika
  getRasadnici(){
    this.service.getRasadnici(this.id).subscribe(
      data => {
        this.rasadnici = data;
        let upozoreni:string[] = []
        for(let temp of this.rasadnici){
          if(temp.temperatura<12 || temp.voda<75){
              upozoreni.push(temp.naziv)            
          }
        }
        sessionStorage.setItem('upozoreni', JSON.stringify(upozoreni))
        if(upozoreni.length>0){
  //        this.rasService.sendMail(this.poljoprivrednik.id,upozoreni.toString()).subscribe();
           this.autServis.upozoreniV.next(true);
        }
       
        
        // if(upozoreni.length>0){
        //   sessionStorage.setItem('upozoreni', JSON.stringify(upozoreni))
        // }
      }
    )
  }

}
