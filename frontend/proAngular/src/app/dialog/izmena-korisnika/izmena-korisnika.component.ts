import { Component, OnInit, Inject } from '@angular/core';
import { User } from 'src/app/models/user';
import { Poljoprivrednik } from 'src/app/models/poljoprivrednik';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { UsersService } from 'src/app/servisi/users.service';

@Component({
  selector: 'app-izmena-korisnika',
  templateUrl: './izmena-korisnika.component.html',
  styleUrls: ['./izmena-korisnika.component.css']
})
export class IzmenaKorisnikaComponent implements OnInit {

  user: User = new User();
  poljoprivrednik: Poljoprivrednik = new Poljoprivrednik();
  newUserId: number;
  newPoljoprivrednnikId: number;
  passwordReplica: string = "";
  razliciteLozinke: boolean = false;
  regex =  new RegExp("(?=.*[a-z])(?=.*[A-Z])^[a-zA-Z](?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{6,})");
  clicked: boolean = false;

  constructor(@Inject(MAT_DIALOG_DATA) public data: any, //this is for data which is passed between dialog and host
  public dialogRef: MatDialogRef<IzmenaKorisnikaComponent>,
  private service: UsersService) { }

  ngOnInit(): void {
    this.razliciteLozinke = false;
    this.clicked=false;
    //ne znam hoce li hteti da radi
    this.user = this.data.user;
    this.poljoprivrednik = this.data.poljoprivrednik;
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
        this.user.role = "ROLE_POLJOPRIVREDNIK";
        //kovde ubaciti kod za izmenu
        this.service.updateUser(this.user.id, this.user).subscribe(
          data =>{
            this.service.updatePoljoprivrednik(this.poljoprivrednik.id, this.poljoprivrednik).subscribe();
          }
        )

        this.dialogRef.close(this.poljoprivrednik);
       
      }
    }
  }

}
