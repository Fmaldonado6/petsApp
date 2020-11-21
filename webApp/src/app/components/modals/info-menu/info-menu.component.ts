import { Component, Input, OnInit, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'info-menu',
  templateUrl: './info-menu.component.html',
  styleUrls: ['./info-menu.component.css']
})
export class InfoMenuComponent implements OnInit {
  @Input() type = Types.success
  @Input() title = "Completed!";
  @Input() accept = "Accept"
  @Output() clickEvent = new EventEmitter();
  buttonColors = {
    [Types.success]: "rgb(81, 182, 81)",
    [Types.badRequest]: "cancel"
  }

  colors = {
    [Types.success]: " rgb(111, 204, 111)",
    [Types.badRequest]: "cancel"
  }

  icons = {
    [Types.success]: "done",
    [Types.badRequest]: "cancel"
  }

  buttonClicked() { this.clickEvent.emit() }

  constructor() { }

  ngOnInit(): void {
  }

}
export enum Types {
  success,
  badRequest
}
