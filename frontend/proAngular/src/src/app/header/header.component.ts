import { Component, OnInit } from '@angular/core';
import { MatDialog, MatDialogConfig } from '@angular/material/dialog';
import { LoginComponent } from '../login/login.component';
import { Router, ActivatedRoute, UrlTree } from '@angular/router';
import { AutentikacijaService } from '../servisi/autentikacija.service';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.css']
})
export class HeaderComponent implements OnInit {

  dialogOpened: boolean = false;
  admin: boolean = false;
  poljoprivrednik: boolean = false;
  preduzece: boolean = false;
  isLoggedIn: boolean = false;
  user: string="";

  constructor(private dialog: MatDialog,
            private router: Router,
            private route: ActivatedRoute,
            private service: AutentikacijaService) { }

  ngOnInit(): void {
    this.user=sessionStorage.getItem('authenticatedUser');
      this.isLoggedIn = this.service.isUserLoggedIn();
      this.poljoprivrednik = this.service.isPoljLoggedIn();
      this.preduzece = this.service.isPreduzeceLoggedIn();
      this.updateLoginLogoutWidget();
  }

  ///ako neko klikne dugme za online prodavnicu
  openShop(){
    this.router.navigate(['/shop']);
  }

    openDialog() {
      if(this.dialogOpened){
        alert("Dijalog je vec otvoren!");
      }else{
        this.dialogOpened = true;
        const dialogConfig = new MatDialogConfig();
        let matDialog = this.dialog.open(LoginComponent, dialogConfig);
        
        matDialog.afterClosed().subscribe(result=>{
        //  console.log(result);
          this.dialogOpened = false;
        });
      }
     
  }

  updateLoginLogoutWidget(){
    this.service.isloggedinV.subscribe(
      data => {
        this.isLoggedIn = data;
        this.poljoprivrednik =  this.service.isPoljLoggedIn();
        this.preduzece = this.service.isPreduzeceLoggedIn();
        //console.log(this.poljoprivrednik)
      }
    )

    
 
  }


  logout(){
    this.service.logout();
    this.router.navigate(['/']);
   
  }

}
