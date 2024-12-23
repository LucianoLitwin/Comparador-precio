import { Component, Inject } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';

@Component({
  selector: 'app-app-message-modal',
  standalone: true,
  imports: [],
  templateUrl: './app-message-modal.component.html',
  styleUrls: ['./app-message-modal.component.css']
})
export class AppMessageModalComponent {
  message: string;

  constructor(
    public dialogRef: MatDialogRef<AppMessageModalComponent>,
    @Inject(MAT_DIALOG_DATA) public data: { text: string; num: number }
  ) {
    this.message = `${data.num}: ${data.text}`;
  }

  close(): void {
    this.dialogRef.close();
  }
}
