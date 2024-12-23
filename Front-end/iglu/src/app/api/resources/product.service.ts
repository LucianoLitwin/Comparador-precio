import { Injectable, signal } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { catchError, Observable, tap, throwError } from 'rxjs';
import { Rubro } from '../models/rubro.model';
import { Categoria } from '../models/categoria.model';
import { Marca } from '../models/marca.model';
import { Producto } from '../models/producto.model';
import { environment } from '../../../environments/environment.development';
import { LoaderService } from '../../core/services/loader.service';
import { AppErrorHandler } from '../../core/handlers/app-error-handler'; // Importa el manejador de errores
import { ListadoProductos } from '../models/listadoProductos.model';
import { tipoProducto } from '../models/tipoProducto.model';

@Injectable({
  providedIn: 'root',
})
export class ProductService {
  private apiUrl = `${environment.apiUrl}`; // URL base de la API
  productos = signal<Producto[]>([]); // Signal para almacenar los productos

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
   * Obtiene los rubros desde la API
   * @returns Observable con la lista de rubros
   */
  getRubros(): Observable<Rubro[]> {
    const language = window.location.port === '4201' ? 'en' : 'es'; // Idioma basado en el puerto
    const headers = new HttpHeaders({ 'Accept-Language': language });
    this.startLoading();
    return this.http.get<Rubro[]>(`${this.apiUrl}indec/rubros`, { headers }).pipe(
      tap(() => this.completeLoading()),
      catchError(this.handleError.bind(this))
    );
  }

  /**
   * Obtiene las categorías según el rubro
   * @param nroRubro Lista de números de rubro
   * @returns Observable con la lista de categorías
   */
  getCategorias(nroRubro: number[]): Observable<Categoria[]> {
    const language = window.location.port === '4201' ? 'en' : 'es';
    const headers = new HttpHeaders({ 'Accept-Language': language });
    this.startLoading();

    return this.http.post<Categoria[]>(
      `${this.apiUrl}indec/categorias`,
      nroRubro, // Envío del array de rubros
      { headers }
    ).pipe(
      tap(() => this.completeLoading()),
      catchError(this.handleError.bind(this))
    );
  }

  /**
   * Obtiene los tipos de productos según la categoría
   * @param nroCategoria Lista de números de categoría
   * @returns Observable con los tipos de producto
   */
  getTiposProductos(nroCategoria: number[]): Observable<tipoProducto[]> {
    const language = window.location.port === '4201' ? 'en' : 'es';
    const headers = new HttpHeaders({ 'Accept-Language': language });
    this.startLoading();
    return this.http.post<tipoProducto[]>(
      `${this.apiUrl}indec/tiposProductos`,
      nroCategoria, // Envío del array de categorías
      { headers }
    ).pipe(
      tap(() => this.completeLoading()),
      catchError(this.handleError.bind(this))
    );
  }

  /**
   * Obtiene las marcas según el tipo de producto
   * @param nroTipoProducto Lista de números de tipo de producto
   * @returns Observable con las marcas
   */
  getMarcas(nroTipoProducto: number[]): Observable<Marca[]> {
    const language = window.location.port === '4201' ? 'en' : 'es';
    const headers = new HttpHeaders({ 'Accept-Language': language });
    this.startLoading();
    return this.http.post<Marca[]>(
      `${this.apiUrl}indec/marcas`,
      nroTipoProducto, // Envío del array de tipos de producto
      { headers }
    ).pipe(
      tap(() => this.completeLoading()),
      catchError(this.handleError.bind(this))
    );
  }

  /**
   * Obtiene los productos según un filtro
   * @param filter Objeto con los criterios de búsqueda
   * @returns Observable con el listado de productos
   */
  getProductos(filter: any): Observable<ListadoProductos> {
    const language = window.location.port === '4201' ? 'en' : 'es'; // Idioma basado en el puerto
    const headers = new HttpHeaders({ 'Accept-Language': language });
    console.log('Enviando solicitud a la API con el body:', filter);
    this.startLoading();

    return this.http.post<ListadoProductos>(`${this.apiUrl}indec/productos`, filter, { headers }).pipe(
      tap((response) => {
        console.log('Respuesta de la API:', response); // Log de la respuesta
        this.productos.set(response.productos); // Actualiza el signal con los productos recibidos
      }),
      tap(() => this.completeLoading()),
      catchError(this.handleError.bind(this))
    );
  }
}
