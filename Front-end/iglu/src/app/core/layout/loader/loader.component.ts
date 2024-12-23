import { Component } from '@angular/core';
import { Subscription } from 'rxjs';
import { Loader, LoaderService } from '../../services/loader.service';

@Component({
  selector: 'app-loader',
  templateUrl: './loader.component.html',
  styleUrls: ['./loader.component.css']
})
export class LoaderComponent {

  private _subscription!: Subscription; // Suscripción al estado del cargador
  private _loaded: boolean = false; // Estado de carga actual

  constructor(private _service: LoaderService) { }

  /**
   * Inicializa el componente y suscribe al observable del servicio de carga
   */
  ngOnInit(): void {
    this._subscription = this._service.loader$.subscribe((ref: Loader) => {
      this._loaded = ref.loaded; // Actualiza el estado de carga
    });
  }

  /**
   * Se ejecuta al destruir el componente para liberar recursos
   */
  ngOnDestroy(): void {
    this._subscription.unsubscribe(); // Cancela la suscripción para evitar fugas de memoria
  }

  /**
   * Devuelve el estado actual del cargador
   * @returns True si el cargador está activo, False en caso contrario
   */
  get loaded(): boolean {
    return this._loaded;
  }

}
