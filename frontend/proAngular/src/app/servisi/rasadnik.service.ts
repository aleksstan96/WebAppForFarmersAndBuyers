import { Injectable } from '@angular/core';
import { Sadnica } from '../models/sadnica';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { BASE_URL } from '../global';
import { map } from 'rxjs/operators';
import { Rasadnik } from '../models/rasadnik';
import { Magacin } from '../models/magacin';

@Injectable({
  providedIn: 'root'
})
export class RasadnikService {

  constructor(private httpClient: HttpClient) { }


  getSadnice(id): Observable<Sadnica[]>{
    const url = `${BASE_URL}/sadnice/search/findByRasadnikId?id=${id}`;
    return this.httpClient.get<GetResponseSadnice>(url).pipe(
      map(response => response._embedded.sadnice)
    )
  }

  getRasadnik(id): Observable<Rasadnik>{
    const url = `${BASE_URL}/rasadnici/${id}`
    return this.httpClient.get<Rasadnik>(url);

  }

  updateRasadnik(id, rasadnik): Observable<Rasadnik>{
    const url = `${BASE_URL}/rasadnici/${id}`
    return this.httpClient.put<Rasadnik>(url, rasadnik);
  }


  saveRasadnik(rasadnik):Observable<Rasadnik>{
    const url = `${BASE_URL}/rasadnici`
    return this.httpClient.post<Rasadnik>(url, rasadnik);
    
  }

  dodeliPoljoprivrednika(rasadnikId,poljoprivrednikId): Observable<Rasadnik>{
     const url = `${BASE_URL}/rasadnici/${rasadnikId}/${poljoprivrednikId}`
     return this.httpClient.patch<Rasadnik>(url, {});

  }

  izvadiSadnicu(id): Observable<{}>{
    const url = `${BASE_URL}/sadnice/update/uklonjena/${id}`
    return this.httpClient.get(url);
  }

  obrisiSadnicu(id): Observable<{}>{
    const url = `${BASE_URL}/sadnice/${id}`
    return this.httpClient.delete(url);
  }

  dohvatiMagacin(id):Observable<Magacin>{
    const url = `${BASE_URL}/magacini/search/findByRasadnikId?id=${id}`;
    return this.httpClient.get<GetResponseMagacini>(url).pipe(
      map(response => response._embedded.magacini[0])
    )
  }

  dodajSadnicu(sadnica):Observable<Sadnica>{
    const url = `${BASE_URL}/sadnice`
    return this.httpClient.post<Sadnica>(url, sadnica);
  }

  dodeliRasadnikSadnici(sadnicaId, rasadnikId): Observable<{}>{
    const url = `${BASE_URL}/sadnice/update/${sadnicaId}/${rasadnikId}`
    return this.httpClient.get(url);
  }

  promeniProgresSadnice(sadnicaId,progres){
    const url = `${BASE_URL}/sadnice/update/progres/${sadnicaId}/${progres}`
    return this.httpClient.get(url);
  }

  findByMagacinId(magId): Observable<Rasadnik>{
    const url = `${BASE_URL}/rasadnici/search/findByMagacinId?id=${magId}`;
    return this.httpClient.get<GetResponseRasadnici>(url).pipe(
      map(response=>response._embedded.rasadnici[0])
    )
  }

  sendMail(poljId: number, rasadnik:string){
    const url =`${BASE_URL}/rasadnikodrzavanje/${poljId}/${rasadnik}`;
    return this.httpClient.get(url);
  }

  }

  



interface GetResponseSadnice{
  _embedded: {
    sadnice: Sadnica[];
  }
}

interface GetResponseMagacini{
  _embedded: {
    magacini: Magacin[];
  }
}

interface GetResponseRasadnici{
  _embedded: {
    rasadnici: Rasadnik[];
  }
}
