package ar.edu.ubp.das.indecrest.factory;

import ar.edu.ubp.das.indecrest.beans.InfoSucursalesBean;
import ar.edu.ubp.das.indecrest.beans.PrecioBatchBean;
import ar.edu.ubp.das.indecrest.beans.ProductoBean;
import ar.edu.ubp.das.indecrest.utils.Httpful;
import com.google.gson.reflect.TypeToken;
import jakarta.ws.rs.HttpMethod;

import java.util.List;

public class SuperRest implements Super {
    private final Httpful httpClient;
    private final int nroSuper;

    public SuperRest(String apiUrl, int nroSuper, String usuario, String clave) {
        this.nroSuper = nroSuper;
        this.httpClient = new Httpful(apiUrl).basicAuth(usuario, clave);
    }

    @Override
    public int getNroSuper() {
        return nroSuper;
    }

    @Override
    public List<PrecioBatchBean> getPreciosProductos(List<ProductoBean> json) {
        return httpClient.path("/productos")
                .method(HttpMethod.POST)
                .post(json)
                .execute(new TypeToken<List<PrecioBatchBean>>(){}.getType());
    }

    @Override
    public List<InfoSucursalesBean> getSucursales() {
        return httpClient.path("/sucursales")
                .method(HttpMethod.GET)
                .execute(new TypeToken<List<InfoSucursalesBean>>(){}.getType());
    }
}

