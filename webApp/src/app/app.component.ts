import { UserService } from './services/api/users/user.service';
import { Status } from './shared/models/Status';
import { AuthService } from './services/api/auth/auth.service';
import { Component } from '@angular/core';
import { User } from './shared/models/dataModels';
import { Router } from '@angular/router';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'webApp';
  Status = Status
  currentSatus = Status.loading
  loggedIn = false;

  constructor(private authService: AuthService, private userService: UserService, private router: Router,
  ) {
    this.loggedIn = this.authService.loggedIn();

    if (!this.loggedIn)
      this.currentSatus = Status.loaded
    else
      this.getUserInfo();

    this.router.events.subscribe(e => {
      this.loggedIn = this.authService.loggedIn();

    })

  }

  signOut() {
    this.loggedIn = false
    this.authService.signOut();
    this.router.navigate(["/"])
  }

  login() {
    this.loggedIn = true;
    this.getUserInfo();
  }

  getUserInfo() {

    let token = this.authService.getTokenInfo()

    let userInfo = JSON.parse(token.sub) as User;

    this.userService.getUserInfo(userInfo.id).subscribe(user => {
      this.userService.setUser(user)
      this.currentSatus = Status.loaded
    }, () => {
      this.signOut();
      this.currentSatus = Status.loaded

    })
  }




}


