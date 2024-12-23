import { Component, OnInit, inject } from '@angular/core';
import { ProductService } from '../../api/resources/product.service';
import { CommonModule } from '@angular/common';
import { MatOptionModule } from '@angular/material/core';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatSelectModule } from '@angular/material/select';
import { FormsModule } from '@angular/forms';
import { ProductCardComponent } from '../product-card/product-card.component';
import { MatIcon } from '@angular/material/icon';
import { Rubro } from '../../api/models/rubro.model';
import { Categoria } from '../../api/models/categoria.model';
import { tipoProducto } from '../../api/models/tipoProducto.model';
import { Marca } from '../../api/models/marca.model';
import { CartService } from '../../api/services/cart.service';
import { MatButtonModule } from '@angular/material/button';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Producto } from '../../api/models/producto.model';
import { ListadoProductos } from '../../api/models/listadoProductos.model';
import { MatInputModule } from '@angular/material/input';

@Component({
  selector: 'app-product-category',
  templateUrl: './product-category.component.html',
  styleUrls: ['./product-category.component.css'],
  standalone: true,
  imports: [
    FormsModule,
    MatFormFieldModule,
    MatSelectModule,
    MatOptionModule,
    ProductCardComponent,
    CommonModule,
    MatIcon,
    MatButtonModule,
    MatInputModule
  ],
})
export class ProductCategoryComponent implements OnInit {
  // Filtros y parámetros seleccionados
  rubros: Rubro[] = []; // Lista de rubros disponibles
  categorias: Categoria[] = []; // Lista de categorías disponibles
  tiposProductos: tipoProducto[] = []; // Lista de tipos de productos disponibles
  marcas: Marca[] = []; // Lista de marcas disponibles

  selectedRubro: number[] = []; // Rubro seleccionado
  selectedCategoria: number[] = []; // Categoría seleccionada
  selectedMarca: number[] = []; // Marca seleccionada
  selectedTipoProducto: number[] = []; // Tipo de producto seleccionado

  categoryName: string = ''; // Nombre de la categoría actual

  barraBusqueda: string = ''; // Término de búsqueda

  // Paginación y carga de productos
  pageNumber = 1; // Número de página actual
  pageSize = 12; // Tamaño de página
  cantidadTotal = 0; // Total de productos disponibles
  products: Producto[] = []; // Lista de productos cargados
  isLoading = false; // Indicador de carga
  allProductsLoaded = false; // Indica si todos los productos se cargaron

  // Inyección de servicios
  private _snackBar = inject(MatSnackBar);

  constructor(private productService: ProductService, private cartService: CartService) { }

  // Métodos del ciclo de vida del componente
  ngOnInit(): void {
    this.loadFilters(); // Carga los filtros al inicializar
    this.loadProducts(); // Inicializa la carga de productos
    this.setupScrollListener(); // Configura el evento de scroll
  }

  // Configuración del evento de scroll
  setupScrollListener(): void {
    window.addEventListener('scroll', () => {
      if (this.shouldLoadMoreProducts()) {
        this.incrementarPage();
      }
    });
  }

  // Manejo de cambio en la barra de búsqueda
  onSearchChange(event: Event): void {
    const input = event.target as HTMLInputElement;
    this.barraBusqueda = input.value.trim();
    this.onFilterChange();
  }

  // Verifica si se deben cargar más productos al hacer scroll
  shouldLoadMoreProducts(): boolean {
    if (this.isLoading || this.allProductsLoaded) return false;

    const scrollPosition = window.innerHeight + window.scrollY;
    const pageHeight = document.documentElement.scrollHeight;

    return scrollPosition >= pageHeight - 100;
  }

  // Incrementa el número de página y carga más productos
  incrementarPage(): void {
    this.isLoading = true;
    this.pageNumber += 1;
    this.onFilterChange();

    setTimeout(() => {
      this.isLoading = false;
      if (this.products.length >= this.cantidadTotal) {
        this.allProductsLoaded = true;
      }
    }, 1000);
  }

  // Carga los filtros iniciales
  loadFilters(): void {
    this.productService.getRubros().subscribe((rubros) => {
      this.rubros = rubros;
    });
  }

  // Carga los productos según los filtros aplicados
  loadProducts(filter: any = {}): void {
    const baseFilter = {
      pageNumber: this.pageNumber,
      pageSize: this.pageSize,
    };
    const finalFilter = { ...baseFilter, ...filter };

    this.productService.getProductos(finalFilter).subscribe((response: ListadoProductos) => {
      if (this.pageNumber !== 1) {
        this.products = [...new Map([...this.products, ...response.productos].map(p => [p.cod_barra, p])).values()];
      } else {
        this.products = response.productos;
      }
      this.cantidadTotal = response.totalCount;
    });
  }

  // Manejo de cambios en los filtros
  onChangeRubro(): void {
    this.pageNumber = 1;
    this.categorias = [];
    this.selectedCategoria = [];
    this.selectedTipoProducto = [];
    this.tiposProductos = [];
    this.selectedMarca = [];
    this.marcas = [];

    if (this.selectedRubro.length > 0) {
      this.productService.getCategorias(this.selectedRubro).subscribe((categorias) => {
        this.categorias = categorias;
      });
    }

    this.onFilterChange();
  }

  onChangeCategoria(): void {
    this.pageNumber = 1;
    this.selectedTipoProducto = [];
    this.tiposProductos = [];
    this.selectedMarca = [];
    this.marcas = [];

    if (this.selectedCategoria.length > 0) {
      this.productService.getTiposProductos(this.selectedCategoria).subscribe((tiposProductos) => {
        this.tiposProductos = tiposProductos;
      });
    }

    this.onFilterChange();
  }

  onChangeTipoProducto(): void {
    this.pageNumber = 1;
    this.selectedMarca = [];
    this.marcas = [];

    if (this.selectedTipoProducto.length > 0) {
      this.productService.getMarcas(this.selectedTipoProducto).subscribe((marcas) => {
        this.marcas = marcas;
      });
    }

    this.onFilterChange();
  }

  onFilterChange(): void {
    this.pageNumber = 1;

    const filter = {
      nroRubros: this.selectedRubro,
      nroCategorias: this.selectedCategoria,
      nroMarcas: this.selectedMarca,
      nroTiposProductos: this.selectedTipoProducto,
      barraBusqueda: this.barraBusqueda,
      pageNumber: this.pageNumber,
      pageSize: this.pageSize,
    };

    const finalFilter = Object.fromEntries(
      Object.entries(filter).filter(([_, v]) => {
        if (v == null) return false;
        if (Array.isArray(v)) return v.length > 0;
        if (typeof v === 'string') return v.length > 0;
        return true;
      })
    );

    this.loadProducts(finalFilter);
  }

  clearFilter<T extends keyof ProductCategoryComponent>(filterName: T): void {
    this[filterName] = [] as any;

    if (filterName === 'selectedRubro') {
      this.categorias = [];
      this.selectedCategoria = [];
      this.tiposProductos = [];
      this.selectedTipoProducto = [];
      this.marcas = [];
      this.selectedMarca = [];
    }

    if (filterName === 'selectedCategoria') {
      this.tiposProductos = [];
      this.selectedTipoProducto = [];
      this.marcas = [];
      this.selectedMarca = [];
    }

    if (filterName === 'selectedTipoProducto') {
      this.marcas = [];
      this.selectedMarca = [];
    }

    this.onFilterChange();
  }

  // Métodos relacionados con el carrito
  addToCart(product: any): void {
    this.cartService.addProduct(product);
    product.isAdded = true;
  }

  isProductInCart(product: Producto): boolean {
    return this.cartService.isProductInCart(product.cod_barra);
  }

  // Métodos relacionados con la UI
  openSnackBar(): void {
    const message = $localize`:@@productAddedSuccess:¡Producto añadido con éxito!`;

    this._snackBar.open(message, '', {
      duration: 2000,
      panelClass: ['mat-snack-bar-container'],
    });
  }
}



