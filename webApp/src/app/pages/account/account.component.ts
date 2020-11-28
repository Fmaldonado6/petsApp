import { BadInput } from './../../shared/errors/errors';
import { MatSnackBar } from '@angular/material/snack-bar';
import { PetsService } from './../../services/api/pets/pets.service';
import { ConfirmComponent } from './../../components/modals/confirm/confirm.component';
import { PicturesService } from './../../services/api/pictures/pictures.service';
import { AddPetModal } from './../../components/modals/pets/add-pet/add-pet.component';
import { MatDialog, MatDialogRef } from '@angular/material/dialog';
import { Picture, User, Pet } from './../../shared/models/dataModels';
import { UserService } from './../../services/api/users/user.service';
import { AuthService } from './../../services/api/auth/auth.service';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { MatBottomSheet, MatBottomSheetRef } from '@angular/material/bottom-sheet';
import { InfoPetComponent } from 'src/app/components/modals/pets/info-pet/info-pet.component';
import { Status } from 'src/app/shared/models/Status';

@Component({
  selector: 'app-account',
  templateUrl: './account.component.html',
  styleUrls: ['./account.component.css']
})
export class AccountPage implements OnInit {
  userId: string
  user: User
  Status = Status
  currentStatus = Status.loading
  profilePicture: Picture;
  pictureData: any
  myProfile = false;
  petsError = false;
  constructor(
    private userService: UserService,
    private picturesService: PicturesService,
    private petsService: PetsService,
    private route: ActivatedRoute,
    private bottomSheet: MatBottomSheet,
    private snackBar: MatSnackBar,
    private dialog: MatDialog) {
    this.userId = this.route.snapshot.paramMap.get('id');
    this.getUserInfo();
  }

  ngOnInit(): void {
  }

  setProfilePicture(event) {

    if (!event.target.files || !event.target.files[0])
      return

    this.user.profilePicture = new Picture();

    let reader = new FileReader();

    this.pictureData = event.target.files[0]

    reader.onload = (e) => {
      this.user.profilePicture.picture = e.target.result as string;
    }

    reader.readAsDataURL(event.target.files[0])
    const fd = new FormData();

    fd.append('file', this.pictureData)
    fd.append('petId', null)
    fd.append('extension', this.pictureData.name.split('.').pop())

    this.picturesService.addPicture(fd).subscribe(pic => {
      this.user.profilePictureId = pic.id
      this.userService.updateUser(this.user).subscribe(user => {
        this.userService.setUser(user)
      }, () => {
        this.snackBar.open("Couldn´t change profile picture!", "CLOSE", { duration: 2000 });
      })
    }, (e) => {

      if (e instanceof BadInput)
        return this.snackBar.open("Image file size must be less than 5mb!", "CLOSE", { duration: 2000 });
      this.snackBar.open("Couldn´t change profile picture!", "CLOSE", { duration: 2000 });
    })


  }

  getUserInfo() {
    this.pictureData = null
    this.userService.getUserInfo(this.userId).subscribe(user => {
      this.user = user;
      this.currentStatus = Status.loaded
      if (this.user.id == this.userService.loggedUser.id)
        this.myProfile = true
    }, () => {
      this.currentStatus = Status.error
    })
  }

  openAddModal() {
    if (window.innerWidth < 700) {
      const dialog = this.bottomSheet.open(AddPetModal)
      dialog.instance.data = { user: this.user }
      dialog.instance.ref = dialog
      dialog.instance.petAdded.subscribe(() => this.getUserInfo())
    }
    else {
      const dialog = this.dialog.open(AddPetModal)
      dialog.componentInstance.data = { user: this.user }
      dialog.componentInstance.ref = dialog
      dialog.componentInstance.petAdded.subscribe(() => this.getUserInfo())

    }


  }

  delete(pet, e) {
    e.stopPropagation()
    const dialog = this.dialog.open(ConfirmComponent, {
      data: {
        title: "Delete pet?",
        text: "Are you sure you want to delete this pet?",
        confirm: "Delete",
        cancel: "Cancel"
      }
    })

    dialog.componentInstance.acceptEvent.subscribe(() => {
      this.currentStatus = Status.loading
      this.petsService.deletePet(pet).subscribe(e => {
        this.getUserInfo();
      }, () => {
        this.getUserInfo();
      })
    })

  }

  openInfo(pet: Pet) {
    let width = window.innerWidth
    pet.owner = this.user
    if (width < 700) {
      const dialog = this.bottomSheet.open(InfoPetComponent)
      dialog.instance.petInfo = pet
      dialog.instance.ref = dialog;

    } else {
      const dialog = this.dialog.open(InfoPetComponent)
      dialog.componentInstance.petInfo = pet
      dialog.componentInstance.ref = dialog;
    }

  }

  isLastElementRow(index) {
    var width = window.innerWidth;

    // Elements Per Row
    var elementsPerRow = 5;
    if (700 > width)
      elementsPerRow = 4;
    if (390 > width)
      elementsPerRow = 2;

    // Last row element
    if ((index + 1) % elementsPerRow === 0)
      return true;

    return false
  }


}
