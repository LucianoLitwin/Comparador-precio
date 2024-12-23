package ar.edu.ubp.das.indecrest.beans;

public class PrecioResponseBean {
    private String imagen_producto;
    private String imagen;
    private String nom_producto;
    private String razon_social;
    private double precio;
    private double precio_anterior;
    private double variacion;
    private String estado_precio;
    private int precio_mas_barato;
    private String estado_super;
    private String supermercado_mas_conveniente; // Campo nuevo para supermercado más conveniente
    private Double monto_total_supermercado;      // Campo nuevo para monto total


    public String getImagen_producto() {
        return imagen_producto;
    }

    public void setImagen_producto(String imagen_producto) {
        this.imagen_producto = imagen_producto;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public String getNom_producto() {
        return nom_producto;
    }

    public void setNom_producto(String nom_producto) {
        this.nom_producto = nom_producto;
    }

    public String getRazon_social() {
        return razon_social;
    }

    public void setRazon_social(String razon_social) {
        this.razon_social = razon_social;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public String getEstado_precio() {
        return estado_precio;
    }

    public void setEstado_precio(String estado_precio) {
        this.estado_precio = estado_precio;
    }

    public String getEstado_super() {
        return estado_super;
    }

    public void setEstado_super(String estado_super) {
        this.estado_super = estado_super;
    }

    public int getPrecio_mas_barato() {
        return precio_mas_barato;
    }

    public void setPrecio_mas_barato(int precio_mas_barato) {
        this.precio_mas_barato = precio_mas_barato;
    }

    public String getSupermercado_mas_conveniente() {
        return supermercado_mas_conveniente;
    }

    public void setSupermercado_mas_conveniente(String supermercado_mas_conveniente) {
        this.supermercado_mas_conveniente = supermercado_mas_conveniente;
    }

    public Double getMonto_total_supermercado() {
        return monto_total_supermercado;
    }

    public void setMonto_total_supermercado(Double monto_total_supermercado) {
        this.monto_total_supermercado = monto_total_supermercado;
    }

    public double getPrecio_anterior() {
        return precio_anterior;
    }

    public void setPrecio_anterior(double precio_anterior) {
        this.precio_anterior = precio_anterior;
    }

    public double getVariacion() {
        return variacion;
    }

    public void setVariacion(double variacion) {
        this.variacion = variacion;
    }
}