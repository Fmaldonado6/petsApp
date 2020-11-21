import { User } from './../../../shared/models/dataModels';
import { DataService } from './../data.service';
import { Injectable } from '@angular/core';
import { catchError } from 'rxjs/internal/operators/catchError';
import * as rx from 'rxjs'
@Injectable({
  providedIn: 'root'
})
export class UserService extends DataService {

  loggedUser: User

  user = new rx.Subject<User>();

  createUser(user: User) {
    return this.http.post<User>(`${this.url}/users`, user).pipe(catchError(this.handleError))
  }

  getUsers() {
    return this.http.get<User[]>(`${this.url}/users`).pipe(catchError(this.handleError))
  }

  getUserInfo(id: string) {
    return this.http.get<User>(`${this.url}/users/${id}`).pipe(catchError(this.handleError))

  }

  setUser(user: User) {
    this.loggedUser = user
    this.user.next(this.loggedUser)
  }

  getMyInfo() {
    return this.user;
  }

  updateUser(user: User) {
    return this.http.put<User>(`${this.url}/users/${user.id}`, user).pipe(catchError(this.handleError))

  }

}
