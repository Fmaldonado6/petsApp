import { Picture } from './../../../shared/models/dataModels';
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

  addPets(pet: Pet) {
    return this.http.post<Pet>(`${this.url}/pets`, pet).pipe(catchError(this.handleError))
  }

  deletePet(pet: Pet) {
    console.log(pet.id)
    return this.http.delete(`${this.url}/pets/${pet.id}`).pipe(catchError(this.handleError))
  }

  updatePet(pet: Pet) {
    return this.http.put<Pet>(`${this.url}/pets/${pet.id}`, pet).pipe(catchError(this.handleError))

  }

}
