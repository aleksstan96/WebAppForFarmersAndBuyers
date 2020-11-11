import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { ProizvodPorudzbina } from '../models/proizvodporudzbina';
import { BASE_URL } from '../global';
import { map } from 'rxjs/operators';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class PorudzbiniService {

  constructor(private httpClient: HttpClient) { }

  public dohvatiProizvodPorudzbina(porId): Observable<ProizvodPorudzbina[]>{
    const url = `${BASE_URL}/proizvodporudzbina/search/findByPorudzbinaId?id=${porId}`;
    return this.httpClient.get<GetResponseProizvodPorudzbina>(url).pipe(
      map(response => response._embedded.proizvodporudzbina)
    )

  }

  public dohvatiProizvodPorudzbinaDvaParam(proId,porId): Observable<ProizvodPorudzbina[]>{
   
    const url = `${BASE_URL}/proizvodporudzbina/search/findByProizvodIdAndPorudzbinaId?prid=${proId}&poid=${porId}`;
    return this.httpClient.get<GetResponseProizvodPorudzbina>(url).pipe(
      map(response => response._embedded.proizvodporudzbina)
    )
  }

  public promeniStatusPorudzbine(porId:number,status:string){
    const url = `${BASE_URL}/porudzbine/updatestatus/${porId}/${status}`;
    return this.httpClient.get(url);
  }

  public ukloniPorudzbinu(porId){
    const url = `${BASE_URL}/porudzbine/${porId}`;
    return this.httpClient.delete(url);
  }

}


interface GetResponseProizvodPorudzbina{
  _embedded: {
    proizvodporudzbina: ProizvodPorudzbina[];
  }
}