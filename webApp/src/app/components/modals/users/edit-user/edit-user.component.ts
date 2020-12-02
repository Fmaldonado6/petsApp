import { ConfirmComponent } from './../../confirm/confirm.component';
import { MatBottomSheetRef } from '@angular/material/bottom-sheet';
import { MatDialog, MatDialogRef } from '@angular/material/dialog';
import { Router } from '@angular/router';
import { AuthService } from './../../../../services/api/auth/auth.service';
import { Conflict } from './../../../../shared/errors/errors';
import { BadInput } from 'src/app/shared/errors/errors';
import { PicturesService } from 'src/app/services/api/pictures/pictures.service';
import { UserService } from 'src/app/services/api/users/user.service';
import { Types } from './../../info-menu/info-menu.component';
import { environment } from 'src/environments/environment';
import { User, Picture } from 'src/app/shared/models/dataModels';
import { FormControl, FormGroup, FormGroupDirective, NgForm, Validators } from '@angular/forms';
import { Status } from 'src/app/shared/models/Status';
import { Component, OnInit, Output, EventEmitter } from '@angular/core';
import { ErrorStateMatcher } from '@angular/material/core';
import { ChangeDetectorRef } from '@angular/core';
export class MyErrorStateMatcher implements ErrorStateMatcher {
  isErrorState(control: FormControl | null, form: FormGroupDirective | NgForm | null): boolean {
    const invalidCtrl = !!(control && control.invalid && control.parent.dirty);
    const invalidParent = !!(control && control.parent && control.parent.invalid && control.parent.dirty);

    return (invalidCtrl || invalidParent);
  }
}
@Component({
  selector: 'app-edit-user',
  templateUrl: './edit-user.component.html',
  styleUrls: ['./edit-user.component.css']
})
export class EditUserComponent implements OnInit {
  Status = Status
  currenStatus = Status.loaded
  baseUrl = environment.base_url
  Pages = Pages;
  currentPage = Pages.main
  user: User;
  matcher = new MyErrorStateMatcher();
  Types = Types
  form: FormGroup
  formPassword: FormGroup;
  newPicture;
  pictureData;
  ref: MatDialogRef<EditUserComponent> | MatBottomSheetRef
  @Output() userUpdated = new EventEmitter();

  constructor(
    private usersService: UserService,
    private dialog: MatDialog,
    private authService: AuthService,
    private router: Router,
    private picturesService: PicturesService,
    private changeDetector: ChangeDetectorRef

  ) { }

  ngOnInit(): void {


    this.form = new FormGroup({
      username: new FormControl(this.user.name, [
        Validators.required,

      ]),
      email: new FormControl(this.user.email, [
        Validators.required,
      ]),
      age: new FormControl(this.user.age, [
        Validators.required,

      ]),
      gender: new FormControl(this.user.gender, [
        Validators.required,
      ]),
    });


    this.formPassword = new FormGroup({
      password: new FormControl('', [
        Validators.required,

      ]),

      confirmPassword: new FormControl('', [
        Validators.required,
      ])
    }, { validators: this.checkPasswords });


  }

  changePage(page: number) {
    this.currentPage = page;
  }

  checkPasswords(group: FormGroup) {
    let pass = group.controls.password.value;
    let confirmPass = group.controls.confirmPassword.value;

    return pass === confirmPass ? null : { notSame: true }
  }

  uploadPicture(event) {

    if (!event.target.files || !event.target.files[0])
      return


    this.newPicture = event.target.files[0]

    let reader = new FileReader();

    reader.onload = (e) => {
      this.pictureData = e.target.result
    }

    reader.readAsDataURL(this.newPicture)

  }

  updateUser(value) {
    this.currenStatus = Status.loading
    let user = new User();

    user.id = this.user.id;
    user.name = value.username
    user.age = value.age
    user.email = value.email
    user.gender = value.gender
    user.profilePictureId = this.user.profilePictureId
    if (this.newPicture != null)
      this.updateUserWithPicture(user)
    else
      this.updateUserNoPicture(user)


  }

  changePasswords(value) {

    let user = new User();
    user.id = this.user.id
    user.name = this.user.name
    user.age = this.user.age
    user.email = this.user.email
    user.gender = this.user.gender
    user.profilePictureId = this.user.profilePictureId
    user.password = value.password

    this.updateUserNoPicture(user);
  }

  updateUserWithPicture(user: User) {
    const fd = new FormData();
    fd.append('file', this.newPicture)
    fd.append('petId', null)
    fd.append('extension', this.newPicture.name.split('.').pop())

    this.picturesService.addPicture(fd).subscribe(picture => {
      user.profilePictureId = picture.id;
      this.usersService.updateUser(user).subscribe(user => {
        this.currenStatus = Status.completed
        this.changeDetector.detectChanges();
        this.userUpdated.emit()

      }, (e) => {
        if (e instanceof Conflict)
          this.currenStatus = Status.repeated
        else
          this.currenStatus = Status.error
        this.changeDetector.detectChanges();
      })
    }, (e) => {

      if (e instanceof BadInput)
        this.currenStatus = Status.badInput
      else
        this.currenStatus = Status.error

      this.changeDetector.detectChanges();
    })
  }

  updateUserNoPicture(user: User) {
    this.usersService.updateUser(user).subscribe(user => {
      this.currenStatus = Status.completed
      this.userUpdated.emit()
      this.changeDetector.detectChanges();

    }, (e) => {

      if (e instanceof Conflict)
        this.currenStatus = Status.repeated
      else
        this.currenStatus = Status.error

      this.changeDetector.detectChanges();
    })
  }

  deleteUser() {

    const dialog = this.dialog.open(ConfirmComponent,
      {
        data: {
          title: "Delete User?",
          text: "Are you sure you want to delete this user?",
          confirm: "Delete",
          cancel: "Cancel"
        }
      })

    dialog.componentInstance.acceptEvent.subscribe(() => {
      this.usersService.deleteUser(this.user).subscribe(() => {
        this.authService.signOut();
        this.router.navigate(["/"])
        if (this.ref instanceof MatBottomSheetRef)
          this.ref.dismiss();
        else
          this.ref.close();
      })
    })

  }

}

enum Pages {
  main,
  userInfo,
  password,
}