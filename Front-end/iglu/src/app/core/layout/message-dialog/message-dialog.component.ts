import { Component, Inject } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { MatIconModule } from '@angular/material/icon'; // Importa MatIconModule
import { CommonModule } from '@angular/common';
import { IMessage } from '../../models/i-message';

@Component({
  selector: 'app-message-dialog',
  templateUrl: './message-dialog.component.html',
  styleUrls: ['./message-dialog.component.css'],
  standalone: true, // Es standalone
  imports: [CommonModule, MatIconModule], // Importa MatIconModule aquí
})
export class MessageDialogComponent {
  /**
   * Mensaje a mostrar en el diálogo. Este no debe ser null o undefined.
   */
  message: IMessage;

  constructor(
    public dialogRef: MatDialogRef<MessageDialogComponent>, // Referencia al diálogo para controlarlo
    @Inject(MAT_DIALOG_DATA) public data: { message: IMessage } // Datos inyectados en el diálogo
  ) {
    this.message = data.message; // Asigna el mensaje desde los datos proporcionados
  }

  /**
   * Cierra el diálogo actual
   */
  close(): void {
    this.dialogRef.close();
  }
}

