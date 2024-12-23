import { Component, OnDestroy, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatTableModule } from '@angular/material/table';
import { MatButtonModule } from '@angular/material/button';
import { FormsModule } from '@angular/forms';
import { CartService } from '../../api/services/cart.service';
import { PrecioComparado } from '../../api/models/precioComparado.model';
import { PriceComparisonService } from '../../api/resources/price.service';
import { MatStepperModule } from '@angular/material/stepper';
import { Producto } from '../../api/models/producto.model';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Provincia } from '../../api/models/provincia.model';
import { Localidad } from '../../api/models/localidad.model';
import { UbicationService } from '../../api/resources/ubication.service';
import { MatOption } from '@angular/material/core';
import { MatFormField, MatLabel, MatSelect } from '@angular/material/select';
import { MapModalSupermercadoComponent } from '../map-modal-supermercado/map-modal-supermercado.component';
import { Sucursal } from '../../api/models/sucursal.model';
import { MatDialog } from '@angular/material/dialog';

@Component({
  selector: 'app-comparador-precios',
  standalone: true,
  imports: [
    CommonModule,
    MatTableModule,
    MatButtonModule,
    FormsModule,
    MatStepperModule,
    MatButtonModule,
    CommonModule, FormsModule,
    MatTableModule, MatOption, MatSelect, MatLabel, MatFormField
  ],
  templateUrl: './comparador-precios.component.html',
  styleUrls: ['./comparador-precios.component.css'],
})
export class ComparadorPreciosComponent implements OnInit, OnDestroy {
  displayedColumns: string[] = []; // Columnas a mostrar en la tabla
  supermercados: string[] = []; // Lista de nombres de supermercados
  productos: Producto[] = []; // Lista de productos a mostrar en la tabla
  supermercadoImagenes: Map<string, string> = new Map(); // Mapa de imágenes por supermercado
  montosTotales: { [key: string]: { monto: string; esConveniente: boolean } } = {}; // Totales por supermercado

  provincias: Provincia[] = []; // Lista de provincias
  localidades: Localidad[] = []; // Lista de localidades

  selectedProvince: number | null = null; // Provincia seleccionada
  selectedLocalidad: number | null = null; // Localidad seleccionada

  supermercadoNoActualizado: string[] = []; // Lista de supermercados no actualizados

  mapPoints: any[] = []; // Puntos para el mapa
  center: google.maps.LatLngLiteral = { lat: -38.4161, lng: -63.6167 }; // Centro del mapa (Argentina)
  zoom = 4; // Nivel de zoom inicial

  supermercadoMasConveniente: string | null = null; // Supermercado más conveniente

  constructor(
    private dataService: UbicationService,
    private cartService: CartService,
    private priceComparisonService: PriceComparisonService,
    private snackBar: MatSnackBar,
    private dialog: MatDialog,
  ) { }

  ngOnInit(): void {
    const dialogRef = history.state.dialogRef; // Recuperar el modal si está abierto
    if (dialogRef) {
      dialogRef.close();
    }
    this.loadProvincias(); // Cargar provincias al inicializar
  }

  ngOnDestroy(): void {
    this.snackBar.dismiss(); // Cerrar snackBars abiertos al destruir
  }

  /**
   * Genera la tabla con los precios comparados
   */
  generateTable(): void {
    if (this.selectedLocalidad !== null) {
      const cartProducts = this.cartService.getCartProducts()();
      const codigosBarra = cartProducts.map((product) => product.cod_barra);

      if (codigosBarra.length > 0) {
        this.priceComparisonService.getPreciosComparados(codigosBarra, this.selectedLocalidad).subscribe({
          next: (data) => {
            this.procesarDatos(data);
            this.mostrarMontosTotales(data);
          },
          error: (error) => {
            console.error($localize`Error al obtener precios comparados:`, error);
          },
        });
      } else {
        this.snackBar.open($localize`El carrito está vacío, por favor agrega productos.`, $localize`Cerrar`);
      }
    } else {
      this.snackBar.open($localize`Por favor, selecciona una localidad primero.`, $localize`Cerrar`);
    }
  }

  /**
   * Carga la lista de provincias desde el servicio
   */
  loadProvincias(): void {
    this.dataService.getProvincias().subscribe({
      next: (provincias: Provincia[]) => {
        this.provincias = provincias;
      },
      error: (error) => {
        console.error('Error loading provincias:', error);
      }
    });
  }

  /**
   * Maneja el cambio de provincia
   */
  onProvinceChange(): void {
    this.selectedLocalidad = null;
    this.snackBar.dismiss();
    if (this.selectedProvince !== null) {
      this.loadLocalidades();
    }
  }

  /**
   * Carga localidades según la provincia seleccionada
   */
  loadLocalidades(): void {
    if (this.selectedProvince !== null) {
      this.dataService.getLocalidades(this.selectedProvince).subscribe({
        next: (localidades) => {
          console.log("LOCALIDADES recibidas:", localidades);
          this.localidades = localidades;
        },
        error: (error) => {
          console.error('Error loading localidades:', error);
        }
      });
    }
  }

  /**
   * Maneja el cambio de localidad
   */
  onLocalidadesChange(): void {
    if (this.selectedLocalidad !== null) {
      this.generateTable();
    }
  }

  /**
   * Procesa los datos de precios comparados
   * @param data Lista de precios comparados
   */
  procesarDatos(data: PrecioComparado[]): void {
    if (this.selectedLocalidad !== null) {
      const productosMap = new Map<string, any>();
      const supermercadosSet = new Set<string>();

      data.forEach((item) => {
        if (item.estado_super === "Actualizado") {
          this.supermercadoImagenes.set(item.razon_social, item.imagen);
          supermercadosSet.add(item.razon_social);

          if (!productosMap.has(item.nom_producto)) {
            productosMap.set(item.nom_producto, {
              nom_producto: item.nom_producto,
              imagen_producto: item.imagen_producto,
              precios: {},
            });
          }

          const producto = productosMap.get(item.nom_producto);
          producto.precios[item.razon_social] = {
            precio: item.estado_precio === 'Actualizado' ? `$${item.precio.toFixed(2)}` : '-',
            esMasBarato: item.precio_mas_barato === 1,
          };

          if (item.supermercado_mas_conveniente) {
            this.supermercadoMasConveniente = item.razon_social;
          }
        } else {
          if (!this.supermercadoNoActualizado.includes(item.razon_social)) {
            this.supermercadoNoActualizado.push(item.razon_social);
          }
        }
      });

      this.supermercados = Array.from(supermercadosSet);
      this.displayedColumns = ['producto', ...this.supermercados];
      this.productos = Array.from(productosMap.values());

      if (this.supermercadoMasConveniente) {
        this.snackBar.open(
          $localize`¡El supermercado más conveniente es: ${this.supermercadoMasConveniente}!`,
          $localize`Cerrar`
        );
      }
    }
  }

  /**
   * Carga sucursales del supermercado más conveniente
   */
  loadSucursales(): void {
    if (this.selectedLocalidad !== null && this.supermercadoMasConveniente != null) {
      this.dataService.getSucursales(this.selectedLocalidad, this.supermercadoMasConveniente).subscribe({
        next: (sucursales) => {
          this.navigateToMapaSucursales(sucursales);
        },
        error: (error) => {
          console.error($localize`Error al cargar las sucursales:`, error);
        }
      });
    }
  }

  /**
   * Navega al mapa con las sucursales
   * @param sucursales Lista de sucursales
   */
  navigateToMapaSucursales(sucursales: Sucursal[]): void {
    console.log("sucursales", sucursales);
    const dialogRef = this.dialog.open(MapModalSupermercadoComponent, {
      width: '80%',
      data: { sucursales }
    });

    dialogRef.afterClosed().subscribe(result => {
      console.log('Modal cerrado', result);
    });
  }

  /**
   * Obtiene la imagen de un supermercado
   * @param supermercado Nombre del supermercado
   * @returns URL de la imagen
   */
  getSupermercadoImagen(supermercado: string): string {
    return this.supermercadoImagenes.get(supermercado) || '';
  }

  /**
   * Muestra los montos totales de cada supermercado
   * @param data Lista de precios comparados
   */
  mostrarMontosTotales(data: PrecioComparado[]): void {
    if (this.selectedLocalidad !== null) {
      const montosMap = new Map<string, { monto: string; esConveniente: boolean }>();

      data.forEach((item) => {
        if (!montosMap.has(item.razon_social)) {
          const montoFormateado = item.monto_total_supermercado
            ? `$${item.monto_total_supermercado.toFixed(2)}`
            : '-';

          montosMap.set(item.razon_social, {
            monto: montoFormateado,
            esConveniente: item.supermercado_mas_conveniente !== null,
          });
        }
      });

      this.montosTotales = Object.fromEntries(montosMap);
    }
  }
}

