import { Injectable } from '@angular/core';
import { catchError } from 'rxjs/internal/operators/catchError';
import { Pet } from 'src/app/shared/models/dataModels';
import { DataService } from '../data.service';

@Injectable({
  providedIn: 'root'
})
export class PetsService extends DataService {


  getPets() {
    return this.http.get<Pet[]>(`${this.url}/pets`).pipe(catchError(this.handleError))
  }

}
