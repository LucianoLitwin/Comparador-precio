import { Pipe, PipeTransform } from '@angular/core';
import { Sucursal } from '../api/models/sucursal.model';

@Pipe({
  name: 'filterSucursales',
  standalone: true,
})
export class FilterSucursalesPipe implements PipeTransform {
  /**
   * Filtra la lista de sucursales según un término de búsqueda.
   * @param sucursales Lista de sucursales a filtrar
   * @param searchTerm Término de búsqueda ingresado por el usuario
   * @returns Lista filtrada de sucursales
   */
  transform(sucursales: Sucursal[], searchTerm: string): Sucursal[] {
    if (!sucursales || !searchTerm) {
      return sucursales; // Si no hay término de búsqueda, devuelve todas las sucursales
    }

    const lowerCaseSearchTerm = searchTerm.toLowerCase(); // Convierte el término de búsqueda a minúsculas para una búsqueda insensible a mayúsculas

    return sucursales.filter((sucursal) =>
      // Filtra por nombre de sucursal, razón social o calle
      sucursal.nom_sucursal.toLowerCase().includes(lowerCaseSearchTerm) ||
      sucursal.razon_social.toLowerCase().includes(lowerCaseSearchTerm) ||
      sucursal.calle.toLowerCase().includes(lowerCaseSearchTerm)
    );
  }
}

