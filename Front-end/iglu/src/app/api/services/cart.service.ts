import { Injectable, signal } from '@angular/core';
import { Producto } from '../models/producto.model';

@Injectable({
    providedIn: 'root',
})
export class CartService {
    private cartProducts = signal<Producto[]>(this.loadCartFromStorage()); // Carga inicial del carrito desde localStorage

    constructor() {
        this.loadCartFromStorage(); // Asegura que el carrito se cargue al inicializar
    }

    /**
     * Carga el carrito desde localStorage
     * @returns Array de productos almacenados o vacío si no existe
     */
    private loadCartFromStorage(): Producto[] {
        const cart = localStorage.getItem('cart');
        return cart ? JSON.parse(cart) : []; // Devuelve un array vacío si no hay datos
    }

    /**
     * Guarda el estado actual del carrito en localStorage
     */
    private saveCartToStorage(): void {
        localStorage.setItem('cart', JSON.stringify(this.cartProducts())); // Guarda como JSON
    }

    /**
     * Verifica si un producto está en el carrito
     * @param codBarra Código de barras del producto a verificar
     * @returns True si el producto está en el carrito, false en caso contrario
     */
    isProductInCart(codBarra: string): boolean {
        return this.cartProducts().some(product => product.cod_barra === codBarra);
    }

    /**
     * Obtiene la lista de productos en el carrito como señal de solo lectura
     * @returns Señal de productos en el carrito
     */
    getCartProducts() {
        const products = this.cartProducts();
        console.log('Productos obtenidos en el servicio:', products);
        return this.cartProducts.asReadonly(); // Retorna señal de solo lectura
    }

    /**
     * Añade un producto al carrito
     * @param product Producto a añadir
     */
    addProduct(product: Producto): void {
        const updatedCart = [...this.cartProducts(), product]; // Agrega el producto
        this.cartProducts.set(updatedCart);  // Actualiza la señal
        this.saveCartToStorage(); // Guarda en localStorage
    }

    /**
     * Elimina un producto del carrito por su código de barras
     * @param codBarra Código de barras del producto a eliminar
     */
    removeProduct(codBarra: string): void {
        const updatedCart = this.cartProducts().filter((p) => p.cod_barra !== codBarra); // Filtra el producto
        this.cartProducts.set(updatedCart); // Actualiza la señal
        this.saveCartToStorage(); // Guarda en localStorage
    }

    /**
     * Vacía el carrito
     */
    clearCart(): void {
        this.cartProducts.set([]); // Limpia la señal
        this.saveCartToStorage(); // Guarda el carrito vacío en localStorage
    }
}
