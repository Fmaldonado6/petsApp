import { Report } from './../../../shared/models/dataModels';
import { DataService } from './../data.service';
import { Injectable } from '@angular/core';
import { catchError } from 'rxjs/internal/operators/catchError';

@Injectable({
  providedIn: 'root'
})
export class ReportsService extends DataService {

  addReport(report: Report) {
    return this.http.post<Report>(`${this.url}/reports`, report).pipe(catchError(this.handleError))
  }

}
