package ar.edu.ubp.das.indecrest.beans;
import java.util.List;

public class PreciosComparadosRequest {
    private int nroLocalidad;
    private List<String> codigosBarra;

    // Getters y setters
    public int getNroLocalidad() {
        return nroLocalidad;
    }

    public void setNroLocalidad(int nroLocalidad) {
        this.nroLocalidad = nroLocalidad;
    }

    public List<String> getCodigosBarra() {
        return codigosBarra;
    }

    public void setCodigosBarra(List<String> codigosBarra) {
        this.codigosBarra = codigosBarra;
    }
}
