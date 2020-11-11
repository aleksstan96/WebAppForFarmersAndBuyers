import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Proizvod } from '../models/proizvod';
import { Porudzbina } from '../models/porudzbina';
import { Observable } from 'rxjs';
import { BASE_URL } from '../global';
import { map } from 'rxjs/operators';
import { Poljoprivrednik } from '../models/poljoprivrednik';
import { Rasadnik } from '../models/rasadnik';
import { Preduzece } from '../models/preduzece';
import { PorudzbinaPost } from '../models/porudzbinaPost';

@Injectable({
  providedIn: 'root'
})
export class PreduzeceService {


  constructor(private httpClient: HttpClient) {
  }

  findByUserdId(userId){
    const url = `${BASE_URL}/preduzeca/search/findByUserId?id=${userId}`;
    return this.httpClient.get<GetResponsePreduzeca>(url).pipe(
      map(result=> result._embedded.preduzeca[0])
    );
  }

  findByNaziv(naziv){
    const url = `${BASE_URL}/preduzeca/search/findByNaziv?naziv=${naziv}`;
    return this.httpClient.get<GetResponsePreduzeca>(url).pipe(
      map(result=> result._embedded.preduzeca[0])
    );
  }



  dohvatiPorudzbinePreduzeca(preduzeceId): Observable<Porudzbina[]>{
    const url = `${BASE_URL}/porudzbine/search/findByPreduzeceId?id=${preduzeceId}&sort=status,asc`;
    return this.httpClient.get<GetResponsePorudzbina>(url).pipe(
      map(result=> result._embedded.porudzbine)
    );
  }

  dohvatiPorudzbinePreduzecaSortiranoPoDatumuRastuce(preduzeceId): Observable<Porudzbina[]>{
    const url = `${BASE_URL}/porudzbine/search/findByPreduzeceId?id=${preduzeceId}&sort=datumKreiranja`;
    return this.httpClient.get<GetResponsePorudzbina>(url).pipe(
      map(result=> result._embedded.porudzbine)
    );
  }

  dohvatiPorudzbinePreduzecaSortiranoPoDatumuOpadajuce(preduzeceId): Observable<Porudzbina[]>{
    const url = `${BASE_URL}/porudzbine/search/findByPreduzeceId?id=${preduzeceId}&sort=datumKreiranja,desc`;
    return this.httpClient.get<GetResponsePorudzbina>(url).pipe(
      map(result=> result._embedded.porudzbine)
    );
  }

  dohvatiPorudzbinePreduzecaUProteklihMesecDana(preduzeceId, startDate, endDate)
  : Observable<Porudzbina[]>
  {
    
  //  endDate.setMonth(endDate.getMonth()+1)
   // console.log(startDate.getFullYear(),startDate.getMonth()+1,startDate.getDate(), endDate.getMonth())
    const url = `${BASE_URL}/porudzbine/search/findByPreduzeceIdAndDatumKreiranjaBetween?id=${preduzeceId}&startDate=${startDate.getFullYear()}/${startDate.getMonth()+1}/${startDate.getDate()}&endDate=${endDate.getFullYear()}/${endDate.getMonth()+1}/${endDate.getDate()+1}`;
    return this.httpClient.get<GetResponsePorudzbina>(url).pipe(
      map(result=> result._embedded.porudzbine)
    );
  }


  dohvatiProizvodePreduzeca(preduzeceId): Observable<Proizvod[]>{
    const url = `${BASE_URL}/proizvodi/search/findByPreduzeceId?id=${preduzeceId}`;
    return this.httpClient.get<GetResponseProizvodi>(url).pipe(
      map(response=> response._embedded.proizvodi)
    )
  }

  dohvatiPoljoprivrednikaIzPorudzbine(porudzbinaId): Observable<Poljoprivrednik>{
    const url = `${BASE_URL}/porudzbine/${porudzbinaId}/poljoprivrednik`;
    return this.httpClient.get<Poljoprivrednik>(url);

  }

  dohvatiRasadnikIzPorudzbine(porudzbinaId): Observable<Rasadnik>{
    const url = `${BASE_URL}/porudzbine/${porudzbinaId}/rasadnik`;
    return this.httpClient.get<Rasadnik>(url);

  }

  kreirajPorudzbinu(porudzbina: PorudzbinaPost): Observable<PorudzbinaPost>{
    const url = `${BASE_URL}/porudzbine`;
    return this.httpClient.post<PorudzbinaPost>(url, porudzbina);
   

  }

  updatePorudzbinaIds(porudzbinaId,poljId,rasadnikId,preduzeceId){
    const url = `${BASE_URL}/porudzbine/updateids/${porudzbinaId}/${preduzeceId}/${poljId}/${rasadnikId}`;
    return this.httpClient.get(url);
  }

  createProizvodPorudzbina(porid, proid, kol){
    const url = `${BASE_URL}/proizvodporudzbina/create/${porid}/${proid}/${kol}`;
    return this.httpClient.get(url);

  }

}


interface GetResponsePorudzbina {
  _embedded: {
    porudzbine: Porudzbina[];
  }
}

interface GetResponseProizvodi{
  _embedded:{
    proizvodi: Proizvod[]
  }
}

interface GetResponsePreduzeca{
  _embedded:{
    preduzeca: Preduzece[]
  }
}