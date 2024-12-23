import { Injectable } from '@angular/core';
import { Observable, Subject } from 'rxjs';

export declare type Loader = { 
  loaded: boolean
};

@Injectable({
  providedIn: 'root'
})
export class LoaderService {

  private _subject = new Subject<Loader>(); // Subject para emitir el estado del cargador

  /**
   * Observable para suscribirse a los cambios del estado del cargador
   */
  get loader$(): Observable<Loader> {
    return this._subject.asObservable();
  }

  /**
   * Inicia el indicador de carga
   */
  start(): void {
    this._subject.next(<Loader>{ loaded: true }); // Emite el estado de "cargando"
  }

  /**
   * Finaliza el indicador de carga
   */
  complete(): void {
    this._subject.next(<Loader>{ loaded: false }); // Emite el estado de "no cargando"
  }
  
}

