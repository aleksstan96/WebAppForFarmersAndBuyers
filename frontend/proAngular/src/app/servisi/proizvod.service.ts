import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Proizvod } from '../models/proizvod';
import { Observable } from 'rxjs';
import { BASE_URL } from '../global';
import { map } from 'rxjs/operators';
import { Preduzece } from '../models/preduzece';
import { JeOcenio } from '../models/jeocenio';

@Injectable({
  providedIn: 'root'
})
export class ProizvodService {

  constructor(private httpClient: HttpClient) { }

  dohvatiSadnice():  Observable<Proizvod[]>{
    const url = `${BASE_URL}/proizvodi/search/findByKategorija?kategorija=sadnica`;
    return this.httpClient.get<GetResponseProizvodi>(url).pipe(
      map(response => response._embedded.proizvodi)
    )
    
  }


  dohvatiPreparate():  Observable<Proizvod[]>{
    const url = `${BASE_URL}/proizvodi/search/findByKategorija?kategorija=preparat`;
    return this.httpClient.get<GetResponseProizvodi>(url).pipe(
      map(response => response._embedded.proizvodi)
    )

  }

  dohvatiSveProizvode(): Observable<Proizvod[]>{
    const url = `${BASE_URL}/proizvodi`;
    return this.httpClient.get<GetResponseProizvodi>(url).pipe(
      map(response => response._embedded.proizvodi)
    )

  }

  dohvatiProizvod(id):Observable<Proizvod>{
    const url = `${BASE_URL}/proizvodi/${id}`;
    return this.httpClient.get<Proizvod>(url);
  }

  dohvatiPreduzeceProizvoda(id): Observable<Preduzece>{
    const url = `${BASE_URL}/proizvodi/${id}/preduzece`;
    return this.httpClient.get<Preduzece>(url);

  }

  pretraziProizvode(theKeyword:string): Observable<Proizvod[]>{

    const url = `${BASE_URL}/proizvodi/search/findByNazivContaining?name=${theKeyword}`;

    return this.httpClient.get<GetResponseProizvodi>(url).pipe(
      map(response => response._embedded.proizvodi));
  }

  dohvatiOcene(idProizvoda): Observable<JeOcenio[]>{
    const url = `${BASE_URL}/jeocenio/search/findByProizvodId?id=${idProizvoda}`;
    return this.httpClient.get<GetResponseOcene>(url).pipe(
      map(response=> response._embedded.jeocenio)
    )

  }

  oceni(proId, userId, komentar, ocena){
    const url = `${BASE_URL}/jeocenio/create/${proId}/${userId}/${komentar}/${ocena}`;
    return this.httpClient.get(url);
  }

  jeOcenio(idProizvoda, idUser): Observable<JeOcenio[]>{
    
    const url = `${BASE_URL}/jeocenio/search/findByUserIdAndProizvodId?uid=${idUser}&pid=${idProizvoda}`;
    return this.httpClient.get<GetResponseOcene>(url).pipe(
      map(response=> response._embedded.jeocenio)
    )
  }

  dodajProizvod(proizvod: Proizvod): Observable<Proizvod>{
    const url = `${BASE_URL}/proizvodi`;
    return this.httpClient.post<Proizvod>(url,proizvod);

  }

  dodeliPreduzeceProizvodu(proizvodId,preduzeceId){
    const url = `${BASE_URL}/proizvodi/update/${proizvodId}/${preduzeceId}`;
    return this.httpClient.get(url);
  }

  obrisiProizvod(proizvodId){
    const url = `${BASE_URL}/proizvodi/${proizvodId}`;
    return this.httpClient.delete(url);
  }

}


interface GetResponseProizvodi{
  _embedded:{
    proizvodi: Proizvod[]
  }
}

interface GetResponseOcene{
  _embedded:{
    jeocenio: JeOcenio[]
  }
}