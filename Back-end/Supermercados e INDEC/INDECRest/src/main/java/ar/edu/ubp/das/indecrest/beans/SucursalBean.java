package ar.edu.ubp.das.indecrest.beans;
//Sucursales normal (get)
public class SucursalBean {
    private String imagen;
    private String razon_social;
    private int nro_sucursal;
    private String nom_sucursal;
    private String calle;
    private int nro_calle;
    private String telefono;
    private float coord_latitud;
    private float coord_longitud;
    private int nro_localidad;
    private String nom_localidad;
    private String nom_provincia;
    private String horario_sucursal;
    private String servicios_disponibles;

    public String getImagen() {return imagen;}

    public void setImagen(String imagen) {this.imagen = imagen;}

    public int getNro_sucursal() {
        return nro_sucursal;
    }

    public void setNro_sucursal(int nro_sucursal) {
        this.nro_sucursal = nro_sucursal;
    }

    public String getNom_sucursal() {
        return nom_sucursal;
    }

    public void setNom_sucursal(String nom_sucursal) {
        this.nom_sucursal = nom_sucursal;
    }

    public String getCalle() {
        return calle;
    }

    public void setCalle(String calle) {
        this.calle = calle;
    }

    public int getNro_calle() {
        return nro_calle;
    }

    public void setNro_calle(int nro_calle) {
        this.nro_calle = nro_calle;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public int getNro_localidad() {
        return nro_localidad;
    }

    public void setNro_localidad(int nro_localidad) {
        this.nro_localidad = nro_localidad;
    }

    public String getHorario_sucursal() {
        return horario_sucursal;
    }

    public void setHorario_sucursal(String horario_sucursal) {
        this.horario_sucursal = horario_sucursal;
    }

    public String getServicios_disponibles() {
        return servicios_disponibles;
    }

    public void setServicios_disponibles(String servicios_disponibles) { this.servicios_disponibles = servicios_disponibles;
    }

    public float getCoord_latitud() {
        return coord_latitud;
    }

    public void setCoord_latitud(float coord_latitud) {
        this.coord_latitud = coord_latitud;
    }

    public float getCoord_longitud() {
        return coord_longitud;
    }

    public void setCoord_longitud(float coord_longitud) {
        this.coord_longitud = coord_longitud;
    }

    public String getRazon_social() {
        return razon_social;
    }

    public void setRazon_social(String razon_social) {
        this.razon_social = razon_social;
    }

    public String getNom_provincia() {
        return nom_provincia;
    }

    public void setNom_provincia(String nom_provincia) {
        this.nom_provincia = nom_provincia;
    }

    public String getNom_localidad() {
        return nom_localidad;
    }

    public void setNom_localidad(String nom_localidad) {
        this.nom_localidad = nom_localidad;
    }
}
