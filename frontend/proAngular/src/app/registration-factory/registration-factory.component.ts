import { Component, OnInit, Inject } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { PredZahtev } from '../models/zahtev';
import { RegistrationService } from '../servisi/registration.service';
import { UsersService } from '../servisi/users.service';

@Component({
  selector: 'app-registration-factory',
  templateUrl: './registration-factory.component.html',
  styleUrls: ['./registration-factory.component.css']
})
export class RegistrationFactoryComponent implements OnInit {

  preduzece: PredZahtev = new PredZahtev();
  passwordReplica: string = "";
  razliciteLozinke: boolean = false;
  regex =  new RegExp("(?=.*[a-z])(?=.*[A-Z])^[a-zA-Z](?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{6,})");
  clicked: boolean = false;
  usernamePostoji: boolean =false;
  captcha: boolean = false;

  constructor(@Inject(MAT_DIALOG_DATA) public data: any, //this is for data which is passed between dialog and host
              public dialogRef: MatDialogRef<RegistrationFactoryComponent>,
              private service: RegistrationService,
              private usersService: UsersService) { }

  ngOnInit(): void {
    this.razliciteLozinke = false;
    this.clicked=false;
    this.usernamePostoji=false;
  }

  save(naziv,username,lozinka,duplikat,datum,mesto,email){
    this.clicked=true;
    if(this.captcha==true){
      this.checkDataAndSave( naziv, username, lozinka, duplikat, datum, mesto,email);
    }
    

  }


  private checkDataAndSave(naziv: any, username: any, lozinka: any, duplikat: any, datum: any, mesto: any, email: any) {
    if (!naziv && !username && !lozinka && !duplikat && !datum && !mesto &&!email) {
      if (this.preduzece.password != this.passwordReplica) {
        this.razliciteLozinke = true;
     //   this.clicked=false;
      }
      else {
        this.usersService.findUserByUsername(this.preduzece.skracenica).subscribe(
          data=>{
            if(data.length==0){ //ne postoji kosrisnik sa istim usernameom
              console.log(data.length)
               //slanje zahteva
              this.preduzece.prihvacen = false;
              this.preduzece.nijePrihvacen = false;
              this.service.posaljiPredZahtev(this.preduzece).subscribe();
              this.dialogRef.close(this.preduzece);
            }else{
              this.usernamePostoji=true;
            //  this.clicked=false;
            }
          }
        )
       
      }
    }
  }

  
  public resolved(captchaResponse: string) {
    // console.log(`Resolved captcha with response: ${captchaResponse}`);
     this.captcha=true;
   }

}
