import { Component, OnInit, Inject } from '@angular/core';
import { User } from 'src/app/models/user';
import { Preduzece } from 'src/app/models/preduzece';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { UsersService } from 'src/app/servisi/users.service';

@Component({
  selector: 'app-izmena-preduzeca',
  templateUrl: './izmena-preduzeca.component.html',
  styleUrls: ['./izmena-preduzeca.component.css']
})
export class IzmenaPreduzecaComponent implements OnInit {

  user: User = new User();
  preduzece: Preduzece = new Preduzece();
  newUserId: number;
  newPreduzeceId: number;
  passwordReplica: string = "";
  razliciteLozinke: boolean = false;
  regex =  new RegExp("(?=.*[a-z])(?=.*[A-Z])^[a-zA-Z](?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{6,})");
  clicked: boolean = false;
  constructor(@Inject(MAT_DIALOG_DATA) public data: any, //this is for data which is passed between dialog and host
  public dialogRef: MatDialogRef<IzmenaPreduzecaComponent>,
  private service: UsersService) { }

  ngOnInit(): void {
    this.razliciteLozinke = false;
    this.clicked=false;
    this.user = this.data.user;
    this.preduzece = this.data.preduzece;
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
         this.user.role = "ROLE_PREDUZECE";
         this.service.updateUser(this.user.id, this.user).subscribe(
          data =>{
            this.service.updatePreduzece(this.preduzece.id, this.preduzece).subscribe();
          }
        )
              this.dialogRef.close(this.preduzece);
          }
        
       
      }
    
  }


}
