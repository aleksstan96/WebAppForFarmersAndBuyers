import { Component, OnInit, Inject } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { UsersService } from 'src/app/servisi/users.service';
import { User } from 'src/app/models/user';
import { Poljoprivrednik } from 'src/app/models/poljoprivrednik';

@Component({
  selector: 'app-dodavanje-korisnika',
  templateUrl: './dodavanje-korisnika.component.html',
  styleUrls: ['./dodavanje-korisnika.component.css']
})
export class DodavanjeKorisnikaComponent implements OnInit {

  user: User = new User();
  poljoprivrednik: Poljoprivrednik = new Poljoprivrednik();
  newUserId: number;
  newPoljoprivrednnikId: number;
  passwordReplica: string = "";
  razliciteLozinke: boolean = false;
  regex =  new RegExp("(?=.*[a-z])(?=.*[A-Z])^[a-zA-Z](?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{6,})");
  clicked: boolean = false;
  usernamePostoji: boolean =false;

  constructor(@Inject(MAT_DIALOG_DATA) public data: any, //this is for data which is passed between dialog and host
  public dialogRef: MatDialogRef<DodavanjeKorisnikaComponent>,
  private service: UsersService) { }

  ngOnInit(): void {
    this.razliciteLozinke = false;
    this.clicked=false;
    this.usernamePostoji=false;
  }

  save(ime,prezime,username,lozinka,duplikat,datum,mesto,telefon,email){
    this.clicked=true;
    
    this.checkDataAndSave(ime, prezime, username, lozinka, duplikat, datum, mesto, telefon, email);
 
  }

  private checkDataAndSave(ime: any, prezime: any, username: any, lozinka: any, duplikat: any, datum: any, mesto: any, telefon: any, email: any) {
    if (!ime && !prezime && !username && !lozinka && !duplikat && !datum && !mesto && !telefon && !email) {
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
              this.user.role = "ROLE_POLJOPRIVREDNIK";
              this.service.addUser(this.user).subscribe(
                data=> {
                  this.newUserId = data.id;
                  console.log(this.newUserId);
                  this.service.addPoljoprivrednik(this.poljoprivrednik).subscribe(
                    data=>{
                      this.newPoljoprivrednnikId = data.id;
                      console.log(this.newPoljoprivrednnikId);
                      this.service.dodeliIdUserPoljoprivredniku(this.newPoljoprivrednnikId,this.newUserId).subscribe();
                    }
                  )
                }
                )

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

}
