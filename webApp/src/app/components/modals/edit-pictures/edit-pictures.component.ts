import { MatDialog } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { environment } from 'src/environments/environment';
import { Picture } from './../../../shared/models/dataModels';
import { Status } from 'src/app/shared/models/Status';
import { User, Pet } from 'src/app/shared/models/dataModels';
import { PicturesService } from 'src/app/services/api/pictures/pictures.service';
import { Component, Input, OnInit, Output, EventEmitter } from '@angular/core';
import { ChangeDetectorRef } from '@angular/core';
import { ConfirmComponent } from '../confirm/confirm.component';

@Component({
  selector: 'edit-pictures',
  templateUrl: './edit-pictures.component.html',
  styleUrls: ['./edit-pictures.component.css']
})
export class EditPicturesComponent implements OnInit {

  @Input() pet: Pet;
  @Input() owner: User;
  @Output() pictureSelected = new EventEmitter();
  @Output() backPressed = new EventEmitter();
  @Input() showBackIcon = true;
  baseUrl = environment.base_url
  Status = Status;
  pictures: Picture[] = []
  currentStatus = Status.loading
  constructor(private picturesService: PicturesService,
    private changeDetector: ChangeDetectorRef,
    private snackBar: MatSnackBar,
    private dialog: MatDialog
  ) {
  }

  ngOnInit(): void {
    this.getPictures();
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
        this.getPictures()
      })
    })
  }

  selectPicture(picture: Picture) {
    this.pictureSelected.emit(picture);
  }

  backButtonPressed() { this.backPressed.emit() }

  uploadPicture(event) {

    if (!event.target.files || !event.target.files[0])
      return

    this.currentStatus = Status.loading

    let pictureData = event.target.files[0]

    const fd = new FormData();

    fd.append('file', pictureData)
    fd.append('petId', this.pet.id)
    fd.append('extension', pictureData.name.split('.').pop())

    this.picturesService.addPicture(fd).subscribe(pic => {
      this.snackBar.open("Picture uploaded!", "CLOSE", { duration: 2000 });
      this.getPictures();

    }, () => {
      this.snackBar.open("Couldn´t upload profile picture!", "CLOSE", { duration: 2000 });
    })


  }

  getPictures() {
    this.currentStatus = Status.loading;

    this.picturesService.getPetPictures(this.pet.id).subscribe(pictures => {
      this.pictures = pictures;
      this.currentStatus = Status.loaded
      this.changeDetector.detectChanges()
    }, (e) => {
      this.currentStatus = Status.error
      this.changeDetector.detectChanges()

    })
  }

}
