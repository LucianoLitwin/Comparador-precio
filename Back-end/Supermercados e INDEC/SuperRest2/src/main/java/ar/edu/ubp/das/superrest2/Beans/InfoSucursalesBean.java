package ar.edu.ubp.das.superrest2.Beans;

public class InfoSucursalesBean {
    private int nro_sucursal;
    private String nom_sucursal;
    private String calle;
    private int nro_calle;
    private String telefono;
    private double coord_latitud;
    private double coord_longitud;
    private boolean habilitada;
    private int nro_localidad;
    private String pais;
    private String servicios;
    private String horarios;


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

    public double getCoord_latitud() {
        return coord_latitud;
    }

    public void setCoord_latitud(double coord_latitud) {
        this.coord_latitud = coord_latitud;
    }

    public double getCoord_longitud() {
        return coord_longitud;
    }

    public void setCoord_longitud(double coord_longitud) {
        this.coord_longitud = coord_longitud;
    }

    public boolean isHabilitada() {
        return habilitada;
    }

    public void setHabilitada(boolean habilitada) {
        this.habilitada = habilitada;
    }

    public int getNro_localidad() {
        return nro_localidad;
    }

    public void setNro_localidad(int nro_localidad) {
        this.nro_localidad = nro_localidad;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }

    public String getServicios() {
        return servicios;
    }

    public void setServicios(String servicios) {
        this.servicios = servicios;
    }

    public String getHorarios() {
        return horarios;
    }

    public void setHorarios(String horarios) {
        this.horarios = horarios;
    }

}
