import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { User } from '../models/user';
import { BASE_URL } from '../global';
import { map } from 'rxjs/operators';
import { Observable } from 'rxjs';
import { Poljoprivrednik } from '../models/poljoprivrednik';
import { Preduzece } from '../models/preduzece';

@Injectable({
  providedIn: 'root'
})
export class UsersService {

  constructor(private httpClient: HttpClient) { }

  findUserByUsername(username){
    const url = `${BASE_URL}/users/search/findByUsername?username=${username}`;
    return this.httpClient.get<GetResponseUsers>(url).pipe(
      map(response => response._embedded.users)
    );

  }

  findUserByUsernameAndPassword(username,password){
    const url = `${BASE_URL}/users/search/findByUsernameAndPassword?username=${username}&password=${password}`;
    return this.httpClient.get<GetResponseUsers>(url).pipe(
      map(response => response._embedded.users)
    );

  }


  findUserById(id){
    const url = `${BASE_URL}/users/search/findById?id=${id}`;
    return this.httpClient.get<GetResponseUsers>(url).pipe(
      map(response => response._embedded.users[0])
    );

  }

  findPoljoprivrednikByUserId(userId){
    const url = `${BASE_URL}/poljoprivrednici/search/findByUserId?id=${userId}`;
    return this.httpClient.get<GetResponsePoljoprivrednik>(url).pipe(
      map(response => response._embedded.poljoprivrednici[0])
    );

  }

  findPreduzeceByUserId(userId){
    const url = `${BASE_URL}/preduzeca/search/findByUserId?id=${userId}`;
    return this.httpClient.get<GetResponsePreduzeca>(url).pipe(
      map(response => response._embedded.preduzeca[0])
    );

  }


  getAllUsers(): Observable<User[]>{
    const url = `${BASE_URL}/users`;
    return this.httpClient.get<GetResponseUsers>(url).pipe(
      map(response=> response._embedded.users)
    )

  }

  addUser(user): Observable<User>{
    const url = `${BASE_URL}/users`;
    return this.httpClient.post<User>(url, user);

  }

  deleteUser(id): Observable<{}> {
    const url = `${BASE_URL}/users/${id}`;
    return this.httpClient.delete(url);
  }

  updateUser(id, user): Observable<User>{
    const url = `${BASE_URL}/users/${id}`;
    return this.httpClient.put<User>(url, user);
  }

  addPoljoprivrednik(poljoprivrednik): Observable<Poljoprivrednik>{
    const url = `${BASE_URL}/poljoprivrednici`;
    return this.httpClient.post<Poljoprivrednik>(url, poljoprivrednik);

  }

  updatePoljoprivrednik(id, poljoprivrednik){
    const url = `${BASE_URL}/poljoprivrednici/${id}`;
    return this.httpClient.put<Poljoprivrednik>(url, poljoprivrednik);
  }

  updatePreduzece(id, preduzece){
    const url = `${BASE_URL}/preduzeca/${id}`;
    return this.httpClient.put<Preduzece>(url, preduzece);
  }

  dodeliIdUserPoljoprivredniku(poljoprivrednikId,userId){
    const url = `${BASE_URL}/poljoprivrednici/update/${poljoprivrednikId}/${userId}`;
    return this.httpClient.get(url);
  }

  addPreduzece(preduzece): Observable<Preduzece>{
    const url = `${BASE_URL}/preduzeca`;
    return this.httpClient.post<Preduzece>(url, preduzece);

  }

  dodeliIdUserPreduzecu(preduzeceId,userId){
    const url = `${BASE_URL}/preduzeca/update/${preduzeceId}/${userId}`;
    return this.httpClient.get(url);
  }
}


interface GetResponseUsers{
  _embedded: {
    users: User[];
  }
}

interface GetResponsePoljoprivrednik{
  _embedded: {
    poljoprivrednici: Poljoprivrednik[];
  }
}

interface GetResponsePreduzeca{
  _embedded: {
    preduzeca: Preduzece[];
  }
}