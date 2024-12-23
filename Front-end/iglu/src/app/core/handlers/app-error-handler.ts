import { ErrorHandler, Injectable, inject } from "@angular/core";
import { IMessage } from "../models/i-message";
import { AppMessageService } from "../services/app-message.service";
import { environment } from "../../../environments/environment";

@Injectable({ providedIn: 'root' })
export class AppErrorHandler implements ErrorHandler {
  private _service = inject(AppMessageService); // Servicio para mostrar mensajes de error
  private lastErrorMessage: string | null = null; // Almacena el último mensaje de error mostrado

  /**
   * Maneja los errores globalmente
   * @param error Error capturado por Angular
   */
  handleError(error: any): void {
    let message: IMessage; // Mensaje de error que será mostrado

    // Si el error es una promesa rechazada, se extrae el error interno
    if (error.rejection) {
      error = error.rejection;
    }

    // Procesa diferentes estructuras de error para extraer el mensaje
    if (error.body) {
      if (error.body.message) {
        message = { text: error.body.message, num: error.status };
      } else if (error.body.error) {
        message = { text: error.body.error, num: error.status };
      } else {
        message = error.status === 0
          ? { text: $localize`:@@serviceConnectionError:Error al conectarse al servicio`, num: error.status }
          : { text: error.body, num: error.status };
      }
    } else if (error.message) {
      message = { text: error.message, num: error.status };
    } else if (error.error) {
      message = { text: error.error, num: error.status };
    } else {
      message = { text: error, num: error.status };
    }

    // Evita mostrar mensajes de error repetidos consecutivamente
    if (message.text === this.lastErrorMessage) {
      return;
    }

    this.lastErrorMessage = message.text; // Actualiza el último mensaje mostrado

    // Muestra el error en consola en modo desarrollo
    if (!environment.production) {
      console.log(error);
    }

    // Llama al servicio para mostrar el mensaje de error en la interfaz
    setTimeout(() => this._service?.showMessage(message), 0);
  }
}

