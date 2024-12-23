package ar.edu.ubp.das.superrest.Repository;

import ar.edu.ubp.das.superrest.Beans.InfoSucursalesBean;
import ar.edu.ubp.das.superrest.Beans.PreciosProductosBean;
import ar.edu.ubp.das.superrest.Components.SimpleJdbcCallFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.awt.*;

@Repository//LISTO
public class PreciosProductosRepository {

    @Autowired
    private SimpleJdbcCallFactory jdbcCallFactory;

    public List<PreciosProductosBean> getPrecios(String json) {
        SqlParameterSource param = new MapSqlParameterSource("json", json);
        return jdbcCallFactory.executeQuery(
                "ObtenerPreciosProductos",
                "dbo",
                param,
                "PreciosProductosRequest",
                PreciosProductosBean.class
        );
    }
}