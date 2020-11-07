import { PetsService } from './../../services/api/pets/pets.service';
import { Component, OnInit } from '@angular/core';
import { Pet } from 'src/app/shared/models/dataModels';

@Component({
  selector: 'app-main',
  templateUrl: './main.component.html',
  styleUrls: ['./main.component.css']
})
export class MainPage implements OnInit {
  Status = Status;

  currentStatus = Status.loading

  pets: Pet[]

  constructor(private petsService: PetsService) {
    this.getPets();
  }

  ngOnInit(): void {

  }

  getPets() {
    this.petsService.getPets().subscribe(pets => {
      this.pets = pets;

      if (this.pets.length == 0)
        return this.currentStatus = Status.empty

      this.currentStatus = Status.loaded

    })
  }

}

enum Status {
  loading = 0,
  loaded,
  error,
  empty
}