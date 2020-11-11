import { Component, OnInit, Inject } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { User } from '../models/user';
import { UsersService } from '../servisi/users.service';

@Component({
  selector: 'app-izmena-lozinke',
  templateUrl: './izmena-lozinke.component.html',
  styleUrls: ['./izmena-lozinke.component.css']
})
export class IzmenaLozinkeComponent implements OnInit {

  oldPass:string="";
  newPass:string="";
  newPass1:string="";
  message:string="";
  currentUser: User = new User();
  regex =  new RegExp("(?=.*[a-z])(?=.*[A-Z])^[a-zA-Z](?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{6,})");
  clicked=false;

  constructor(@Inject(MAT_DIALOG_DATA) public data: any, //this is for data which is passed between dialog and host
  public dialogRef: MatDialogRef<IzmenaLozinkeComponent>,
  private userServis: UsersService) { }

  ngOnInit(): void {
    this.userServis.findUserById(sessionStorage.getItem('authenticatedUserId')).subscribe(
      data=>{
        this.currentUser=data;
      }
    )

  }

  izmeni(){
    this.clicked=true;
    if(this.oldPass=="" || this.newPass=="" || this.newPass1== ""){
      this.message="Unesite sve podatke"
    }else{
      if(this.oldPass!=this.currentUser.password){
        this.message="Stara lozinka nije korektna"
      }else{
        if(this.newPass!=this.newPass1){
          this.message="Ponovljena lozinka mora biti ista kao nova lozinka"
        }else{
          if(this.newPass==this.oldPass){
            this.message="Nova lozinka se mora razlikovati od stare"
          }else{ //sve ok
            //console.log(this.oldPass,this.newPass)
            this.currentUser.password=this.newPass;
            this.userServis.updateUser(this.currentUser.id, this.currentUser).subscribe(
              data=>{
                this.dialogRef.close();
              }
            )
          }
        }
      }
    }

  }

}
