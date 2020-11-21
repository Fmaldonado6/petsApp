import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { Component, OnInit, Output, EventEmitter, Inject } from '@angular/core';

class ModalData {
  title: string
  text: string
  confirm: string
  cancel: string = "Cancel"
}

@Component({
  selector: 'app-confirm',
  templateUrl: './confirm.component.html',
  styleUrls: ['./confirm.component.css']
})
export class ConfirmComponent implements OnInit {
  @Output() acceptEvent = new EventEmitter();

  constructor(private dialogRef: MatDialogRef<ConfirmComponent>, @Inject(MAT_DIALOG_DATA) public modalData: ModalData) { }

  ngOnInit() {
  }

  accept() {
    this.acceptEvent.emit()
    this.closeDialog();
  }

  closeDialog() {
    this.dialogRef.close();
  }
}