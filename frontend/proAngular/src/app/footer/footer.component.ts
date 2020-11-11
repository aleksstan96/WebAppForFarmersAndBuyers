import { Component, OnInit } from '@angular/core';
import { AutentikacijaService } from '../servisi/autentikacija.service';
import { MatDialogConfig, MatDialog } from '@angular/material/dialog';
import { IzmenaLozinkeComponent } from '../izmena-lozinke/izmena-lozinke.component';

@Component({
  selector: 'app-footer',
  templateUrl: './footer.component.html',
  styleUrls: ['./footer.component.css']
})
export class FooterComponent implements OnInit {
  isLoggedIn: boolean = false;
  
  dialogOpened: boolean = false;

  constructor(private servis: AutentikacijaService,
    private dialog: MatDialog) { }

  ngOnInit(): void {
    this.isLoggedIn = this.servis.isUserLoggedIn()
    this.servis.isloggedinV.subscribe(
      data=>{
        if(data==true){
          this.isLoggedIn=true;
        }else{
          this.isLoggedIn=false;
        }
      }
    )
  }

  openDialog() {
    if(this.dialogOpened){
      alert("Dijalog je vec otvoren!");
    }else{
      this.dialogOpened = true;
      const dialogConfig = new MatDialogConfig();
      let matDialog = this.dialog.open(IzmenaLozinkeComponent, dialogConfig);
      
      matDialog.afterClosed().subscribe(result=>{
      //  console.log(result);
        this.dialogOpened = false;
      });
    }
   
}


}
