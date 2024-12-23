package ar.edu.ubp.das.supersoap.beans;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "PreciosResponse")
@XmlAccessorType(XmlAccessType.FIELD)
public class PreciosProductosBean {
    @XmlElement(name = "nro_sucursal")
    private int nro_sucursal;
    @XmlElement(name = "cod_barra")
    private String cod_barra;
    @XmlElement(name = "precio")
    private double precio;

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

    public int getNro_sucursal() {
        return nro_sucursal;
    }

    public void setNro_sucursal(int nro_sucursal) {
        this.nro_sucursal = nro_sucursal;
    }
}
