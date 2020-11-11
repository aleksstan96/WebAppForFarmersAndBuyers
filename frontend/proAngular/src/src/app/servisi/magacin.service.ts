import { Injectable } from '@angular/core';
import { MagacinProizvod } from '../models/magacinproizvod';
import { BASE_URL } from '../global';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';
import { Porudzbina } from '../models/porudzbina';

@Injectable({
  providedIn: 'root'
})
export class MagacinService {

  constructor(private httpClient: HttpClient) { }


  dohvatiSadnice(magacinId):  Observable<MagacinProizvod[]>{
    const url = `${BASE_URL}/magacinproizvodi/search/findByMagacinIdAndKategorija?id=${magacinId}&kategorija=sadnica`;
    return this.httpClient.get<GetResponseProizvodi>(url).pipe(
      map(response => response._embedded.magacinproizvodi)
    )
    
  }

  dohvatiPreparate(magacinId):  Observable<MagacinProizvod[]>{
    const url = `${BASE_URL}/magacinproizvodi/search/findByMagacinIdAndKategorija?id=${magacinId}&kategorija=preparat`;
    return this.httpClient.get<GetResponseProizvodi>(url).pipe(
      map(response => response._embedded.magacinproizvodi)
    )

  }

  dohvatiProizvode(magacinId): Observable<MagacinProizvod[]>{
    const url = `${BASE_URL}/magacinproizvodi/search/findByMagacinId?id=${magacinId}`;
    return this.httpClient.get<GetResponseProizvodi>(url).pipe(
      map(response => response._embedded.magacinproizvodi)
    )

  }

  dohvatiProizvod(magacinId, proizvoId): Observable<MagacinProizvod>{
    const url = `${BASE_URL}/magacinproizvodi/search/findByMagacinIdAndProizvodId?mid=${magacinId}&pid=${proizvoId}`;
    return this.httpClient.get<GetResponseProizvodi>(url).pipe(
      map(response => response._embedded.magacinproizvodi[0])
    )
  }

  obrisiProizvod(magacinId, proizvodId): Observable<{}>{
    const url = `${BASE_URL}/magacinproizvodi/delete/${magacinId}/${proizvodId}`
    return this.httpClient.get(url);
  }


  updateProizvodKolicina(magacinId, proizvodId,kolicina): Observable<{}>{
    const url = `${BASE_URL}/magacinproizvodi/update/kolicina/${magacinId}/${proizvodId}/${kolicina}`
     return this.httpClient.get(url);
  }

  dohvatiPorudzbineRasadnika(pid,rid): Observable<Porudzbina[]>{
    const url = `${BASE_URL}/porudzbine/search/findByPoljoprivrednikIdAndRasadnikId?pid=${pid}&rid=${rid}&sort=datumKreiranja`
    return this.httpClient.get<GetResponsePorudzbina>(url).pipe(
      map(response=>response._embedded.porudzbine)
    )
  }


}

interface GetResponseProizvodi{
  _embedded:{
    magacinproizvodi: MagacinProizvod[]
  }
}

interface GetResponsePorudzbina{
  _embedded:{
    porudzbine: Porudzbina[]
  }
}
