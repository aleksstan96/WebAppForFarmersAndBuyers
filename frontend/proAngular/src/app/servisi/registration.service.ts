import { Injectable } from '@angular/core';
import { PoljZahtev, PredZahtev } from '../models/zahtev';
import { BASE_URL } from '../global';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { map } from 'rxjs/operators';
import { User } from '../models/user';

@Injectable({
  providedIn: 'root'
})
export class RegistrationService {

  constructor(private httpClient: HttpClient) { }


  posaljiPoljZahtev(zahtev):Observable<PoljZahtev>{
    const url = `${BASE_URL}/poljzahtevi`
    return this.httpClient.post<PoljZahtev>(url, zahtev);

  }

  posaljiPredZahtev(zahtev):Observable<PredZahtev>{
    const url = `${BASE_URL}/predzahtevi`
    return this.httpClient.post<PredZahtev>(url, zahtev);

  }

  dohvatiPoljZahteve():Observable<PoljZahtev[]>{
    const url = `${BASE_URL}/poljzahtevi?sort=prihvacen,nijePrihvacen`
    return this.httpClient.get<GetResponsePoljZahtevi>(url).pipe(
      map(response => response._embedded.poljzahtevi)
    );
  }

  dohvatiPredZahteve():Observable<PredZahtev[]>{
    const url = `${BASE_URL}/predzahtevi?sort=prihvacen,nijePrihvacen` 
    return this.httpClient.get<GetResponsePredZahtevi>(url).pipe(
      map(response => response._embedded.predzahtevi)
    );
  }

  findBySkracenica(username){
    const url = `${BASE_URL}/predzahtevi/search/findBySkracenica?username=${username}`
    return this.httpClient.get<GetResponsePredZahtevi>(url).pipe(
      map(response => response._embedded.predzahtevi)
    );

  }

  findByUsername(username){
    const url = `${BASE_URL}/poljzahtevi/search/findByUsername?username=${username}`
    return this.httpClient.get<GetResponsePoljZahtevi>(url).pipe(
      map(response => response._embedded.poljzahtevi)
    );

  }


  prihvatiPoljZahtev(id){
    const url = `${BASE_URL}/poljzahtevi/prihvati/${id}`;
    return this.httpClient.get(url);

  }

  odbijPoljZahtev(id){
    const url = `${BASE_URL}/poljzahtevi/odbij/${id}`;
    return this.httpClient.get(url);

  }

  prihvatiPredZahtev(id){
    const url = `${BASE_URL}/predzahtevi/prihvati/${id}`;
    return this.httpClient.get(url);


  }

  odbjPredZajtev(id){
    const url = `${BASE_URL}/predzahtevi/odbij/${id}`;
    return this.httpClient.get(url);


  }

}

interface GetResponsePoljZahtevi{
  _embedded: {
    poljzahtevi: PoljZahtev[];
  }
}

interface GetResponsePredZahtevi{
  _embedded: {
    predzahtevi: PredZahtev[];
  }
}

