import { Component, Input, OnInit } from '@angular/core';

@Component({
  selector: 'empty',
  templateUrl: './empty.component.html',
  styleUrls: ['./empty.component.css']
})
export class EmptyComponent implements OnInit {
  @Input() icon = "help_outline";
  @Input() text;

  constructor() { }

  ngOnInit(): void {
  }

}
