package ar.edu.ubp.das.indecrest.beans;
//Uso mas que nada para productos con filtros
public class ProductoBean {

    private String cod_barra;
    private String nom_producto;
    private String imagen;


    public String getNom_producto() {
        return nom_producto;
    }

    public void setNom_producto(String nom_producto) {
        this.nom_producto = nom_producto;
    }

    public String getCod_barra() {
        return cod_barra;
    }

    public void setCod_barra(String cod_barra) {
        this.cod_barra = cod_barra;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }
}


/*
package ar.edu.ubp.das.indecrest.beans;
//Uso mas que nada para productos generales, eventualmente serán la lista de la CB de indec
public class ProductosINDEC {

    private String cod_barra;
    private String nom_producto;

    public String getCod_barra() {
        return cod_barra;
    }

    public void setCod_barra(String cod_barra) {
        this.cod_barra = cod_barra;
    }

    public String getNom_producto() {
        return nom_producto;
    }

    public void setNom_producto(String nom_producto) {
        this.nom_producto = nom_producto;
    }
}

 */