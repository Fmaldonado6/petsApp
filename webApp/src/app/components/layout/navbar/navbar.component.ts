import { User } from './../../../shared/models/dataModels';
import { AuthService } from './../../../services/api/auth/auth.service';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.css']
})
export class NavbarComponent implements OnInit {

  userInfo: User;

  constructor(private authService: AuthService) { }

  ngOnInit(): void {

    let token = this.authService.getTokenInfo()

    this.userInfo = JSON.parse(token.sub) as User;

    console.log(this.userInfo)
  }

}
