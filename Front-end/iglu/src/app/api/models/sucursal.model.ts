export interface Sucursal {
  imagen: string;
  razon_social: string;
  nro_sucursal: number;
  nom_sucursal: string;
  calle: string;
  nro_calle: number;
  telefono: string;
  coord_latitud: number;
  coord_longitud: number;
  horario_sucursal: string;
  servicios_disponibles: string;
  info?: string; // Agregar esta propiedad opcional
}
