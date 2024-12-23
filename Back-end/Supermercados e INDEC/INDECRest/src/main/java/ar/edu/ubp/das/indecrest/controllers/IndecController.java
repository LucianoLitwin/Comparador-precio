package ar.edu.ubp.das.indecrest.controllers;

import ar.edu.ubp.das.indecrest.beans.*;
import ar.edu.ubp.das.indecrest.repositories.IndecRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/indec")
public class IndecController {

    @Autowired
    private IndecRepository indecRepository;

    @GetMapping("/provincias")//LISTO
    public ResponseEntity<List<ProvinciaBean>> obtenerProvincias() {
        List<ProvinciaBean> provincias = indecRepository.getProvincias();
        return ResponseEntity.ok(provincias);
    }

    @PostMapping("/localidades")//LISTO
    public ResponseEntity<List<LocalidadBean>> obtenerLocalidades(@RequestBody int cod_provincia) {
        List<LocalidadBean> localidades = indecRepository.getLocalidades(cod_provincia);
        return ResponseEntity.ok(localidades);
    }

    @PostMapping("/sucursales") // LISTO
    public ResponseEntity<List<SucursalBean>> obtenerInformacion(
            @RequestBody SucursalRequestBean request) {

        List<SucursalBean> response = indecRepository.getSucursales(request.getNroLocalidad(), request.getSupermercado());
        return ResponseEntity.ok(response);
    }


    @GetMapping("/rubros")//LISTO
    public ResponseEntity<List<RubroBean>> obtenerRubros(@RequestHeader("Accept-Language") String codIdioma) {
        List<RubroBean> rubros = indecRepository.getRubros(codIdioma);
        return ResponseEntity.ok(rubros);
    }

    @PostMapping("/categorias")
    public ResponseEntity<List<CategoriaBean>> obtenerCategorias(
            @RequestHeader("Accept-Language") String codIdioma,
            @RequestBody List<Integer> nroRubros) {
        List<CategoriaBean> categorias = indecRepository.getCategorias(codIdioma, nroRubros);
        return ResponseEntity.ok(categorias);
    }

    @PostMapping("/tiposProductos")
    public ResponseEntity<List<TipoProductoBean>> obtenerTiposProductos(@RequestHeader("Accept-Language") String codIdioma, @RequestBody List<Integer> nroCategorias) {
        List<TipoProductoBean> tiposProductos = indecRepository.getTiposProductos(codIdioma, nroCategorias);
        return ResponseEntity.ok(tiposProductos);
    }

    @PostMapping("/marcas")
    public ResponseEntity<List<MarcaBean>> obtenerMarcas(@RequestBody List<Integer> nroTiposProductos) {
        List<MarcaBean> marcas = indecRepository.getMarcas(nroTiposProductos);
        return ResponseEntity.ok(marcas);
    }

    @PostMapping("/productos")
    public ResponseEntity<ProductoResponseBean> obtenerProductos(@RequestHeader("Accept-Language") String codIdioma, @RequestBody RequestBean criteria) {
        // Verifica que el criterio de búsqueda esté siendo pasado correctamente en el request body
        ProductoResponseBean producto = indecRepository.getProductos(codIdioma, criteria);
        return ResponseEntity.ok(producto);
    }


    @PostMapping("/precios-comparados")
    public ResponseEntity<List<PrecioResponseBean>> obtenerPreciosComparados(
            @RequestBody PreciosComparadosRequest request) {  // Usamos un objeto para encapsular los parámetros
        List<PrecioResponseBean> preciosComparados = indecRepository.getPreciosComparados(request.getCodigosBarra(), request.getNroLocalidad());
        return ResponseEntity.ok(preciosComparados);
    }



    @PostMapping("/BatchPrecios")
    public ResponseEntity<Void> obtenerBatchPrecios() {
        try {
            indecRepository.obtenerBatchPrecios();
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PostMapping("/BatchSucursales")//LISTO
    public ResponseEntity<Void> obtenerBatchSucursales() {
        try {
            indecRepository.obtenerBatchSucursales();
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
}