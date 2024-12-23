import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { Provincia } from '../models/provincia.model';
import { Localidad } from '../models/localidad.model';
import { Sucursal } from '../models/sucursal.model';
import { environment } from '../../../environments/environment.development';

@Injectable({
  providedIn: 'root',
})
export class UbicationService {
  private apiUrl = `${environment.apiUrl}`; // URL base de la API

  constructor(private http: HttpClient) { }

  /**
   * Obtiene la lista de provincias desde la API
   * @returns Observable con la lista de provincias
   */
  getProvincias(): Observable<Provincia[]> {
    console.log('Solicitando provincias desde:', `${this.apiUrl}/indec/provincias`);
    return this.http.get<Provincia[]>(`${this.apiUrl}indec/provincias`).pipe(
      catchError((error) => {
        return throwError(() => error); // Lanza el error al manejador global
      })
    );
  }

  /**
   * Obtiene la lista de localidades para una provincia específica
   * @param codProvincia Código de la provincia
   * @returns Observable con la lista de localidades
   */
  getLocalidades(codProvincia: number): Observable<Localidad[]> {
    return this.http
      .post<Localidad[]>(`${this.apiUrl}indec/localidades`, codProvincia, {
        headers: { 'Content-Type': 'application/json' },
      })
      .pipe(
        catchError((error) => {
          return throwError(() => error); // Lanza el error al manejador global
        })
      );
  }

  /**
   * Obtiene la lista de sucursales para una localidad específica y supermercado
   * @param nroLocalidad Número de la localidad
   * @param supermercado Nombre del supermercado (opcional)
   * @returns Observable con la lista de sucursales
   */
  getSucursales(nroLocalidad: number, supermercado: string = ''): Observable<Sucursal[]> {
    const payload = { nroLocalidad, supermercado }; // Cuerpo de la solicitud

    return this.http
      .post<Sucursal[]>(`${this.apiUrl}indec/sucursales`, payload, {
        headers: { 'Content-Type': 'application/json' },
      })
      .pipe(
        catchError((error) => {
          console.error('Error al obtener sucursales:', error);
          return throwError(() => error); // Lanza el error al manejador global
        })
      );
  }
}
