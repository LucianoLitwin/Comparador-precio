import { Injectable, signal } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { catchError, Observable, tap, throwError } from 'rxjs';
import { environment } from '../../../environments/environment.development';
import { LoaderService } from '../../core/services/loader.service';
import { AppErrorHandler } from '../../core/handlers/app-error-handler'; // Manejador de errores
import { PrecioComparado } from '../models/precioComparado.model';

@Injectable({
    providedIn: 'root',
})
export class PriceComparisonService {
    private apiUrl = `${environment.apiUrl}indec/precios-comparados`; // URL de la API para precios comparados
    preciosComparados = signal<PrecioComparado[]>([]); // Signal para almacenar los precios comparados

    constructor(
        private http: HttpClient,
        private loaderService: LoaderService, // Servicio para manejar el indicador de carga
        private errorHandler: AppErrorHandler // Servicio para manejar errores
    ) { }

    /**
     * Inicia el indicador de carga
     */
    private startLoading(): void {
        this.loaderService.start();
    }

    /**
     * Finaliza el indicador de carga
     */
    private completeLoading(): void {
        this.loaderService.complete();
    }

    /**
     * Maneja errores utilizando el manejador global
     * @param error Error recibido
     * @returns Observable con el error
     */
    private handleError(error: any): Observable<never> {
        this.errorHandler.handleError(error);
        this.completeLoading();
        return throwError(() => error);
    }

    /**
     * Obtiene precios comparados desde la API
     * @param codigosBarra Lista de códigos de barras
     * @param localidad Número de la localidad
     * @returns Observable con la lista de precios comparados
     */
    getPreciosComparados(codigosBarra: string[], localidad: number): Observable<PrecioComparado[]> {
        const requestBody = {
            nroLocalidad: localidad, // Número de la localidad para la consulta
            codigosBarra: codigosBarra // Lista de códigos de barras de productos
        };

        const headers = new HttpHeaders({
            'Content-Type': 'application/json',
        });

        console.log("nroLocalidad: ", requestBody.nroLocalidad);
        console.log("codigosBarra: ", requestBody.codigosBarra);

        this.startLoading();

        return this.http.post<PrecioComparado[]>(this.apiUrl, requestBody, { headers }).pipe(
            tap((response) => {
                console.log('Respuesta de precios comparados:', response); // Log de la respuesta
                this.preciosComparados.set(response); // Actualiza el signal con la respuesta
            }),
            tap(() => this.completeLoading()), // Finaliza el indicador de carga
            catchError(this.handleError.bind(this)) // Manejo de errores
        );
    }
}
