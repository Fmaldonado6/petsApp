import { Types } from './../../info-menu/info-menu.component';
import { UserService } from 'src/app/services/api/users/user.service';
import { ChangeDetectorRef, Component, Input, OnInit } from '@angular/core';
import { FormControl, FormGroup, FormGroupDirective, NgForm, Validators } from '@angular/forms';
import { ErrorStateMatcher } from '@angular/material/core';
import { BadInput } from 'src/app/shared/errors/errors';
import { User } from 'src/app/shared/models/dataModels';
import { Status } from 'src/app/shared/models/Status';
import { MatDialogRef } from '@angular/material/dialog';

export class MyErrorStateMatcher implements ErrorStateMatcher {
  isErrorState(control: FormControl | null, form: FormGroupDirective | NgForm | null): boolean {
    const invalidCtrl = !!(control && control.invalid && control.parent.dirty);
    const invalidParent = !!(control && control.parent && control.parent.invalid && control.parent.dirty);

    return (invalidCtrl || invalidParent);
  }
}

@Component({
  selector: 'app-add-user',
  templateUrl: './add-user.component.html',
  styleUrls: ['./add-user.component.css']
})
export class AddUserModal implements OnInit {
  form: FormGroup
  matcher = new MyErrorStateMatcher();
  Status = Status
  currentStatus = Status.loaded
  Types = Types
  @Input() ref;
  constructor(private userService: UserService,
    private changeDetector: ChangeDetectorRef) { }

  ngOnInit(): void {
    this.form = new FormGroup({
      username: new FormControl('', [
        Validators.required,

      ]),

      password: new FormControl('', [
        Validators.required,

      ]),
      email: new FormControl('', [
        Validators.required,
      ]),
      age: new FormControl('', [
        Validators.required,

      ]),
      gender: new FormControl('', [
        Validators.required,

      ]),
      confirmPassword: new FormControl('', [
        Validators.required,
      ])
    }, { validators: this.checkPasswords });


  }

  checkPasswords(group: FormGroup) {
    let pass = group.controls.password.value;
    let confirmPass = group.controls.confirmPassword.value;

    return pass === confirmPass ? null : { notSame: true }
  }

  createUser(value) {
    this.currentStatus = Status.loading
    let user = new User();
    user.name = value.username;
    user.age = value.age;
    user.email = value.email;
    user.gender = Number.parseInt(value.gender);
    user.password = value.password;

    this.userService.createUser(user).subscribe(createdUser => {

      this.currentStatus = Status.completed
      this.changeDetector.detectChanges();
    }, (e) => {
      this.changeDetector.detectChanges();
      this.currentStatus = Status.error

    })

  }

  close() {
    if (this.ref instanceof MatDialogRef)
      this.ref.close()
    else
      this.ref.dismiss()
  }

}

