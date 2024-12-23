package ar.edu.ubp.das.indecrest.beans;

import java.util.List;

public class RequestBean {
    private List<Integer> nroRubros;          // Cambiado a lista
    private List<Integer> nroCategorias;     // Cambiado a lista
    private List<Integer> nroTiposProductos; // Cambiado a lista
    private List<Integer> nroMarcas;         // Cambiado a lista
    private String barraBusqueda;
    private Integer pageNumber;
    private Integer pageSize;

    // Getters and Setters
    public List<Integer> getNroRubros() {
        return nroRubros;
    }

    public void setNroRubros(List<Integer> nroRubros) {
        this.nroRubros = nroRubros;
    }

    public List<Integer> getNroCategorias() {
        return nroCategorias;
    }

    public void setNroCategorias(List<Integer> nroCategorias) {
        this.nroCategorias = nroCategorias;
    }

    public List<Integer> getNroTiposProductos() {
        return nroTiposProductos;
    }

    public void setNroTiposProductos(List<Integer> nroTiposProductos) {
        this.nroTiposProductos = nroTiposProductos;
    }

    public List<Integer> getNroMarcas() {
        return nroMarcas;
    }

    public void setNroMarcas(List<Integer> nroMarcas) {
        this.nroMarcas = nroMarcas;
    }

    public String getBarraBusqueda() {
        return barraBusqueda;
    }

    public void setBarraBusqueda(String barraBusqueda) {
        this.barraBusqueda = barraBusqueda;
    }

    public Integer getPageNumber() {
        return pageNumber;
    }

    public void setPageNumber(Integer pageNumber) {
        this.pageNumber = pageNumber;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }
}
