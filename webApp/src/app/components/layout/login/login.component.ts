import { AuthService } from './../../../services/api/auth/auth.service';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { AddUserModal } from './../../modals/users/add-user/add-user.component';
import { Component, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { User } from 'src/app/shared/models/dataModels';

@Component({
  selector: 'login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  form: FormGroup;

  constructor(private dialog: MatDialog, private authService: AuthService) { }

  ngOnInit(): void {
    this.form = new FormGroup({
      email: new FormControl('', [
        Validators.required,

      ]),

      password: new FormControl('', [
        Validators.required,

      ]),

    });
  }

  login(value) {
    console.log(value)
    let user = new User();
    user.email = value.email;
    user.password = value.password;
    this.authService.login(user).subscribe((token: any) => {
      console.log(token)
      this.authService.setToken(token.token)
    })
  }

  openCreateAccountModal() {
    this.dialog.open(AddUserModal)
  }

}
