import { Types } from './../../info-menu/info-menu.component';
import { BadInput } from './../../../../shared/errors/errors';
import { Status } from './../../../../shared/models/Status';
import { PetsService } from './../../../../services/api/pets/pets.service';
import { PicturesService } from './../../../../services/api/pictures/pictures.service';
import { Pet, Picture, User } from './../../../../shared/models/dataModels';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { ChangeDetectorRef, Component, Inject, Input, OnInit, Output, EventEmitter } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { MAT_BOTTOM_SHEET_DATA, MatBottomSheetRef } from '@angular/material/bottom-sheet';

interface ModalData {
  user: User
}

@Component({
  selector: 'app-add-pet',
  templateUrl: './add-pet.component.html',
  styleUrls: ['./add-pet.component.css']
})
export class AddPetModal implements OnInit {
  Status = Status
  currenStatus = Status.loaded
  form: FormGroup;
  pet: Pet = new Pet;
  hasPicture = false;
  Types = Types;
  profilePicture: Picture;
  pictureData: any
  @Input() ref: any
  @Input() data: ModalData
  @Output() petAdded = new EventEmitter();
  constructor(
    private pictureService: PicturesService,
    private petsService: PetsService,
    private changeDetector: ChangeDetectorRef
  ) {
  }

  setProfilePicture(event) {
    if (!event.target.files || !event.target.files[0])
      return


    this.hasPicture = true;

    let reader = new FileReader();

    this.pictureData = event.target.files[0]

    reader.onload = (e) => {
      this.profilePicture = new Picture();
      this.profilePicture.picture = e.target.result as string;
      this.changeDetector.detectChanges();
    }

    reader.readAsDataURL(event.target.files[0])


  }

  ngOnInit(): void {

    this.form = new FormGroup({
      name: new FormControl('', [
        Validators.required,
      ]),
      species: new FormControl('', [
        Validators.required,
      ]),
      breed: new FormControl('', [
      ]),
      age: new FormControl(null, [
        Validators.required,
      ]),
      gender: new FormControl('', [
      ]),
      description: new FormControl('', [
      ]),

    });
  }

  addPet(value) {
    this.pet.name = value.name;
    this.pet.breed = value.breed;
    this.pet.ownerId = this.data.user.id;
    this.pet.age = value.age;
    this.pet.description = value.description;
    this.pet.type = value.species
    this.pet.gender = value.gender;


    this.currenStatus = Status.loading
    this.petsService.addPets(this.pet).subscribe(pet => {

      if (this.pictureData != null)
        this.saveProfilePicture(pet)
      else {
        this.currenStatus = Status.completed
        this.changeDetector.detectChanges();
        this.petAdded.emit();
      }


    }, () => {
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

      this.petsService.deletePet(pet).subscribe();

      if (e instanceof BadInput)
        return this.currenStatus = Status.badInput

      this.currenStatus = Status.error

    })
  }

}
