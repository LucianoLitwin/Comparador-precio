import { Injectable } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MessageDialogComponent } from '../layout/message-dialog/message-dialog.component';
import { IMessage } from '../models/i-message';

@Injectable()
export class AppMessageService {
  private isDialogOpen = false; // Indica si hay un diálogo abierto actualmente

  constructor(private dialog: MatDialog) { }

  /**
   * Muestra un mensaje en un diálogo modal
   * @param message Objeto con el mensaje que se desea mostrar
   */
  showMessage(message: IMessage): void {
    if (this.isDialogOpen) {
      return; // Evita abrir múltiples diálogos simultáneamente
    }

    this.isDialogOpen = true; // Marca que el diálogo está abierto

    const dialogRef = this.dialog.open(MessageDialogComponent, {
      data: { message }, // Pasa el mensaje al componente del diálogo
    });

    // Restablece el estado al cerrar el diálogo
    dialogRef.afterClosed().subscribe(() => {
      this.isDialogOpen = false;
    });
  }
}

