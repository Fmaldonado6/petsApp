import { InfoPetComponent } from './../../components/modals/pets/info-pet/info-pet.component';
import { MatBottomSheet } from '@angular/material/bottom-sheet';
import { MatDialog } from '@angular/material/dialog';
import { PetsService } from './../../services/api/pets/pets.service';
import { Component, OnInit } from '@angular/core';
import { Pet } from 'src/app/shared/models/dataModels';
import { Status } from 'src/app/shared/models/Status';
import { StackConfig } from 'angular2-swing';
import { Router } from '@angular/router';

const RIGHT = "Symbol(RIGHT)"
const LEFT = "Symbol(LEFT)"

@Component({
  selector: 'app-main',
  templateUrl: './main.component.html',
  styleUrls: ['./main.component.css']
})
export class MainPage implements OnInit {
  Status = Status;
  Math = Math
  currentStatus = Status.loading
  like = false;
  dislike = false;
  pets: Pet[]
  currentPet = 0
  stackConfig: StackConfig;
  constructor(
    private petsService: PetsService,
    private dialog: MatDialog,

    private bottomSheet: MatBottomSheet
  ) {
    this.getPets();
    this.stackConfig = {

      minThrowOutDistance: 2000
    };
  }

  ngOnInit(): void {

  }

  getPets() {
    this.currentStatus = Status.loading
    this.petsService.getPets().subscribe(pets => {
      this.pets = pets;
      if (this.pets.length == 0)
        return this.currentStatus = Status.empty

      this.currentPet = this.pets.length - 1
      this.currentStatus = Status.loaded

    })
  }

  openInfo() {
    let width = window.innerWidth

    if (width < 700) {
      const dialog = this.bottomSheet.open(InfoPetComponent)
      dialog.instance.petInfo = this.pets[this.currentPet]
    } else {
      const dialog = this.dialog.open(InfoPetComponent)
      dialog.componentInstance.petInfo = this.pets[this.currentPet]
    }

  }

  signOut() {

  }

  removeLikeDislike() {
    this.like = false;
    this.dislike = false
  }

  addLikeDislike(event) {

    if (Math.abs(event.offset) < 20)
      return;

    if (event.offset > 0) {
      this.like = true;
      this.dislike = false

    }
    else {
      this.dislike = true
      this.like = false
    }
  }

  throw(element) {


    if (element.throwDirection.toString() == RIGHT)
      this.pets[this.currentPet].likes++;
    else
      this.pets[this.currentPet].dislikes++;

    this.petsService.updatePet(this.pets[this.currentPet]).subscribe(pet => {

      if (this.currentPet > 0)
        this.currentPet--
      else
        this.getPets();
    })
    element.target.remove()
  }

}

