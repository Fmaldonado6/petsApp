import { User } from './../../../shared/models/dataModels';
import { DataService } from './../data.service';
import { Injectable } from '@angular/core';
import { catchError } from 'rxjs/internal/operators/catchError';

@Injectable({
  providedIn: 'root'
})
export class AuthService extends DataService {


  login(user: User) {
    return this.http.post<string[]>(`${this.url}/auth`, user).pipe(catchError(this.handleError))
  }

  setToken(token: string) {
    localStorage.setItem("token-pets-app", token);
  }

  loggedIn() {
    return !!localStorage.getItem('token-pets-app');
  }

  getToken() {
    return localStorage.getItem('token-pets-app')
  }

  signOut() {
    localStorage.removeItem('token-pets-app')
  }

  getTokenInfo() {
    let token = this.getToken();
    let base64Url = token.split('.')[1];
    var base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
    var jsonPayload = decodeURIComponent(atob(base64).split('').map(function (c) {
      return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
    }).join(''));

    return JSON.parse(jsonPayload);
  }

}
