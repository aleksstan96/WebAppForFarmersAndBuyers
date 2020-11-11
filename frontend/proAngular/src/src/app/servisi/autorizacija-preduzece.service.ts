import { Injectable } from '@angular/core';
import { Router, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';

@Injectable({
  providedIn: 'root'
})
export class AutorizacijaPreduzeceService {

  constructor(private router: Router) { }

  canActivate(route: ActivatedRouteSnapshot, state: RouterStateSnapshot){
    let role = sessionStorage.getItem('authenticatedUserRole');
    if(role=='ROLE_PREDUZECE'){
      return true;
    }else{
      this.router.navigate(['/']); //da ne idemo na blank page vec da nas vrati na login stranicu
      return false;
    }
    
  }
}
