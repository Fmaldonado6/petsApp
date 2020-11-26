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
    [Types.badRequest]: "#ef5350"
  }

  colors = {
    [Types.success]: " rgb(111, 204, 111)",
    [Types.badRequest]: "#ef5350"
  }

  icons = {
    [Types.success]: "done",
    [Types.badRequest]: "close"
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
