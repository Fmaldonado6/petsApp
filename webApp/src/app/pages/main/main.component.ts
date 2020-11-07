import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-main',
  templateUrl: './main.component.html',
  styleUrls: ['./main.component.css']
})
export class MainPage implements OnInit {
  Status = Status;

  currentStatus = Status.loaded

  constructor() { }

  ngOnInit(): void {
  }

}

enum Status {
  loading = 0,
  loaded,
  error
}