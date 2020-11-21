import { environment } from './../../../../environments/environment';
import { UserService } from './../../../services/api/users/user.service';
import { PicturesService } from './../../../services/api/pictures/pictures.service';
import { User } from './../../../shared/models/dataModels';
import { AuthService } from './../../../services/api/auth/auth.service';
import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.css']
})
export class NavbarComponent implements OnInit {
  @Output() signOutEvent = new EventEmitter();
  userInfo: User = new User();
  basePath = environment.base_url
  constructor(private userService: UserService, private picturesService: PicturesService) {

  }

  ngOnInit(): void {
    this.userInfo = this.userService.loggedUser

    this.userService.getMyInfo().subscribe(user => {
      this.userInfo = user
      if (this.userInfo.profilePictureId != null)
        this.picturesService.getPicture(this.userInfo.profilePictureId).subscribe(pic => {
          this.userInfo.profilePicture = pic
        })
    });
  }

  signOut() {
    this.signOutEvent.emit();

  }

}
