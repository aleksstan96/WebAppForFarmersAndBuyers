import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { EntryComponent } from './entry/entry.component';
import { RegistrationComponent } from './registration/registration.component';
import { LoginComponent } from './login/login.component';
import { PoljoprivrednikComponent } from './poljoprivrednik/poljoprivrednik.component';
import { RasadnikComponent } from './rasadnik/rasadnik.component';
import { MagacinComponent } from './magacin/magacin.component';
import { ShopComponent } from './shop/shop.component';
import { AdminComponent } from './admin/admin.component';
import { AdminUsersComponent } from './admin-users/admin-users.component';
import { ProizvodDetaljiComponent } from './proizvod-detalji/proizvod-detalji.component';
import { PreduzeceComponent } from './preduzece/preduzece.component';
import { PreduzeceProizvodiComponent } from './preduzece-proizvodi/preduzece-proizvodi.component';
import { AutentikacijaService } from './servisi/autentikacija.service';
import { AutorizacijaService } from './servisi/autorizacija.service';
import { AutorizacijPoljService } from './servisi/autorizacij-polj.service';
import { AutorizacijaPreduzeceService } from './servisi/autorizacija-preduzece.service';
import { ShoppingCartComponent } from './shopping-cart/shopping-cart.component';
import { MagPorudzbineComponent } from './mag-porudzbine/mag-porudzbine.component';
import { RezultatiComponent } from './rezultati/rezultati.component';
import { MapaComponent } from './mapa/mapa.component';
import { KuririComponent } from './kuriri/kuriri.component';
import { ErrorComponent } from './error/error.component';



const routes: Routes = [
  {path: "", component: EntryComponent},
  // // {path: "registration", component: RegistrationComponent},
  // {path: "login", component: LoginComponent},
  {path: "poljoprivrednik", component: PoljoprivrednikComponent, canActivate:[AutentikacijaService, AutorizacijPoljService]}, //vrv ce biti poljoprivrednik/:id
  {path: "rasadnik/:id", component: RasadnikComponent, canActivate:[AutentikacijaService, AutorizacijPoljService]},
  {path: "magacin/:id", component: MagacinComponent, canActivate:[AutentikacijaService, AutorizacijPoljService]},
  {path: "magPor/:id", component: MagPorudzbineComponent, canActivate:[AutentikacijaService, AutorizacijPoljService]},
  {path: "shoppingcart", component: ShoppingCartComponent, canActivate:[AutentikacijaService, AutorizacijPoljService]},
  {path: "shop", component: ShopComponent, canActivate:[AutentikacijaService]},
  {path: "admin", component: AdminComponent, canActivate:[AutentikacijaService, AutorizacijaService]},
  {path: "admin/korisnici", component: AdminUsersComponent, canActivate:[AutentikacijaService,AutorizacijaService ]},
  {path: "shop/proizvod", component: ProizvodDetaljiComponent, canActivate:[AutentikacijaService]},
  {path: "preduzece", component: PreduzeceComponent, canActivate:[AutentikacijaService, AutorizacijaPreduzeceService]}, //vrv ce biti preduzece/:id
  {path: "rezultati", component: RezultatiComponent, canActivate:[AutentikacijaService, AutorizacijaPreduzeceService]},
  {path: "preduzece/:id/proizvodi/proizvod", component: ProizvodDetaljiComponent, canActivate:[AutentikacijaService, AutorizacijaPreduzeceService]}, 
  {path: "preduzece/:id/proizvodi", component: PreduzeceProizvodiComponent, canActivate:[AutentikacijaService, AutorizacijaPreduzeceService]},   
  {path: "preduzece/:id/kuriri/:porId", component: KuririComponent, canActivate:[AutentikacijaService, AutorizacijaPreduzeceService]},   
  {path: "preduzece/mapa", component: MapaComponent, canActivate:[AutentikacijaService, AutorizacijaPreduzeceService]},
   {path:'**', component:ErrorComponent}   
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
