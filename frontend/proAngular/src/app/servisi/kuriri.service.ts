import { Injectable } from '@angular/core';
import { Kurir } from '../models/kurir';
import { JeDodeljen } from '../models/jedodeljen';
import { BASE_URL } from '../global';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { map } from 'rxjs/operators';
import { Rasadnik } from '../models/rasadnik';

@Injectable({
  providedIn: 'root'
})
export class KuririService {

  constructor(public httpClient: HttpClient) { }

  dohvatiKurirePreduzeca(preduzeceId): Observable<Kurir[]>{
    const url = `${BASE_URL}/kuriri/search/findByPreduzeceId?id=${preduzeceId}`;
    return this.httpClient.get<GetResponseKuriri>(url).pipe(
      map(response=> response._embedded.kuriri)
    )
  }

  dohvatiJeDodeljen(kurirId, preduzeceId): Observable<JeDodeljen>{
    const url = `${BASE_URL}/jedodeljen/search/findByKurirIdAndPorudzbinaId?uid=${kurirId}&pid=${preduzeceId}`;
    return this.httpClient.get<GetResponseJeDodeljen>(url).pipe(
      map(response=> response._embedded.jedodeljen[0])
    )
  }

  insertJeDodeljen(kurId,porId,udaljenost,vreme){
    const url = `${BASE_URL}/jedodeljen/create/${kurId}/${porId}/${udaljenost}/${vreme}`;
    return this.httpClient.get(url)
  }

  getRasadnikPorudzbine(porId): Observable<Rasadnik>{
    const url = `${BASE_URL}/porudzbine/${porId}/rasadnik`;
    return this.httpClient.get<Rasadnik>(url);
  }

 

}

interface GetResponseKuriri{
  _embedded:{
    kuriri: Kurir[]
  }
}

interface GetResponseJeDodeljen{
  _embedded:{
    jedodeljen: JeDodeljen[]
  }
}