import { HttpInterceptorFn } from '@angular/common/http';
import { LoaderService } from '../services/loader.service';
import { inject } from '@angular/core';
import { catchError, finalize, throwError } from 'rxjs';

export const appHttpInterceptor: HttpInterceptorFn = (req, next) => {
  const _loader = inject(LoaderService); // Servicio para manejar el estado del indicador de carga

  _loader.start(); // Inicia el indicador de carga antes de enviar la solicitud

  return next(req).pipe(
    // Captura errores de la solicitud HTTP
    catchError((error) => {
      console.error('HTTP Error:', error); // Log del error para depuración
      return throwError(() => error); // Lanza el error para ser manejado externamente
    }),

    // Finaliza el indicador de carga al completar la solicitud
    finalize(() => _loader.complete())
  );
};
