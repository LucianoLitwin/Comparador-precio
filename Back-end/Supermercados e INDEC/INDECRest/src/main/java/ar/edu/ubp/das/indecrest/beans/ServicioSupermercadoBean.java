package ar.edu.ubp.das.indecrest.beans;

import java.time.LocalDateTime;

public class ServicioSupermercadoBean {
    private int nro_supermercado;
    private String url_servicio;
    private String tipo_servicio;
    private String usuario;
    private String clave;
    private LocalDateTime fecha_ult_act_servicio;

    public int getNro_supermercado() {
        return nro_supermercado;
    }

    public void setNro_supermercado(int nro_supermercado) {
        this.nro_supermercado = nro_supermercado;
    }

    public String getUrl_servicio() {
        return url_servicio;
    }

    public void setUrl_servicio(String url_servicio) {
        this.url_servicio = url_servicio;
    }

    public String getTipo_servicio() {
        return tipo_servicio;
    }

    public void setTipo_servicio(String tipo_servicio) {
        this.tipo_servicio = tipo_servicio;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public LocalDateTime getFecha_ult_act_servicio() {
        return fecha_ult_act_servicio;
    }

    public void setFecha_ult_act_servicio(LocalDateTime fecha_ult_act_servicio) {
        this.fecha_ult_act_servicio = fecha_ult_act_servicio;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }
}
