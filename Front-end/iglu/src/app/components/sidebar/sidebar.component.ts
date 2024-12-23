import { Component, effect, signal } from '@angular/core';
import { Router } from '@angular/router';
import { MatSidenavModule } from '@angular/material/sidenav';
import { MatListModule } from '@angular/material/list';
import { CommonModule } from '@angular/common';
import { MatButtonModule } from '@angular/material/button';
import { MatSelectModule } from '@angular/material/select';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatIconModule } from '@angular/material/icon';
import { MatTooltipModule } from '@angular/material/tooltip';
import { RouterModule } from '@angular/router';
import { CartService } from '../../api/services/cart.service';
import { Producto } from '../../api/models/producto.model';
import { MatDialog, MatDialogModule } from '@angular/material/dialog';
import { CartModalComponent } from '../cart-modal/cart-modal.component';

@Component({
  selector: 'app-sidebar',
  standalone: true,
  imports: [
    CommonModule,
    MatSidenavModule,
    MatListModule,
    MatFormFieldModule,
    MatSelectModule,
    MatButtonModule,
    MatIconModule,
    MatTooltipModule,
    RouterModule,
    MatDialogModule,

  ],
  templateUrl: './sidebar.component.html',
  styleUrls: ['./sidebar.component.css']
})
export class SidebarComponent {
  cartProductsCount = signal(0); // Signal para el contador de productos en el carrito
  cartProducts = signal<Producto[]>([]); // Signal para almacenar los productos del carrito
  isExpanded = false; // Controla si la barra lateral está expandida
  selectedLanguage: string = 'es'; // Idioma predeterminado

  constructor(
    private router: Router,
    private cartService: CartService,
    private dialog: MatDialog, // Servicio para manejar diálogos modales
  ) {
    // Detecta el idioma al iniciar
    this.detectLanguage();

    // Efecto para actualizar el contador y los productos del carrito
    effect(() => {
      const cart = this.cartService.getCartProducts()(); // Obtiene los productos del carrito
      this.cartProducts.set(cart); // Actualiza la lista de productos
      this.cartProductsCount.set(cart.length); // Actualiza el contador de productos
    }, { allowSignalWrites: true }); // Permite modificar señales dentro del efecto
  }

  /**
   * Abre el modal del carrito si hay productos en él
   */
  openCartModal(): void {
    if (this.cartProductsCount() > 0) {
      this.dialog.open(CartModalComponent, {
        data: this.cartProducts(), // Pasa los productos del carrito al modal
        width: '80%', // Define el tamaño del modal
      });
    }
  }

  /**
   * Alterna el estado expandido de la barra lateral
   */
  toggleCart(): void {
    this.isExpanded = !this.isExpanded;
  }

  /**
   * Navega a la ruta especificada
   * @param path Ruta a la que se desea navegar
   */
  navigateTo(path: string): void {
    this.router.navigate([path]);
  }

  /**
   * Detecta el idioma actual según el puerto de la aplicación
   */
  detectLanguage(): void {
    const currentPort = window.location.port;
    this.selectedLanguage = currentPort === '4201' ? 'en' : 'es';
  }

  /**
   * Cambia el idioma de la aplicación y redirige al puerto correspondiente
   * @param language Idioma seleccionado ('en' o 'es')
   */
  changeLanguage(language: string): void {
    this.selectedLanguage = language;

    // Determina el puerto según el idioma
    const currentHost = window.location.hostname;
    const newPort = language === 'en' ? '4201' : '4200';

    // Limpia el carrito al cambiar de idioma
    this.cartService.clearCart();

    // Redirige si el puerto actual no coincide con el deseado
    if (window.location.port !== newPort) {
      window.location.href = `${window.location.protocol}//${currentHost}:${newPort}`;
    }
  }
}

