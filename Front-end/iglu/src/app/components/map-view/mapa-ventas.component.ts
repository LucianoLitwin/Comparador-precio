import { Component, OnInit, ViewChild, ViewChildren, QueryList } from '@angular/core';
import { GoogleMapsModule, MapInfoWindow, MapMarker } from '@angular/google-maps';
import { UbicationService } from '../../api/resources/ubication.service';
import { Localidad } from '../../api/models/localidad.model';
import { Provincia } from '../../api/models/provincia.model';
import { Sucursal } from '../../api/models/sucursal.model';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatButtonModule } from '@angular/material/button';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatIconModule } from '@angular/material/icon';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatTableModule } from '@angular/material/table';
import { CartService } from '../../api/services/cart.service';
import { Producto } from '../../api/models/producto.model';
import { FilterSucursalesPipe } from '../../pipes/filter-sucursales.pipe';


@Component({
  selector: 'app-mapa-ventas',
  templateUrl: './mapa-ventas.component.html',
  styleUrls: ['./mapa-ventas.component.css'],
  imports: [
    MatButtonModule, MatFormFieldModule, MatIconModule,
    MatSelectModule, MatToolbarModule, CommonModule, FormsModule,
    ReactiveFormsModule, MatInputModule, GoogleMapsModule, MatTooltipModule, MatTableModule, FilterSucursalesPipe
  ],
  standalone: true
})
export class MapaVentasComponent implements OnInit {
  @ViewChild(MapInfoWindow, { static: false }) infoWindow!: MapInfoWindow; // Referencia a la ventana de información del mapa
  @ViewChildren(MapMarker) markers!: QueryList<MapMarker>; // Lista de marcadores en el mapa

  points: any[] = []; // Puntos para el mapa
  mapPoints: any[] = []; // Puntos filtrados a mostrar en el mapa
  infoContent: string = ""; // Contenido de la ventana de información
  center: google.maps.LatLngLiteral = { lat: -38.4161, lng: -63.6167 }; // Centro inicial (Argentina)
  zoom = 4; // Nivel de zoom inicial

  provincias: Provincia[] = []; // Lista de provincias
  localidades: Localidad[] = []; // Lista de localidades
  sucursales: Sucursal[] = []; // Lista completa de sucursales
  filteredPoints: Sucursal[] = []; // Lista filtrada de sucursales

  selectedProvince: number | null = null; // Provincia seleccionada
  selectedLocalidad: number | null = null; // Localidad seleccionada

  barraBusqueda: string = ""; // Término de búsqueda para el filtro

  cartProducts!: () => Producto[]; // Productos en el carrito (señal reactiva)

  constructor(
    private dataService: UbicationService,
    private cartService: CartService,
  ) { }

  ngOnInit(): void {
    this.loadProvincias(); // Cargar lista de provincias al inicializar
    this.cartProducts = this.cartService.getCartProducts(); // Inicializar productos del carrito
  }

  /**
   * Determina si mostrar el botón de comparación
   * @returns True si hay productos en el carrito y una localidad seleccionada
   */
  showCompareButton(): boolean {
    return this.cartProducts().length > 0 && this.selectedLocalidad !== null;
  }

  /**
   * Carga la lista de provincias desde el servicio
   */
  loadProvincias(): void {
    this.dataService.getProvincias().subscribe({
      next: (provincias) => {
        this.provincias = provincias;
      },
      error: (error) => {
        console.error(`Error al cargar las provincias:`, error);
      }
    });
  }

  /**
   * Carga la lista de localidades para la provincia seleccionada
   */
  loadLocalidades(): void {
    if (this.selectedProvince !== null) {
      this.dataService.getLocalidades(this.selectedProvince).subscribe({
        next: (localidades) => {
          console.log(`LOCALIDADES recibidas:`, localidades);
          this.localidades = localidades;
        },
        error: (error) => {
          console.error(`Error al cargar las localidades:`, error);
        }
      });
    }
  }

  /**
   * Carga las sucursales para la localidad seleccionada y actualiza el mapa
   */
  loadSucursales(): void {
    if (this.selectedLocalidad !== null) {
      this.dataService.getSucursales(this.selectedLocalidad).subscribe({
        next: (sucursales) => {
          if (sucursales.length > 0) {
            const firstSucursal = sucursales[0];
            this.center = {
              lat: firstSucursal.coord_latitud,
              lng: firstSucursal.coord_longitud,
            };
            this.zoom = 10; // Ajusta el zoom para la vista de sucursales
          } else {
            this.center = { lat: -38.4161, lng: -63.6167 }; // Restaurar centro inicial
            this.zoom = 4; // Restaurar zoom inicial
          }

          this.sucursales = sucursales;
          this.updateMapPoints(); // Actualiza los puntos en el mapa
        },
        error: (error) => {
          console.error(`Error al cargar las sucursales:`, error);
        }
      });
    }
  }

  /**
   * Maneja el cambio de provincia seleccionada
   */
  onProvinceChange(): void {
    this.localidades = [];
    this.filteredPoints = [];
    this.mapPoints = [];
    this.selectedLocalidad = null;

    this.center = { lat: -38.4161, lng: -63.6167 }; // Restaurar centro inicial
    this.zoom = 4; // Restaurar zoom inicial

    if (this.selectedProvince !== null) {
      this.loadLocalidades();
    }
  }

  /**
   * Maneja el cambio de localidad seleccionada
   */
  onLocalidadChange(): void {
    this.filteredPoints = [];
    this.mapPoints = [];

    if (this.selectedLocalidad !== null) {
      this.loadSucursales();
    }
  }

  /**
   * Abre la ventana de información de un marcador específico
   * @param windowIndex Índice del marcador en la lista
   * @param content Contenido HTML a mostrar
   */
  openInfoWindow(windowIndex: number, content: string): void {
    this.markers.forEach((marker: MapMarker, ix: number) => {
      if (windowIndex === ix) {
        this.infoContent = content;
        this.infoWindow.open(marker);
      }
    });
  }

  /**
   * Maneja el cambio en el término de búsqueda
   */
  onSearchChange(): void {
    this.updateMapPoints();
  }

  /**
   * Obtiene las sucursales filtradas basado en el término de búsqueda
   */
  get filteredSucursales(): Sucursal[] {
    return new FilterSucursalesPipe().transform(this.sucursales, this.barraBusqueda);
  }

  /**
   * Actualiza los puntos a mostrar en el mapa basado en las sucursales filtradas
   */
  updateMapPoints(): void {
    const filtered = this.filteredSucursales;
    this.mapPoints = filtered.map((sucursal) => ({
      title: sucursal.nom_sucursal,
      position: { lat: sucursal.coord_latitud, lng: sucursal.coord_longitud },
      info: `
        <h5>Sucursal: ${sucursal.razon_social} ${sucursal.nro_sucursal}</h5>
        <h5>Dirección: ${sucursal.calle} ${sucursal.nro_calle}</h5>
        <p>Teléfono: ${sucursal.telefono}</p>
        <p>Horario: ${sucursal.horario_sucursal}</p>
      `,
    }));
  }
}


