import { Component, OnInit } from '@angular/core';

import {MatDialog, MatDialogConfig } from '@angular/material/dialog';
import { RegistrationComponent } from '../registration/registration.component';
import { RegistrationFactoryComponent } from '../registration-factory/registration-factory.component';
import { RegistrationService } from '../servisi/registration.service';
import { AutentikacijaService } from '../servisi/autentikacija.service';
import { Router } from '@angular/router';


@Component({
  selector: 'app-entry',
  templateUrl: './entry.component.html',
  styleUrls: ['./entry.component.css']
})
export class EntryComponent implements OnInit {


  isUserLoggedIn: boolean = false;
  isAdminLoggedIn: boolean = false;
  isPoljoprivrednikLoggedIn: boolean = false;
  isPreduzeceLoggedIn: boolean = false;

  constructor(private dialog: MatDialog,
    private service: RegistrationService,
    private authService: AutentikacijaService,
    private router: Router) { }

  ngOnInit(): void {
    this.isUserLoggedIn = this.authService.isUserLoggedIn();
    this.authService.isloggedinV.subscribe(
      data=>this.isUserLoggedIn = data
    )
    this.isAdminLoggedIn = this.authService.isAdminLoggedIn();
    this.isPreduzeceLoggedIn = this.authService.isPreduzeceLoggedIn();
    this.isPoljoprivrednikLoggedIn = this.authService.isPoljLoggedIn();
  }

  admin(){
    this.router.navigate(['/admin'])
  }

  poljoprivrednik(){
    this.router.navigate(['/poljoprivrednik'])

  }


  preduzece(){
    this.router.navigate(['/preduzece'])

  }

  openDialog() {
    const dialogConfig = new MatDialogConfig();
    let matDialog = this.dialog.open(RegistrationComponent, dialogConfig);
    
    matDialog.afterClosed().subscribe(result=>{
      console.log(result)
    });
  }

  openDialog1() {
    const dialogConfig = new MatDialogConfig();
    let matDialog = this.dialog.open(RegistrationFactoryComponent, dialogConfig);
    
    matDialog.afterClosed().subscribe(result=>{

    });
  }

}
