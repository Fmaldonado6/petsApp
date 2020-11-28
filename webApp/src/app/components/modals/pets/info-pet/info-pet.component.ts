import { MatBottomSheetRef } from '@angular/material/bottom-sheet';
import { Router } from '@angular/router';
import { ConfirmComponent } from './../../confirm/confirm.component';
import { MatDialog, MatDialogRef } from '@angular/material/dialog';
import { UserService } from './../../../../services/api/users/user.service';
import { Status } from './../../../../shared/models/Status';
import { environment } from './../../../../../environments/environment';
import { Pet, Picture } from './../../../../shared/models/dataModels';
import { Component, Input, OnInit } from '@angular/core';
import { PicturesService } from 'src/app/services/api/pictures/pictures.service';

@Component({
  selector: 'app-info-pet',
  templateUrl: './info-pet.component.html',
  styleUrls: ['./info-pet.component.css']
})
export class InfoPetComponent implements OnInit {

  basePath = environment.base_url
  Status = Status;
  owner = false
  currentStatus = Status.loading
  picturesStatus = Status.loading
  @Input() petInfo: Pet;
  @Input() ref: MatDialogRef<InfoPetComponent> | MatBottomSheetRef<InfoPetComponent>;
  constructor(
    private userService: UserService,
    private dialog: MatDialog,
    private picturesService: PicturesService,
    private router: Router
  ) {
  }

  ngOnInit(): void {
  }

  ngAfterViewInit() {
    setTimeout(() => this.loadInfo(), 100)
  }

  uploadPicture(event) {
    if (!event.target.files || !event.target.files[0])
      return

    let data = event.target.files[0]
    const fd = new FormData();

    fd.append('file', data)
    fd.append('petId', this.petInfo.id)
    fd.append('extension', data.name.split('.').pop())

    this.picturesService.addPicture(fd).subscribe(pic => {
      this.gePictures();
    })
  }

  gePictures() {
    this.picturesStatus = Status.loading
    this.picturesService.getPetPictures(this.petInfo.id).subscribe(pictures => {
      this.petInfo.pictures = pictures;
      if (this.petInfo.pictures.length == 0)
        return this.picturesStatus = Status.empty

      this.picturesStatus = Status.loaded
    })
  }

  delete(picture: Picture) {

    const dialog = this.dialog.open(ConfirmComponent,
      {
        data:
        {
          title: "Delete picture?",
          text: "Are you sure you want to delete this picture?",
          confirm: "Delete",
          cancel: "Cancel"
        }
      })

    dialog.componentInstance.acceptEvent.subscribe(() => {
      this.picturesService.deletePicture(picture).subscribe(() => {
        this.gePictures()
      })
    })


  }

  ownerDetails(userId) {
    
    if(this.ref instanceof MatDialogRef)
      this.ref.close();
    else
      this.ref.dismiss();

    this.router.navigate(["account/" + userId])
  }

  loadInfo() {

    this.currentStatus = Status.loaded
    const myId = this.userService.loggedUser.id
    this.gePictures();
    if (this.petInfo.ownerId == myId)
      this.owner = true;
  }

}


