import { Injectable } from '@angular/core';
import { map }  from 'rxjs/operators'; 
import { HttpClient } from '@angular/common/http';
import { Rasadnik } from '../models/rasadnik';
import { Observable } from 'rxjs';
import { BASE_URL } from '../global';
import { Poljoprivrednik } from '../models/poljoprivrednik';
import { User } from '../models/user';
import { Porudzbina } from '../models/porudzbina';

@Injectable({
  providedIn: 'root'
})
export class PoljoprivrednikService {


  constructor(private httpClient: HttpClient) { }



  getPoljoprivrednikByUserId(id): Observable<Poljoprivrednik>{
    const url = `${BASE_URL}/poljoprivrednici/search/findByUserId?id=${id}`;
    return this.httpClient.get<GetResponsePoljoprivrednik>(url).pipe(
      map(response=>response._embedded.poljoprivrednici[0])
    );
  }

  getUser(poljoprivrednikId): Observable<User>{
    const url = `${BASE_URL}/poljoprivrednici/${poljoprivrednikId}/user`;
    return this.httpClient.get<User>(url);
  }



  getRasadnici(id): Observable<Rasadnik[]>{
    
    const url = `${BASE_URL}/poljoprivrednici/${id}/rasadnici`;
    return this.httpClient.get<GetResponseRasadnik>(url).pipe(
      map(response => response._embedded.rasadnici)
    )

  }

  getPorudzbineStatusIsporucena(pojId):Observable<Porudzbina[]>{
    let status='isporucena';
    const url = `${BASE_URL}/porudzbine/search/findByPoljoprivrednikIdAndStatus?pid=${pojId}&status=${status}`;
    return this.httpClient.get<GetResponsePorudzbina>(url).pipe(
      map(response => response._embedded.porudzbine)
    )
  }

  getPorudzbineStatusPrihvacena(pojId):Observable<Porudzbina[]>{
    let status='prihvacena';
    const url = `${BASE_URL}/porudzbine/search/findByPoljoprivrednikIdAndStatus?pid=${pojId}&status=${status}`;
    return this.httpClient.get<GetResponsePorudzbina>(url).pipe(
      map(response => response._embedded.porudzbine)
    )
  }

}

interface GetResponseRasadnik {
  _embedded: {
    rasadnici: Rasadnik[];
  }
}

interface GetResponsePoljoprivrednik {
  _embedded: {
    poljoprivrednici: Poljoprivrednik[];
  }
}

interface GetResponsePorudzbina{
  _embedded:{
    porudzbine: Porudzbina[]
  }
}
