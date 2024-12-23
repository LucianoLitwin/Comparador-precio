import { Component, Inject, OnInit, QueryList, ViewChild, ViewChildren } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogModule } from '@angular/material/dialog';
import { Sucursal } from '../../api/models/sucursal.model';
import { CommonModule } from '@angular/common';
import { GoogleMapsModule, MapInfoWindow, MapMarker } from '@angular/google-maps';

@Component({
  selector: 'app-map-modal-supermercado',
  standalone: true,
  imports: [CommonModule, MatDialogModule, GoogleMapsModule],
  templateUrl: './map-modal-supermercado.component.html',
  styleUrls: ['./map-modal-supermercado.component.css'],
})
export class MapModalSupermercadoComponent implements OnInit {
  @ViewChild(MapInfoWindow, { static: false }) infoWindow!: MapInfoWindow; // Referencia a la ventana de información del mapa
  @ViewChildren(MapMarker) markers!: QueryList<MapMarker>; // Lista de marcadores en el mapa

  mapPoints: any[] = []; // Puntos a mostrar en el mapa
  center: google.maps.LatLngLiteral = { lat: -38.4161, lng: -63.6167 }; // Coordenadas iniciales (Argentina)
  zoom: number = 4; // Nivel de zoom inicial
  infoContent: string = ''; // Contenido mostrado en la ventana de información

  constructor(@Inject(MAT_DIALOG_DATA) public data: { sucursales: Sucursal[] }) { }

  /**
   * Inicializa el componente, configurando el mapa y sus puntos
   */
  ngOnInit(): void {
    const sucursales = this.data.sucursales; // Sucursales proporcionadas como datos al modal

    if (sucursales.length > 0) {
      // Centra el mapa en la primera sucursal
      const firstSucursal = sucursales[0];
      this.center = {
        lat: firstSucursal.coord_latitud,
        lng: firstSucursal.coord_longitud,
      };
      this.zoom = 10; // Ajusta el zoom para la vista de sucursales

      // Configura los puntos del mapa basándose en las sucursales
      this.mapPoints = sucursales.map((sucursal) => ({
        title: sucursal.nom_sucursal,
        position: { lat: sucursal.coord_latitud, lng: sucursal.coord_longitud },
        info: `
          <h5>${$localize`:@@sucursal: Sucursal:`} ${sucursal.razon_social} ${sucursal.nro_sucursal}</h5>
          <h5>${$localize`:@@direccion: Dirección:`} ${sucursal.calle} ${sucursal.nro_calle}</h5>
          <p>${$localize`:@@telefono: Teléfono:`} ${sucursal.telefono}</p>
          <p>${$localize`:@@horario: Horario:`} ${sucursal.horario_sucursal}</p>
        `,
      }));

      console.log("Puntos del mapa configurados:", this.mapPoints);
    } else {
      console.warn($localize`:@@no-sucursales:No se encontraron sucursales para mostrar.`);
    }
  }

  /**
   * Abre la ventana de información para un marcador específico
   * @param windowIndex Índice del marcador en la lista
   * @param content Contenido HTML para mostrar en la ventana
   */
  openInfoWindow(windowIndex: number, content: string): void {
    this.markers.forEach((marker: MapMarker, ix: number) => {
      if (windowIndex === ix) {
        this.infoContent = content; // Establece el contenido de la ventana
        this.infoWindow.open(marker); // Abre la ventana en el marcador correspondiente
      }
    });
  }
}

