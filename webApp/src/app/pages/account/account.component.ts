import { EditUserComponent } from './../../components/modals/users/edit-user/edit-user.component';
import { EditPicturesComponent } from './../../components/modals/edit-pictures/edit-pictures.component';
import { EditPetComponent } from './../../components/modals/pets/edit-pet/edit-pet.component';
import { environment } from 'src/environments/environment';
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
import { Component, HostListener, OnInit } from '@angular/core';
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
  myProfile = false;
  petsError = false;
  baseUrl = environment.base_url
  hideFab = false;
  scrollY = 0
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

    this.scrollY = window.pageYOffset
  }

  setProfilePicture(event) {

    if (!event.target.files || !event.target.files[0])
      return

    this.currentStatus = Status.loading

    let pictureData = event.target.files[0]

    const fd = new FormData();

    fd.append('file', pictureData)
    fd.append('petId', null)
    fd.append('extension', pictureData.name.split('.').pop())

    this.picturesService.addPicture(fd).subscribe(pic => {
      this.user.profilePictureId = pic.id
      this.userService.updateUser(this.user).subscribe(user => {
        this.userService.setUser(user)
        this.getUserInfo()
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
    this.currentStatus = Status.loading
    this.userService.getUserInfo(this.userId).subscribe(user => {
      this.user = user;
      this.currentStatus = Status.loaded
      if (this.user.id == this.userService.loggedUser.id) {
        this.userService.setUser(user)
        this.myProfile = true
      }
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

  openPicturesModal(pet: Pet, e) {
    e.stopPropagation()
    if (window.innerWidth < 700) {
      const dialog = this.bottomSheet.open(EditPicturesComponent)
      dialog.instance.pet = pet
      dialog.instance.showBackIcon = false

    }
    else {
      const dialog = this.dialog.open(EditPicturesComponent)
      dialog.componentInstance.pet = pet
      dialog.componentInstance.showBackIcon = false


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

  openMenu(event) {
    event.stopPropagation();
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

  openEdit(pet: Pet) {
    let width = window.innerWidth
    pet.owner = this.user
    if (width < 700) {
      const dialog = this.bottomSheet.open(EditPetComponent)
      dialog.instance.petInfo = pet
      dialog.instance.ref = dialog;

    } else {
      const dialog = this.dialog.open(EditPetComponent)
      dialog.componentInstance.petInfo = pet
      dialog.componentInstance.ref = dialog;
    }

  }

  openEditUser() {
    let width = window.innerWidth
    if (width < 700) {
      const dialog = this.bottomSheet.open(EditUserComponent)
      dialog.instance.user = this.user;
      dialog.instance.userUpdated.subscribe(() => this.getUserInfo())
      dialog.instance.ref = dialog;


    } else {
      const dialog = this.dialog.open(EditUserComponent)
      dialog.componentInstance.user = this.user;
      dialog.componentInstance.userUpdated.subscribe(() => this.getUserInfo())
      dialog.componentInstance.ref = dialog;

    }
  }

  @HostListener('window:scroll', ['$event']) // for window scroll events
  onScroll(event) {


    if (window.pageYOffset > this.scrollY)
      this.hideFab = true
    else
      this.hideFab = false

    this.scrollY = window.pageYOffset
  }



}
