import { Component, Inject } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { Producto } from '../../api/models/producto.model';
import { CartService } from '../../api/services/cart.service';
import { CommonModule } from '@angular/common';
import { MatListModule } from '@angular/material/list';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { Router } from '@angular/router';

@Component({
  selector: 'app-cart-modal',
  standalone: true,
  imports: [CommonModule, MatListModule, MatIconModule, MatButtonModule],
  templateUrl: './cart-modal.component.html',
  styleUrls: ['./cart-modal.component.css']
})
export class CartModalComponent {
  constructor(
    @Inject(MAT_DIALOG_DATA) public cartProducts: Producto[],  // Recibe los productos del carrito
    private cartService: CartService,
    private router: Router,
    private dialogRef: MatDialogRef<CartModalComponent>  // Referencia al modal
  ) { }

  /**
   * Elimina un producto del carrito
   * @param codBarra Código de barras del producto a eliminar
   */
  removeProductFromCart(codBarra: string): void {
    this.cartService.removeProduct(codBarra); // Elimina el producto del servicio
    this.cartProducts = this.cartService.getCartProducts()(); // Actualiza la lista local

    // Cierra el modal si el carrito está vacío
    if (this.cartProducts.length === 0) {
      this.closeModal();
    }
  }

  /**
   * Vacía completamente el carrito
   */
  removeAllProductFromCart(): void {
    this.cartService.clearCart(); // Vacía el carrito en el servicio
    console.log("Carrito vaciado");
    this.closeModal(); // Cierra el modal
  }

  /**
   * Navega al comparador de precios y cierra el modal
   */
  navigateToComparator(): void {
    this.router.navigate(['/comparador-precios']); // Navega a la ruta del comparador
    this.closeModal(); // Cierra el modal
  }

  /**
   * Cierra el modal
   */
  closeModal(): void {
    this.dialogRef.close(); // Cierra el modal
  }
}
