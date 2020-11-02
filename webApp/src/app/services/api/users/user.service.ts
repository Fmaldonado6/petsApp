import { User } from './../../../shared/models/dataModels';
import { DataService } from './../data.service';
import { Injectable } from '@angular/core';
import { catchError } from 'rxjs/internal/operators/catchError';

@Injectable({
  providedIn: 'root'
})
export class UserService extends DataService {

  createUser(user: User) {
    return this.http.post<User[]>(`${this.url}/users`, user).pipe(catchError(this.handleError))
  }

  getUsers() {
    return this.http.get<User[]>(`${this.url}/users`).pipe(catchError(this.handleError))
  }

}
