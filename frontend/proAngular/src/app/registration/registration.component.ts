import { Component, OnInit, Inject } from '@angular/core';
import { MatDialogRef, MatDialogConfig, MatDialog, MAT_DIALOG_DATA } from "@angular/material/dialog";
import { PoljZahtev } from '../models/zahtev';
import { RegistrationService } from '../servisi/registration.service';
import { UsersService } from '../servisi/users.service';


@Component({
  selector: 'app-registration',
  templateUrl: './registration.component.html',
  styleUrls: ['./registration.component.css']
})
export class RegistrationComponent implements OnInit {

  poljoprivrednik: PoljZahtev = new PoljZahtev();
  passwordReplica: string = "";
  razliciteLozinke: boolean = false;
  regex =  new RegExp("(?=.*[a-z])(?=.*[A-Z])^[a-zA-Z](?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{6,})");
  clicked: boolean = false;
  usernamePostoji: boolean =false;
  captcha: boolean = false;

  constructor(@Inject(MAT_DIALOG_DATA) public data: any, //this is for data which is passed between dialog and host
              public dialogRef: MatDialogRef<RegistrationComponent>,
              private service: RegistrationService,
              private usersService: UsersService) { }

  ngOnInit(): void {
    this.razliciteLozinke = false;
    this.clicked=false;
    this.usernamePostoji=false;
  }

  save(ime,prezime,username,lozinka,duplikat,datum,mesto,telefon,email){
    this.clicked=true;
    if(this.captcha){
      this.checkDataAndSave(ime, prezime, username, lozinka, duplikat, datum, mesto, telefon, email);
    }
    
 
  }

  private checkDataAndSave(ime: any, prezime: any, username: any, lozinka: any, duplikat: any, datum: any, mesto: any, telefon: any, email: any) {
    if (!ime && !prezime && !username && !lozinka && !duplikat && !datum && !mesto && !telefon && !email) {
      if (this.poljoprivrednik.password != this.passwordReplica) {
        this.razliciteLozinke = true;
     //   this.clicked=false;
      }
      else {
        this.usersService.findUserByUsername(this.poljoprivrednik.username).subscribe(
          data=>{
            if(data.length==0){ //ne postoji kosrisnik sa istim usernameom
              console.log(data.length)
               //slanje zahteva
              this.poljoprivrednik.prihvacen = false;
              this.poljoprivrednik.nijePrihvacen = false;
              this.service.posaljiPoljZahtev(this.poljoprivrednik).subscribe();
              this.dialogRef.close(this.poljoprivrednik);
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
