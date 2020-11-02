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
    localStorage.setItem("token", token);
  }

  loggedIn() {
    return !!localStorage.getItem('token');
  }

  getToken() {
    return localStorage.getItem('token')
  }

}
