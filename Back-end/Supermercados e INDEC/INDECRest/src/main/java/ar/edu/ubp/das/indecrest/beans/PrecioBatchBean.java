package ar.edu.ubp.das.indecrest.beans;

import jakarta.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "PreciosResponse")

public class PrecioBatchBean {
    private int nro_sucursal;
    private String cod_barra;
    private double precio;
    private double precio_anterior;
    private double varicion;


    public int getNro_sucursal() {
        return nro_sucursal;
    }

    public void setNro_sucursal(int nro_sucursal) {
        this.nro_sucursal = nro_sucursal;
    }

    public String getCod_barra() {
        return cod_barra;
    }

    public void setCod_barra(String cod_barra) {
        this.cod_barra = cod_barra;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public double getPrecio_anterior() {
        return precio_anterior;
    }

    public void setPrecio_anterior(double precio_anterior) {
        this.precio_anterior = precio_anterior;
    }

    public double getVaricion() {
        return varicion;
    }

    public void setVaricion(double varicion) {
        this.varicion = varicion;
    }
}
