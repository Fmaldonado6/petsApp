import { Picture } from './../../../shared/models/dataModels';
import { DataService } from './../data.service';
import { Injectable } from '@angular/core';
import { catchError } from 'rxjs/internal/operators/catchError';

@Injectable({
  providedIn: 'root'
})
export class PicturesService extends DataService {

  addPicture(fd: FormData) {
    return this.http.post<Picture>(`${this.url}/pictures`, fd).pipe(catchError(this.handleError))

  }

  getPetPictures(id: string) {
    return this.http.get<Picture[]>(`${this.url}/pictures/pet/${id}`).pipe(catchError(this.handleError))

  }

  deletePicture(picture: Picture) {
    return this.http.delete(`${this.url}/pictures/${picture.id}`).pipe(catchError(this.handleError))

  }

  getPicture(id: string) {
    return this.http.get<Picture>(`${this.url}/pictures/${id}`).pipe(catchError(this.handleError))

  }

}
