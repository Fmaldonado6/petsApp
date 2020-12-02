import { Conflict } from './../../shared/errors/errors';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { throwError } from 'rxjs';
import { AppError, BadInput, NotFoundError } from 'src/app/shared/errors/errors';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class DataService {

  public url = `${environment.base_url}api/v1`


  constructor(protected http: HttpClient) { }

  protected handleError(error: Response) {
    if (error.status === 400)
      return throwError(new BadInput(error));

    if (error.status === 404)
      return throwError(new NotFoundError(error));

    if (error.status === 409)
      return throwError(new Conflict(error));

    return throwError(new AppError(error));
  }
}
