import { Component, OnInit, Output, EventEmitter, Input } from '@angular/core';

@Component({
  selector: 'app-error',
  templateUrl: './error.component.html',
  styleUrls: ['./error.component.css']
})
export class ErrorComponent implements OnInit {

  @Output() clickEvent = new EventEmitter();
  @Input() color = "color: rgb(211, 211, 211)"
  constructor() { }

  ngOnInit(): void {
  }

  click(){
    this.clickEvent.emit()
  }

}
