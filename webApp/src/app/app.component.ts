import { AuthService } from './services/api/auth/auth.service';
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'webApp';
  loggedIn = false;

  constructor(private authService: AuthService) {

    this.loggedIn = this.authService.loggedIn();
  }



}
