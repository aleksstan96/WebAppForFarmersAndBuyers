import { Component, OnInit, Inject } from '@angular/core';
import { User } from 'src/app/models/user';
import { Preduzece } from 'src/app/models/preduzece';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { UsersService } from 'src/app/servisi/users.service';

@Component({
  selector: 'app-dodavanje-preduzeca',
  templateUrl: './dodavanje-preduzeca.component.html',
  styleUrls: ['./dodavanje-preduzeca.component.css']
})
export class DodavanjePreduzecaComponent implements OnInit {

  user: User = new User();
  preduzece: Preduzece = new Preduzece();
  newUserId: number;
  newPreduzeceId: number;
  passwordReplica: string = "";
  razliciteLozinke: boolean = false;
  regex =  new RegExp("(?=.*[a-z])(?=.*[A-Z])^[a-zA-Z](?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{6,})");
  clicked: boolean = false;
  usernamePostoji: boolean =false;

  constructor(@Inject(MAT_DIALOG_DATA) public data: any, //this is for data which is passed between dialog and host
  public dialogRef: MatDialogRef<DodavanjePreduzecaComponent>,
  private service: UsersService) { }

  ngOnInit(): void {
    this.razliciteLozinke = false;
    this.clicked=false;
    this.usernamePostoji=false;
  }

  save(naziv,username,lozinka,duplikat,datum,mesto,email){
    this.clicked=true;
    
    this.checkDataAndSave( naziv, username, lozinka, duplikat, datum, mesto,email);
 
  }

  private checkDataAndSave(naziv: any, username: any, lozinka: any, duplikat: any, datum: any, mesto: any, email: any) {
    if (!naziv && !username && !lozinka && !duplikat && !datum && !mesto &&!email) {
      if (this.user.password != this.passwordReplica) {
        this.razliciteLozinke = true;
     //   this.clicked=false;
      }
      else {
        this.service.findUserByUsername(this.user.username).subscribe(
          data=>{
            if(data.length==0){ //ne postoji kosrisnik sa istim usernameom
              console.log(data.length)
               //slanje zahteva
              this.user.role = "ROLE_PREDUZECE";
              this.service.addUser(this.user).subscribe(
                data=> {
                  this.newUserId = data.id;
                  console.log(this.newUserId);
                  this.service.addPreduzece(this.preduzece).subscribe(
                    data=>{
                      this.newPreduzeceId = data.id;
                      console.log(this.newPreduzeceId);
                      this.service.dodeliIdUserPreduzecu(this.newPreduzeceId,this.newUserId).subscribe();
                    }
                  )
                }
                )

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

}
