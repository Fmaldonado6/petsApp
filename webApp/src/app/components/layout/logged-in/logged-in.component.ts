import { Component, OnInit, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'logged-in',
  templateUrl: './logged-in.component.html',
  styleUrls: ['./logged-in.component.css']
})
export class LoggedInComponent implements OnInit {

  @Output() signOutEvent = new EventEmitter();
  constructor() { }

  ngOnInit(): void {
  }

  signOut(){
    this.signOutEvent.emit();
  }
  
}
