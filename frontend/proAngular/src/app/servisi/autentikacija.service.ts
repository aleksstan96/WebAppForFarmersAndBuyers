import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { User } from '../models/user';
import { UsersService } from './users.service';
import { Router, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { Subject } from 'rxjs';
import { AppComponent } from '../app.component';

@Injectable({
  providedIn: 'root'
})
export class AutentikacijaService {

  user: User = new User();
  correctUsername = false;
  correctPassword = false;

  ///login i logout widget
  isloggedinV: Subject<boolean> = new Subject<boolean>();
  upozoreniV: Subject<boolean> = new Subject<boolean>();

  upozoreni: string[] = []


  constructor( private usersService: UsersService, private router: Router) { }

  canActivate(route: ActivatedRouteSnapshot, state: RouterStateSnapshot){
    if(this.isUserLoggedIn()){
      return true;
    }else{
      this.router.navigate(['/']); //da ne idemo na blank page vec da nas vrati na login stranicu
      return false;
    }
    
  }

  isUserLoggedIn(){
    let user =  sessionStorage.getItem('authenticatedUser');
    return !(user===null);
  }

  logout(){
 //   console.log("Logging out")
    sessionStorage.removeItem('authenticatedUser');
    sessionStorage.removeItem('authenticatedUserId');
    sessionStorage.removeItem('authenticatedUserRole');
    sessionStorage.removeItem('proizvodiUKorpi');
    sessionStorage.removeItem('proizvodjaci');
    sessionStorage.removeItem('upozoreni');
    this.isloggedinV.next(false);
    
  }

  login(){
  //  console.log("Logging in")
    this.isloggedinV.next(true);
  }

  isAdminLoggedIn(){
    let user =  sessionStorage.getItem('authenticatedUserRole');
    return (user=='ROLE_ADMIN');
  }

  isPoljLoggedIn(){
    let user =  sessionStorage.getItem('authenticatedUserRole');
    return (user=='ROLE_POLJOPRIVREDNIK');
  }

  isPreduzeceLoggedIn(){
    let user =  sessionStorage.getItem('authenticatedUserRole');
    return (user=='ROLE_PREDUZECE');
  }

  jeUpozoren():string[]{
    if(sessionStorage.getItem('upozoreni')!=null){
      this.upozoreni=JSON.parse(sessionStorage.getItem('upozoreni'));
      return this.upozoreni
    }
    return null;
  }



}
