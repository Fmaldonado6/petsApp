import { AuthService } from './auth/auth.service';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class TokenInterceptorService {

  intercept(req, next) {
    let token = req;
    console.log(token)
    if (this.authService.getToken) {
      token = req.clone({
        setHeaders: {
          Authorization: `Bearer ${this.authService.getToken()}`
        }
      })
    }

    return next.handle(token)

  }

  constructor(private authService: AuthService) { }
}
