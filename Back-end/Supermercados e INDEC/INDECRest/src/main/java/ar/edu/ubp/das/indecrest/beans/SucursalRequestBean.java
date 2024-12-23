package ar.edu.ubp.das.indecrest.beans;

public class SucursalRequestBean {
    private int nroLocalidad;
    private String supermercado; // Puede ser null o vacío si no se quiere filtrar por supermercado.

    public int getNroLocalidad() {
        return nroLocalidad;
    }

    public void setNroLocalidad(int nroLocalidad) {
        this.nroLocalidad = nroLocalidad;
    }

    public String getSupermercado() {
        return supermercado;
    }

    public void setSupermercado(String supermercado) {
        this.supermercado = supermercado;
    }
}
