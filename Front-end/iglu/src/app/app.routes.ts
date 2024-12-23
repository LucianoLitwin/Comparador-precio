import { Routes } from '@angular/router';
import { HomeComponent } from './components/home/home.component';
import { ProductCategoryComponent } from './components/product-category/product-category.component';
import { MapaVentasComponent } from './components/map-view/mapa-ventas.component';
import { ComparadorPreciosComponent } from './components/comparador-precios/comparador-precios.component';

export const routes: Routes = [
  { path: 'home', component: HomeComponent }, // Ruta explícita a /home
  { path: 'productos', component: ProductCategoryComponent },
  { path: 'mapa-sucursales', component: MapaVentasComponent },
  { path: 'comparador-precios', component: ComparadorPreciosComponent },
  { path: '', redirectTo: '/home', pathMatch: 'full' }, // Redirige '' a /home
  { path: '**', redirectTo: '/home' }
];
