import { Component, OnInit, Inject } from '@angular/core';
import { User } from 'src/app/models/user';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { UsersService } from 'src/app/servisi/users.service';

@Component({
  selector: 'app-dodavanje-admina',
  templateUrl: './dodavanje-admina.component.html',
  styleUrls: ['./dodavanje-admina.component.css']
})
export class DodavanjeAdminaComponent implements OnInit {

  user: User = new User();
 
  passwordReplica: string = "";
  razliciteLozinke: boolean = false;
  regex =  new RegExp("(?=.*[a-z])(?=.*[A-Z])^[a-zA-Z](?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{6,})");
  clicked: boolean = false;
  usernamePostoji: boolean =false;

  constructor(@Inject(MAT_DIALOG_DATA) public data: any, //this is for data which is passed between dialog and host
  public dialogRef: MatDialogRef<DodavanjeAdminaComponent>,
  private service: UsersService) { }

  ngOnInit(): void {
    this.razliciteLozinke = false;
    this.clicked=false;
    this.usernamePostoji=false;
  }

  save(username,lozinka){
    this.clicked=true;
    
    this.checkDataAndSave(username, lozinka);
 
  }

  private checkDataAndSave(username: any, lozinka: any) {
    if (!username && !lozinka) {
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
              this.user.role = "ROLE_ADMIN";
              this.service.addUser(this.user).subscribe();
              this.dialogRef.close(this.user);
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
