import { Component, OnInit, Inject } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { AutentikacijaService } from '../servisi/autentikacija.service';
import { UsersService } from '../servisi/users.service';
import { Router, ActivatedRoute } from '@angular/router';
import { Subject } from 'rxjs';
import { ProizvodKorpa } from '../models/proizvod';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  username: string = "";
  password: string = "";
  message: string = "";
  
  
  

  constructor(@Inject(MAT_DIALOG_DATA) public data: any, //this is for data which is passed between dialog and host
             public dialogRef: MatDialogRef<LoginComponent>,
             private authService: AutentikacijaService,
             private usersService: UsersService,
             private router: Router,
             private route: ActivatedRoute) { }

  ngOnInit(): void {
  }

  save(){
    if(this.username=="" || this.password==""){
      this.message="Unesite sve podatke"
    }
    else
    {
      this.usersService.findUserByUsername(this.username).subscribe(
      data=>{
        if(data.length==0){ //ne postoji user 
          this.message = "Ne postoji korisnik sa navedenim korisničkim imenom";
          return this.message;
        }else{
          this.usersService.findUserByUsernameAndPassword(this.username, this.password).subscribe(
            data=>{
              if(data.length==0){
                this.message = "Lozinka nije korektna";
                return this.message;
              }else{//postoji korisnik
                sessionStorage.setItem('authenticatedUser', this.username);
             //   console.log(data);
                sessionStorage.setItem('authenticatedUserId', data[0].id.toString());
                this.dialogRef.close();
                //this.authService.login();
                if(data[0].role=='ROLE_ADMIN'){
                  sessionStorage.setItem('authenticatedUserRole', data[0].role);
                  const url = `admin`;
                  this.authService.login();
                 this.router.navigate([url], {relativeTo: this.route} );
                }else if(data[0].role=='ROLE_POLJOPRIVREDNIK'){
                  //korpa prazna
                  let proizvodi: ProizvodKorpa[] = [];
                  sessionStorage.setItem('proizvodiUKorpi', JSON.stringify(proizvodi));
                  //proizvodjaci prazni
                  let proizvodjaci: string[] = [];
                  sessionStorage.setItem('proizvodjaci', JSON.stringify(proizvodjaci))

                  sessionStorage.setItem('authenticatedUserRole', data[0].role);
                  const url = `poljoprivrednik`;
                  this.authService.login();
                 this.router.navigate([url], {relativeTo: this.route} );
                  
                }else if(data[0].role=='ROLE_PREDUZECE'){
                  sessionStorage.setItem('authenticatedUserRole', data[0].role);
                  const url = `preduzece`;
                  this.authService.login();
                 this.router.navigate([url], {relativeTo: this.route} );

                }
              }
            }
          )
        }
      }
    )
    }
    
    

  }

}
