import { environment } from 'src/environments/environment';
import { MatDialogRef } from '@angular/material/dialog';
import { MatBottomSheetRef } from '@angular/material/bottom-sheet';
import { Pet, Picture } from 'src/app/shared/models/dataModels';
import { ChangeDetectorRef, Component, EventEmitter, OnInit, Output } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';
import { PetsService } from 'src/app/services/api/pets/pets.service';
import { PicturesService } from 'src/app/services/api/pictures/pictures.service';
import { BadInput } from 'src/app/shared/errors/errors';
import { Status } from 'src/app/shared/models/Status';
import { Types } from '../../info-menu/info-menu.component';

@Component({
  selector: 'app-edit-pet',
  templateUrl: './edit-pet.component.html',
  styleUrls: ['./edit-pet.component.css']
})
export class EditPetComponent implements OnInit {
  baseUrl = environment.base_url
  petInfo: Pet = new Pet();
  ref: MatBottomSheetRef | MatDialogRef<EditPetComponent>
  Status = Status
  Pages = Pages;
  currentPage = Pages.main
  currenStatus = Status.loading
  form: FormGroup;
  hasPicture = false;
  Types = Types;
  profilePicture: Picture;
  pictureData: any
  @Output() petAdded = new EventEmitter();
  constructor(
    private pictureService: PicturesService,
    private petsService: PetsService,
    private changeDetector: ChangeDetectorRef
  ) {
  }

  changePage(status: number) {
    this.currentPage = status;
  }

  ngOnInit(): void {

    this.form = new FormGroup({
      name: new FormControl(this.petInfo.name, [
        Validators.required,
      ]),
      species: new FormControl(this.petInfo.type, [
        Validators.required,
      ]),
      breed: new FormControl(this.petInfo.breed, [
      ]),
      age: new FormControl(this.petInfo.age, [
        Validators.required,
      ]),
      gender: new FormControl(this.petInfo.gender, [
      ]),
      description: new FormControl(this.petInfo.description, [
      ]),

    });

    this.hasPicture = this.petInfo.profilePicture != null

    this.currenStatus = Status.loaded
  }

  changeProfilePicture(picture: Picture) {
    this.currentPage = Pages.main
    this.petInfo.profilePicture = picture;
    this.petInfo.profilePictureId = picture.id;
  }

  ngAfterViewInit() {


  }

  updatePet(value) {
    this.petInfo.name = value.name;
    this.petInfo.breed = value.breed;
    this.petInfo.ownerId = this.petInfo.owner.id;
    this.petInfo.age = value.age;
    this.petInfo.description = value.description;
    this.petInfo.type = value.species
    this.petInfo.gender = value.gender;


    this.currenStatus = Status.loading

    this.petsService.updatePet(this.petInfo).subscribe(pet => {
      this.currenStatus = Status.completed
      this.changeDetector.detectChanges();
      this.petAdded.emit();

    }, (e) => {
      console.log(e)
      this.currenStatus = Status.error

    })


  }

  close() {
    if (this.ref instanceof MatDialogRef)
      this.ref.close()
    else
      this.ref.dismiss()

  }

  saveProfilePicture(pet: Pet) {
    const fd = new FormData();
    fd.append('file', this.pictureData)
    fd.append('petId', pet.id)
    fd.append('extension', this.pictureData.name.split('.').pop())
    this.pictureService.addPicture(fd).subscribe(e => {
      pet.profilePictureId = e.id;

      this.petsService.updatePet(pet).subscribe(petUpdated => {
        this.currenStatus = Status.completed;
        this.petAdded.emit();
        this.changeDetector.detectChanges();

      })

    }, (e) => {

      if (e instanceof BadInput)
        return this.currenStatus = Status.badInput

      this.currenStatus = Status.error

    })
  }

}

enum Pages {
  main,
  pictures
}