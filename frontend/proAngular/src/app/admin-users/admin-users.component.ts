import { Component, OnInit } from '@angular/core';
import { UsersService } from '../servisi/users.service';
import { User } from '../models/user';
import { MatDialog, MatDialogConfig } from '@angular/material/dialog';
import { DodavanjeKorisnikaComponent } from '../dialog/dodavanje-korisnika/dodavanje-korisnika.component';
import { DodavanjeAdminaComponent } from '../dialog/dodavanje-admina/dodavanje-admina.component';
import { DodavanjePreduzecaComponent } from '../dialog/dodavanje-preduzeca/dodavanje-preduzeca.component';
import { IzmenaAdminaComponent } from '../dialog/izmena-admina/izmena-admina.component';
import { IzmenaPreduzecaComponent } from '../dialog/izmena-preduzeca/izmena-preduzeca.component';
import { IzmenaKorisnikaComponent } from '../dialog/izmena-korisnika/izmena-korisnika.component';
import { Poljoprivrednik } from '../models/poljoprivrednik';
import { Preduzece } from '../models/preduzece';

@Component({
  selector: 'app-admin-users',
  templateUrl: './admin-users.component.html',
  styleUrls: ['./admin-users.component.css']
})
export class AdminUsersComponent implements OnInit {

  korisnici: User[] = [];
  korisnik: User = new User();
  userId: number;
  poljoprivrednik: Poljoprivrednik = new Poljoprivrednik();
  preduzece: Preduzece = new Preduzece();

  constructor(private userService: UsersService,
              private dialog: MatDialog,) { }

  ngOnInit(): void {
    this.getAllUsers();
  }

  getAllUsers(){
    this.userService.getAllUsers().subscribe(
      data => this.korisnici = data
    )
  }




  openDialogDodavanjePolj() {
    const dialogConfig = new MatDialogConfig();
   // dialogConfig.data = { poljoprivrednikId: `${this.id}`} //na ovaj nacin prosledjujemo dijalogu id poljoprivrednika
    let matDialog = this.dialog.open(DodavanjeKorisnikaComponent, dialogConfig);
    
    matDialog.afterClosed().subscribe(
      data =>{
        this.ngOnInit();

      }
      
    );
  }

  openDialogDodavanjeAdmina() {
    const dialogConfig = new MatDialogConfig();
   // dialogConfig.data = { poljoprivrednikId: `${this.id}`} //na ovaj nacin prosledjujemo dijalogu id poljoprivrednika
    let matDialog = this.dialog.open(DodavanjeAdminaComponent, dialogConfig);
    
    matDialog.afterClosed().subscribe(
      data =>{
        this.ngOnInit();

      }
      
    );
  }

  openDialogDodavanjePreduzeca() {
    const dialogConfig = new MatDialogConfig();
   // dialogConfig.data = { poljoprivrednikId: `${this.id}`} //na ovaj nacin prosledjujemo dijalogu id poljoprivrednika
    let matDialog = this.dialog.open(DodavanjePreduzecaComponent, dialogConfig);
    
    matDialog.afterClosed().subscribe(
      data =>{
        this.ngOnInit();

      }
      
    );
  }

  deleteUser(userId){
    this.userService.deleteUser(userId).subscribe(
      data=> this.ngOnInit()
    );
  }

  openDialogIzmena(user: User){
    this.korisnik = user;
    console.log(user)
    if(user.role=="ROLE_POLJOPRIVREDNIK"){
      this.userService.findPoljoprivrednikByUserId(user.id).subscribe(
        data =>{
          this.poljoprivrednik = data;
          console.log(this.poljoprivrednik);
          this.openDialogIzmenaPoljoprivrednika(this.korisnik, this.poljoprivrednik);
        }
      )
      
    }else if(user.role=="ROLE_PREDUZECE"){
      this.userService.findPreduzeceByUserId(user.id).subscribe(
        data =>{
          this.preduzece = data;
         // console.log(this.preduzece);
          this.openDialogIzmenaPreduzeca(this.korisnik, this.preduzece);
        }
      )
    }else if(user.role=="ROLE_ADMIN"){
      this.openDialogIzmenaAdmina(this.korisnik);
    }
  }

  openDialogIzmenaPoljoprivrednika(user: User, poljoprivrednik: Poljoprivrednik) {
      const dialogConfig = new MatDialogConfig();
      dialogConfig.data = { user: user, poljoprivrednik: poljoprivrednik} //na ovaj nacin prosledjujemo dijalogu id poljoprivrednika
      let matDialog = this.dialog.open(IzmenaKorisnikaComponent, dialogConfig);
      
      matDialog.afterClosed().subscribe(
        data =>{
          this.ngOnInit();

        }
        
      );
    }


  openDialogIzmenaAdmina(user: User) {
    const dialogConfig = new MatDialogConfig();
    dialogConfig.data = { user: user} //na ovaj nacin prosledjujemo dijalogu id poljoprivrednika
    let matDialog = this.dialog.open(IzmenaAdminaComponent, dialogConfig);
    
    matDialog.afterClosed().subscribe(
      data =>{
        this.ngOnInit();

      }
      
    );
  }

  openDialogIzmenaPreduzeca(user: User, preduzece: Preduzece) {
    const dialogConfig = new MatDialogConfig();
    dialogConfig.data = { user: user, preduzece: preduzece} //na ovaj nacin prosledjujemo dijalogu id poljoprivrednika
    let matDialog = this.dialog.open(IzmenaPreduzecaComponent, dialogConfig);
    
    matDialog.afterClosed().subscribe(
      data =>{
        this.ngOnInit();

      }
      
    );
  }

  

  

}
