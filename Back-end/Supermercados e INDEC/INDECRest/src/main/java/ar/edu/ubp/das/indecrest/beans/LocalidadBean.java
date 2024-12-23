package ar.edu.ubp.das.indecrest.beans;

public class LocalidadBean {
    private int cod_provincia;
    private String cod_pais;
    private int nro_localidad;
    private String nom_localidad;

    public int getCod_provincia() {
        return cod_provincia;
    }

    public void setCod_provincia(int cod_provincia) {
        this.cod_provincia = cod_provincia;
    }

    public String getCod_pais() {
        return cod_pais;
    }

    public void setCod_pais(String cod_pais) {
        this.cod_pais = cod_pais;
    }

    public int getNro_localidad() {
        return nro_localidad;
    }

    public void setNro_localidad(int nro_localidad) {
        this.nro_localidad = nro_localidad;
    }

    public String getNom_localidad() {
        return nom_localidad;
    }

    public void setNom_localidad(String nom_localidad) {
        this.nom_localidad = nom_localidad;
    }
}
