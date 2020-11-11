import { BrowserModule } from '@angular/platform-browser';
import { NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { MatDialogModule } from '@angular/material/dialog'
import { FormsModule, ReactiveFormsModule  }   from '@angular/forms';
import { jqxGaugeModule } from 'jqwidgets-ng/jqxgauge';
import { jqxLinearGaugeModule } from 'jqwidgets-ng/jqxlineargauge';
import { jqxCheckBoxModule } from 'jqwidgets-ng/jqxcheckbox';
import { jqxButtonModule } from 'jqwidgets-ng/jqxbuttons';
import { jqxExpanderModule } from 'jqwidgets-ng/jqxexpander';
import { jqxRadioButtonModule } from 'jqwidgets-ng/jqxradiobutton';
import { CommonModule }   from '@angular/common';
import {MatSidenavModule} from '@angular/material/sidenav';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { jqxBarGaugeModule }   from 'jqwidgets-ng/jqxbargauge';
import {HttpClientModule} from '@angular/common/http';
import { NgCircleProgressModule } from 'ng-circle-progress';
import {MatTableModule} from '@angular/material/table';
import {MatInputModule} from '@angular/material/input';
import {MatSortModule} from '@angular/material/sort';
import { RouterModule } from '@angular/router';
import {MatSelectModule} from '@angular/material/select';
import { ChartsModule } from 'ng2-charts';
import { RecaptchaModule } from 'ng-recaptcha';
// import { AgmCoreModule, GoogleMapsAPIWrapper } from '@agm/core';
// import { AgmDirectionModule } from 'agm-direction'; 



import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { EntryComponent } from './entry/entry.component';
import { HeaderComponent } from './header/header.component';
import { FooterComponent } from './footer/footer.component';
import { RegistrationComponent } from './registration/registration.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { LoginComponent } from './login/login.component';
import { RegistrationFactoryComponent } from './registration-factory/registration-factory.component';
import { PoljoprivrednikComponent } from './poljoprivrednik/poljoprivrednik.component';
import { RasadnikComponent } from './rasadnik/rasadnik.component';
import { MagacinComponent } from './magacin/magacin.component';
import { CreateRasadnikComponent } from './create-rasadnik/create-rasadnik.component';
import { ShopComponent } from './shop/shop.component';
import { AdminComponent } from './admin/admin.component';
import { AdminUsersComponent } from './admin-users/admin-users.component';
import { IzmenaKorisnikaComponent } from './dialog/izmena-korisnika/izmena-korisnika.component';
import { DodavanjeKorisnikaComponent } from './dialog/dodavanje-korisnika/dodavanje-korisnika.component';
import { DodavanjeAdminaComponent } from './dialog/dodavanje-admina/dodavanje-admina.component';
import { DodavanjePreduzecaComponent } from './dialog/dodavanje-preduzeca/dodavanje-preduzeca.component';
import { IzmenaPreduzecaComponent } from './dialog/izmena-preduzeca/izmena-preduzeca.component';
import { IzmenaAdminaComponent } from './dialog/izmena-admina/izmena-admina.component';
import { ProizvodDetaljiComponent } from './proizvod-detalji/proizvod-detalji.component';
import { RejtingComponent } from './dialog/rejting/rejting.component';
import { PreduzeceComponent } from './preduzece/preduzece.component';
import { KuririComponent } from './kuriri/kuriri.component';
import { PreduzeceProizvodiComponent } from './preduzece-proizvodi/preduzece-proizvodi.component';
import { DodavanjeProizvodaComponent } from './dialog/dodavanje-proizvoda/dodavanje-proizvoda.component';
import {MatStepperModule} from '@angular/material/stepper';
import { ShoppingCartComponent } from './shopping-cart/shopping-cart.component';
import { MagPorudzbineComponent } from './mag-porudzbine/mag-porudzbine.component';
import { RezultatiComponent } from './rezultati/rezultati.component';
import { IzmenaLozinkeComponent } from './izmena-lozinke/izmena-lozinke.component';
import { MapaComponent } from './mapa/mapa.component';
import { KurirDetaljiComponent } from './kurir-detalji/kurir-detalji.component';
import { ErrorComponent } from './error/error.component';

@NgModule({
  declarations: [
    AppComponent,
    EntryComponent,
    HeaderComponent,
    FooterComponent,
    RegistrationComponent,
    LoginComponent,
    RegistrationFactoryComponent,
    PoljoprivrednikComponent,
    RasadnikComponent,
    MagacinComponent,
    CreateRasadnikComponent,
    ShopComponent,
    AdminComponent,
    AdminUsersComponent,
    IzmenaKorisnikaComponent,
    DodavanjeKorisnikaComponent,
    DodavanjeAdminaComponent,
    DodavanjePreduzecaComponent,
    IzmenaPreduzecaComponent,
    IzmenaAdminaComponent,
    ProizvodDetaljiComponent,
    RejtingComponent,
    PreduzeceComponent,
    KuririComponent,
    PreduzeceProizvodiComponent,
    DodavanjeProizvodaComponent,
    ShoppingCartComponent,
    MagPorudzbineComponent,
    RezultatiComponent,
    IzmenaLozinkeComponent,
    MapaComponent,
    KurirDetaljiComponent,
    ErrorComponent,
  ],
  imports: [
    
    BrowserModule,
    AppRoutingModule,
  //   AgmCoreModule.forRoot({
  //     apiKey: "AIzaSyCz1e-vmhLybFO8tkoBPxR9sh0AoTnXsHY",
  //     libraries: ["places", "geometry"]
  //     /* apiKey is required, unless you are a premium customer, in which case you can use clientId */
  // }),
  //   AgmDirectionModule,
    BrowserAnimationsModule,
    MatDialogModule,
    FormsModule,
    ReactiveFormsModule ,
    CommonModule, 
    jqxGaugeModule, 
    jqxLinearGaugeModule, 
    jqxCheckBoxModule, 
    jqxButtonModule, 
    jqxExpanderModule, 
    jqxRadioButtonModule,
    MatSidenavModule, 
    jqxBarGaugeModule,
    NgbModule,
    HttpClientModule,
    RecaptchaModule,
    NgCircleProgressModule.forRoot({
      // set defaults here
      radius: 100,
      outerStrokeWidth: 16,
      innerStrokeWidth: 8,
      outerStrokeColor: "#78C000",
      innerStrokeColor: "#C7E596",
      animationDuration: 300,
     
    }),
   
    MatTableModule,
    MatInputModule,
    MatSortModule,
    RouterModule,
    MatStepperModule,
    MatSelectModule,
    ChartsModule,
    
  ],
 // providers: [GoogleMapsAPIWrapper],
 providers: [],
  bootstrap: [AppComponent],
  entryComponents: [RegistrationComponent],
  schemas: [ CUSTOM_ELEMENTS_SCHEMA ]
})
export class AppModule { }
