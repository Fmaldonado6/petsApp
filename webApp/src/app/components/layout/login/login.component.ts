import { MatBottomSheet } from '@angular/material/bottom-sheet';
import { AuthService } from './../../../services/api/auth/auth.service';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { AddUserModal } from './../../modals/users/add-user/add-user.component';
import { Component, OnInit, Output, EventEmitter } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { User } from 'src/app/shared/models/dataModels';
import { MatSnackBar } from '@angular/material/snack-bar';

@Component({
  selector: 'login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  @Output() loginEvent = new EventEmitter();
  form: FormGroup;

  constructor(
    private dialog: MatDialog,
    private bottomSheet: MatBottomSheet,
    private snakcbar: MatSnackBar,
    private authService: AuthService) { }

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
    let user = new User();
    user.email = value.email;
    user.password = value.password;
    this.authService.login(user).subscribe((token: any) => {
      this.authService.setToken(token.token)
      this.loginEvent.emit()
    }, () => {
      this.snakcbar.open("Wrong username or password!", "CLOSE", { duration: 2000 })
    })
  }

  openCreateAccountModal() {
    let width = window.innerWidth

    if (width < 700) {
      const dialog = this.bottomSheet.open(AddUserModal)
      dialog.instance.ref = dialog
    }
    else {

      const dialog = this.dialog.open(AddUserModal)
      dialog.componentInstance.ref = dialog

    }
  }

}
