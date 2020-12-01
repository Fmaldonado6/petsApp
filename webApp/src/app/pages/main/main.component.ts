import { MatSnackBar } from '@angular/material/snack-bar';
import { ConfirmComponent } from './../../components/modals/confirm/confirm.component';
import { InfoPetComponent } from './../../components/modals/pets/info-pet/info-pet.component';
import { MatBottomSheet } from '@angular/material/bottom-sheet';
import { MatDialog } from '@angular/material/dialog';
import { PetsService } from './../../services/api/pets/pets.service';
import { Component, OnInit } from '@angular/core';
import { Pet, Report } from 'src/app/shared/models/dataModels';
import { Status } from 'src/app/shared/models/Status';
import { StackConfig } from 'angular2-swing';
import { Router } from '@angular/router';
import { ReportsService } from 'src/app/services/api/reports/reports.service';
import { environment } from 'src/environments/environment';

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
  currentStatus = Status.error
  like = false;
  dislike = false;
  pets: Pet[]
  baseUrl = environment.base_url

  currentPet = 0
  stackConfig: StackConfig;
  constructor(
    private petsService: PetsService,
    private dialog: MatDialog,
    private reportsService: ReportsService,
    private bottomSheet: MatBottomSheet,
    private snackBar: MatSnackBar
  ) {
    this.getPets();
    this.stackConfig = {

      minThrowOutDistance: 2000
    };
  }

  ngOnInit(): void {
    let first = localStorage.getItem("first-time");

    if (first == null)
      return

    localStorage.setItem("first-time", "true");
    this.snackBar.open("Swipe right to like, left to dislike", "OK", { duration: 4000 })
  }

  getPets() {
    this.currentStatus = Status.loading
    this.petsService.getPets().subscribe(pets => {
      this.pets = pets;
      if (this.pets.length == 0)
        return this.currentStatus = Status.empty

      this.currentPet = this.pets.length - 1
      this.currentStatus = Status.loaded

    }, () => {
      this.currentStatus = Status.error
    })
  }

  openInfo() {
    let width = window.innerWidth

    if (width < 700) {
      const dialog = this.bottomSheet.open(InfoPetComponent)
      dialog.instance.petInfo = this.pets[this.currentPet]
      dialog.instance.ref = dialog;
    } else {
      const dialog = this.dialog.open(InfoPetComponent)
      dialog.componentInstance.petInfo = this.pets[this.currentPet]
      dialog.componentInstance.ref = dialog;
    }

  }

  openReport(e) {
    e.stopPropagation();
    const dialog = this.dialog.open(ConfirmComponent, {
      data: {
        title: "Report pet",
        text: "Would you like to report this pet?",
        confirm: "Report",
        cancel: "Cancel"
      },
    });

    dialog.componentInstance.acceptEvent.subscribe(() => {
      let report = new Report();
      report.petId = this.pets[this.currentPet].id;
      report.petname = this.pets[this.currentPet].name;
      report.userId = this.pets[this.currentPet].ownerId;
      report.username = this.pets[this.currentPet].owner.name;
      report.pictureId = this.pets[this.currentPet].profilePictureId;
      report.picture = this.pets[this.currentPet].profilePicture.picture;

      this.reportsService.addReport(report).subscribe(() => {
        this.getPets();
      }, () => {
        this.getPets();
        this.snackBar.open("Couldn´t create report!", "CLOSE", { duration: 2000 });
      });



    })
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

